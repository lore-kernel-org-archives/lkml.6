Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C747C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E684322507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E684322507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbeKMKTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:19:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44595 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbeKMKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:19:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id b81-v6so4600241pfe.11;
        Mon, 12 Nov 2018 16:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yGJf+UnN5Q2V45X8ygYIi3F00vVl8LFI6xRmvSvcbr0=;
        b=WmLYukRh05ssGLM2L8PIEUqJQI+/dqp3ngEeyj9XXbaykK97wZ9Tj5puUlRwFbDl+Y
         Msjp5jU1h0R02YP7lNmktAMSeUbOtKGsllWuDWo8exlpvwZGxRj01Rdvyv6cmIsBnBp2
         3O1oj7MPmxCLLouEFxxNDEI0P5RCdYOEaaLbic6csgtbB6Dj3gJ2SJNZbMO0FzmgCD6O
         OA7ZVaro40zqMaashOk4gVFR/X4cCR+DWzDoe9dejc/aecTWcD3R6Jbzf8dnLEbRhwgC
         qoIsz6PBmTW2QXBFzGDgUOVKLNMeXQ6xcbUpYCJW0AQ4Pa8C/4j6/3vDPuiokey7xBc3
         1xVg==
X-Gm-Message-State: AGRZ1gI07GcsmY+Ms2juNEJDLEDBD48obLkTqxauNjq/pjG2Whz4rizY
        OFnilhdr4w3Om2YE4YrWM/SkMmNfRjpd
X-Google-Smtp-Source: AJdET5dneHn1Q1sx2MlxdQuZbTf0T9Ag4jdBMjqnVsiZwvCdUyoAgfyuDN5bapldSLXQNYEAcl47YA==
X-Received: by 2002:a65:66ce:: with SMTP id c14mr2704002pgw.450.1542068646188;
        Mon, 12 Nov 2018 16:24:06 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id x194-v6sm25873625pfd.32.2018.11.12.16.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 16:24:05 -0800 (PST)
Date:   Mon, 12 Nov 2018 18:24:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: clk: meson-g12a: Add G12A EE Clock
 Bindings
Message-ID: <20181113002404.GA31672@bogus>
References: <1541682912-120480-1-git-send-email-jian.hu@amlogic.com>
 <1541682912-120480-2-git-send-email-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541682912-120480-2-git-send-email-jian.hu@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 21:15:10 +0800, Jian Hu wrote:
> Add new clock controller compatible and dt-bingdings headers
> for the Everything-Else domain of the g12a SoC
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,gxbb-clkc.txt           |  1 +
>  include/dt-bindings/clock/g12a-clkc.h              | 93 ++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 include/dt-bindings/clock/g12a-clkc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
