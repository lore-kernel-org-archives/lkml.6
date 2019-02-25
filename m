Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70D820842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551113592;
	bh=AkldCmnHFNxibYlQL0OLyZmnxoLqAKLeIXIJHDE+6J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yt97/Ov6xNNitQV1LqgAQST/YJBso/Jla672d8+L9C7tpnIM1IL5J6CxRnvpeJRf5
	 ypE55IxvE/+sJvTO4Vo1Zn4gDpsO5B/AZJDXDU1uc7rdXQOSYTaLYhWvH6x5B4Zknt
	 jjc/1voZ55h1/PkUeyCH1nxIVfqDKHwtd2Xppx6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfBYQxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:53:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43595 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfBYQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:53:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id n71so8402968ota.10;
        Mon, 25 Feb 2019 08:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8CIZ6kZBu1TZgHpB6AGWCKL+TVXxUEmUGJjZB7ZF4Sw=;
        b=eC9TnP9xBelF7uJzdZKaP5dPj9ny27nC0SaoRZndzc/y6A19pSvOURFCUe2CncnKiP
         BUwJThvya1BTOOUcuTAyX0u84DlLbLYG6CvXbNcr8D5AgeQHu8TtO2eg697gtRs4BRTS
         d8tthv/jL1sPk0iU4aix+XRp0rcjh1bFY/x8uVIquFg3dmC3t+3DkWiLS6GgRPYgmqzv
         5DBKXPIdvC+Y+cYl0Pe6zsLa1g8zE48SngaQyONqFXTLjqM5FB9lHx9/e7W/OmNB40if
         ERd44wyTVAkNd0pflca5W6l8l5Z1iGXn0NrcCBdAXV8KzyDuopn1cQE0zzgsxNrRB57R
         77UA==
X-Gm-Message-State: AHQUAuasN/+T6rhe2WE5z9WscNsUSJjhR24DflaJBVVzRC1wiroJkQ6m
        pp+bwLcMJJ4r4xGoJxy/xQ==
X-Google-Smtp-Source: AHgI3IaeSSxCMa9nMXe3qaDYnwDKmYUw1l5TNoVBh3WHVzVCS5vaJFU040tFbrpHbTUG+vGt+abUsw==
X-Received: by 2002:a9d:3f7:: with SMTP id f110mr10226971otf.174.1551113588926;
        Mon, 25 Feb 2019 08:53:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm4187293otl.69.2019.02.25.08.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 08:53:08 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:53:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     srinivas.kandagatla@linaro.org, alexandre.torgue@st.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        lionel.debieve@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: Add STM32 factory-programmed
 romem
Message-ID: <20190225165307.GA26260@bogus>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
 <1548866336-14765-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548866336-14765-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 05:38:53PM +0100, Fabrice Gasnier wrote:
> Add documentation for STMicroelectronics STM32 Factory-programmed
> read only memory area.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> new file mode 100644
> index 0000000..fbff52e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> @@ -0,0 +1,31 @@
> +STMicroelectronics STM32 Factory-programmed data device tree bindings
> +
> +This represents STM32 Factory-programmed read only non-volatile area: locked
> +flash, OTP, read-only HW regs... This contains various information such as:

Several distinct types here. Does s/w need to know the difference 
rather than just one generic-ish compatible? Access size restrictions 
maybe? Ability to unlock and program?

If not, then why even make this stm32 specific?

> +analog calibration data for temperature sensor (e.g. TS_CAL1, TS_CAL2),
> +internal vref (VREFIN_CAL), unique device ID...
> +
> +Required properties:
> +- compatible:		Should be one of:
> +			"st,stm32-romem"
> +			"st,stm32mp15-bsec"
> +- reg:			Offset and length of factory-programmed area.
> +- #address-cells:	Should be '<1>'.
> +- #size-cells:		Should be '<1>'.
> +
> +Optional Data cells:
> +- Must be child nodes as described in nvmem.txt.
> +
> +Example on stm32f4:
> +	romem: nvmem@1fff7800 {
> +		compatible = "st,stm32-romem";
> +		reg = <0x1fff7800 0x400>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		/* Data cells: ts_cal1 at 0x1fff7a2c */
> +		ts_cal1: calib@22c {
> +			reg = <0x22c 0x2>;
> +		};
> +		...
> +	};
> -- 
> 1.9.1
> 
