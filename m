Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DBFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1868921755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1868921755
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbeHNAcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:32:03 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34761 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbeHNAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:32:01 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so16387540ioj.1;
        Mon, 13 Aug 2018 14:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LPXTQfapscXylWkPR7SEXzXrYHKBkgv/EkvtxS2YDV8=;
        b=OqegXrXogLfZMv2EQcg9kIeYgYL6/ESQdxklThMlwInCfGWSQxHL7yotOhC2lihPaM
         464V2HICFPfwBRptaWz8CzUGSrC/nP2Ueyfup23RItqRTjKgdBuqoaefU9EpLrl12MYg
         gy1GnfQHXeyySYPhBZbIuPbQCnGdaWPcEVuCAH8Pp6fnAaqhSiuiCjU1jmc85LEobqhP
         On2VtVBjh0J52FP/e15yaEJNXfHNjbrGqgILtUGP3juts2THRqwZdAO5r8mBpadEXMOg
         JCk83kJrJDYg2JNRGv35yhdKuSKIhFJsTtAU0J5oas9CvuEZS7bFV+ZFCJZxPESnimDb
         NbUA==
X-Gm-Message-State: AOUpUlFDFsBNs4EKzBgjgibiDChvgqg742wGhoNNfv+9D706pJoddker
        vzWvjt7VMre6xMbxzL97VsHoLKs=
X-Google-Smtp-Source: AA+uWPwPNV7wf/EIMkN0WEr0PmKZI4VPg8SMis36st5/tw+db8jT60Rck6YrlFh+ybsbyrNews4Lew==
X-Received: by 2002:a5e:c00d:: with SMTP id u13-v6mr17075771iol.155.1534196877113;
        Mon, 13 Aug 2018 14:47:57 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id l13-v6sm7271366itb.43.2018.08.13.14.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 14:47:56 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:47:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Shettel <mshettel@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, boris.brezillon@bootlin.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH v1 2/3] dt-bindings: i3c: Document Qualcomm GENI I3C
 master bindings
Message-ID: <20180813214755.GA18952@rob-hp-laptop>
References: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
 <1533101942-29442-3-git-send-email-mshettel@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533101942-29442-3-git-send-email-mshettel@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:39:01PM -0600, Mike Shettel wrote:
> Signed-off-by: Mike Shettel <mshettel@codeaurora.org>
> ---
>  .../devicetree/bindings/i3c/qcom,geni-i3c.txt      | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
> 
> diff --git a/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt b/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
> new file mode 100644
> index 0000000..8b76fda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
> @@ -0,0 +1,44 @@
> +Bindings for Qualcomm Geni I3C master block
> +===========================================
> +
> +Required properties:
> +--------------------
> +- compatible: shall be "qcom,geni-i3c"
> +- clocks: shall reference the se clock
> +- clock-names: shall contain clock name corresponding to the serial engine

What's the name?

> +- interrupts: the interrupt line connected to this I3C master
> +- reg: I3C master registers
> +
> +Optional properties:
> +--------------------
> +- se-clock-frequency: Source serial clock frequency to use

You should be able to figure out this frequency based on available 
dividers and the specified bus frequencies.

Or use assigned-clocks.

> +- dfs-index: Dynamic frequency scaling table index to use

Needs a vendor prefix.

> +
> +Mandatory properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- #address-cells: shall be set to 3
> +- #size-cells: shall be set to 0
> +
> +Optional properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- i2c-scl-hz
> +- i3c-scl-hz
 +
> +I3C device connected on the bus follow the generic description (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
> +
> +Example:
> +
> +	i3c-master@0d040000 {
> +		compatible = "qcom,geni-i3c";
> +		clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +		clock-names = "se";
> +		interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0x0d040000 0x4000>;
> +		#address-cells = <3>;
> +		#size-cells = <0>;
> +		i2c-scl-hz = <100000>;
> +	};
> +
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
