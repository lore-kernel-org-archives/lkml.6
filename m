Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCACC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5F620855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544481207;
	bh=pfdHItWSUm+4sdGGLP7fQVxK7Yna5JckDdtaKw5jBhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UhqKULz+DxxDEUqW7rZEtl5oo7gtkPey8ZvPbJXYr9FOVz4bT4cxERa7A4RM8sNDK
	 8PmgBret7kH4UbC9j000aMwotbD4UDZpMMMcdf4rMuRt3SLjD4h2wyNZYd6+TnBn4v
	 N0rKIqmXT/WeU0N5I7bueKNWm0MqCR/hK80JZtIU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5F620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeLJWd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:33:26 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33195 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJWd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:33:26 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so10441530oib.0;
        Mon, 10 Dec 2018 14:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yfwr3ceJXdWZ5pAW5Q1dV5iAmfUilIgFOg2s3h330Oc=;
        b=LX0wvONixfZHa8nAzDneouGUXQFZI/TAVBI+96H4e9bnL4sHm6Un+HPcP9/1YBGLTX
         yIjaWP7Fc24NJIwONFWK5b2CHkypY5W51blZwhJobi3tw7Ypf0FCyqW24ZekX/K7GX10
         lNRqP+k4UDpjfpurpP/mBJ0QPrkNbVmn4p1vDYWp9Ou2MUGYUDO8LSIuwjvjoFN3s1q1
         jpFiU7R9HD2OJolGw8w1kjRBuhxptDXZEawa+oRPpng46Zp6Ihxui3HRvsHy0y6BwSq8
         VCp3+qo4myAH1wzmAQbJ2GAtSSyXURqaj2mlUEL8vJ3bgo6n+MTFZQSVn2Jv5hiB+KZ5
         Tpcg==
X-Gm-Message-State: AA+aEWZpf7RxtmAwKVUQ2Ok2FpAekIYnEYdvqiTe1edfBamDaBjs/xWu
        Pfcs6paL4gyTDS66P50Smg==
X-Google-Smtp-Source: AFSGD/XZxAZfcYGBIjAdtZHteUa2XJ0kK/XKcdhdLN3eo1D0xiUOzguYYpbfT5kvWQoQ7gdYdr3Xmg==
X-Received: by 2002:aca:c649:: with SMTP id w70mr8768116oif.186.1544481204328;
        Mon, 10 Dec 2018 14:33:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b18sm5675330otl.33.2018.12.10.14.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 14:33:23 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:33:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] clk: samsung: exynos5433: add imem clocks
Message-ID: <20181210223322.GA16266@bogus>
References: <20181204165248.17572-1-k.konieczny@partner.samsung.com>
 <CGME20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee@eucas1p2.samsung.com>
 <20181204165248.17572-6-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204165248.17572-6-k.konieczny@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:52:48PM +0100, Kamil Konieczny wrote:
> Add imem clocks for exynos5433. This will enable to use crypto Security
> SubSystem (in short SSS) and SlimSSS IP blocks.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c   | 193 +++++++++++++++++++++++++
>  include/dt-bindings/clock/exynos5433.h |  55 +++++++
>  2 files changed, 248 insertions(+)

Lots of trailing whitespace checkpatch errors...
