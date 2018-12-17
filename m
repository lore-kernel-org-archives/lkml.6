Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C144DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A7621783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545085051;
	bh=AsO6CJGabYAigd5sRWkxO/0ce0ywfhiMu7R2t30gNfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WJU7vWsEc0ydEh8Qp/qlXHhrGJGWAe1RMYsHXpv0KdAljtcA7KXMxr4aAZfAdIpzZ
	 PoS1/JtfgzMcS8fcTzXfxg2sp/HcoHg8S0l+0JitiVvVmN+RoyMkcmfGJ4bleLdEuJ
	 hT/sTQ6K3TYmXwU0gxvp7PK93C5y+S6MHgOiNt4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbeLQWRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:17:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:47034 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeLQWRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:17:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so13711517otm.13;
        Mon, 17 Dec 2018 14:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVJ69umSoxIdykbuMxTkJS5wtVxY9vHH6fN6Y6T4pY8=;
        b=KTGR8huvj7ylfkN/jowILGNPNQsHNr2BrdkkXb3+7fb/uanpafMyzeV5Nyrtgldhfy
         RCirKgnTzK5sEalq4vWGAiJnyPcJeZO5FpLnNeZ6TqTxWeY7eqW/gQD+Z2dcIFTk3YQL
         /pM7MCzsfnmNQqoKyzAD78lDQSWYO6KDFnHsamUcF8p16B1vQThGkA2lb/8mPEyr6Zqk
         T14TT2H3hExUAfEuLMY+mzmIGqrMk6fTYNdahe+krb9PatomjmVBrAgw1ynDntn5Nk/k
         JDLsb9T9aTe1TB8ByDUfaG9X5xXBs0ZiiFU7MoFqOpjx6gQrLTCD5bJo8YgVeiIfDmpj
         rKIQ==
X-Gm-Message-State: AA+aEWa2YSUTIYUmz7pK8/EROsnbCGFX2vxD/xiZAHJ+sSwl8IWe/sqY
        /799B1q8YnJKncYiMZi/cA==
X-Google-Smtp-Source: AFSGD/X6ekIy/+Hk4HU3Nd5W0HalYQzuNPyek0+9uaD509+wk8anl+CXN7OByb1fcbY8QaOAG+iFag==
X-Received: by 2002:a9d:5263:: with SMTP id q35mr9885276otg.129.1545085048916;
        Mon, 17 Dec 2018 14:17:28 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id t8sm7501107otp.69.2018.12.17.14.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 14:17:28 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:17:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sravanthi Kollukuduru <skolluku@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        sean@poorly.run, seanpaul@chromium.org,
        linux-kernel@vger.kernel.org,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: msm/disp: Introduce interconnect
 bindings  for MDSS on SDM845
Message-ID: <20181217221727.GA15191@bogus>
References: <20181122090653.3523-1-skolluku@codeaurora.org>
 <20181122090653.3523-4-skolluku@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122090653.3523-4-skolluku@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 14:36:53 +0530, Sravanthi Kollukuduru wrote:
> Add interconnect properties such as interconnect provider specifier
> , the edge source and destination ports which are required by the
> interconnect API to configure interconnect path for MDSS.
> 
> Changes in v2:
> 	- none
> 
> Changes in v3:
> 	- Remove common property definitions (Rob Herring)
> 
> Signed-off-by: Sravanthi Kollukuduru <skolluku@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dpu.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
