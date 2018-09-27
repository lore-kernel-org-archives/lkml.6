Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BF6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7479E21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7479E21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeI0XrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:47:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38525 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeI0XrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:47:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id h15-v6so3357715otj.5;
        Thu, 27 Sep 2018 10:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FYY3458sE/UBFJhUUUgVYbRPpyDuhfLmE2RJENc6+to=;
        b=RiYddMpkKXbpIFOPQfciCCwUvx6ahnRhU2CcTO9XHciktLvXj9l+0+7/ClEgOy9GR+
         VSqheIZ0gG0689FLdazip+cmfrQGCBS/OLw7M3JiMEBFd59Z3pjrFdMyi3jjTE1eF0bh
         hwft/0c0+ycjqukd+W+LYZTdypCDQSdkbLMEMIG6klo0u/Jx4Yu47e7BfWhmMdezjVvi
         ySrwUd7liyX1kemV4nCTDBXe8+8jqYeOUVsj0Po/jpVvkAdA7xX37/luI6wVlzHocbme
         wB/PUZdkvg6KB1OaDuBG2A4IdPEW6VSC2CB5SL0Gdn5wyUdMPTPKExj98PtenjIIxlwT
         tcRw==
X-Gm-Message-State: ABuFfoh8QR4dVpt2gAcEOYRQBOqKzVQo7aegoa+YBY82DIrMX7nnYrey
        UhPVXpaUqV2boRwGD6L8gg==
X-Google-Smtp-Source: ACcGV63p3ZCbi7xr6X0x6VVSzrc1Pnbw1ysl84gzLM91WSJ6bZuEIMPpBhYZINi0uO2wnsd7ogTFVQ==
X-Received: by 2002:a9d:5b14:: with SMTP id x20-v6mr8083177oth.224.1538069279639;
        Thu, 27 Sep 2018 10:27:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11-v6sm935909otc.18.2018.09.27.10.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 10:27:59 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:27:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: Add binding document for SR
 thermal
Message-ID: <20180927172758.GA17761@bogus>
References: <1538062603-7490-1-git-send-email-srinath.mannam@broadcom.com>
 <1538062603-7490-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538062603-7490-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:06:41PM +0530, Srinath Mannam wrote:
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> 
> Add binding document for supported thermal implementation
> in Stingray.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../bindings/thermal/brcm,sr-thermal.txt           | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> new file mode 100644
> index 0000000..717617b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> @@ -0,0 +1,25 @@
> +* Broadcom Stingray Thermal
> +
> +This binding describes thermal sensors that is part of Stingray SoCs.
> +
> +Required properties:
> +- compatible : Must be "brcm,sr-thermal"
> +- reg : memory where tmon data will be available.
> +- brcm,tmon-mask: A one cell bit mask of valid TMON sources.
> +                  Each bit represents single TMON source.
> +- brcm,max-crit-temp: Maximum supported critical temperature.

We already have a defined binding for setting trip points. 

> +
> +Example:
> +	tmons {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x8f100000 0x100>;
> +
> +		tmon: thermal@0 {
> +			compatible = "brcm,sr-thermal";
> +			reg = <0 0x40>;
> +			brcm,tmon-mask = <0x3f>;
> +			brcm,max-crit-temp = <105000>;
> +		};
> +	};
> -- 
> 2.7.4
> 
