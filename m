Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C8EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19393218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545336607;
	bh=NivbT7SG2BNLmLeqIwAMiE2z5d4wIPjd3t4eLQFxoDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Eu/0xtu7+yOt6w2pq1eyyPWG/DvFQSjb4NVQnbfh88iPHyHm/De4ShsaMtq2Zf7Lg
	 CsaMWsaQPf022TJ/0GpFtZjVneqZwJn97x0q8C3jB4fQ3sxAWo30Tet+pTjE8EoJH6
	 VyEc3nZJ57Djo7U+yC6UdR5OPZDNMK26czbXFjXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbeLTUKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:10:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45152 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbeLTUKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:10:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id y1so2918763oie.12;
        Thu, 20 Dec 2018 12:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XgyqBNKrhVreiPD5SUQQ10IUV2HGrJTcm0g1cAZmsMA=;
        b=IlYK3WFIsKLrJr4RNa41L8vV9GK41QKBP+XXUTuof1KKiYHgZo+T0xm2bRogqFQupF
         qZHtZPgLRYFbST1/TfTnRxPQ9tWM9MM2m0CfWwT62FxhWq+NZOdPVYOfICWDDtcW+Q5n
         0rtChu7zEcGJZrkM7h65VpirPH58GVbn+oYKkpWrhc2gzqxreRIpaA+KDQhMxsAo4vyk
         DA9g/TxkP5mBEe95zlQFabbS5tRR2XrFXjjlBz+tdiZCwODieH6fplQcBfxQgl+bAIS7
         7slKcTW61Fmk1WRJ8aQDBR2QCjV1k0ErhnBVGFIsS0WUSME6ZK0RpPfmdPxYb4jZlLSL
         i0xw==
X-Gm-Message-State: AJcUukeW06eLrPTnPNsBTXUg1WY5InRWIP5LV7HqilgzyITcojOuaGNe
        nkHaknPfbGmLACXG4JWI1w==
X-Google-Smtp-Source: AFSGD/VOz59lhYBdrIcbplCBMLtCq4OAmrq/4Rxy68jTRULAo6TUW0gI/YVKX+4TIluvGUyFsKPFkQ==
X-Received: by 2002:aca:6155:: with SMTP id v82mr93983oib.259.1545336604263;
        Thu, 20 Dec 2018 12:10:04 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id m89sm12121760otc.35.2018.12.20.12.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:10:03 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:10:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        briannorris@chromium.org, akdwived@codeaurora.org,
        clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: qcom: Add firmware bindings
 for Q6V5 MSS
Message-ID: <20181220201002.GA8831@bogus>
References: <20181212124456.3164-1-sibis@codeaurora.org>
 <20181212124456.3164-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212124456.3164-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 06:14:55PM +0530, Sibi Sankar wrote:
> Add optional firmware bindings for Q6V5 MSS. It lists the two relative
> firmware paths which are used for booting and authenticating the Hexagon
> core.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 9ff5b0309417..1f6988a60636 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -36,6 +36,13 @@ on the Qualcomm Hexagon core.
>  	Value type: <stringlist>
>  	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
>  
> +- qcom,firmware:

We already have a standard name 'firmware-name'. Use that. I'm fine with 
allowing it to be more than 1 string.

> +	Usage: optional
> +	Value type: <stringlist>
> +	Definition: must list the 2 relative firmware paths (mba and modem
> +		    metadata respectively) which are used for booting and
> +		    authenticating the Hexagon core.
> +
>  - clocks:
>  	Usage: required
>  	Value type: <phandle>
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
