Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6CDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C81C208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C81C208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbeGaVCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:02:24 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40762 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbeGaVCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:02:23 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so5931340ita.5;
        Tue, 31 Jul 2018 12:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rSFYstEIa8RbxytHmD/gyJXZDer0a6LDZ65lafginfY=;
        b=uOlR9hjrQzF2U82bS0ZCYViBfYhdrTAL0VwsML7IUOaV9bw2Gibd5ZUapfncTR7VsX
         N0Aktc0pgrCEC02b3eI8+MfuNPkLTyxncMIg4Jh/EKZMBSO+6LUCEG1unkZgXA0PFxOe
         oJ0fK6hVgxWV/+SmrJaLT9qjOCQtmGZ9OBORzww/CLLsy3tOKjY+cGnKLaq2VG000os6
         s/ss2OxCbUj/19Z1U30uK6nPRGkTr3Rp5ESMinOkTAQDbT113AUiGtB/JnlRB6pCXKtu
         1QGafkbFGuy/I2OmGXwlTdQAraUTBVpsvQZgAy5iEQ+ZMJgYqvUUO3VKgz2FZ9mEcCf1
         D14w==
X-Gm-Message-State: AOUpUlHb6HPYALKbwC3VVwlH0q25oB7io0YQvz/PD1WyJlq0cXijqcac
        c5A8aOvi5xVolG81kO9N+g==
X-Google-Smtp-Source: AAOMgpeBzgoeJ9Eg85fkkZWrUy3VPEDhhpr/gSanB6uCjrZ337Zl+n+tEvcxr53Q4H8GpMeHTXgLRg==
X-Received: by 2002:a24:7853:: with SMTP id p80-v6mr815081itc.133.1533064838055;
        Tue, 31 Jul 2018 12:20:38 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id i3-v6sm1786918iti.40.2018.07.31.12.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:20:37 -0700 (PDT)
Date:   Tue, 31 Jul 2018 13:20:36 -0600
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
Subject: Re: [PATCH v6 2/5] dt-bindings: thermal: qcom-spmi-temp-alarm:
 Improve thermal zone in example
Message-ID: <20180731192036.GA3770@rob-hp-laptop>
References: <20180731185917.176074-1-mka@chromium.org>
 <20180731185917.176074-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180731185917.176074-2-mka@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:59:14AM -0700, Matthias Kaehlcke wrote:
> The current example for a thermal zone isn't very useful as reference
> since it would result in a hardware shutdown at 145°C, instead of
> allowing the system to try to shutdown gracefully. Without an ADC
> channel a maximum of two trip points is useful in practice for this
> sensor, with temperatures corresponding to the stage 1 and stage 2
> 'hardware trip points'. A critical trip point at stage 2 may allow the
> system to shutdown before a hardware shutdown at stage 3 kicks in. It
> should be noted though that by default the chip performs a 'partial
> shutdown' when the temperature reaches stage 2, which may prevent an
> orderly shutdown. The 'partial shutdown' can be disabled by software.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v6:
> - patch added to the series
> ---
>  .../bindings/thermal/qcom-spmi-temp-alarm.txt         | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
