Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DF978C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94432208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CPJSkf8s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fTKdQpjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94432208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754604AbeFNGfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:35:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55592 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbeFNGfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:35:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E03A607BB; Thu, 14 Jun 2018 06:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528958140;
        bh=D8Htjk9Y6ajh7AQSVx04+GL2bsLe/rG8h9SPDZHjM9g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=CPJSkf8sTspQPzKmtaCaa84Hy+rT08hCegZRbFUKxyjnpDzo/vAL/3jQhzpYgRqN+
         BqZKSqU+FaXU6bzn8E7/FpHd9gng+NmZeJIzazE4QY/WCA5ZwNpSWuug6dMHXJGTON
         cV9buaS1mT+ynnoavKW7hqnS9uMGEroEZ6qubI40=
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com [209.85.220.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB3E8602FC;
        Thu, 14 Jun 2018 06:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528958139;
        bh=D8Htjk9Y6ajh7AQSVx04+GL2bsLe/rG8h9SPDZHjM9g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=fTKdQpjzA2rXe5c8/qBBnIERbltz0Au4t4eyjGUJoOIOFwWQgBAb8eS5sZQZBoeV9
         8AbC8dptxKOVaWzti44IJFTJUIFzUlxBG+ssSMRQ3K6Jw9UqdNacodybnaeXFSoFT5
         xvrl8+rvv6256kx0jq5bnTaeAsQBW9TEM06IhlJI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB3E8602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f176.google.com with SMTP id r66-v6so3030325qkr.7;
        Wed, 13 Jun 2018 23:35:39 -0700 (PDT)
X-Gm-Message-State: APt69E1FxM0fhuMAHn3d7ObKpu5A8cVAxEU6fyLXa714aH3vhIPVovrw
        0UqBlLXzvRVBBTM8+A/gX184D74YceaeZwYuQho=
X-Google-Smtp-Source: ADUXVKJk4m6rn2xwl4zOQvZDopKRrBqFvkLofVQFoKc23d36X9eZIHlALbH/+09fmyWB3euiUlBf+y6dxybA1AM6z+8=
X-Received: by 2002:a37:5ec1:: with SMTP id s184-v6mr999848qkb.284.1528958139025;
 Wed, 13 Jun 2018 23:35:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 23:35:38
 -0700 (PDT)
In-Reply-To: <20180613125401.11734-6-niklas.cassel@linaro.org>
References: <20180613125401.11734-1-niklas.cassel@linaro.org> <20180613125401.11734-6-niklas.cassel@linaro.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 14 Jun 2018 12:05:38 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFsLfKoLy+mzLP7-RGwSrkdA5sSt0UwNT7O6ehmn=VckQ@mail.gmail.com>
Message-ID: <CAFp+6iFsLfKoLy+mzLP7-RGwSrkdA5sSt0UwNT7O6ehmn=VckQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] soc: qcom: Remove depends on ARCH_QCOM
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 6:24 PM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
> we unconditionally include the soc/qcom/Makefile.
>
> This opens up the possibility to compile test the code even when
> building for other architectures.

Why do we want to do this when all of it is qcom specific?
Besides wouldn't this increase the binary size for other platforms

>
> Remove the depends on ARCH_QCOM for all Kconfigs, except for
> two Kconfigs that depend on QCOM_SCM, since that triggers lots of build
> errors in qcom_scm. However, that shouldn't stop us from removing
> it from those where it is possible.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 1d4a9f3ada8c..8c83025c466e 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -5,7 +5,7 @@ menu "Qualcomm SoC drivers"
>
>  config QCOM_COMMAND_DB
>         bool "Qualcomm Command DB"
> -       depends on (ARCH_QCOM && OF) || COMPILE_TEST
> +       depends on OF || COMPILE_TEST
>         help
>           Command DB queries shared memory by key string for shared system
>           resources. Platform drivers that require to set state of a shared
> @@ -14,7 +14,6 @@ config QCOM_COMMAND_DB
>
>  config QCOM_GENI_SE
>         tristate "QCOM GENI Serial Engine Driver"
> -       depends on ARCH_QCOM || COMPILE_TEST
>         help
>           This driver is used to manage Generic Interface (GENI) firmware based
>           Qualcomm Technologies, Inc. Universal Peripheral (QUP) Wrapper. This
> @@ -32,7 +31,6 @@ config QCOM_GLINK_SSR
>
>  config QCOM_GSBI
>          tristate "QCOM General Serial Bus Interface"
> -        depends on ARCH_QCOM
>          select MFD_SYSCON
>          help
>            Say y here to enable GSBI support.  The GSBI provides control
> @@ -55,7 +53,7 @@ config QCOM_PM
>
>  config QCOM_QMI_HELPERS
>         tristate
> -       depends on ARCH_QCOM && NET
> +       depends on NET
>         help
>           Helper library for handling QMI encoded messages.  QMI encoded
>           messages are used in communication between the majority of QRTR
> @@ -76,7 +74,6 @@ config QCOM_RMTFS_MEM
>
>  config QCOM_SMEM
>         tristate "Qualcomm Shared Memory Manager (SMEM)"
> -       depends on ARCH_QCOM
>         depends on HWSPINLOCK
>         help
>           Say y here to enable support for the Qualcomm Shared Memory Manager.
> @@ -85,7 +82,6 @@ config QCOM_SMEM
>
>  config QCOM_SMD_RPM
>         tristate "Qualcomm Resource Power Manager (RPM) over SMD"
> -       depends on ARCH_QCOM
>         depends on RPMSG && OF
>         help
>           If you say yes to this option, support will be included for the
> @@ -122,7 +118,6 @@ config QCOM_SMSM
>
>  config QCOM_WCNSS_CTRL
>         tristate "Qualcomm WCNSS control driver"
> -       depends on ARCH_QCOM
>         depends on RPMSG
>         help
>           Client driver for the WCNSS_CTRL SMD channel, used to download nv
> @@ -130,7 +125,6 @@ config QCOM_WCNSS_CTRL
>
>  config QCOM_APR
>         tristate "Qualcomm APR Bus (Asynchronous Packet Router)"
> -       depends on ARCH_QCOM
>         depends on RPMSG
>         help
>            Enable APR IPC protocol support between
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
