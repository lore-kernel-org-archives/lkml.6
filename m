Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20B7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E67320657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547582832;
	bh=gz2DF96jaPlL3gzgP05wPFZMo/Ker8SFCAP326BzLWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RvKd2xzBVCWb05zTNS10ys8t6x4nXq5Hmdo00E6Gp021iQCfe47AUv5G8Wn0fE4GJ
	 GA69GpSVNd8kHN1w61qaLuthjU/KK06fHeTrQmc+6L09UXcZKPKFM0h+1KDhhWzQYg
	 fpSRQL6anZk7UWOR3/09eYZjFGQnPFWWG4NIDgcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389735AbfAOUHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:07:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45230 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbfAOUHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:07:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so3675577ota.12;
        Tue, 15 Jan 2019 12:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7IChYKDZ9R5hbwmXxYWL7g6/bGDY7PsOzrKN1Ww9zew=;
        b=kxTNP6yW/nPuh3kXi5QtgpBqmW/tuDRXtRIon1rxSkr9FjcUHg8lRlkKtySVDL6pEJ
         He46bn9uaRf14BJfE9V+MNGelcjZXN0EsNpHE5T07MhoFSy55zmoJ3pC80ux/XPdLWd5
         /0i1YNnUxujnQhCBmxv2toxwp0pp+La9CPbTOAstBkDMRvp+Rdovu1B9A2U9S8akNwhP
         eR1rTMwehw5iMQrGJZKg1UHrK1m0ze6GPGiuKSb0ZZztpTBEYngIIc9fXobmdrmi7uWi
         vCL3xNvhgTZljozedobB+C219JWVFExhLXp3qeD+CieKysjg3CkgJeKxFCH2+vX1G9GY
         bY5Q==
X-Gm-Message-State: AJcUuke1SCbfuQCfLsaKrC5UVw/vHnxIbMceJcluwYwAYSFGQBOlkh4X
        neKnmGLe8e4Jf/5P1hPa5A==
X-Google-Smtp-Source: ALg8bN5kemHddsXMJ7cJhGIcQXpFXKX63kJfOKaXTgMS0jG9NxmD+6bDi1k41+Y83UYDDz3PUpIN1g==
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr3322604oti.367.1547582830022;
        Tue, 15 Jan 2019 12:07:10 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id j5sm2624151otc.54.2019.01.15.12.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:07:09 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:07:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/14] dt-bindings: pinctrl: qcom-pmic-gpio: add
 qcom,pmi8998-gpio binding
Message-ID: <20190115200708.GA20288@bogus>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113154716.5145-2-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2019 10:47:03 -0500, Brian Masney wrote:
> Add support for the PMI8998 GPIO variant to the Qualcomm PMIC GPIO
> binding document.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> This is a new patch introduced in V4.
> 
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
