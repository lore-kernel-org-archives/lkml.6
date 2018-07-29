Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3CAC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4FC20892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 14:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhbMr9PH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4FC20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeG2Pv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 11:51:58 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40456 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbeG2Pv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 11:51:58 -0400
Received: by mail-ua0-f196.google.com with SMTP id p22-v6so6233640uao.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bcaOIW6dlRxI7z2ltrMiE3Oo+t0bKIVdvIrsjypv8yk=;
        b=uhbMr9PH4bKUniL/sGFc3KgONnVTWLQ6wGVxfeOSPIVbyo3zAHX4gMoiulrNtV6Xos
         9iDXwEMm/qhF84kLUT21UrLqNnc1U9WBlMdLnJkr+IKbrkxCidJPaX2b0QqX1jA3dhHt
         igLrBQJbVlvUDVsUNABhA32YCaYhfolU1pp7c6Wcn5Tyz4tnj0V7NCxD9VOGy+EYJY5j
         6dl+M0VWRdBiZVhcp8z1xDiEk7lQG7xrRFLiqGj7NM+bMcMstCHFcj3XJjgYe64jqmaT
         ORaZL5NecHqFVEJuwsxoymLbSEsXMLf4zCHjHbw5hkna/pJERQU9XFmxYmVP8vFyBDLW
         yZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bcaOIW6dlRxI7z2ltrMiE3Oo+t0bKIVdvIrsjypv8yk=;
        b=msadXirwbsVWzoo/w8Ff1bkxin4qHztq0mC/2Ttqa/xRjNxGY5EWvlobAtXolqBOh1
         ZO1on7f6X9yyYtkhsSSRqOS+zAff7yuTH9HOVaTkzSSp1Pr/IDZS8q2SM8coEayUMawb
         eucFRoh/QxRKEDbnifQHzALx0Nf24ap05o8iDAuU3QdjKe7I/0nWDNM4Z+2N9c1hlr/N
         r3rlLPyMam/3MrjOtkKSeoIj9Q9DUh3wj6CTeg9DWedWUzK+6TDx9rykLpZVSa/DEwPW
         2XpS5odqH/J/nvIWGAPjVZdw0dPGCuVV2HFr4wx6eN04mTTUckc+kiROJcNh652RljKp
         fUSw==
X-Gm-Message-State: AOUpUlFIzG5N7CRhpbZJrJg4nsontM/ckD4WwVzx1nhy+LhhQ42ZQvkA
        ae4+IIJ3P8YyYZh73DPHZTSTGk+qRiqfFH6q0uQ=
X-Google-Smtp-Source: AAOMgpdbHoCBVg8+pVRm2TXLJ2DS0waHoqY+EseNC/7gbFzoheaZcyLd2l+C/0MGIQdGLL3GMPunQHDsGyXBOMBdteY=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr9735622uad.12.1532874081081;
 Sun, 29 Jul 2018 07:21:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 07:21:19
 -0700 (PDT)
In-Reply-To: <e14dedc721b7aed1cf3ff1bdbc09014c0131c276.1532795905.git.joe@perches.com>
References: <e14dedc721b7aed1cf3ff1bdbc09014c0131c276.1532795905.git.joe@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 29 Jul 2018 17:21:19 +0300
Message-ID: <CAHp75VcvdAVWCuUpj+aQeD5aEU1LM1SjOPJ7_1hdQnQiya36SA@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: Convert uses of REG_FMT to %p
To:     Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 7:39 PM, Joe Perches <joe@perches.com> wrote:
> Use %p pointer output instead of REG_FMT and cast the unsigned longs to
> (void *) to avoid exposing kernel addresses.
>
> Miscellanea:
>
> o Convert pr_cont to printk(KERN_DEFAULT as these uses are
>   new logging lines and not previous line continuations
> o Remove the now unused REG_FMT defines

> +       pr_alert("Unable to handle kernel %s at virtual address %p\n",

> +                (addr < PAGE_SIZE) ? "NULL pointer dereference" :
> +                "paging request", (void *)addr);

Hmm... This is what printf() should take care of.

Petr, what is the status of your series to unify this kind of
addresses to be printed?

-- 
With Best Regards,
Andy Shevchenko
