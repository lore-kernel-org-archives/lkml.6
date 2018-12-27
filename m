Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DF721741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545945670;
	bh=dBDI/hTw7+8I050GpPPG+P6CNnmY0jwOpLSK2y5YALw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pYSVNOwp41AD2+44t386tqeehG2L/Cu8Ig2E7J3kONcRUZpuGA/7byFCBJn5t26V2
	 DI1cC74x7bsbpRo2O1OeYNCXBnzB2I6XDxv/zwN2UqMHCdCsOers2MFbFLC4eurPnl
	 oDhBI4bfFN22ncHvjF1zA0ky+mfSroBnZWtcbViw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbeL0VVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:21:09 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34901 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbeL0VVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:21:08 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so25160544itp.0;
        Thu, 27 Dec 2018 13:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tTzmOyVGb0ChmxTiUqYJ/JO27ql6meNxpyiAHDz+IQo=;
        b=NK90OZI0+K9tOlnbYmxjOVrTRg1Xr+X1X3orOKQGeYfdhIt5AkVhP2dVhhdl4dMX3i
         l34oQX+ofL8cb7DOW8O1P0jmLsyJWzhw42ie5aPYN+0OkJwCgxkg+BuwfuSxOl3S6r28
         bSAcxIuUX4tnMCROPakEDJztaH7kOo5uu/A7Vg413rordB4e1wiivXa8yfETQ7/gBK/H
         TsFK8piopTKESEhhwSLi2GO1wkJ6+3XYACBulB94ZGok/mDkmtS1UnNa1y31O74B6anG
         bhfYaLDF8bu63vs6uBAAA45pNy7OPRNKsTnG15ZYn/imux/AS/Nyl52Ad8CQCGmfa3Un
         cjoA==
X-Gm-Message-State: AA+aEWYMhi9vHBMsi31oZ9kADaQ8LjWnS8JnYwnPQEEQNdkjKUWrhoBe
        Gc0vO/eIWFffYKvrDMnVbw==
X-Google-Smtp-Source: AFSGD/UAXQnTJuZlkyzMhy96dB+p0Vl2MDz7TVhh7E+AYuyMdP29KQqYZxBAMjY3O8b/pEEYTGtaVg==
X-Received: by 2002:a02:89dd:: with SMTP id e29mr17375886jak.21.1545945667265;
        Thu, 27 Dec 2018 13:21:07 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id n4sm5347603iog.36.2018.12.27.13.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:21:06 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:21:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        evgreen@chromium.org, briannorris@chromium.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH v3 2/8] dt-bindings: remoteproc: qcom: Add missing clocks
 for SDM845
Message-ID: <20181227212105.GA19897@bogus>
References: <20181226125229.20149-1-sibis@codeaurora.org>
 <20181226125229.20149-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226125229.20149-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 06:22:23PM +0530, Sibi Sankar wrote:
> Add missing clock bindings for Q6V5 MSS on SDM845 SoCs.
> 
> Fixes: fb22022ff63d ("dt-bindings: remoteproc: Add Q6v5 Modem PIL
> binding for SDM845")
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> v3:
>   * Fixup dt-binding documentation as suggested by Doug
> 
>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt   | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 9ff5b0309417..20dd19f9ed99 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -39,13 +39,21 @@ on the Qualcomm Hexagon core.
>  - clocks:
>  	Usage: required
>  	Value type: <phandle>
> -	Definition: reference to the iface, bus and mem clocks to be held on
> -		    behalf of the booting of the Hexagon core
> +	Definition: reference to the clocks that match clock-names
>  
>  - clock-names:
>  	Usage: required
>  	Value type: <stringlist>
> -	Definition: must be "iface", "bus", "mem"
> +	Definition: The clocks needed depend on the compatible string:
> +	qcom,ipq8074-wcss-pil:
> +		    no clock names required
> +	qcom,q6v5-pil:
> +	qcom,msm8916-mss-pil:
> +	qcom,msm8974-mss-pil:
> +		    must be "iface", "bus", "mem", "xo"
> +	qcom,sdm845-mss-pil:
> +		    must be "xo", "prng", "iface", "bus", "mem", "gpll0_mss",
> +		    "snoc_axi", "mnoc_axi"

Please keep the same order for the 4 clocks which are the same.

Rob
