Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5036C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847B9214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBtj+CkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847B9214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbeKVGQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:16:37 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:44474 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeKVGQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:16:36 -0500
Received: by mail-pl1-f174.google.com with SMTP id s5-v6so6894616plq.11;
        Wed, 21 Nov 2018 11:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=huH2jO3JEZYNKogN8ZL+zwNX1hoHtaAVwp+bkQjnWPg=;
        b=nBtj+CkI6c7ARmSZ0MuSt6ZlMo2GKfFkH43PmSF+OGNeR02RUGQVpdg0lx54d5H/cp
         tpSX+woqjyG4ClpPXUP8GSLMw+DG8SlH5G84nH/nstsR8ZyX+heIK7LTC/q2IutUe9hI
         3yAFMsjgAygJzPNuV2Ly/+sLdcRbTfNo2UXhHOOQqCaLOXOTqtNXaeP/UVBON4A/JhFJ
         juKL4BZdwbiDXprLyhFPmoEC3Xl9gr7jMB8waDekISFfcxTa3Ze3rZYaPt177SSQTcRt
         /mlxyQX1/7G9c/1zb9/7GNxKTr8BZ9cBx5IP6ske4l1f2IJ5AD8adFSmPpTjFAnam0wT
         uA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=huH2jO3JEZYNKogN8ZL+zwNX1hoHtaAVwp+bkQjnWPg=;
        b=Q64tRLKus8CFQTk1t4xsiT0yWshpWzD8kPWWznVuPDITfh1qdoasbQ32rryg7C0jOA
         CgQzC20vHMpzvHpGnKh8ByQxhdOPaKqk/3UgVfuumNZ0asumvHw8UdMTSfqUlxZU9yEu
         gTkR/IDV7NMYHFHm38ZuK022xTsjNyzwsl/W/9bl+Grp+zOX1X+7JAQBR351FUWhUxbE
         HNJk8zoiC4VBdZojhB1plOaerSrCMkwje+6zqcSrFoErxjKuLDQr4WgshYUVnLqOpmMz
         3ZShurzPuAAJW0ve++i3k4vWltszlNN6rW8vXWXaeWgfk58jXCV32eQ7dI4MV8eUMIFB
         yISw==
X-Gm-Message-State: AA+aEWYgSjzeW+hwDQT7meiSTKKtRiQnbue5GXuab1kilRDLoMWWvARa
        cefS2L8nb6UYI7/meo4CFkg=
X-Google-Smtp-Source: AFSGD/VRsTj+fEXmnmlUZzKq03X8YbZ6nBxT4UjFwdXblMA1qpSOFf0VxhbflnoY+x/mdBBwVBnV3g==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr8373627plf.202.1542829256856;
        Wed, 21 Nov 2018 11:40:56 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c14-v6sm53928464pfc.92.2018.11.21.11.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 11:40:56 -0800 (PST)
Date:   Wed, 21 Nov 2018 11:40:52 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     =?iso-8859-1?B?QnL8bnMs?= Stefan <Stefan.Bruens@rwth-aachen.de>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC][PATCH] hwmon: (ina2xx) Improve current and power reading
 precision
Message-ID: <20181121194051.GA8902@Asurada-Nvidia.nvidia.com>
References: <20181121012629.5432-1-nicoleotsuka@gmail.com>
 <2863036.QIPGp1Eqjm@sbruens-linux.lcs.intern>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2863036.QIPGp1Eqjm@sbruens-linux.lcs.intern>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Removing "m.purski@samsung.com" since it's not reachable any more)

Hi Stefan,

Thank you for the comments.

On Wed, Nov 21, 2018 at 04:13:01PM +0000, Brüns, Stefan wrote:
> > === Problem ===
> > Both methods simplify software routine by fixing one factor, which
> > sacrifices the precision of the hardware measurement results.
> > 
> > Using ina226 for example, with method A, the current scale was 1mA
> > and the power scale was 25mA.
> > 
> > With method B, calibration value is fixed at 2048 so the precision
> > is decided by shunt resistor value. It sounds reasonable since the
> > hardware engineers can use a larger shunt resistor when they need
> > higher resolution. However, they often concern power burning across
> > the resistor as well, so the resistor usually won't be so large: a
> > typical value 1000 micro-ohms, which results in a current scale at
> > 2.5 mA and a power sacle at 62.5 mW.
> 
> Power loss surely is a concern, but figures should be kept reasonable.
> 
> 1. You mention 1.8V bus voltage, and currents in the 30mA range. Using the 
> 1mOhm current shunt:
> 
> U_S = R_S * I_S 1e-3 Ohm * 30e-3 A = 30e-6 V  (30uV)
> P_S = U_S * I_S = 30e-6V * 30e-3 A = 900e-9W = 0.9 uW
> 
> INA219 Power Supply (Datasheet)
> Min operating Voltage: 3V
> Quiescent Current: 0.7mA
> -> Min power: 2.1mW
> 
> So the INA219 alone uses 2.1mW, 1000 times more than the shunt.

Chip can enter power-down or one-shot mode. Though this upstream
driver doesn't have these two mode supports yet, I am working on
it so they'll be added.

> Another concern may be voltage drop over the shunt, but for this case you have 
> a nominal voltage of 1.8V, so 30uV are 0.001%.
>  
> > When measuring a 1.8v voltage running a small current (e.g. 33 mA),
> > the power value (that's supposed to be 59.4 mW) becomes inaccurate
> > due to the larger scale (25mA for method A; 62.5 mA for method B).

Just found out that I have typos here: 25mW and 62.5mW.

> Another look into the datasheet reveals, even at full gain (PGA=1), the LSB is
> 40mV / 2^12 = 40mV / 4096 ~ 10uV. So when the current ADC reads out as 3*LSB, 
> this anything between 25mA and 35mA. This is the best case figure.

Current read doesn't get affected a lot actually, since hwmon ABI
also reports current value in unit mA. However, the power read is
the matter here. With a 62.5mW power_lsb, power results are kinda
useless on my system.

> On top of quantisation error, you have the ADC offset voltage (V_OS), which is 
> given as (for PGA=1, best case): (+-) 10uV typical, (+-) 100uV max.
>
> So, if you want to have meaningful readouts adjust your shunt to a reasonable 
> value. Even 100 times the current value will have no measurable effect on you 
> system (power loss: 90uW, voltage drop: 3mV).

I understand your last point. But I believe that'd be a separate
idea to improve precision but not an alternative one from driver
aspect. Yes, I agree using a larger shunt resistor is always one
way to get precision, but it doesn't give an excuse for software
driver to be less optimized.

The truth is that calibration value is set to the minimum value,
giving the best range of current measurement meanwhile the worst
precision. You can argue that our hardware engineers might have
been too conservative by putting a not-big-enough resistor. But
they may also argue that software driver doesn't optimize while
the register is totally configurable. I believe both sides have
their own reasons.

But apparently configuring in software is fairly less expensive.
And it doesn't sound convincing to me by telling them "hey guys,
go to change your hardware design because we will not set that
register": We have more than thousands of products in the market
(all battery powered so being conservative), so not possible to
recall all of them back just to place larger shunt resistors.

From my point of view, there's nothing wrong for hardware folks
being conservative to put a smaller resistor since the software
has the capability to improve precision with a single I2C write.

A separate topic, I actually thought about setting the default
calibration value using a number somewhere in the middle of the
best range and the best precision. But it looks that I am right
to keep the default to minimum value so that no existing users
will be affected.

So my patch merely gives an opportunity for those conservative
designers to fine-tune the software for a better precision. It
is necessary since there are such designers/users and products.
And it isn't supposed to affect existing users.

Thank you
Nicolin
