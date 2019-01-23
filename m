Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903AAC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6A721872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GP3yP9OR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfAWRIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:08:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46244 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAWRID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:08:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so1323660pgp.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 09:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mdyf5oyBgcfnR8L4p9FrrLtyz2DDZSi/aou2XyovQrs=;
        b=GP3yP9ORIywJIRkT1ceBjLEFKBkMx5TMY2+A7vJIb+SIZzo98QRTNEFt0jD0pjAJlP
         dxigrCUzE7Xre3QYrOspy2ABmAnehs39JIPBSoBgUwMQuW1HlgeDW/6dJendIpp6v3jF
         hZkOqGAcWU8XlLycu54fiM3qwn4CsVP8UIGR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mdyf5oyBgcfnR8L4p9FrrLtyz2DDZSi/aou2XyovQrs=;
        b=RRq/T0Zl9NA2BVW5NY4F1Qo6IjE1Vcvz8SSqH2UgWukX0LEKc+YT7JDbzX8Ho4kGLj
         7EtR8HgHiMWNugr16mgTsTL3oauyU5WZBxE9glg4MDH4Yc/m5/wclQf4KMcqXHhRgZGv
         ezPYiGhRE8eMRKwPsM5g3VI4cSt3yGN7lrd+L9KVhmZDu1Sg50K4IxuUw+GFIw7xz/nd
         QZ3rnIIx0hWGAuCTAkrR5HqDeGeK7wsu4tuggJXFc/TMzRxmT65FvbTLocMIw9qCd7Rc
         1XozAQJvIoloOGAVTY7Qnc8rpD6EtPr+u14Mgd8mSCbT4FM+wXngIF7CQXx5CchN11Zn
         8HrQ==
X-Gm-Message-State: AJcUukdn5YoE+c64HK+KPhmyspNkzUAmvwSUTns0e3mftd3GE5Telw5S
        AEbr9IH+ZVGIDAZwtTUuo1Orlg==
X-Google-Smtp-Source: ALg8bN5EIHAkwFGlnX3lA5P8PuU3MXURevjCT5fxfAIQDC2IcrBEvxem6+Wy7lHF8bCBMP1W6dnEEg==
X-Received: by 2002:a62:1212:: with SMTP id a18mr2772613pfj.217.1548263282470;
        Wed, 23 Jan 2019 09:08:02 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 134sm26076337pgb.78.2019.01.23.09.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 09:08:01 -0800 (PST)
Date:   Wed, 23 Jan 2019 09:07:58 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org,
        dianders@chromium.org, swboyd@chromium.org
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
Message-ID: <20190123170758.GB512@tuxbook-pro>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 Jan 22:33 PST 2019, Alok Chauhan wrote:

> Add documentation for the interconnect and interconnect-names bindings
> for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.
> 
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> index dab7ca9..44d7e02 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> @@ -17,6 +17,12 @@ Required properties if child node exists:
>  - #address-cells: 	Must be <1> for Serial Engine Address
>  - #size-cells: 		Must be <1> for Serial Engine Address Size
>  - ranges: 		Must be present
> +- interconnects:	phandle to a interconnect provider. Please refer
> +			../interconnect/interconnect.txt for details.
> +			Must be 2 paths corresponding to 2 AXI ports.
> +- interconnect-names:	Port names to differentiate between the

s/Port names/Path names/

> +			2 interconnect paths defined with interconnect
> +			specifier.

These two names are significant in that they must match what the driver
expects, hence you must actually specify them here.

And as the scope of these strings are local to the QUP node you can omit
"qup" from them, so make them "memory" and "config" (or perhaps iface,
to match the clock naming?).

Regards,
Bjorn

>  
>  Properties for children:
>  
> @@ -67,6 +73,10 @@ Example:
>  		#size-cells = <1>;
>  		ranges;
>  
> +		interconnects = <&qnoc 11 &qnoc 512>,
> +				<&qnoc 0 &qnoc 543>;

I presu

> +		interconnect-names = "qup-memory", "qup-config";
> +
>  		i2c0: i2c@a94000 {
>  			compatible = "qcom,geni-i2c";
>  			reg = <0xa94000 0x4000>;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
