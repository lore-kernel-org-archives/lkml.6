Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAB820856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546033739;
	bh=HFMaKroDzHtipIHAZDno4GUadc1hp4rR+dpnwd3/iSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nq230xDsDPjf4kib20ebmJXFe4wchTTt/DOWflWP7rkPSQy/OZWOQdVZ18zhDwhBo
	 xgZgXOWtOgGNSzrMyfUI48L0ZPbZGUuGAHzLumDmocmAMH3RUkoXI5DMA+52ZSQFx7
	 HYTpKGavznICg/rdsX3F9Xyo88/dqLsz6kP79594=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeL1Vs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:48:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46839 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeL1Vs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:48:57 -0500
Received: by mail-io1-f65.google.com with SMTP id v10so17639484ios.13;
        Fri, 28 Dec 2018 13:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pgp8QGM8Sxxy+ekOkA+knxIXmgF85vwv+RMpA4VSbk8=;
        b=lAWfndzZAMnCjngEkD+CYOj+aq8t05yWQfWRZosGqPSC12qfTFpRAKpMSd6gf3TkV6
         IL25p+pRj2n++KIGdwJTc9+EypgTMJG3llJCiOjHUnfjH0x0XQhwisTC1be7hj4Qv65W
         AQK3fJ84WdfcHi16RktPzKRrQAW6W9loM1+954d0GTXRgptdf535yYHtzFphVbn+9mtk
         /Q2e01DzgEcgPgRbamGmig9oPxuzmqmjTT8/8WXgAX1Do5cfotxv+E3oyzHZBBcwBd+o
         xxgc+ct6DoLDq0A1rAr7c8TuCSpFWTK21xakt4cwx0vuxMuJeQlVcIloRzVoQfXKj+Fs
         AbbQ==
X-Gm-Message-State: AJcUukdjTKdDG8gMQDC2OfNnLjGcDrfV2BmlkKOF7UU0m9gh9kCdIJGs
        kU7dfUrxbPwScQvLW38yxLyp0kU=
X-Google-Smtp-Source: ALg8bN6aDTD1I7/EbuShlAij+H9/MbsXHjlDPik1xXo1Fd8ylo7K27yHtXd/qIvMn/YaGE7V6iXytg==
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr19828025ior.169.1546033735971;
        Fri, 28 Dec 2018 13:48:55 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id m10sm4218931ioq.25.2018.12.28.13.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 13:48:55 -0800 (PST)
Date:   Fri, 28 Dec 2018 15:48:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v9 03/27] dt-bindings: Add doc for the Ingenic TCU drivers
Message-ID: <20181228214853.GA8568@bogus>
References: <20181227181319.31095-1-paul@crapouillou.net>
 <20181227181319.31095-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227181319.31095-4-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2018 19:12:55 +0100, Paul Cercueil wrote:
> Add documentation about how to properly use the Ingenic TCU
> (Timer/Counter Unit) drivers from devicetree.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>      v4: New patch in this series. Corresponds to V2 patches 3-4-5 with
>          added content.
>     
>      v5: - Edited PWM/watchdog DT bindings documentation to point to the new
>            document.
>          - Moved main document to
>            Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>          - Updated documentation to reflect the new devicetree bindings.
>     
>      v6: - Removed PWM/watchdog documentation files as asked by upstream
>          - Removed doc about properties that should be implicit
>          - Removed doc about ingenic,timer-channel /
>            ingenic,clocksource-channel as they are gone
>          - Fix WDT clock name in the binding doc
>          - Fix lengths of register areas in watchdog/pwm nodes
>     
>      v7: No change
> 
>      v8: - Fix address of the PWM node
>          - Added doc about system timer and clocksource children nodes
> 
>      v9: - Remove doc about system timer and clocksource children
>            nodes...
> 	 - Add doc about ingenic,pwm-channels-mask property
> 
>  .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  25 ----
>  .../devicetree/bindings/timer/ingenic,tcu.txt      | 139 +++++++++++++++++++++
>  .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 ---
>  3 files changed, 139 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
