Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA2DC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87D6208DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87D6208DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbeHGUeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:34:12 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40477 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeHGUeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:34:12 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so83472ita.5;
        Tue, 07 Aug 2018 11:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tKNGxHKZXPDMLr4J+fLWCRD1sKePCaCNKpCEG6enebs=;
        b=WaTFysLq13TwIv4haVYIjfxJco3jhXSHfaVvML11wT2/IYeXAO/ki0FmP+C65KHMh8
         OutL/BTvYRJ+gswRb8w5u6lv7FI9KBcj9oj5xhomXnCw9llnXdaSh/qBuUCJE+fPKW1m
         bZQ0FrL3Lb1Ham0/Gm+RdQ5yQ083xPyeK9chXzjDSVMK4cr/pX3WGFpmgPW6kXwkFPHN
         o8n5Aa/FbgmHX2+m7eT4adCwOS2TsPG2cPaBh61KNek5mrq6JWGIUCHF/shu9oR/fmVc
         Qo8UUTN5t5+f/yVbRbkemt/ZyHp8/uOulTn+19pkIK40xPxtUQm1R7naqvE620BKKvcX
         MT2g==
X-Gm-Message-State: AOUpUlGHETCz2W3aCwmd7dUWaCZ0k4TtDjJABERI90kt60SsWqOS6ZmU
        GG+ar6VxeqUASL3YeCleFDjhDGw=
X-Google-Smtp-Source: AAOMgpfsIS/29U/ACUlA+nQGSvrTU+vwqeGp9PiHrewABudgIkVWnyJzmVgjEjwHPFg4tHw5evJIig==
X-Received: by 2002:a02:4a0a:: with SMTP id k10-v6mr16935406jab.134.1533665916593;
        Tue, 07 Aug 2018 11:18:36 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v3-v6sm1235007ita.6.2018.08.07.11.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 11:18:36 -0700 (PDT)
Date:   Tue, 7 Aug 2018 12:18:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH 4/4] remoteproc: qcom: q6v5-pil: Add PDC restart for
 modem on SDM845 SoCs
Message-ID: <20180807181835.GA28960@rob-hp-laptop>
References: <20180727152811.15258-1-sibis@codeaurora.org>
 <20180727152811.15258-4-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727152811.15258-4-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 08:58:11PM +0530, Sibi Sankar wrote:
> In the presence of a PDC block working with subsystem RSC,
> assert/deassert PDC restart in modem start/stop path.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/remoteproc/qcom,q6v5.txt         |  4 +++

Please split bindings to separate patch.

>  drivers/remoteproc/qcom_q6v5_pil.c            | 27 ++++++++++++++++---
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 601dd9f389aa..124fb1dc6fb8 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -51,6 +51,8 @@ on the Qualcomm Hexagon core.
>  	Usage: required
>  	Value type: <phandle>
>  	Definition: reference to the reset-controller for the modem sub-system
> +		    reference to the list of 2 reset-controllers for the modem
> +		    sub-system on SDM845 SoCs
>  		    reference to the list of 3 reset-controllers for the
>  		    wcss sub-system
>  
> @@ -58,6 +60,8 @@ on the Qualcomm Hexagon core.
>  	Usage: required
>  	Value type: <stringlist>
>  	Definition: must be "mss_restart" for the modem sub-system
> +	Definition: must be "mss_restart", "pdc_restart" for the modem
> +		    sub-system on SDM845 SoCs
>  	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
>  		    for the wcss syb-system
>  
