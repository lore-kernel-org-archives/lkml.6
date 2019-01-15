Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8DDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623E720866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHowTknp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbfAOSJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:09:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42671 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729737AbfAOSJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:09:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so1668180pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oBOlSwg5KOoWJlc5kXrIwN/GNjiYbrk4fZJH6b59kn0=;
        b=EHowTknpw3sUSJQWtAa7y7qxFZG7TxQD3qcV0iLDLxHwyb87aXnDuw3DYgzgWH8pC3
         dX7o6TPYKtbwOlBvLXMEXas9O4a2IMlXT8pL6adHNVeV64eg5Xf9R/srFGlyFmnapLIh
         FP0YzOYEp1H6mhdnwXvW2cA8dk65hsmya17ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oBOlSwg5KOoWJlc5kXrIwN/GNjiYbrk4fZJH6b59kn0=;
        b=rsVkpwJcFxqmIUg6GeyH20vzoDtcw6yuL+InugG1UN9tklgkgBypGcjyh6Wm+oV2r+
         y3lORpXDjBWwhePLR/5zHTkATu7A2QPtahHXcsYPGP4v9GF1ZMa+ShUncVXZtSoDD1YC
         OEm/20VUiMZ12zhbieNU3GCq/aPDkws/R33u/gnku8VE5H5sFZC3gIeFpY76c8t2cPfC
         g6cP1c6lcA9IoC5NN8pXSQAJbwKQ5PuEoifbVDvN7lDFtJFvoeTUO34OGFdUO+xpvYH9
         XlsLwdQFuL6+/9sWFYIMvejDBODuq5nVFRHGjglT4bMB3ot+OtdK+bn8Wki7ff30ObDc
         HS7A==
X-Gm-Message-State: AJcUukdJHbE9NmdLL+xZL4ws4OpRrDQCFlM2JlzfrCTwPbm12G9Yicsx
        QhESZoqZn3x1IZmBVi8bkU5sWg==
X-Google-Smtp-Source: ALg8bN6kKEz2EK4il0b/WyCBV3U9PEgbtIpBDL6Dls3Zn2pRdaa+lNoMhIr5/W5u2Ig7nMKGh/5GQg==
X-Received: by 2002:a62:e201:: with SMTP id a1mr5189125pfi.75.1547575785067;
        Tue, 15 Jan 2019 10:09:45 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h64sm5998806pfc.142.2019.01.15.10.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:09:44 -0800 (PST)
Date:   Tue, 15 Jan 2019 10:09:01 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: usb: Add support for msm8998
Message-ID: <20190115180901.GD28907@builder>
References: <1547483787-5371-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547483787-5371-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jan 08:36 PST 2019, Jeffrey Hugo wrote:

> msm8998 USB has a dwc3 controller just like the existing sdm845 support
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> index 95afdcf..cb695aa 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
> @@ -4,6 +4,7 @@ Required properties:
>  - compatible:		Compatible list, contains
>  			"qcom,dwc3"
>  			"qcom,msm8996-dwc3" for msm8996 SOC.
> +			"qcom,msm8998-dwc3" for msm8998 SOC.
>  			"qcom,sdm845-dwc3" for sdm845 SOC.
>  - reg:			Offset and length of register set for QSCRATCH wrapper
>  - power-domains:	specifies a phandle to PM domain provider node
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
