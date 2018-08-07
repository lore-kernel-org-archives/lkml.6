Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A1FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EFE2177A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EFE2177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbeHGJq5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:46:57 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35579 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732805AbeHGJq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:46:56 -0400
Received: by mail-ua0-f193.google.com with SMTP id q12-v6so15076879ual.2;
        Tue, 07 Aug 2018 00:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RIztZSW56qlEmpFi4Woqf2wd8+YujPd82HedacZbr7A=;
        b=qJENOlC5YKCWvu8GcUkAWrqUe5f7wYgjQS5Bhx43ctYiPZmYeBlBOjd2c5/4uxPYwn
         9F3ejxEWdb04k7/8MuZJzBhgLtMRql1YgqoH4R+jY7fEL9tDAtWUcTqKGGmfYvvTBJ/G
         sp8z1lOlWs63J/mnIEkD5bPgwh6mo3k5sP0kWjfkp88Zs2iFUKVRlbhUcmlDeTejPHi7
         +m7lvwQwU16bFI96XLvPbbZweQwUPZHQe/M4R54kLIAULC/0gxnJxjRWmUw/H4Io+o1t
         7jslAxY9p0DvI33DoSWY7v06hlQYUl6j0UgECeI/3FpwzgtaKlUDq6zrH3bAv+bDfVV3
         8xjg==
X-Gm-Message-State: AOUpUlFkaiAkQ8KrMYPCdBINMd5e+BmQbPm+U66vqmwBEql510Pw4Q9u
        bQhJh/SdpkUPoKT5FtAnnZ8zKjh5cVjxsSxnu5H6I4cy
X-Google-Smtp-Source: AAOMgpcae72AYYRxaexs4Jin4o9qoUM+RYscsmBy6B4OH4ZhSWRt9dfo3cto9RiF0VOn1ui1qE8nD71QwzkgNw/1vnw=
X-Received: by 2002:a9f:37c8:: with SMTP id q66-v6mr12521003uaq.180.1533627233144;
 Tue, 07 Aug 2018 00:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-15-songjun.wu@linux.intel.com> <20180803055640.GA32226@kroah.com>
 <763bba56-3701-7fe9-9b31-4710594b40d5@linux.intel.com> <20180803103023.GA6557@kroah.com>
 <3360edd2-f3d8-b860-13fa-ce680edbfd0a@hauke-m.de> <20180804124309.GB4920@kroah.com>
 <CAK8P3a3qs34LuhPeaef2wPHYEWbYO5N-4n7763BcaDyppiJ6DA@mail.gmail.com>
 <acd28f40-4342-7f67-8468-7d4578f614a1@linux.intel.com> <CAMuHMdWY9NuYOXq8sD9wmH48=vhMcSBomRY9ZbC+tGE3PGiTGg@mail.gmail.com>
 <0ab8e6e7-3cc2-8e50-b1f3-99616437f527@linux.intel.com> <CAMuHMdUJ8-bveoHWOetjrHtq2HNPnf00PidQwJ-kZD2o86KLMw@mail.gmail.com>
 <d6d0be20-aea9-cecf-1e39-3d65c0dbad5f@linux.intel.com>
In-Reply-To: <d6d0be20-aea9-cecf-1e39-3d65c0dbad5f@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Aug 2018 09:33:39 +0200
Message-ID: <CAMuHMdXADda8fuc9_oTGQFPUnYs8gX-Bp6md5fJgu=wHvM-duw@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] serial: intel: Add CCF support
To:     songjun.wu@linux.intel.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, hua.ma@linux.intel.com,
        yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Songjun,

On Tue, Aug 7, 2018 at 9:18 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
> On 8/6/2018 5:29 PM, Geert Uytterhoeven wrote:
> > On Mon, Aug 6, 2018 at 10:58 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
> >> The reason we add a new head file is also for two macros(LTQ_EARLY_ASC
> >> and CPHYSADDR)
> >> used by legacy product. We need to provide the no-op stub for these two
> >> macro for new product.
> > No you don't. The line number should not be obtained by comparing the
> > resource address with a hardcoded base address.
> This is the previous code. Now the line number is obtained from dts.

Note that obtaining line numbers from DTS has its own share of problems, when
considering DT overlays. I've replied to the patch adding the call to
of_alias_get_id().

> We keep this code for the compatibility.
>
> Referring to the conditional-compilation part in coding-style,
> We add a header file to avoid using “#ifdef” in C file.
> > Perhaps the override of port->line should just be removed, as IIRC, the serial
> > core has already filled in that field with the (next available) line number?

Gr{oetje,eeting}s,

                        Geert--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
