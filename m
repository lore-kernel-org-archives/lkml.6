Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CC3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CA42081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRWMfbIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CA42081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeKBCID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:08:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43937 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeKBCIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:08:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id r71so12696593qkr.10;
        Thu, 01 Nov 2018 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgwtFZkC/rR7koRrJEVoHDkT2WR/nSpGr7t0u1xCW7E=;
        b=dRWMfbIY0vHpLvHnKtS95RxAQRe4OFFNIuteYBqAC7kAPiJYKz/80JKem10zpHmUhB
         iyw5vUN93IfUrWkhh4H9zcZk3tffPeKugvp9gxpGPjmxt2RtoO0LiDxF814JS3ffA1xT
         MPm8Rm9gXACaSIO6JAKIDCK3E7TeOkAZ8yUK2dr3eGXbm43Nu5GWJl5RrJOQcVv5RyO1
         FcDNwuXKlVoh5/ZozX6l3E/fDBnL4y3OZayfOarkPOTGWh1WAK9cKvo3bHHqgm6ndOmC
         1hsOiFk4N6Tn+HxtwLErlyNQOsH1kD85LhzMWYlw6yX7PzZU0mA0m+GpjouFd3GRisRz
         e/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgwtFZkC/rR7koRrJEVoHDkT2WR/nSpGr7t0u1xCW7E=;
        b=bynke+9CuzWQPMUNXos/mScP0hyfoxJS+EaOOJnxrSfRGgvIPkyTjD7oN7qpQl0z1P
         rn9IomVAQHt4WHR8+a05A6opj9ZMBxUC8Gp30O6r+EAUaO2Cmvxb05p09NPnZRh6p8Z3
         RPeV8YIU8e5d/f6z09RoHV9XXqUY0UtGLGspsEHeTF2U0WLfzQuyUdg3iACEqlhtrTVU
         KW7fmNbVwjnWLgDAnyiUO9CWcChb1ed1PVYKLPbQQJy1clXWgW+t1/A6cqUA9qnU9Caf
         ual2K5Mwlu+lGG1vGqau9SviEd2xC8HK3s+LLze6F8NlM5RIDrhmiwHPd+5Cj1RYR92D
         caVQ==
X-Gm-Message-State: AGRZ1gIkcWD6KixKxXGSWv1HjFyrbQijaoRa+gUJUbGXpHipNDSemoqJ
        nkXyctr87DnZ0MOerOLFXRLmf9ex+IfS3m0u++I=
X-Google-Smtp-Source: AJdET5ffotE2aCRaWlgJzyYe5LJiHvS6ZTiw5uC01dgaJQYsSBphiNcF51BLfeX9rG9/8qAxrk/Y22/mIXG3cp7l3xY=
X-Received: by 2002:a37:7983:: with SMTP id u125-v6mr6883413qkc.219.1541091853184;
 Thu, 01 Nov 2018 10:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn> <1541085002-42993-6-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1541085002-42993-6-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Nov 2018 19:04:00 +0200
Message-ID: <CAHp75VfNDKgenuc0ApMODfCw6h9azwBDskPuV2S4E8nLFsuTxw@mail.gmail.com>
Subject: Re: [PATCH V5 6/8] misc/pvpanic: add MMIO support
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 9:00 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> On some architectures (e.g. arm64), it's preferable to use MMIO, since
> this can be used standalone. Add MMIO support to the pvpanic driver.

> -       if (acpi_dev_resource_io(res, &r) {
> -               port = r.start;
> +       if (acpi_dev_resource_io(res, &r) ||
> +           acpi_dev_resource_memory(res, &r)) {


> +               if (r.flags & IORESOURCE_IO)

You need spend some time to understand better how acpi_dev_resource_*() works.
Hint: this condition is redundant.

> +                       base = (void __iomem *) ioport_map(r.start,
> +                                               r.end - r.start + 1);
> +               else
> +                       base = ioremap(r.start, r.end - r.start + 1);
> +


-- 
With Best Regards,
Andy Shevchenko
