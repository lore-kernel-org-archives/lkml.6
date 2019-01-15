Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14C120659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWyq1JM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfAOAtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:49:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44388 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfAOAtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:49:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so407787pgr.11;
        Mon, 14 Jan 2019 16:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lITpQhkTAY4H8va6tCtjzZuKDnZlHTf+x600mZr05Fk=;
        b=hWyq1JM5pMk8K35n6avi89coxbX56u4mA0qdIRr622Nldq/3srD4e2gU5lwyQcXW49
         +pN1UPd84SXX+Iteg/D02T0K5JhHcpmONTqp8OVWAGgh1YTBnS/lAsldStwB0wP+qH75
         M7PZCdcgJn2OCGVE1c+mTAfsBw5D+IAU6ru0taEgyWq/lNI5NSdHGMp24Z4cqaWAo79/
         Y6CXIMy7OVhkCCiCWcv/AjDKD3n3osO01xK3q/SDM9Tk0revVeVFyYq/l4iCy6LbzpTJ
         /kal1smUMXcZaQKVXcSU6u2YiLy4zTeG6snk8uF9OTqEwKOGT2bhjLyIEZ+jO4GZCKoq
         taKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lITpQhkTAY4H8va6tCtjzZuKDnZlHTf+x600mZr05Fk=;
        b=n8msEEndS/L56cltn2WrZfFyAAQnTwbZtZAokIRoTpPrMPOFdjTTAR/q2r4NMVbyyH
         8KwGQap0t8ffpkpNIjS4FdLWmHv1d1hVPqfjdryGcqItTW5zz4G5u5JKqd+WKbv3u9AJ
         /3bVhxidmyv5pm0i7zFYPK938APQ73SptFHzn1kX+EVm8EmH6ZgXLoj6/TN61tu1NRKt
         JD9gL7XzHiRK21Cn8Ny0ogXvy7k9e1NBD4gCfdLRwsBlBzoF24YkqQcTMmZqDgfMwjZm
         ur1l8GbNnbUP1jTlZveeGadktUYsaDJGxTedeRA/vgvI3o/WsDZrSfcpbSR+pc/Jz0nW
         v7XQ==
X-Gm-Message-State: AJcUukeW2/DCv+EgQJmYbRsUubdtCqYBHFgw84dICaHtqEKHynBibZjL
        UaOtqj4t4OiUEGR9RWTvr18=
X-Google-Smtp-Source: ALg8bN4LYhSguketyR/AVx0LhA3vwopaTUiH4oHLIJtlxOZGM35hs7L9A6wJrIgCA9vyTH8fOdGZGg==
X-Received: by 2002:a62:7892:: with SMTP id t140mr1171851pfc.237.1547513340178;
        Mon, 14 Jan 2019 16:49:00 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n70sm2253164pfi.185.2019.01.14.16.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:48:59 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:48:56 -0800
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
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
Message-ID: <20190115004856.GL117329@dtor-ws>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
 <20181214124701.GZ4497@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214124701.GZ4497@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:47:01PM +0000, Lee Jones wrote:
> On Fri, 30 Nov 2018, Pascal PAILLET-LME wrote:
> 
> > The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from 
> > STMicroelectronics. 
> > The STPMIC1 regulators supply power to an application processor as well as 
> > to external system peripherals such as DDR, Flash memories and system
> > devices. It also features onkey button input and an hardware watchdog.
> > The STPMIC1 is controlled via I2C. 
> > 
> > Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
> > irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
> > as parent.
> > 
> > STPMIC1 MFD and regulator drivers maybe mandatory at boot time.
> > 
> > Pascal Paillet (7):
> > changes in v7:
> > * rebase on regul/for-next
> > 
> >   dt-bindings: mfd: document stpmic1
> >   mfd: stpmic1: add stpmic1 driver
> >   dt-bindings: input: document stpmic1 pmic onkey
> >   input: stpmic1: add stpmic1 onkey driver
> >   dt-bindings: watchdog: document stpmic1 pmic watchdog
> >   watchdog: stpmic1: add stpmic1 watchdog driver
> >   regulator: stpmic1: fix regulator_lock usage
> 
> Could you please remove any patches which have been applied and
> [RESEND]?
> 
> Also, is Dmitry planning on Acking:
> 
>   dt-bindings: input: document stpmic1 pmic onkey
> 
> ... or is Rob's Ack enough?

For bindings I normally defer to Rob (unless I see something that really
bugs me and then I'll speak up).

Thanks.

-- 
Dmitry
