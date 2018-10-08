Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111CEC676C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C027620652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W48E6MMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C027620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeJHTDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:03:11 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52114 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeJHTDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:03:11 -0400
Received: by mail-it1-f196.google.com with SMTP id 74-v6so11047762itw.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 04:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X9Aute8ZUC3dPos1MQwm34+FQZ1sSwi/wPcFVLmSfHY=;
        b=W48E6MMdw+DH3TSG8HCoJBoFUrW204hSJZFk9Q2c0LtRNKNMQ1NBpOwXgwqp8zvmzj
         I2dOILkTV2HcifGjwAmgsevwQ5jH3a/GwAAYhc2D6p63Zxhcu4lwbo8TFsoihiyCxbhq
         YgYxN081pyaLAMcFLmi0BGExdPLmn9nyRiFAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X9Aute8ZUC3dPos1MQwm34+FQZ1sSwi/wPcFVLmSfHY=;
        b=a/pCwURA8hbLlnW2dvUCpH89zYwRFWMOCIPt9qUvoRxuIMnDYIrn2MRNb///zjSlSQ
         YEFqPFuq09EG2/HiTb0gLW9AKUWYx57KGTzW+UAkdKbNQWy3Hdbp1dwpLzdgtsZPt1Be
         5kDBddThIHmmbR2q/WbCprC43Z+QXerc5DKBaKNHMYJ6P2UjIK1sHn3a3GL3xPEek/Z3
         /z9NjgDTIQBu6P5bMqbWjBzBI6lKwBDghQx5jve/j0CiQP1NPEp/PWqs5SW0lG5rOZhC
         ZY53yQcmTQ8y30pTDC1LPjdsEZAG5q05U19/+fphWq+CoWRTn0BsFQ0/65WzJvvALNFZ
         VvLw==
X-Gm-Message-State: ABuFfohBjGepCuqIAmo/IzajRpO5w7VSv5Yo7IR0WdVm4H9GPfggYD5b
        MTwrPd7oJ1YNcsNcQl9VIujZULZ97lfSp327V8YbvQ==
X-Google-Smtp-Source: ACcGV60cABD8Bnok8wafhgwuDgvuuyUG5KvMCd0KUur9rdIcLls637iSfAqtv6v/W6xBR/FJIfIjV9IZWRe0HdiQ7BQ=
X-Received: by 2002:a24:8045:: with SMTP id g66-v6mr17455231itd.45.1538999509017;
 Mon, 08 Oct 2018 04:51:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 04:51:08 -0700 (PDT)
In-Reply-To: <20180927140738.1006-1-linux.amoon@gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Oct 2018 13:51:08 +0200
Message-ID: <CAPDyKFp-gnxqknz1ic5jrQ2G0M3X9rMVgj9sWeOiWOX+S7VODw@mail.gmail.com>
Subject: Re: [PATCHv5 0/6] Add support for UHS-I on Exynos5422 odroid boards
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 September 2018 at 16:07, Anand Moon <linux.amoon@gmail.com> wrote:
> This is series v4 since my previous patches were incomplete with driver
> changes missing.
>
> v5 changes.
> drop the cd-gpios wp-gpio gpio pin setting, just add the pinctrl
> configration to support write protect.
>
> v4 changes.
> squash cd-gpios and wp-gpio changes into single patch.
> change the subject prefix to "ARM: dts: exynos:"
>
> These changes add UHS-I tuning for dw_mmc-exynos driver.
>
> Rebased on Krzysztof branch next/dt
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
>
> Anand Moon (6):
>   ARM: dts: exynos: Added UHS-I bus speed support
>   ARM: dts: exynos: fix regulator min values of LDO13 for Odroid XU3/XU4
>   ARM: dts: exynos: update maximum frequency for sdcard to 200MHz
>   ARM: dts: exynos: Add pin configuration for SD write protect on Odroid
>     XU3/XU4
>   ARM: dts: exynos: update maximum frequency for emmc to 200MHz
>   mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode
>
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  7 +++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 ++++++--
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
>  drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
>  4 files changed, 25 insertions(+), 2 deletions(-)
>
> --
> 2.17.1
>

Anand,

I have applied the mmc patch for next, thanks!

In regards to the DTS changes, I assume the soc maintainers will pick
them up, but maybe you need to resend them separately.

Kind regards
Uffe
