Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BF4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E997F2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547245276;
	bh=aKd2Sg6D2nzhQ8DTeyGVYVgMFUGZ6Ha/mWTvP/eokI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sva7evre5mSoGv/Svl5dws26sGiUQTgmi+MAakAI2JUj3Wf7u1LS8y91jf2AYrYhd
	 aU0nUgyJFPKSTTtI70eNsl+s+jWNQ9rCkNC+jupjrD6cu6fGLaR2x2EgTvpXb3MQAi
	 OaqqrjjwWkw5tlNQw3YSO0vc0ktEfiU8c0Rvqr+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfAKWVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:21:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46121 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:21:14 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so14487269otm.13;
        Fri, 11 Jan 2019 14:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Nel2vVzq6eWDK0fFrMqnPPVRkuH4RMd3RrAGtv5Xdo=;
        b=Fs7sgatJkK4kSbJc7WRCbrQJ+7W1bDtpHa8Tu5isG6h8LcqomhTBpjKtUNfCWA5Pv5
         qnnUEcXHqIfTbPgVMz1PMeJS15QT8BdrBfRtueBabCHwQrg6T8CYOPZGmCpmPrV1k5+Y
         P8gQxr0IQrd9G8aom2P5CAffAFhnGPFmknmeXqVkq5wpSQ+F7LLN9BF36IBZwp5naBT/
         eVR2kpe+IZJatnrB9lAUpHItqo2MgWz/FA0hT684uMyG9cnDhvkixm4QIimNjVnj5sRI
         mZX+X72i/ZDmQqU9vaKWK0dYEa+V6pRzI+g4gS1BzB1cPxcad1ZmvugHU13YTnhDH76k
         XgjQ==
X-Gm-Message-State: AJcUukdqSpZYH9g8fzDSHLjnYvynpaupHlZp393GZmDf1HVe1uROYR2m
        fq+LktU+VAfQ3Ef6ohdwiA==
X-Google-Smtp-Source: ALg8bN70geTue42OwdBrFAUryFk0n6KBaHh9O+hanM0kR1SSpFzF98W9yIRUDG6tNKgZ3bhfMhp5Lg==
X-Received: by 2002:a9d:ac8:: with SMTP id 66mr11625947otq.315.1547245273906;
        Fri, 11 Jan 2019 14:21:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d5sm35176349oth.78.2019.01.11.14.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 14:21:12 -0800 (PST)
Date:   Fri, 11 Jan 2019 16:21:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joseph Lo <josephl@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joseph Lo <josephl@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: timer: add Tegra210 timer
Message-ID: <20190111222112.GA14252@bogus>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-2-josephl@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107032810.13522-2-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019 11:28:05 +0800, Joseph Lo wrote:
> The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
> timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
> from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
> (TMR10-TMR13). Each TMR can be programmed to generate one-shot periodic,
> or watchdog interrupts.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  .../bindings/timer/nvidia,tegra210-timer.txt  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
