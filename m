Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7157C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D55A204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D55A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754698AbeFTS0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:26:19 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45682 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeFTS0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:26:17 -0400
Received: by mail-yw0-f195.google.com with SMTP id v190-v6so181293ywa.12;
        Wed, 20 Jun 2018 11:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QSgWanzpgaw1i3Xm2ffz21H3mN+Dnq366rkUcZpnAAY=;
        b=NSZbdd0iNgfI25dVPBC8VSayAFBT1+6lXXrFmw589ig9pvcRNySiyZEXQLr9NqovbH
         i8cZ19nYAoh7obraJB1ttbsOq9Z1jUH7JVmc1LUpBQEE7lho6eBnBNOIvz0szt7DKcJe
         dd2l0UhM8mbwlXYofrZYHasg9qvup26LVW/Uqpxi65IgAK2ixm2xM5DTRkkoYAWXfWfO
         wh7tVrCk36opAG+AEkByY6DUv6TJItUfBFEgeOwDex9Q9hhsHYc1c0zPjBQSyIHHa7Lr
         Hk81Y1Am89Km3/IZIPTCKIxkHpjvv7BSgosVT+bZV2YfImANgtpC6ih9Gm0oJRK5MRgQ
         ykiA==
X-Gm-Message-State: APt69E2R7a63rM4SlgTXoLBSIMvrwlcQaF2bH43GettZug3J2tJGtj3Q
        c/9NNQiBNuAgfM6UTuSr9g==
X-Google-Smtp-Source: ADUXVKIa+RGQdA1D7nVHDclPCh+p3sRClXOFoodqGgeGvVreK7Nwt9HPBhY+RzkIXl3vi2a6RstD1w==
X-Received: by 2002:a81:8106:: with SMTP id r6-v6mr10383346ywf.159.1529519176831;
        Wed, 20 Jun 2018 11:26:16 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id f125-v6sm1129558ywc.46.2018.06.20.11.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:26:16 -0700 (PDT)
Date:   Wed, 20 Jun 2018 12:26:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maciej Purski <m.purski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 6/9] dt-bindings: tc358754: add DT bindings
Message-ID: <20180620182615.GA15792@rob-hp-laptop>
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
 <CGME20180619082001eucas1p1df565ba7d1eaa320c2703e7dc019792b@eucas1p1.samsung.com>
 <1529396370-18761-7-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529396370-18761-7-git-send-email-m.purski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:19:27AM +0200, Maciej Purski wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>
> 
> The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
> Bindings describe power supplies, reset gpio and video interfaces.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  .../bindings/display/bridge/toshiba,tc358764.txt   | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt

Reviewed-by: Rob Herring <robh@kernel.org>
