Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F122C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EF3213A2
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EF3213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeKRCBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:01:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45243 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeKRCBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:01:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so23489263ota.12;
        Sat, 17 Nov 2018 07:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IYc/ZdbKrZX8H8NjdfW4nPMpwhVGM2Rx4jFyO4EOyHI=;
        b=E6GKDIeBrzxZaCopOBV5+t+jTNYE18vjtTWbwJM1UxdCHTNljnfjk4UMrGK4drW4Qd
         Dh9xLFfnKU2NPLjxaDoiX/IZ/pcSQQVPWwJgd21wdjy5akB5fGnJ0+zs1alq3nr4SU48
         cz0s9ROf3CrP65sVzoT/s68lsd6U/uBKEATILjENr9aCYwjpE0in/4e3Uu27R7h7zrmu
         20rj0S58W7Kz4CpxVg+CCP+Q3NOs2BXH/nqn1BSj5oiV7ViSNmUw6+pypDqnIj4dsOLz
         KPk2ia1/Zw9QFWxdd//HKDaEaoBMfAZy3n62fqSrGE3IbZNT21OMF9z+1HfCIzhHCFGI
         a6MQ==
X-Gm-Message-State: AGRZ1gJXAIFC5KHB3ASt/lT7Ur/8m15sQjrHQoLk0hb3fXwAFN86D9aY
        R0O40/GQK92tYbYBTVRINw==
X-Google-Smtp-Source: AJdET5dCBI7D+aRppojFbJLwHrKNfIbcHM6yIsXh4LVrQ6eRWYCeKMgkgB+i6LaaGdVKER6S2h/tyQ==
X-Received: by 2002:a9d:2c94:: with SMTP id p20mr8591603otb.92.1542469455385;
        Sat, 17 Nov 2018 07:44:15 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id u8sm12099380otc.11.2018.11.17.07.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 07:44:14 -0800 (PST)
Date:   Sat, 17 Nov 2018 09:44:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: Re: [PATCH v2] power: supply: bq24190_charger: add support for
 bq24196 variant
Message-ID: <20181117154412.GA5215@bogus>
References: <20181113124753.29948-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113124753.29948-1-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 13:47:53 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> The bq24196 is another variant of the bq24190 charger ic.
> Its register set is identical to the bq24192 and it even reuses
> the same part number (0x5).
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> ---
> This should go on top of the bq24192 support patches from Brian Masney /
> Jonathan Marek [0]
> 
> [0] https://patchwork.kernel.org/patch/10663409/
> 
> changes in v2:
> - add missing compatible to dt-binding
> 
>  Documentation/devicetree/bindings/power/supply/bq24190.txt | 1 +
>  drivers/power/supply/bq24190_charger.c                     | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
