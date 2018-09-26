Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DDBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792D920676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792D920676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeIZNQo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:16:44 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43987 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZNQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:16:44 -0400
Received: by mail-vs1-f68.google.com with SMTP id y22-v6so1771325vsj.10;
        Wed, 26 Sep 2018 00:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e+HTNIJM+xn+xoUx++zPbQFgb49So6CykUMhycjkewk=;
        b=WV9UUEXTzDFaSyDdlTds7nz4aD8BH4Kjpc0OuZz/EIO7tGkQlVRJB4an+CraYh+89a
         YfAX3gE8G8Rs9HM0nt260ZHTryzmH99RtWVVmkfvuYlVZ+MGN0Mlsc/bnme/9RRzLaxG
         L5u00n0/uzAaZK7eDNh3YjfDBjOBPTepPpImgCF4t2YeM6QY4451mTFWUefxsMiWcm2r
         699bSGpoKgb1+FUFvBN3KY0n1qUIpBhG0rS7dJKMYEqNt96gQoKHQ+FluFMWY3za1vlG
         ZfT1wXilyNtiksRUKrbfGTpAcd6AibaDL5rmgr3MTD0ar5IFGSxJIfpaNyfVExXXH0sV
         Ay4Q==
X-Gm-Message-State: ABuFfogGB1HZ+fP5+zH4ZAbzp+U7xpdG0fRiUWTL1U9iXJiHLqXI1NIi
        CmP3ThEw4URhv2VweJnJCYGSpM2zP8BuJit8sI4=
X-Google-Smtp-Source: ACcGV60Nx27x7f9HmzoyqPToALt25Ks5eSZ1a/83hXDdAEn5OL7Vr+Kv0QXhaTK8Sf6u5SwMtc4CahH33GLD2WdBGBM=
X-Received: by 2002:a67:3a51:: with SMTP id h78-v6mr1234339vsa.63.1537945516501;
 Wed, 26 Sep 2018 00:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180926015147.GA14862@WindFlash>
In-Reply-To: <20180926015147.GA14862@WindFlash>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Sep 2018 09:05:04 +0200
Message-ID: <CAMuHMdXaAuHdCK8aeRucefn_GwkM-uYdFArOBPHD2gM5bdNRwg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Remove errors building drivers/DRIVERNAME
To:     leobras.c@gmail.com
Cc:     lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        oprofile-list@lists.sf.net,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

Thanks for your patch series!

On Wed, Sep 26, 2018 at 3:51 AM Leonardo Brás <leobras.c@gmail.com> wrote:
> This Patchset changes some driver's Makefile to allow them building
> using the command 'make drivers/DRIVERNAME', if compatible.

Please note that running "make drivers/DRIVERNAME" assumes that you know
exactly what you're doing. In the normal build process, you should just run
"make".

> The changed drivers would return error if the above command was run
> on them, after an x86 allyesconfig.

That is expected, as the DIO, NuBus, and Zorro buses, and PA-RISC and
S390 specific drivers are not supported on x86.
That is also the reason why you cannot enable support for them when configuring
your kernel.

If you want to enable e.g. NuBus support, you have to configure a kernel
for m68k/Mac, and (cross)compile it.

At https://mirrors.edge.kernel.org/pub/tools/crosstool/, you can find cross
compiler binaries for download.  Altermatively, your Linux distribution may
provide cross compiler packages.

> The main reason of this patchset is to allow building lists of
> drivers looking for warnings and errors to be fixed.

We already have COMPILE_TEST for that.
If you want to increase compile coverage, please look into adding
"|| COMPILE_TEST" dependencies to subsystems and drivers that still lack it,
and (if needed) modifying the code to make the result build.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
