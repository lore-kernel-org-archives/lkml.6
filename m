Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16366C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80712084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6cPrSQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfAUI2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:28:55 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38633 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbfAUI2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:28:54 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so12108838vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPt9zQ5JJ6/6xe3JL33xGYAfShQ/WDBd87OhBvAcO2Q=;
        b=J6cPrSQaSZD9zbF1SUHk77k/I36CABmF3o72CJteRV5wEFiD1ZjVwNg6MaXOKXBpAd
         JK7WcZrDy8sAjgWrGxhRN0gJe7Rz2ZzQAVwWFlhBQMVBPgzYZQGXO3GQ9OEXy8GE9NUf
         ot2KjABQieWqSOK9d+Wj+LCmsnN0cS1WCJi58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPt9zQ5JJ6/6xe3JL33xGYAfShQ/WDBd87OhBvAcO2Q=;
        b=eNR8BB8XjUFPcmm57kTUfQ7BuXBmM/O1xkBZgb1FNi5ksKjMyWNu/PdjRtT/SUY/33
         euee+JLHMp4aj54BZ3QLNnE8MPpMmOsZ0K7BRA/TWzloWrFCDpvXQd2pkhVxApmR+P+x
         wUcP/N4quJmS9KsSSglw5icOeAw2Phk5p1JkNJxEcELrU3sVmqGCj7g7mlV5k5KEAEvN
         gc386CMcbRfY/uwC55iKEeosOj+Fc7qdkrg+oQzaR9YwipId0i7osG05/QoxzNQG9lo7
         IM0W95EBkdtJ6aGmOQ/LAoK4RqBRYOM58XWt08iRJo7v+U96P+6hBDAqOmHcRdsdUfZo
         Br4Q==
X-Gm-Message-State: AJcUukfkId+uI1cJ6xU8HfxQ10bER7mxlmnQj91Budwqi3yKdtAwRI7Q
        RpnpephFAdjEM6SAGoHkCTRsn7mft4itHZSU2fKchgdmNF0=
X-Google-Smtp-Source: ALg8bN6dK35e2kBxbLVXT6XRZFa3/LFN0O5ZgHAjs8kTteyxAf7zQ8z4zYujS6S4di1y2KSqqV1R99Mj1B5p9ontk/Y=
X-Received: by 2002:a67:7ed8:: with SMTP id z207mr11181196vsc.159.1548059332848;
 Mon, 21 Jan 2019 00:28:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547494994.git.amit.kucheria@linaro.org> <3f8a0c7a8701446abe02f1e35d412d72d9c1f0f3.1547494994.git.amit.kucheria@linaro.org>
In-Reply-To: <3f8a0c7a8701446abe02f1e35d412d72d9c1f0f3.1547494994.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 21 Jan 2019 13:58:41 +0530
Message-ID: <CAHLCerMLYec-jf151xPbNB0RxT+wvJ87nGY3_4jwS7rQwt+hCg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] MAINTAINERS: update list of qcom drivers
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>, marc.w.gonzalez@free.fr,
        Bjorn Andersson <bjorn.andersson@linaro.org>, kvalo@adurom.com,
        joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 1:16 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Several drivers didn't have a specific maintainer (other than the
> subsystem maintainer). Add some generic regex patterns to capture most
> qcom drivers in the list of supported drivers. For the rest, add
> explicit filenames.
>
> Sort the entries, while we're at it.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Hi Andy,

Do you need another revision of this or is this good enough?

Regards,
Amit

> ---
>  MAINTAINERS | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32d444476a90..a2b21a622ae1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1948,19 +1948,37 @@ M:      David Brown <david.brown@linaro.org>
>  L:     linux-arm-msm@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/soc/qcom/
> +F:     Documentation/devicetree/bindings/*/qcom*
>  F:     arch/arm/boot/dts/qcom-*.dts
>  F:     arch/arm/boot/dts/qcom-*.dtsi
>  F:     arch/arm/mach-qcom/
> -F:     arch/arm64/boot/dts/qcom/*
> +F:     arch/arm64/boot/dts/qcom/
> +F:     drivers/*/qcom/
> +F:     drivers/*/qcom*
> +F:     drivers/*/*/qcom/
> +F:     drivers/*/*/qcom*
> +F:     drivers/*/pm8???-*
> +F:     drivers/bluetooth/btqcomsmd.c
> +F:     drivers/clocksource/timer-qcom.c
> +F:     drivers/extcon/extcon-qcom*
> +F:     drivers/iommu/msm*
>  F:     drivers/i2c/busses/i2c-qup.c
> -F:     drivers/clk/qcom/
> -F:     drivers/dma/qcom/
> -F:     drivers/soc/qcom/
> +F:     drivers/i2c/busses/i2c-qcom-geni.c
> +F:     drivers/mfd/ssbi.c
> +F:     drivers/mmc/host/mmci_qcom*
> +F:     drivers/mmc/host/sdhci_msm.c
> +F:     drivers/pci/controller/dwc/pcie-qcom.c
> +F:     drivers/phy/qualcomm/
> +F:     drivers/power/*/msm*
> +F:     drivers/reset/reset-qcom-*
> +F:     drivers/scsi/ufs/ufs-qcom.*
>  F:     drivers/spi/spi-qup.c
> +F:     drivers/spi/spi-geni-qcom.c
> +F:     drivers/spi/spi-qcom-qspi.c
>  F:     drivers/tty/serial/msm_serial.c
> -F:     drivers/*/pm8???-*
> -F:     drivers/mfd/ssbi.c
> -F:     drivers/firmware/qcom_scm*
> +F:     drivers/usb/dwc3/dwc3-qcom.c
> +F:     include/dt-bindings/*/qcom*
> +F:     include/linux/*/qcom*
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git
>
>  ARM/RADISYS ENP2611 MACHINE SUPPORT
> --
> 2.17.1
>
