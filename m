Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B90C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C52F222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbfBNIK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:10:27 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34130 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfBNIK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:10:27 -0500
Received: by mail-vs1-f65.google.com with SMTP id e10so3136512vsp.1;
        Thu, 14 Feb 2019 00:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7mH6uc/WErzysdhYHrwGn+Za9Ii5z+9SMgUHEvVd2c=;
        b=n5TD9eepwxpjCsmohVDD8Xxu3e92SP7bFHAf7eEa9laoZn2F9cc9nZeyIrCll2qcfx
         gbCb/S8iNRTssTBPYME1j4JLInA6q0Y3R6Wl9iThQAbRprl2oaHmjC148Gzn2PsSFRVq
         HA5a9zOpyDwx8s06gwOr6+pS7hrHjzuQaeU563nMEz5rUdyCjQowaYXxbEpTjAF8V3TB
         aTL4U/Hk8srAaDWEoLh4Ibzd8tMXRrA8ZhRnKR92rVEvR6wOYWx63vW84eEKnEyW9LXr
         RTopBkkylNNwW7t4eJdzZdreBuGwTcy0zeG5b8Tx0PAEPkm2lXeg6ctznSpeDvpQ9Qfw
         NbDQ==
X-Gm-Message-State: AHQUAuZnNW3aqdtEewfUi2ELUD/u8WutE5pkm5iMXmvw/jqxhC8LWVg8
        OBL57aQZKPQYXlF6hotEnHxcwxcJ0MAlYIe1+R8=
X-Google-Smtp-Source: AHgI3IainHdtNgPKfyU8YjSDdQ+iRTA5h4usd5PDFEqXOlRT2t4Q7Q4DByDOzAkMWCZQ41k3lVfXLhI1reoT4R3LmvA=
X-Received: by 2002:a67:f43:: with SMTP id 64mr1331176vsp.166.1550131826029;
 Thu, 14 Feb 2019 00:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-4-hch@lst.de>
In-Reply-To: <20190213174005.28785-4-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Feb 2019 09:10:14 +0100
Message-ID: <CAMuHMdWRPm0_u2EX5OXeraZdKL602RJvbO5aKm09Sf-HKMGzjg@mail.gmail.com>
Subject: Re: [PATCH 03/11] kernel/locks: consolidate RWSEM_GENERIC_* options
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:08 AM Christoph Hellwig <hch@lst.de> wrote:
> Introduce one central definition of RWSEM_XCHGADD_ALGORITHM and
> RWSEM_GENERIC_SPINLOCK in kernel/Kconfig.locks and let architectures
> select RWSEM_XCHGADD_ALGORITHM if they want it, otherwise default to
> the spinlock version.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/Kconfig       | 7 -------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
