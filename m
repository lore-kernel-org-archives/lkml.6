Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC181C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7765A213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7765A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbeGKTmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:42:15 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36403 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbeGKTmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:42:15 -0400
Received: by mail-oi0-f68.google.com with SMTP id r16-v6so51431097oie.3;
        Wed, 11 Jul 2018 12:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8n6dHyy8SY6Z4H4meT5y6KRmvJHCP8De9mLiq2KOp0I=;
        b=ISwCUm7Qnal4xuZlpA3J75zwKHejIzNCfAIg00zffdppp/mjBl9zF3h5iWDAN3T5d4
         SkSs5GoQYXjFp/bA63Gq1+yzl7WcjRZFNHbPMn7P0IqIlmXhaRR/U49gRqbjCH4q6aW3
         XxYMW401a/uximhbw2/6gIBz+psLg0VlLr2GFjiztlbHx7Dhwr/MvTrzixPyd0OljFc3
         O8cOFhDp/bCNFBZli2wIY2RAvNw1FYxN//oOSrBToHg7NxqXpdwMsI6I4Pes3aM0WuwJ
         8akgxgvBFZgmzp0kaFUr1SI4KX8tUZFispQNOgqzy9mzwJPxyvpKFMr3cmV41qW5Go3s
         +oDg==
X-Gm-Message-State: AOUpUlEMnAqdkOkMwigU6gOkyi3PMPGsqGz0x+mVSD9081fSR8VrneOo
        t6WOrDhtRPKiJjJKEm7PdA==
X-Google-Smtp-Source: AAOMgpet4JKFXRAiNk7bQ5CgxznGQPs+r/BxMhGunaAy/ZJCPcRMTMkLnd9kO3FIyo+iLMYAgaUGyg==
X-Received: by 2002:aca:7c5:: with SMTP id 188-v6mr2797oih.58.1531337786915;
        Wed, 11 Jul 2018 12:36:26 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 1-v6sm6126976oir.19.2018.07.11.12.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 12:36:26 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:36:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sujeev Dias <sdias@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 6/7] mhi_bus: controller: MHI support for QCOM modems
Message-ID: <20180711193625.GC8659@rob-hp-laptop>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-7-git-send-email-sdias@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531166894-30984-7-git-send-email-sdias@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:08:13PM -0700, Sujeev Dias wrote:
> QCOM PCIe based modems uses MHI as the communication protocol.
> MHI control driver is the bus master for such modems. As the bus
> master driver, it oversees power management operations
> such as suspend, resume, powering on and off the device.
> 
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> Reviewed-by: Tony Truong <truong@codeaurora.org>
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/bus/mhi_qcom.txt |  58 +++

And this one in it's own patch.

>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/bus/Kconfig                                |   1 +
>  drivers/bus/mhi/Makefile                           |   1 +
>  drivers/bus/mhi/controllers/Kconfig                |  13 +
>  drivers/bus/mhi/controllers/Makefile               |   1 +
>  drivers/bus/mhi/controllers/mhi_qcom.c             | 461 +++++++++++++++++++++
>  drivers/bus/mhi/controllers/mhi_qcom.h             |  67 +++
>  8 files changed, 603 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/mhi_qcom.txt
>  create mode 100644 drivers/bus/mhi/controllers/Kconfig
>  create mode 100644 drivers/bus/mhi/controllers/Makefile
>  create mode 100644 drivers/bus/mhi/controllers/mhi_qcom.c
>  create mode 100644 drivers/bus/mhi/controllers/mhi_qcom.h
> 
> diff --git a/Documentation/devicetree/bindings/bus/mhi_qcom.txt b/Documentation/devicetree/bindings/bus/mhi_qcom.txt
> new file mode 100644
> index 0000000..0a48a50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/mhi_qcom.txt
> @@ -0,0 +1,58 @@
> +Qualcomm Technologies Inc MHI Bus controller
> +
> +MHI control driver enables clients to communicate with external mode
> +using MHI protocol.
> +
> +==============
> +Node Structure
> +==============
> +
> +Main node properties:
> +
> +- reg
> +  Usage: required
> +  Value type: Array (5-cell PCI resource) of <u32>
> +  Definition: First cell is devfn, which is determined by pci bus topology.
> +	Assign the other cells 0 since they are not used.
> +
> +- qcom,smmu-cfg

This should probably be part of the SMMU binding?

> +  Usage: required
> +  Value type: <u32>
> +  Definition: Required SMMU configuration bitmask for PCIe bus.
> +	BIT mask:
> +	BIT(0) : Attach address mapping to endpoint device
> +	BIT(1) : Set attribute S1_BYPASS
> +	BIT(2) : Set attribute FAST
> +	BIT(3) : Set attribute ATOMIC
> +	BIT(4) : Set attribute FORCE_COHERENT
> +
> +- qcom,addr-win
> +  Usage: required if SMMU S1 translation is enabled
> +  Value type: Array of <u64>
> +  Definition: Pair of values describing iova start and stop address
> +
> +- MHI bus settings
> +  Usage: required
> +  Values: as defined by mhi.txt
> +  Definition: Per definition of devicetree/bindings/bus/mhi.txt, define device
> +	specific MHI configuration parameters.
> +
> +========
> +Example:
> +========
> +
> +/* pcie domain (root complex) modem connected to */
> +&pcie1 {
> +	/* pcie bus modem connected to */
> +	pci,bus@1 {
> +		reg = <0 0 0 0 0>;
> +
> +		qcom,mhi {
> +			reg = <0 0 0 0 0>;

2 levels of PCI addresses doesn't look right, but I can't really tell in 
your example. The addresses don't look valid.

> +			qcom,smmu-cfg = <0x3d>;
> +			qcom,addr-win = <0x0 0x20000000 0x0 0x3fffffff>;
> +
> +			<mhi bus configurations>
> +		};
> +	};
> +};
