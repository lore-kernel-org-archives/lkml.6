Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01960C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF78A2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF78A2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeI1CLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:11:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36430 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeI1CLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:11:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125-v6so3285401oic.3;
        Thu, 27 Sep 2018 12:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=08IFIA8w2uFiET0+TGKYWHOVLyp19QotfFxi2V2zgPs=;
        b=ezvxRoWPWFmUoB/+xkqv7QzjNzLjb7B82AvYhrqj4i42gBZNY2R6uQBkkSpFaaKWV7
         FsRuiiAI+tcljMuD1A3fRVFe5dcuIHRSdPscCIjMJKHO4n4RtYK/yIt8dDPal9Sucet+
         shiWAAXnSEGOZaE+Jn2o0JS0EePr0EgxTzNkiTfatqUGTkJYW+1nlY5pjSM7gBQsApU2
         0ePgTrYD9En+viWtgv8o1aSkx8Oa26lXVlJtMLLNAbula/AXFrc9TpwIPa7p/Dxqh1xI
         ulXZG7jFp3njZRzMgLSV2mkfQsx15ZcE6WfMTi+1JmfOEAIKjdTkXBef96yKvs6AjkJC
         ZQAg==
X-Gm-Message-State: ABuFfoiOHz9jJbi4iQGSwJLDw4kQDYp1mSHy+E9iZJgyUFDy76idcw3l
        IyJdwggnldHlYEhYCUQJQQ==
X-Google-Smtp-Source: ACcGV61aJ1OxLzzjEWtyX/ZLGaa/RboV1Hs+M0RuYVOaQfBtpXAkV0DITWJy104hIohxa+OqJ/O2jQ==
X-Received: by 2002:aca:54ca:: with SMTP id i193-v6mr4111882oib.340.1538077895781;
        Thu, 27 Sep 2018 12:51:35 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 31-v6sm1289774ota.23.2018.09.27.12.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 12:51:35 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:51:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v3] clk: qcom: Add Global Clock controller (GCC) driver
 for SDM660
Message-ID: <20180927195134.GA19806@bogus>
References: <20180810202123.29238-1-ctatlor97@gmail.com>
 <20180925173603.2274-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925173603.2274-1-ctatlor97@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 06:35:58PM +0100, Craig Tatlor wrote:
> From: Taniya Das <tdas@codeaurora.org>
> 
> Add support for the global clock controller found on SDM660
> based devices. This should allow most non-multimedia device
> drivers to probe and control their clocks.
> Based on CAF implementation.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> [craig: rename parents to fit upstream, and other cleanups]
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
> Changes from V1:
>     Change authorship
>     Add sdm630 compatible
>  .../devicetree/bindings/clock/qcom,gcc.txt    |    1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/qcom/Kconfig                      |    9 +
>  drivers/clk/qcom/Makefile                     |    1 +
>  drivers/clk/qcom/gcc-sdm660.c                 | 2480 +++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-sdm660.h   |  159 ++
>  5 files changed, 2650 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-sdm660.c
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sdm660.h
