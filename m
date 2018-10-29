Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD4C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42B32080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yhRfLMBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42B32080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeJ2WF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:05:27 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:20503 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeJ2WF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:05:27 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w9TDGdsh018015;
        Mon, 29 Oct 2018 22:16:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w9TDGdsh018015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540819000;
        bh=mtxxoCKlUoMFyowcP85HE/LxC+zp4AEGyBeBStcpg1I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yhRfLMBVeHnIji1EApF3MSxw0e8H0283zsw70fUqx/JPliwxgFzq1NyNOVTBoccI0
         4Dt4W/YXvISC8eFsWDK2fOP+TufLgaM45vee1GcfiCfO3QfBU7aP3K7Ob8kDwDfX2V
         Qz7yhH8YGB0FDlTaGShXm3SrlhJ4ob7R3EszohtwMvJC8FXgXL1NexpRF3kNkwF7wy
         /lR7ccZZkX61we3RZMAOUBVK748seWN2lUtS/aKIWA8cTg16QJ91XCQK7sV6hkBflU
         Hetd7Pe45yZA5GZvU/GsQxNkXwXsBLfrsTDS88jk0PoVFJdrhX5WCeaD2PXMrVxKOZ
         /VMdV7YQ23cgQ==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id d62so3440960vsd.2;
        Mon, 29 Oct 2018 06:16:39 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKlB4Jzx7uzeUfTVuIPZTfssI4Tlo04utmlXNQarmUqJJaV1SeI
        f/SOGUzS7U3NXk4F7wQYhNbPx7LEq34xjlgtu/g=
X-Google-Smtp-Source: AJdET5f2plpwbcd5U7l61DIiBItbwOSz/KDsGuy8sN7UbcKkXgtF/qVpDMyKM8MBCOypCRBAZL4o5UzOnJSzp3Klrdw=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr5905045vsm.181.1540818998694;
 Mon, 29 Oct 2018 06:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181028130945.23581-1-changbin.du@gmail.com> <20181028130945.23581-5-changbin.du@gmail.com>
In-Reply-To: <20181028130945.23581-5-changbin.du@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Oct 2018 22:16:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8UPXBbOpG9Zy_aP7an2jbq5H7uQGymUAn+hv46WQ4Bw@mail.gmail.com>
Message-ID: <CAK7LNAS8UPXBbOpG9Zy_aP7an2jbq5H7uQGymUAn+hv46WQ4Bw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING
 to apply GCC -Og optimization
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 10:11 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This will apply GCC '-Og' optimization level which is supported
> since GCC 4.8. This optimization level offers a reasonable level
> of optimization while maintaining fast compilation and a good
> debugging experience. It is similar to '-O1' while perferring
> to keep debug ability over runtime speed.
>
> If enabling this option breaks your kernel, you should either
> disable this or find a fix (mostly in the arch code). Currently
> this option has only been tested on x86_64 and arm platform.
>
> This option can satisfy people who was searching for a method
> to disable compiler optimizations so to achieve better kernel
> debugging experience with kgdb or qemu.
>
> The main problem of '-Og' is we must not use __attribute__((error(msg))).
> The compiler will report error though the call to error function
> still can be optimize out. So we must fallback to array tricky.


I removed the sentence "So we must fallback to array tricky."

Commit 81b45683487a51b0f4d3b29d37f20d6d078544e4
killed the fallback to the negative array trick.


I also resolved a conflict.

Your series is now available in the following branch.

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild kbuild


Please double check if I did it correctly.


--
Best Regards
Masahiro Yamada
