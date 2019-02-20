Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA5BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF11217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhDpOS9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfBTB0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:26:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35186 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfBTB0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:26:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id p19so98699plo.2;
        Tue, 19 Feb 2019 17:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Od3EhlF9rRUhTmewXpccIjWjwG2bn0+UJXtWkBluhy4=;
        b=BhDpOS9zxMmgoDJV3hLld5I2ZaJDpA9+T+hk+Ze+vC6LZjZ5mB26VRn8mxk9QKTQs+
         95dKYwyufPUs2dE4ZG/X6B/ppfCVct+c8XrtzRUwuWlp8YPOrLe36GPWhLvSC4ZMPbQn
         qDd8bZ2DbHvffehFvSYA9GAYXI23L1ZPMQyX56SVDbtRPXyEwghzzJOJqF3Yy54xLeCB
         zGyHqYPfiNxQKQ+kcEW8HvW43rQrmzqIW9DMPanWAfXRpwYwyBBbaYffSMmmhgK8FMli
         4CHZiUn6KnqUYUYn/HIpRosSYGIqXtBftrRqnXvGBBgmvgU1CTCF3kzGKYO9uecwDX9s
         5f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Od3EhlF9rRUhTmewXpccIjWjwG2bn0+UJXtWkBluhy4=;
        b=kFsjTd4zMjN4vNgWXcIN+DTdIQ8V/64mKlyflqb0WUKL+MznyfXOkj9KKSzT6r7P7V
         gaYCzHsSlMkPPo7kfE4aYRPMVhQbBqNaeVuWLwV/zKCniQXrwhcFWAQyBnpkuGX7Jmmb
         DxIKuqhTPB504ZxnGJPV1rmLZo437d/6BvD4WsxXNBx23GtsMunLDNdpuw1tIVn7Hy19
         jYD35yWNznrpbXEAFSqV3uJ5O7d/CPqWjTUnqG87fUG8D7qfD1KHMEk4f88bBohKoIgO
         EYCTqZVu/eF0HOvvCUvGN1vyN7D3tc2w0hA7FvIy98K6WBhHNT1kJHM5u70WkHqt9a9E
         aEtA==
X-Gm-Message-State: AHQUAuaTXbdUX8A+pZeleL6EoprDHJIPI+l6yiBEhivDxlMRJwi8WTZT
        3QHKMOUg9Tq3VEYMKlX/Y24=
X-Google-Smtp-Source: AHgI3IYWHf0wCYyL2hYGzlyUCyrI25dNRJuI7Z31l4RdxNNDpjNqw7nzTIJas8MqgebQXtg88iL7Og==
X-Received: by 2002:a17:902:e711:: with SMTP id co17mr19694693plb.171.1550626004832;
        Tue, 19 Feb 2019 17:26:44 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id d85sm1165339pfe.159.2019.02.19.17.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:26:43 -0800 (PST)
Date:   Tue, 19 Feb 2019 17:26:42 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 00/12] qcom: dts: thermal cleanups
Message-ID: <20190220012641.GH2811@localhost.localdomain>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey
On Mon, Feb 18, 2019 at 06:05:14PM +0530, Amit Kucheria wrote:
> - Expose all temperature sensors on msm8916, msm996, msm8998, sdm845
> - split up the register address map for msm8998
> - standardize names of the various thermal-zones across boards to make it
>   easy for test scripts to parse
> 

I am generally fine with the effort but please fix the following
(applies for the whole series) wrt to required properties for DT
thermal:
a. Trip points for your zones
b. Cooling Mappings for zones that have passive trips.

> Amit Kucheria (12):
>   arm64: dts: msm8998: thermal: split address space into two
>   arm64: dts: msm8998: efficiency is not valid property
>   arm64: dts: msm8916: thermal: Add sensor for modem
>   arm64: dts: msm8996: thermal: Add temperature sensors near major
>     peripherals
>   arm64: dts: msm8998: thermal: Fix the cpu sensor numbers
>   arm64: dts: msm8998: thermal: Fix the gpu sensor number
>   arm64: dts: msm8998: thermal: GPU has two sensors, add the second
>   arm64: dts: msm8998: thermal: Add temperature sensors near major
>     peripherals
>   arm64: dts: sdm845: thermal: Add temperature sensors near major
>     peripherals
>   arm64: dts: msm8998: thermal: Make trip names consistent
>   arm64: dts: msm8916: thermal: Make trip names consistent
>   arm64: dts: msm8996: thermal: Make trip names consistent
> 
>  arch/arm64/boot/dts/qcom/msm8916.dtsi |  30 +++--
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 122 ++++++++++++++++++--
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 154 ++++++++++++++++++--------
>  arch/arm64/boot/dts/qcom/sdm845.dtsi  |  91 +++++++++++++++
>  4 files changed, 328 insertions(+), 69 deletions(-)
> 
> -- 
> 2.17.1
> 
