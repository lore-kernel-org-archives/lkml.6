Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006D12147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EciKZRru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440238AbfBNVe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:34:58 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35793 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436452AbfBNVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:34:58 -0500
Received: by mail-yw1-f66.google.com with SMTP id s204so2934129ywg.2;
        Thu, 14 Feb 2019 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cufxpBUZ2PFDaKJUbe1LoYEcfgdJ6Va1j/2T3vLPI/c=;
        b=EciKZRruenGVLzCQQyf4hCrPesod4TxS48xVqCO/OQd3A8ADKzOPJEdxlznJ38XS5I
         Cy/VyOkpuo9Lf3hE68Hm3R2UuxR/knaYuG7AxzShCgZkIAqBHtyyYlwt3f1CdJfnk1H+
         LhhkJZeF48I3GH2RrO+YMEc2sx0siT1icQ3BtWAd5XpbPksgxGOfqUWCPZ3Jrd5PRz19
         xUpQozn5E6PmA7vzbXPaljg3a5snDlOQQPtfNd4K5ceUJzrM1dxFS8A0GQNoR5+VmqgD
         FLSbi/BuQ/lnjynHsSCVTzkl4eDDXrC30rNFarFFlSpNN9qnl4yDI8x3pZsYiM2JzNWV
         9hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cufxpBUZ2PFDaKJUbe1LoYEcfgdJ6Va1j/2T3vLPI/c=;
        b=SZfY+u4eAGc63vKD1gcWS7bIPA9VYxv18hRbTOxcc3uJLWuKadAi+2g2+0mnqIbLA4
         n78w4atFOBuIvFF+A+QG+c+sXi1gu/XBakRS4NjdCJZZPU3FgDszNYRn3LRY4DKsDaBa
         gp8FUJRltkFkq+Vj1uxxo2dWC5XMdiSXPOJT6C3wDG9x/ylXaOdAFXcWWYObZo2XbsLt
         3fXHbAsCGW/S/4T48tNWzumDmS9DbLiEcpABy7Aaj9kA+p96hdVCtApsf6MLGiWG09vC
         pjomPXDRQ5DnjO8RgG4zuTuRr7ZhFBHXO4q5ZjRsC4jjUyNv1Nbsoz/dggD+NzY9mYiQ
         dgZg==
X-Gm-Message-State: AHQUAuZeBz+V2g65G9yoJm8fBjnTV1R6SpROVpJVw/ekGFcdtAH+nUgM
        LbRWbD4jNepcYLYAsOO53fc=
X-Google-Smtp-Source: AHgI3IZ8spadDeRFJeGlCSc/QpynJskJQD0mUFDfAyhUxs4qlDWu0catWJoH37jUP6sGj+OpvSk3ng==
X-Received: by 2002:a81:5c89:: with SMTP id q131mr4982047ywb.90.1550180096879;
        Thu, 14 Feb 2019 13:34:56 -0800 (PST)
Received: from localhost.localdomain ([46.216.144.99])
        by smtp.gmail.com with ESMTPSA id r20sm1369083ywa.13.2019.02.14.13.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 13:34:55 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1guOej-0000i2-EY; Fri, 15 Feb 2019 00:34:53 +0300
Date:   Fri, 15 Feb 2019 00:34:53 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190214213453.GA30250@jeknote.loshitsa1.net>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
 <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Feb 14, 2019 at 10:57:13AM +0100, Hans de Goede wrote:
 
> > Anyway, in such case I'd propose having rmmod/reboot/poweroff hook
> > that just sets it to breathing. No need to expose it to userspace.
> 
> That assumes that breathing is the default setting on all hardware
> and again I don't see why not to export this functionality to
> userspace. Just because something does not fit in the existing
> API is IMHO not a good reason to not expose it to userspace.
> 
> I suggest that we deal with this special case by adding 3 custom
> sysfs attributes:
> 
> 1) "mode" which when read, prints, e.g. :
> manual [on-when-charging]
> 
> With the [] indicating the current mode, and writes accepting
> all 3 values and updating the hw accordingly.
> 
> This format is used in more places in the kernel and allows
> for the user to easily discover the possible values.
> 
> 2) "pattern" which when read, prints, e.g. :
> on blinking [breathing]

Leds class API already has pattern_set()/pattern_get() callbacks
which can be used for breathing mode set/request. How this API should
deal with specific 'breathing' sysfs attribute? I like the idea about
specific 'pattern' attribute because this is very simple, anyway. 

Second issue: the 'pattern' led trigger supports default pattern initialization
by device properties only, not by hardware request. Setting breathing
parameters via 'pattern' led trigger may looks too complicated for
users, given that only one hw-supported option exists. Pattern
corresponded to hw-supported breating should contain too many
(brightness, duration) tuples with minimal stepping and has no
practical sense.


If hw-controlled 'breathing' mode is quite common case for leds
controllers, maybe it makes sense to introduce something like
'lighting mode' attribute with values 'continuous'/'breathing' without
clarification of breathing parameters? What do you think about this?

The same question about frequency of breathing setting. Blinking
frequency can be set with existing API, but not a breathing frequency.

> 
> 3) "frequency", when read prints, e.g. :
> 0.25hz [0.5hz] 1hz 2hz
> Note this controls both the blinking and breathing freq.
> 
> Note I've not listed off anywhere, this can be achieved by
> setting the brightness to 0 as we do with normal leds.
> 
> For interactions with other APIs we can do the standard
> thing where writing 0 to brightness resets things, in this
> case this would reset mode to manual and pattern to on.
> 
> And if the blinking API gets used, then too the mode should
> be switched to manual, and the pattern obviously becomes
> blinking.
> 
> I believe this will work well with this hardware and
> nicely allow the user to control all settings.
> 
> Regards,
> 
> Hans

-- 
Yauhen Kharuzhy
