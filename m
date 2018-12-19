Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4627FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1312A218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545229323;
	bh=xqFJzKMfs8ghNnEpII9IwFWehbjTc4JRJvu2YekOxVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gqn8xdr5mdI2N89HPA4Qgii2JhfUbjZpkinMVESWSNoDuAKCUQsZpkqZ0Dhb1Pmv2
	 FieENgLB/XVg14i409/gqnqxlGKk6gOBbwnE+fj330TzIoPVuZxNYMgtFM1iPcy2HV
	 Lqx9wMRodebL9C38I7leVj8o9GYeVGLLwFhJ1uAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbeLSOWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:22:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39163 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeLSOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:22:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so19219420otl.6;
        Wed, 19 Dec 2018 06:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASkGQXhK5UigqgkVZTikfy6yutOp5zh9GOy6IF50t1U=;
        b=i6Dk8QEfRaaOaCVe2b48otoTgp2zRKCTAq/i6bG+bUIScdCzCAD5ksltXtqfKdTbwf
         1dNyNZLta13eSRq6b2b0KYwXxLaU6c6rKT0e9N99JTgsvc6KWpFACWPpA0/+9hQponz8
         Itzv932hYJb8uSdUnFLNOEeFMbf6hsuyTdin1nXHxCGh+30isRVw0vShBEBYl38KQidA
         /xvolR0ekmuf+eRE/2bor7hvRmXTqvJBCsABNtKllTPF6MPZqPsU0EWPFcdCKa2o3io+
         5kbJl7OniGbffIcc1PVEgtSJQlZPsJiCiO3f7wBq6ODRZ5x1yNZ4eYCZF9FrpkmpEKxv
         JoIg==
X-Gm-Message-State: AA+aEWbjgVpPoX3FHUOTx+5uij/DrSoTZN2MLodwBV+lWtUi5K++CPAl
        4YqW//IuQqMqhvqLIR4qRg==
X-Google-Smtp-Source: AFSGD/VjQ85kDeN76ltR7pXDaMXLvYQ39GmIrpHX4jbf434rawhxuKzSU6Bl8nUA+TTa58Pb6T/TvQ==
X-Received: by 2002:a9d:7a8c:: with SMTP id l12mr13485073otn.335.1545229320912;
        Wed, 19 Dec 2018 06:22:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m207sm9106325oig.2.2018.12.19.06.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 06:22:00 -0800 (PST)
Date:   Wed, 19 Dec 2018 08:21:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xingyu Chen <xingyu.chen@amlogic.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: New binding for
 Meson-G12A SoC
Message-ID: <20181219142159.GA3700@bogus>
References: <20181203061324.36248-1-xingyu.chen@amlogic.com>
 <20181203061324.36248-2-xingyu.chen@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203061324.36248-2-xingyu.chen@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018 14:13:23 +0800, Xingyu Chen wrote:
> Update the dt-binding document to support new compatible string for the
> GPIO interrupt controller which found in Amlogic's Meson-G12A SoC.
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt    | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
