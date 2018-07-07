Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C23DC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166272075E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166272075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeGGIze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:55:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44409 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeGGIzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:55:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id f12-v6so10270441edq.11;
        Sat, 07 Jul 2018 01:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V22bWkWyoT0Uir9lF5/cC9nc/vHpp9//VIm0zntYkiY=;
        b=Kp6n4m5XqyU0h1SKVHnpiyQb9THMyW/YPuNAJqlaK15fCkQLfepi1da9468srFWnEY
         HOua7yKLoWcKkgm1Om2R0+2XshFg+8qE8kXVpctA0fvkSefK9TTuazqhHBEKZRFeAe5m
         CU2xcHBIPxePj0ce466ilnflbMd5HOCr/ZYyQr2KghPWjeTxeo2clhXYuNEbv28MXVnn
         Z0qQMk2wSEdh36pm2UDllhiFZWT1qEiAsAZrfJzNyaxO+JP4mDymeLj2/LzyVljY4GF9
         b0bRJw2EbbTZvHG3fJTEPvjxjf6U+6m3nZ37Y3OAhhZALpAu7OEa/uwnHiv+0KNlh8GB
         iriw==
X-Gm-Message-State: APt69E2BF8653aTZbGTc6KWdhLLRcww2VGXz3ExyxtfL7cJnwMKJUgHl
        UMmeFDXQSkwOGKXjTZjhI3k=
X-Google-Smtp-Source: AAOMgpeihv7oIrhSYQzSpq69pdGARyaajAKMekgtaEM7Q1ASQHEIF53lo1zbuuIUX3sdXvWHmApDLw==
X-Received: by 2002:a50:b4db:: with SMTP id x27-v6mr14373594edd.155.1530953730125;
        Sat, 07 Jul 2018 01:55:30 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id b4-v6sm1764782edl.57.2018.07.07.01.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 01:55:29 -0700 (PDT)
Date:   Sat, 7 Jul 2018 10:55:27 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Maciej Purski <m.purski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 8/9] ARM: dts: exynos5250: add DSI node
Message-ID: <20180707085527.vdnbqy5digndxc7i@kozik-lap>
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
 <CGME20180619082003eucas1p1ee69166282872a3c031caf08cb550269@eucas1p1.samsung.com>
 <1529396370-18761-9-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1529396370-18761-9-git-send-email-m.purski@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:19:29AM +0200, Maciej Purski wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>
> 
> The patch adds common part of DSI node for Exynos5250 platforms
> and a required mipi-phy node.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>

I see that bindings got Rob's ack but kbuild complained about driver
changes so I guess you are going resend everything? I'll wait with
applying these for v4.

Best regards,
Krzysztof

