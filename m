Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F1BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D1620663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 05:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KoSAFT/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfANF7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 00:59:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37723 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANF73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 00:59:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so9636489plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 21:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x57sZbEDsjykW3GtFlbtNUa1V9Tvbn3B88MgJuNaAEY=;
        b=KoSAFT/Y7ba4AofX4bQd8LplcDm6kUAVHFo8eGtq6HlVOtX1pB5pb1CR28s1zE3KtW
         dxQCiufIpwhOU8faVj58fbyH9QFC5yk4hFCRKqAXDzxtUbghJC2EZrwYNDigPijs7jOz
         3iKjYInv70v/jZLATycFbVKpp9ewFj+KqjDXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x57sZbEDsjykW3GtFlbtNUa1V9Tvbn3B88MgJuNaAEY=;
        b=OivCgG+x+kIHhht9IOZQQqoZXosGJZJp5A0WsCLfXzne6fk2PsMFfYE6DGVy6S7lv2
         Z2090w0SPtTzbP9kEu4+y27damQwDoB7SBciHSLYywVv7PMWQhWHLR4OYgKT048ra8To
         KHFIsAijp6v8STv4WpNjNziRmwLfVer8Pp8Tdu5ZvjjDusrf6hep/wpjk59KRLUoE+hi
         NCDL5ckD4tsJDK2i/WScFiAkhzlppFFTU27SoVcm+Kt65Scd+20uMU1aMkhhy/N9Nvuf
         FGpYBl+cqoA/TmLJs5dxW1+N/EKZs1VVTxNSCUgitp5XwYp8tHdnArRTjbTnstQZWH9Q
         qdHg==
X-Gm-Message-State: AJcUukcfBnPOPDpTk1w0rI+ImJ+c/85IRdB3wHLKfc/5GmAclNfcYI8V
        rpD5EI+Evs6iT2hkV9ZBPTl0HQ==
X-Google-Smtp-Source: ALg8bN58JtKAgjjMtDqgUc91A20TL1whs57S9IDdTE66wXz+0bD5Y00YmaCGmR9MSNHUU8p6GE7nNw==
X-Received: by 2002:a17:902:765:: with SMTP id 92mr24154083pli.242.1547445567903;
        Sun, 13 Jan 2019 21:59:27 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id n7sm140407940pff.36.2019.01.13.21.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 21:59:27 -0800 (PST)
Date:   Mon, 14 Jan 2019 11:29:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, daniel.lezcano@linaro.org
Subject: Re: [PATCH v1 7/7] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190114055924.kbjanbnhbnnbunx3@vireshk-i7>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
 <20190110022217.GX261387@google.com>
 <20190110062359.aea3tic5aw3iuocr@vireshk-i7>
 <20190110184241.GY261387@google.com>
 <20190111034653.6dstox4c6hpjum4f@vireshk-i7>
 <20190111195813.GF261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111195813.GF261387@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-01-19, 11:58, Matthias Kaehlcke wrote:
> On Fri, Jan 11, 2019 at 09:16:53AM +0530, Viresh Kumar wrote:
> Just to gain a better understanding: is cpuidle cooling already
> available for arm64 (or is there a patch set)? I came across the
> relatively new idle injecting framework but it seems currently the
> only user is the Intel powerclamp driver.

Daniel was trying to upstream it earlier:

lore.kernel.org/lkml/1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org

> > > even though only one will be active at any given
> > > time. However I wonder if we could change this:
> > 
> > I won't say it that way. I see it as all the CPUs are active during a
> > cooling state, i.e. they are all participating.
> 
> agreed, I was referring to the CPU cooling device, which (without
> cpuidle injection) could be considered a single device per freq domain.

Even without cpuidle injection all CPUs actually take part in cooling.

> > > For device tree based platform the above implies that cooling maps
> > > must include a list of all possible cooling devices of a frequency
> > > domain, even though only one of them will exist at any given time.
> > > 
> > > For example:
> > > 
> > > cooling-maps {
> > > 	map0 {
> > > 		trip = <&cpu_alert0>;
> > > 		cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
> > > 				 <&CPU1 THERMAL_NO_LIMIT 4>,
> > > 				 <&CPU2 THERMAL_NO_LIMIT 4>,
> > > 				 <&CPU3 THERMAL_NO_LIMIT 4>;
> > > 	};
> > > 	map1 {
> > > 		trip = <&cpu_crit0>;
> > > 		cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > 				 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > 				 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > 				 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > 
> > This is the right thing to do hardware description wise, no matter
> > what the kernel does.
> 
> Not sure I would call it a hardware description. I'd say we pretend
> the thermal configuration is a hardware description so the DT folks
> don't yell at us ;-) IMO a CPU cooling device is an abstraction, I
> think there is no such IP block on most systems.

Right.

> It seems with cpuidle injection CPUs can perform cooling actions
> individually, with that I agree that representing them as individual
> cooling devices in the DT makes sense. Without that a cooling device
> per freq domain would seem a resonable abstraction.

But we actually have 4 different cooling devices no matter what. The only thing
is that they switch their cooling state together. And that shouldn't bother DT
is what I thought :)

> One of the reasons I dislike the above list of cooling devices is that
> it is repeated for different thermal-zone/cooling-maps, but I guess
> we have to live with that, would be nice if the DT would allow to do
> something like this:
> 
> thermal-zones {
> 	cooling_maps_fd0 : cooling-maps {
> 		map0 {
> 			trip = <&cpu_alert0>;
> 			cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
> 					 <&CPU1 THERMAL_NO_LIMIT 4>,
> 					 <&CPU2 THERMAL_NO_LIMIT 4>,
> 					 <&CPU3 THERMAL_NO_LIMIT 4>;
> 		};
> 		map1 {
> 			trip = <&cpu_crit0>;
> 			cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> 					 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> 					 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> 					 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 	};
> 
> 	cpu0-thermal {
> 		...
> 		cooling-maps = @cooling_maps_fd0;
> 		...
> 	};
> 
> 	cpu1-thermal {
> 		...
> 		cooling-maps = @cooling_maps_fd0;
> 		...
> 	};
> 
> 	...
> };

Yeah, maybe. There aren't lot of examples of such duplication though if I
remember correctly.

-- 
viresh
