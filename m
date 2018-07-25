Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B803C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B387520843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B387520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeGYRNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:13:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51307 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbeGYRNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:13:25 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so1127764itf.1;
        Wed, 25 Jul 2018 09:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cmi7KhvPkctDNc+X4qNl3wtabEN+9uX/bxC4Cw/VEf8=;
        b=MYyTrsBhizclCLtvTYm9z/1MM7+WCNz/Pw41gPKNBoO6T6j7luw9mc+pnKBH3HbRKG
         3JJnv+1q33/Mibw8qNUub2V1u/CxSolb1yvv0+8ZZCh7Q+aId6gAxKVlPvttqntzOnX6
         pByK9Kaj/IsskNA43RvQtLYCmIy0mmHB4AhMY6MVvxibCbHeuM5OJodrgHHfrEKHejic
         DIg9vZfUtlIVR+OxB3uNzo1TLpPuiRKuohLGFwcrsrC23vtPxNZAX4PQ4BefiyYQX5Vs
         GhbhysJ4YShi80zD/svLixM6uxnnAov2WKFxq0cV1J8834S2ElOXKiTkBdFP+3kao2va
         JcRQ==
X-Gm-Message-State: AOUpUlFYJNUUkV1dK2u0cCf1j/6lbhqHBgmmHblhH+Yt7pTo9aQizUBX
        2MQucO1abRHW8wZJKkU5XQ==
X-Google-Smtp-Source: AAOMgpfMN6ABMPkgjd4JWqDocBwHE6I6Yix3udTNy31vfO1BvmZtrYiZgdAOFUGrejsYkdWkrAksOA==
X-Received: by 2002:a02:9b54:: with SMTP id g20-v6mr20668452jal.33.1532534463781;
        Wed, 25 Jul 2018 09:01:03 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id e2-v6sm4135234ioa.33.2018.07.25.09.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 09:01:03 -0700 (PDT)
Date:   Wed, 25 Jul 2018 10:01:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     sboyd@kernel.org, andy.gross@linaro.org, tdas@codeaurora.org,
        girishm@codeaurora.org, linux-arm-msm@vger.kernel.org,
        anischal@codeaurora.org, bjorn.andersson@linaro.org,
        grahamr@codeaurora.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/2] clk: qcom: Add qspi (Quad SPI) clock defines for
 sdm845 to header
Message-ID: <20180725160102.GA18545@rob-hp-laptop>
References: <20180724174513.174018-1-dianders@chromium.org>
 <20180724174513.174018-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724174513.174018-2-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:45:12AM -0700, Douglas Anderson wrote:
> These clocks will need to be defined in the clock driver and
> referenced in device tree files.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  include/dt-bindings/clock/qcom,gcc-sdm845.h | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
