Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B01ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D4B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SAB6+Seg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U9pluZ0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D4B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbeGLU10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:27:26 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:46238 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeGLU10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:27:26 -0400
Received: by mail-ua0-f194.google.com with SMTP id r18-v6so19225773ual.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y7o8j7oaQpA2ZdCXzGmoaLFXG7b1U2dgDmoZ+vmzfFo=;
        b=SAB6+Segig866OVqGC+/s14ScQfmB+co99d0ktQGvLtm4SdrC5VWWE5xTlBv8+B+4C
         66XQLM/0Hr2QUkv1tK5YC5dnzyNQK5uLTxaFLFxW22C2PjtYRTPvelwWz2v8nPIHNkCE
         nEmmUsj5tKB5dlyl53I+99lWG4HHbgzY8CeuGujftzjafR0PMF4HecXiyC/UL/0689A9
         KsfDOlJ43EENDyL70MyUIpaNR01fmGjz7O1zAt/XjwQTnV6q3umSIhBFAY7wrvX31+vT
         dE0zuJAMuoW/MZ35ah5z0Z8NF9/8r7Uur1QaMx0Tx8BvYE1zvUIxo422TSDsx8mCsP0z
         o+Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y7o8j7oaQpA2ZdCXzGmoaLFXG7b1U2dgDmoZ+vmzfFo=;
        b=U9pluZ0V9D0ipoNWGonmkVOS9ZXDFfs7B8Unze4UYrqHsM2xhG+9msepMgAw4hunmo
         9t8h42lowHrvSHrH2Qj6fBxN2J0R5tg0sXyjgid5d72LaIQ0myV0etqVQwagDhjZwk4C
         yxxhm9XwmVZu8IGFOQHEGCZs3I4AUg9pmQzUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=y7o8j7oaQpA2ZdCXzGmoaLFXG7b1U2dgDmoZ+vmzfFo=;
        b=GU78Ek2XcyoSDPzQ+0S3OUM/qUcRQ1RYrl97138lOc+xiUiVMyhUnQO7EKLz2NYnWC
         hLj2aHUu5xMa+x1dEDNDUp99lB8X6s1/+t594q5VAXNjo/Iy5n8lcXmsxJB+NsUCefTV
         F8ndJAEUqPDCr3yakLbE8nUCt3ldL0fqjpYB0jwDo28aufJNW//lq4cgs7P7En+DWOIa
         t6auFQwbshCvzn+0WMtHQ9RpNOmSlXAU1zUtYFfg96Ylv7ZyYhHfLx7NbbcqayhJf9rA
         wMjQtOUzTTESJFT6HoUKKknVS/Jf+yxkkEJ5XFuxiJWET3StBA89GDAiRO668GGMWPcb
         HG6g==
X-Gm-Message-State: AOUpUlEoMiTiUwBnHjp543yHriaIvSzFaO+2wVV/rjeII3iKxCXZHcVX
        BueR79O28zHsJDuzUinVJlnqdmr4mqJQzrgJEE0ObOVW
X-Google-Smtp-Source: AAOMgpdhPqQNOD/F8eEDrjqzjfzVs8fdfD8Nj+jv58XUphFIJsXwdqWk5V0Wll1B9egCtvKylXp3a70xLNKnAYOhZWE=
X-Received: by 2002:ab0:11dd:: with SMTP id q29-v6mr2374447uac.191.1531426577133;
 Thu, 12 Jul 2018 13:16:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 13:16:16
 -0700 (PDT)
In-Reply-To: <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org> <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Jul 2018 13:16:16 -0700
X-Google-Sender-Auth: Kdo3W1OruG1wWPmcEeT7BVNfYME
Message-ID: <CAD=FV=W0NUFw1u5Zb2dXrpBp75C2AFXzrVtCSF_fXFnRXbET_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
To:     Girish Mahadevan <girishm@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        boris.brezillon@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 5, 2018 at 2:46 PM, Girish Mahadevan <girishm@codeaurora.org> wrote:
> New driver for Qualcomm QuadSPI(QSPI) controller that is used to
> communicate with slaves such flash memory devices. The QSPI controller
> can operate in 2 or 4 wire mode but only supports SPI Mode 0 and SPI
> Mode 3. The controller can also operate in Single or Dual data rate modes.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  drivers/spi/Kconfig         |   7 +
>  drivers/spi/Makefile        |   1 +
>  drivers/spi/spi-qcom-qspi.c | 728 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 736 insertions(+)
>  create mode 100644 drivers/spi/spi-qcom-qspi.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 97e1fa9..bc71cd3 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -571,6 +571,13 @@ config SPI_QCOM_GENI
>           This driver can also be built as a module.  If so, the module
>           will be called spi-geni-qcom.
>
> +config SPI_QCOM_QSPI
> +       tristate "QTI QPSPI controller"
> +       depends on ARCH_QCOM
> +       help
> +         QSPI(Quad SPI) driver for Qualcomm QSPI controller.
> +
>  config SPI_QUP
>         tristate "Qualcomm SPI controller with QUP interface"
>         depends on ARCH_QCOM || (ARM && COMPILE_TEST)

I tried to apply your patch and `patch` complained that it was
malformed.  In fact it is.  The numbers above say that there should be
13 lines in the section above but you only have 12.  Did you manually
munge the patch after generating it?  Please be more careful.


-Doug
