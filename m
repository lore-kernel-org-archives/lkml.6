Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED49C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFC82087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6M9YLHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfA2UjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:39:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40793 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbfA2UjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:39:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so9255824pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XLB+LA1eAe3kDYs6gI43vB4A4plZV87iVFLZSgZKshY=;
        b=b6M9YLHLm95w2F8xMDJZyQxDaTG93Fr5J96f/gLEhPbW+TjnBVfOcU+thx/npnjai4
         QTelNVPJwh1pjp2fO5ZipEJG27CKoMAzmzanAQ2BBaWYONuk6OUiw/J94jh3alkA4k0p
         NVhhnwHwC1gAA7d/7BaYGsdAay0HQqnWn/umk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XLB+LA1eAe3kDYs6gI43vB4A4plZV87iVFLZSgZKshY=;
        b=hLi4Yw3JDtaPlPF0yPA2XgO6GYKOy1S3ZZ1fTbxDt4MoeI0pyilEpVLPUlIDPJbdMZ
         6g22aWmQxjrRO1S36go1/CxKS6gB6r0H8ZeirZtl8A3GHY9LLXL65k/ToHd1Ebr1uAT/
         seb2Rgg22EXHDW4UHLwlIapQ7qqS2SBUzSXC0bN9VpPjcmEKT3lHWSjnHhZcEgFDftXy
         T72uSZPFyybbunn+mtMz3pbE/zXH9xcxOtjikxUc8Op9X9hdIn3T8ywJ8kIbafzAo98J
         8N/hevAwNB+hr9RPXLFfwOcMd5xZbGj4MHyVwmyqAMWS779sev2L+FdOyQ7UhxW6qSSy
         GGxQ==
X-Gm-Message-State: AJcUukcTsdLhwi+LPC2VP5C34Od5gQ5A13ux1ecWK7ObsYKnvrlkLXy/
        4YTL3PZT+N08itZ8xhldu+volA==
X-Google-Smtp-Source: ALg8bN6l9RgIGPV500wq7bErcA6nagZmyIup1a/geaPxPdI5AJMf/J1VxFChwL2wcS0Ft1AXmi5tPA==
X-Received: by 2002:a63:134f:: with SMTP id 15mr24853357pgt.19.1548794344136;
        Tue, 29 Jan 2019 12:39:04 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g26sm45604376pfh.61.2019.01.29.12.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 12:39:03 -0800 (PST)
Date:   Tue, 29 Jan 2019 12:38:45 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org,
        shawn.guo@linaro.org, vkoul@kernel.org, khasim.mohammed@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
Message-ID: <20190129203845.GB3036@builder>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29 Jan 03:35 PST 2019, Jorge Ramirez-Ortiz wrote:

> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY

SuperSpeed

> controller embedded in QCS404.
> 
> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> definitions.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> new file mode 100644
> index 0000000..8ef6e39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> @@ -0,0 +1,73 @@
> +Qualcomm Synopsys 1.0.0 SS phy controller
> +===========================================
> +
> +Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
> +chipsets

It's based on Synopsys IP, but it's Qualcomm's version, and isn't the
1.0.0 Qualcomm's version number for this block?

Also I think it "provides SuperSpeed USB connectivity on some Qualcomm
platforms".

> +
> +Required properties:
> +
> +- compatible:
> +    Value type: <string>
> +    Definition: Should contain "qcom,usb-ssphy".
> +
> +- reg:
> +    Value type: <prop-encoded-array>
> +    Definition: USB PHY base address and length of the register map.
> +
> +- #phy-cells:
> +    Value type: <u32>
> +    Definition: Should be 0. See phy/phy-bindings.txt for details.
> +
> +- clocks:
> +    Value type: <prop-encoded-array>
> +    Definition: See clock-bindings.txt section "consumers". List of
> +		 three clock specifiers for reference, phy core and
> +		 pipe clocks.
> +
> +- clock-names:
> +    Value type: <string>
> +    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
> +		 property. Must contain "ref", "phy" and "pipe".
> +
> +- vdd-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the regulator VDD supply node.
> +
> +- vdda1p8-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the regulator 1.8V supply node.
> +
> +
> +Optional child nodes:
> +
> +- vbus-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the VBUS supply node.
> +
> +- resets:
> +    Value type: <prop-encoded-array>
> +    Definition: See reset.txt section "consumers". PHY reset specifiers
> +		 for phy core and COR resets.
> +
> +- reset-names:
> +    Value type: <string>
> +    Definition: Names of the resets in 1-1 correspondence with the "resets"
> +		 property. Must contain "com" and "phy".

Perhaps "Must contain both com and phy, if property is specified", to
clarify that it's all or nothing.


Looks good otherwise.

Regards,
Bjorn
