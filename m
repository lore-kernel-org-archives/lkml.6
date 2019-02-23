Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D110C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0105206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550882700;
	bh=GC03rfT9zULMRjL5hsWuXdubPfq3wYrzmTss+Xuhq0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QL/cCQ/SAqOw4W+XbZXJo+Iv3DLWU8V05fKDMUJt0Xt8dIcmT0IYyXbWQ3/pugZDU
	 muKJmuR8Lt8MmChB2KYhi86R4YMOuBHsADnygSYIWEbq2PBucz7f1nF8yNts0pO6/l
	 JfqRyzACDNY3ZK7S9SOMuKT8f+jI+SspktlNGX7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfBWAo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:44:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39830 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBWAo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:44:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id b4so3174299oif.6;
        Fri, 22 Feb 2019 16:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5yCkJsFM9EH0Kw6t4rfJCwN2CCCyMGusGK5MqBJDYhU=;
        b=I+5yDBGj+0X6DML1Ur6G1eScQJ6PT4BvALPaiMfVMdkjiDlqyV2LZk2jDdh+46Wusj
         06hPvUiKzyk8BzMttw+5BonSiOTN2Pqf6r4n4Ss+O9S9Aptsa9eKlo0EZQ7npjBUEC/9
         zkwpMSej+gsH9GWMnOlY3vMn8joPYdDDNz5LuoWMfjmebS/2WgM9juaMl7TeASXBXyFY
         6Lgwfp2qY4Brrl76dV46YLHfiFWMzyVLzt1Dv6YWzR/MGIKUQoKI1q4hz3V7EmNtSQ0t
         E8o0MChRrqZyFeg6DmgzC6i7FOWDL60HCLhdvcaDFUESr+1/n53HOQig7mSKI/VQ1v48
         FwpA==
X-Gm-Message-State: AHQUAuZu6vV7DxR7nF/GGCeZpSZoIUIStoTw2uy9baTCQkEbk/8LDbaA
        qx9XCJ9HDuazFYV/QRLhxg==
X-Google-Smtp-Source: AHgI3IYAbqAlIYIwOyD6Z5qaxoa8MeMQMajoUev2NiXSsYOoGwVMZUSLbPY/Doz8uFWijhqOIQs56Q==
X-Received: by 2002:aca:b354:: with SMTP id c81mr4325957oif.26.1550882697314;
        Fri, 22 Feb 2019 16:44:57 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d11sm1194861otp.18.2019.02.22.16.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 16:44:56 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:44:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     jorge.ramirez-ortiz@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        niklas.cassel@linaro.org, khasim.mohammed@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: qcom_spmi: Document pms405 support
Message-ID: <20190223004455.GA8453@bogus>
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548675904-18324-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548675904-18324-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 12:45:02 +0100, Jorge Ramirez-Ortiz wrote:
> The PMS405 supports 5 SMPS and 13 LDO regulators.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/regulator/qcom,spmi-regulator.txt     | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
