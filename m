Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60B5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8996720878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubVUa2h/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8996720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbeLFRNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:13:07 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38508 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFRNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:13:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id e12so1100209otl.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6A0R4UMIWpK2qb6dozgV9FrCdbsazP6YEg3wAf6S7E=;
        b=ubVUa2h/R0L7xrZ92dHenhp7r72ArPn0tBpuldMbN9F/ziHEh1ErameJxJEsTPNv5G
         Asw2Q9RxAsQaYqWor0LUnJqsIs3HYUEwu48MRPqkAu9owzTbXzkeh8BN4JEHOJmqhecZ
         GBcwsgmLdXd8D7wQPfAV+oBCMbYXTqn5EeFlar70b4PO9k6DVs6wRtjETHEloCUsSsr5
         yAJke7tYKiAZDrCNDFnYeFqF3NC6U0+nk8bzQXP/fw5rBVNw/JRHkGReVWIJBMLCOpFO
         xH5vOCY7oxV2OXQI0PGU/6V8xYf5q3heEpTN9L094iQdJ79gakugJDRt5DXbLxFLcW5z
         kdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6A0R4UMIWpK2qb6dozgV9FrCdbsazP6YEg3wAf6S7E=;
        b=cfd4j4P4u2uZTxCU2Vh+ZZi6jOdejJkmEeYTSP1eciajJeMSW0VvWGXlpwytJ+EBmc
         Loj6ctyXVxjGoWcL6jzKuQatBEZOMufzC31L0bEV3gUgXenS0suvsRp3Kh4+PbKeyWGp
         Ck0/IrQRRK4m75rgTNb0ZENwiNNTa1PGY8JVdoe21h27dELPxjvRdAzH1M5C3B6+nQiu
         QAGkFJhTAfdUlUdBx0Ilbh8Oi3Nd+SyIrHgA/tirS3vRpUOhQKuxX8LJGv8gHFWTLJWc
         10+cCnP/MRoZgtAQK7mjwGcfPjsRQiWIU4p3ywUuXap0pSin6jidd0amQ2T6aYhUeQRZ
         2iyw==
X-Gm-Message-State: AA+aEWbdOlzd1QI3uv5EF722KZYCGAL8yMrkQJlQubLfgjvlygOSA8bt
        ByV0A4+a8z+oci0soS4nQK2F3poIoVevaZh3PCk=
X-Google-Smtp-Source: AFSGD/U/M20i9kXNyL8YT14AYoKoro57rNRPqDpPEhabNQcMFl6HIPwPRKDVJ35DYyXl2/47O5TghyG6a3sKzZhdU7c=
X-Received: by 2002:a9d:7cd9:: with SMTP id r25mr17646182otn.110.1544116385932;
 Thu, 06 Dec 2018 09:13:05 -0800 (PST)
MIME-Version: 1.0
References: <20181206150156.28210-1-david.abdurachmanov@gmail.com>
 <20181206150156.28210-2-david.abdurachmanov@gmail.com> <CAGXu5jKevZHDW8hRAAh_muFUXsg-WOVCYh3HczjY5qKtR=wYNg@mail.gmail.com>
In-Reply-To: <CAGXu5jKevZHDW8hRAAh_muFUXsg-WOVCYh3HczjY5qKtR=wYNg@mail.gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Thu, 6 Dec 2018 18:12:54 +0100
Message-ID: <CAEn-LTpVeULecL3JGRDjQcdZTh9yfqXsrirrxcAamYdX2jRkew@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: add support for SECCOMP incl. filters
To:     Kees Cook <keescook@chromium.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        luto@amacapital.net, Will Drewry <wad@chromium.org>,
        Green Hu <green.hu@gmail.com>, deanbo422@gmail.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 6:07 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Dec 6, 2018 at 7:02 AM David Abdurachmanov
> <david.abdurachmanov@gmail.com> wrote:
> > The patch adds support for SECCOMP and SECCOMP_FILTER (BPF).
>
> I built this against linux-next but it's missing seccomp.h. Was that
> accidentally left out of the commit?
>
>
>   CC      arch/riscv/kernel/asm-offsets.s
> In file included from ./include/linux/sched.h:21:0,
>                  from arch/riscv/kernel/asm-offsets.c:18:
> ./include/linux/seccomp.h:14:10: fatal error: asm/seccomp.h: No such
> file or directory
>  #include <asm/seccomp.h>
>           ^~~~~~~~~~~~~~~
>

I forgot to add it...
Will fix it.

david
