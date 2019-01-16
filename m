Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01CDC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEF420859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAe4AuZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbfAPIOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:14:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35521 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733232AbfAPIOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:14:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so980697wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 00:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pHG+BUOwpa9VHZNedTQ9afqjkM8N+M5cVumSRF2uNwA=;
        b=UAe4AuZ6CV2oi7R63WMD/lkiJ1rkY/pvZMNkl26QN4eqyfwmO/T7wuT/+C8q8PDIYA
         q7tEffu9ehGWmflkX24nvZJWQuhB6nsjgbsQJLUiU2ID0i0/Id4Z1a2TIQq87mCe8KG6
         I6f+zBRV1HwTs+xFWKP5fKcVnXV2HGacWvpGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pHG+BUOwpa9VHZNedTQ9afqjkM8N+M5cVumSRF2uNwA=;
        b=ncW+KBDMc6tgsQQ60MrCaH/tS29Sf6JotkCGEmBgZrgv/faIx8lpJ/R1vdkv0eyjKC
         AK+lf2DgnFZwcLjPgz6hRQsoOzXrpYFSEG6eDDhxp/nvfyV6F7VLAXhQEZaxCJXhG3RZ
         JESHjNf5TpEKXPNveEvrhmCAjub2lHuyeiKXhVxvUbZCggj5FdgDYKQoNbPrafeu0/7t
         q1awwnce6kObAoiVYyuLXEXxBwjAh65prf8OCBnGHbqeORmP0M5U4S5b3YrhBK2R5TFi
         dBkaKQ9z35Ju4T+ILqdfSjmW55UDeUGVQuf2z3NybDiVF8yFb93YaETqKchaFzWnQd4R
         Uhmg==
X-Gm-Message-State: AJcUukcmbSikl9U5zpwa13hrq0+WqweHx4m87IDk6HG11vPq6q48vxrb
        ukGouYv40b75Hbxpu/Nww3eObQ==
X-Google-Smtp-Source: ALg8bN57izQtVwJrEtN1dejN8muWFcjllCxTKKOVt+A6vVTBk05ig1yKWbb0Dpy1bpbkRiRVW5kwMw==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr6675914wmd.36.1547626439866;
        Wed, 16 Jan 2019 00:13:59 -0800 (PST)
Received: from dell ([2.27.35.149])
        by smtp.gmail.com with ESMTPSA id x81sm35165380wmg.17.2019.01.16.00.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 00:13:58 -0800 (PST)
Date:   Wed, 16 Jan 2019 08:13:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc:     Pascal PAILLET-LME <p.paillet@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Message-ID: <20190116081356.GA23399@dell>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
 <20181214124701.GZ4497@dell>
 <20190115004856.GL117329@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190115004856.GL117329@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019, dmitry.torokhov@gmail.com wrote:

> On Fri, Dec 14, 2018 at 12:47:01PM +0000, Lee Jones wrote:
> > On Fri, 30 Nov 2018, Pascal PAILLET-LME wrote:
> > 
> > > The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from 
> > > STMicroelectronics. 
> > > The STPMIC1 regulators supply power to an application processor as well as 
> > > to external system peripherals such as DDR, Flash memories and system
> > > devices. It also features onkey button input and an hardware watchdog.
> > > The STPMIC1 is controlled via I2C. 
> > > 
> > > Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
> > > irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
> > > as parent.
> > > 
> > > STPMIC1 MFD and regulator drivers maybe mandatory at boot time.
> > > 
> > > Pascal Paillet (7):
> > > changes in v7:
> > > * rebase on regul/for-next
> > > 
> > >   dt-bindings: mfd: document stpmic1
> > >   mfd: stpmic1: add stpmic1 driver
> > >   dt-bindings: input: document stpmic1 pmic onkey
> > >   input: stpmic1: add stpmic1 onkey driver
> > >   dt-bindings: watchdog: document stpmic1 pmic watchdog
> > >   watchdog: stpmic1: add stpmic1 watchdog driver
> > >   regulator: stpmic1: fix regulator_lock usage
> > 
> > Could you please remove any patches which have been applied and
> > [RESEND]?
> > 
> > Also, is Dmitry planning on Acking:
> > 
> >   dt-bindings: input: document stpmic1 pmic onkey
> > 
> > ... or is Rob's Ack enough?
> 
> For bindings I normally defer to Rob (unless I see something that really
> bugs me and then I'll speak up).

I usually do the opposite.  Seeing as Rob is pretty heavily laden with
DT patches, I tend to review/apply patches which do not add new DT
properties and/or are obvious/trivial and leave Rob to the rest.

Your train-set though of course, your decision.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
