Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E39C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DD820652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5yKtW/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DD820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeJHWNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJHWNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:13:18 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F82120878;
        Mon,  8 Oct 2018 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539010869;
        bh=4QCRMRp0Hx+rOxWRmocnfvcaD62jpdnt12g1qjYb5p0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P5yKtW/Tstgj6osd4/ZamXyXGb+SMsHJVIbzU3Ig9RJRnkRb9NTL8kF8EABlJC6Lw
         46EJ0H3xmcKHCDOIuHZZCK6+jFTVOZ/XsMWemrTPbxhLY6umqJmKMyFkJtKgtDA+04
         GXZwpf0VhoN6XMbAlr2RDJ5OeHlKnsXKEVJz95MM=
Received: by mail-qk1-f174.google.com with SMTP id m8-v6so12222184qka.12;
        Mon, 08 Oct 2018 08:01:09 -0700 (PDT)
X-Gm-Message-State: ABuFfoiOXsScQRZEilRrWxXEe9+KY+kwaRSbvGnCuAIhNe7fZgjbNCQ0
        QyeXt0thic61CCiXQp50/685ZCjC0hSIfDC14g==
X-Google-Smtp-Source: ACcGV63PeBf+j6t0Duwmd906INGCpERipbUPctdTF48TReH6Qkmjokxk5dF55K/zsBrxm6LZcOHJEg1JZPTKX59LZis=
X-Received: by 2002:a37:9201:: with SMTP id u1-v6mr13346177qkd.29.1539010868778;
 Mon, 08 Oct 2018 08:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <1e4e9047636e94dc2bff62b915bd0261f334dd8a.1538999925.git.michal.simek@xilinx.com>
In-Reply-To: <1e4e9047636e94dc2bff62b915bd0261f334dd8a.1538999925.git.michal.simek@xilinx.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 8 Oct 2018 10:00:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL445pSkwmjet7BrSa5gLeAtf9R9fgdi-GApqfLK672tg@mail.gmail.com>
Message-ID: <CAL_JsqL445pSkwmjet7BrSa5gLeAtf9R9fgdi-GApqfLK672tg@mail.gmail.com>
Subject: Re: [PATCH v2] of: base: Fix english spelling in of_alias_get_alias_list()
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 6:58 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Fix english spelling in of_alias_get_alias_list().
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: b1078c355d76 ("of: base: Introduce of_alias_get_alias_list() to check alias IDs")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Changes in v2:
> - Fix 2 more issues reported by Randy Dunlap
> - Add fixed log sha1
>
> Greg: Please apply it on the top of tty-next because patch is going via
> your tree.

Acked-by: Rob Herring <robh@kernel.org>
