Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE316C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC0320867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC0320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeIZBMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:12:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44437 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbeIZBMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:12:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id 36-v6so25551419oth.11;
        Tue, 25 Sep 2018 12:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eyFJsqasl8zpJFZdhd+JpeFdRkxcip9LquLgNy/Iy6c=;
        b=gZXz8CPdZX/Amf43BUhVK/hxuO+OaNk3Z4WtGfrUGN4tdBnR9AlHKCA8Ulo7Wvfsl4
         +QxSk4Je6WgXXPjRYqUpLIBDGQYu8+55Ckx/9fUhGFt1fgov1od5mvRKLnNyvM+Kd3Xf
         nV+7O0r7YxUGjH6kjSLNdw5udve2fXHO3I/F0O8c6VMyva/iiOp3jlQL5r1C6gcTMSZe
         aOlw1bn/62dpSAegzuB51YQj8wqX3g3KYkznN1ZsP/wv4LIFRtcoS5X+DkkB3qBGk3te
         bVWx5GAG90VEnAO81H1pcUmGV2Fx5F4EnuLAM4kh4N9Ib//LBX1hgt/ZEYaKYvjUXedJ
         sczg==
X-Gm-Message-State: ABuFfoiLJY90r1MKXuTMMspmx/0OG2UYR8yd9JBiqhAbbPhuRSoeuBz8
        rqKFu+6K2Srlv7s77kTwQw==
X-Google-Smtp-Source: ACcGV63GD/U27iU2DNkudF1kSVdf9iLpiiAJH8zsq55EKls6tIVFowyofQ9EyYzvf4g9ZyRGq6q4LA==
X-Received: by 2002:a9d:3788:: with SMTP id x8-v6mr1750317otb.171.1537902195121;
        Tue, 25 Sep 2018 12:03:15 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i9-v6sm985659oth.5.2018.09.25.12.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:03:14 -0700 (PDT)
Date:   Tue, 25 Sep 2018 14:03:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 28/37] ARM: tegra: colibri_t20: simplify model and
 compatible properties
Message-ID: <20180925185028.GA25151@bogus>
References: <20180902100906.25792-1-marcel@ziswiler.com>
 <20180902100906.25792-29-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180902100906.25792-29-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  2 Sep 2018 12:08:57 +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Simplify model and compatible by dropping the 256/512 MB from the model
> and -512 from the compatible properties to be more in-line with all our
> other device trees.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Also reflect this change in the Iris device tree.
> - Also reflect this change in the device tree bindings documentation.
> 
>  Documentation/devicetree/bindings/arm/tegra.txt | 2 +-
>  arch/arm/boot/dts/tegra20-colibri-iris.dts      | 4 ++--
>  arch/arm/boot/dts/tegra20-colibri.dtsi          | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
