Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4998AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAB920857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAB920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbeGaVAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:00:07 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43346 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbeGaVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:00:07 -0400
Received: by mail-io0-f196.google.com with SMTP id y10-v6so13981699ioa.10;
        Tue, 31 Jul 2018 12:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HxXpF2o5AD5wRHqNMmrmWFxmdW9iQ/2uc+9SglAjRvU=;
        b=aYwWAGhboj5zBOHW9VxH3BgKqDEpIvhpWFmSS42a9H/C+jakWne7/NJttBmbTqGTT9
         tdVlbizoGmA+9CNlddN5i6nN5ltD4Jo33YUbxZO6FvIdGoaOqOuiJ9Bss1y/m75gWnMU
         qnXCzYbvvaDpqP8wqss9R/w+TgUKMLriV5Cm0Md6SdTxEUN9hdoHZAKHpPfyQRxiIl+d
         yt0JDY6pfoGRHTdBLPBMCCOdgPgXjGzzTbk9tfo3h/hSSwz4QA91zEYpWOGzwNO0R3jQ
         IcwlBU6C0Ft8liOLfFEVPvCKb1LiFyEu5ltGvoALz9fjUT7MTk8J5/1lic66fAUOXJ/T
         0Pmg==
X-Gm-Message-State: AOUpUlHtrFiTlVuPGLeGDpe8Wy5NOnK3t71ZuSkraSZ/BTaNMxkVhDO2
        Ikqn8aA6f4sMym5lgu51Zg==
X-Google-Smtp-Source: AAOMgpfB9o4Lsis0ohAan4BEKFKSaOWEq7UWYtvH/NsRHdZHuUre7MQJkNHIgXCZVyAZaVfOvr/Cew==
X-Received: by 2002:a6b:348f:: with SMTP id b137-v6mr861379ioa.134.1533064702125;
        Tue, 31 Jul 2018 12:18:22 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 137-v6sm2442698itl.39.2018.07.31.12.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:18:21 -0700 (PDT)
Date:   Tue, 31 Jul 2018 13:18:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: thermal: qcom-spmi-temp-alarm: Fix
 documentation of 'reg'
Message-ID: <20180731191820.GA1723@rob-hp-laptop>
References: <20180731185917.176074-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731185917.176074-1-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:59:13AM -0700, Matthias Kaehlcke wrote:
> The documentation claims that the 'reg' property consists of two values,
> the SPMI address and the length of the controller's registers. However
> the SPMI bus to which it is added specifies "#size-cells = <0>;". Remove
> the controller register length from the documentation of the field and the
> example.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v6:
> - patch added to the series
> ---
>  .../devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt     | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

