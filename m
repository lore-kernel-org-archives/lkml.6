Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA61240BD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA61240BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeGEXeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:34:05 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40313 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeGEXeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:34:03 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so20101852oie.7;
        Thu, 05 Jul 2018 16:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rcNZGc2ivvr+QDuHpx9RAJ7z8v5L+ruqWLieebsfA1Q=;
        b=B8+QyZwAEJTooypHHZ9uCLV5Rh72YZL/GdFEVgBqsdTV2S0XSW+0Qg1eD6V4tygCTC
         j7JxjmvwqNZy6y7shJ69Jd4AgBmbI/G9ql8dmbB+/QVMZP1TZO4qBt5feCfbXZOu8J/O
         WT6OJ/nxbqPCSVouLImjuLNrE9YuvljseJOKoOCbHBvenyRL6XEdVrv+uY+qpEGQJ8uF
         BgifiUpJgADDoR0YUFlzjX17s6XJoOFbefyY1fI0ib6RrEqWE9dGTNXzNR/oV2YBolVA
         uK4BGICibER/ohrhOJALp68+qo7Zu3D7WMHGN+DqhG16H7WDCH+ZPWtZeeqfLlDitvOF
         PS+A==
X-Gm-Message-State: APt69E1ocIqw5zUlBCackSeoy8elqWxCc31k9mM8rrzmTM/bPLez/wW7
        N8ZOh1WdotjqxnGfR/SQFw==
X-Google-Smtp-Source: AAOMgpeqzTEVEW8Dj+CHCJTJJaLs++AsDeU/jpdr3CUrr8Uwfp+yQbWa53pfO+u4yokVN+g3qFOEaw==
X-Received: by 2002:aca:f20a:: with SMTP id q10-v6mr8174412oih.165.1530833642841;
        Thu, 05 Jul 2018 16:34:02 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id l133-v6sm6200191oif.48.2018.07.05.16.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 16:34:01 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:34:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: Add binding doc for Stingray
 PCIe PHY
Message-ID: <20180705233401.GA26079@rob-hp-laptop>
References: <1530728533-28770-1-git-send-email-ray.jui@broadcom.com>
 <1530728533-28770-2-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530728533-28770-2-git-send-email-ray.jui@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 11:22:12AM -0700, Ray Jui wrote:
> Add binding document for Stingray PCIe PHYs for both PAXB and PAXC based
> root complex
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
> new file mode 100644
> index 0000000..5a13511
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
> @@ -0,0 +1,41 @@
> +Broadcom Stingray PCIe PHY
> +
> +Required properties:
> +- compatible: must be "brcm,sr-pcie-phy"
> +- reg: base address and length of the PCIe SS register space
> +- brcm,sr-cdru: phandle to the CDRU syscon node
> +- brcm,sr-mhb: phandle to the MHB syscon node
> +- #phy-cells: Must be 1, denotes the PHY index
> +
> +For PAXB based root complex, one can have a configuration of up to 8 PHYs
> +PHY index goes from 0 to 7
> +
> +For the internal PAXC based root complex, PHY index is always 8
> +
> +Example:
> +	mhb: syscon@60401000 {
> +		compatible = "brcm,sr-mhb", "syscon";
> +		reg = <0 0x60401000 0 0x38c>;
> +	};
> +
> +	cdru: syscon@6641d000 {
> +		compatible = "brcm,sr-cdru", "syscon";
> +		reg = <0 0x6641d000 0 0x400>;
> +	};
> +
> +	pcie_phy: phy {

Needs a unit address.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +		compatible = "brcm,sr-pcie-phy";
> +		reg = <0 0x40000000 0 0x800>;
> +		brcm,sr-cdru = <&cdru>;
> +		brcm,sr-mhb = <&mhb>;
> +		#phy-cells = <1>;
> +	};
> +
> +	/* users of the PCIe PHY */
> +
> +	pcie0: pcie@48000000 {
> +		...
> +		...
> +		phys = <&pcie_phy 0>;
> +		phy-names = "pcie-phy";
> +	};
> -- 
> 2.1.4
> 
