Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D82DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B85B217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550520500;
	bh=wMmtW5ey5GVDUnk8uvFWZTPrAVa4RUtv7kJNrLOCyEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vm1aGGfCNOeqeJwrB2BrE2CYj5ZjpAJEJrDHrBvG8yruuCbcZseheNWFrKSSB2kWD
	 cQl7gHOrh+vtZFz+NlU5u3GSJJfRikKko/nkRRe4AW9WlT7NaVL/vWhvScUc/XQVUx
	 DNNdsOf/qtqEvDQn2NMx4PrXVXrcEqFK13p1+eOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfBRUIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:08:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42168 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRUIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:08:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so30322993oto.9;
        Mon, 18 Feb 2019 12:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yhKD54KFzTOfa8P48/HBjpVRuzRUrFZL/Y6dFBlM10Y=;
        b=VIsYKtk83OdaUWN5boEanqvpMsOJFs3zbjX6btNhGz41MFMlka5aFC8q71F3EssaRH
         aiIsz3UbkgbSDl5GoKblI0UjAe5dAhHzx4cunsJUQTIimTz8v5p7DrNPQap+qMRDAZtf
         TsS7gtcemvh7Hwxjyk/PKrwau/7GREjK5DsUkYtUS7zo1eH1B448r3s4ReHueNTNMbIV
         XhLaAio661cJVBtZsBcWN4USL98ig4N2fUGbQZJbX2aGgE3XsX/ih11Os+Uv5c/KJKDv
         qDuYGCfp+iAnzO7eG+c2XzGQUl/u9JLg7p9Jg6YxPeIv1GHRMidXca6Xj0Py5wGJGIcI
         M2Dw==
X-Gm-Message-State: AHQUAuaaS9r+wX/cSSVC9GNtzmt/wkWx6HVMZhnkBTl/mnFOhbbdx5iD
        SfNCxdOXo+5DlMPnfjPO/g==
X-Google-Smtp-Source: AHgI3Ibc3csWKg+9fThFwFG6QwOJP4Gr6B1wsnSrBNtF9UrbUphfNfi0Kbh8ty6edhhviPbUe9gZhw==
X-Received: by 2002:a9d:3a22:: with SMTP id j31mr15561164otc.238.1550520497666;
        Mon, 18 Feb 2019 12:08:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s12sm4263255otk.0.2019.02.18.12.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:08:17 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:08:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     p.zabel@pengutronix.de, xuwei5@hisilicon.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, guodong.xu@linaro.org,
        john.stultz@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Add HI3670 reset controller
 binding
Message-ID: <20190218200816.GA9606@bogus>
References: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
 <20190215054955.788-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215054955.788-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 11:19:54 +0530, Manivannan Sadhasivam wrote:
> HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
> driver is reused for HI3670 SoC and the binding is documented here which
> uses the fallback approach.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt   | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
