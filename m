Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCB2C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BBE20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BBE20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbeGYUXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:23:36 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36242 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbeGYUXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:23:36 -0400
Received: by mail-it0-f67.google.com with SMTP id p81-v6so10172437itp.1;
        Wed, 25 Jul 2018 12:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+b36x3Kmrk7ISfKcO2IEcYz/Q8xsrhu3gip2H7XU5xM=;
        b=pcxfDh67hAjZKal8NWYbbLfQGGbJWeT1KC+/LdFoT/Tt7EH7nSd/L0LlJI9jnhooKo
         9E7gI8645/RWhoiwofKo4R0/3aAfM4wcEAC07bKIiS4uWmHZ2qWOIpLhHcTZSSn7VqPn
         z20c2l3ARlUVWKvC1yPjYn8RnClS0oai3KQs8aSRqRq8EpYxMTnauHtlmCsP1BT/Kyaw
         GgXvhzBkSLIxoxWxyIpoaIgsJ8zfnffizNOa4XhwapJW+wMTMcdAcRDck62wXrO7seft
         U68kFikSFdO5AXhe/p4daP5wzmSI2Um5/nr27Yg2fvFkjXIAFpv15MaIcW+MaDWxSk6v
         GPmA==
X-Gm-Message-State: AOUpUlG9XQmc4aCYVYIABR++zv5V+9AENzame4DEIXZ0vPiKxFmEipmo
        5HuQKVHEt3+gkKL87jxx8OUrszswrw==
X-Google-Smtp-Source: AAOMgpeXdUpCtoOO2TouTOnWP6WFkmMfJVcgIyoxOFS7MQOZMStkO40OOVthg/VLKlruUZzwAZ+pwg==
X-Received: by 2002:a24:5e4b:: with SMTP id h72-v6mr7328891itb.108.1532545835424;
        Wed, 25 Jul 2018 12:10:35 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id c5-v6sm2663079itj.9.2018.07.25.12.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 12:10:34 -0700 (PDT)
Date:   Wed, 25 Jul 2018 13:10:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/16] clk: at91: add new DT lookup function
Message-ID: <20180725191034.GA29658@rob-hp-laptop>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
 <20180717222757.10253-10-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717222757.10253-10-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:27:50AM +0200, Alexandre Belloni wrote:
> Add a new DT lookup function to lookup for PMC clocks.
> 
> Note that the #ifndef AT91_PMC_MOSCS section will be removed once all the
> platforms are converted.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/clk/at91/pmc.c           | 34 ++++++++++++++++++++++++++++++++

>  include/dt-bindings/clock/at91.h | 14 +++++++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 48 insertions(+)
