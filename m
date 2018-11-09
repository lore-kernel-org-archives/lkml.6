Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E98DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FBD20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTqy399c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FBD20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeKIOrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 09:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbeKIOrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 09:47:20 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31F4D20825;
        Fri,  9 Nov 2018 05:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541740107;
        bh=1L28arPKFWUF6jSRFWKhiDxW1RaTDBxiuS6IaI3NviA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTqy399cLvmPV6yDpr7GjbfI7SCNh5rloo+z4Z3LeBbDyLTSs2POp1fDTBsGhRWwV
         20MWmHfZ/uSo9cm+cwMUwDogQUqBveJjeTfBa4fhGe6ecLnG2odzMnHdl8gSOSplxw
         yHvcc1wwM5fo5yexAVXscRhWsxmKKidHAOeFLaYE=
Date:   Fri, 9 Nov 2018 10:38:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed
 USB PHY binding
Message-ID: <20181109050819.GK12092@vkoul-mobl>
References: <20181108070449.23572-1-shawn.guo@linaro.org>
 <20181108070449.23572-2-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108070449.23572-2-shawn.guo@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-18, 15:04, Shawn Guo wrote:
> From: Sriharsha Allenki <sallenki@codeaurora.org>
> 
> It adds bindings for Synopsys 28nm femto phy controller that supports
> LS/FS/HS usb connectivity on Qualcomm chipsets.
> 
> Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
> Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> new file mode 100644
> index 000000000000..75e7a09dd558
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> @@ -0,0 +1,101 @@
> +Qualcomm Synopsys 28nm Femto phy controller
> +===========================================
> +
> +Synopsys 28nm femto phy controller supports LS/FS/HS usb connectivity on
> +Qualcomm chipsets.
> +
> +Required properties:
> +
> +- compatible:
> +    Value type: <string>
> +    Definition: Should contain "qcom,usb-snps-hsphy".
> +
> +- reg:
> +    Value type: <prop-encoded-array>
> +    Definition: USB PHY base address and length of the register map.
> +
> +- #phy-cells:
> +    Value type: <u32>
> +    Definition: Should be 0.

I dont quite understand the definition that it should be 0, maybe you
mean allowed value is 0, if so why have this property?

-- 
~Vinod
