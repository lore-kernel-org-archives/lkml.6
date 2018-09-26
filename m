Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988D1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE94214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgxn6NEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE94214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeI0EKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:10:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35745 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeI0EKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:10:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so327121pgb.2;
        Wed, 26 Sep 2018 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FwxrjihwDso9VTGq02igHbAg21oKtx7KVkNeYEoewUk=;
        b=Tgxn6NEt9Fpuw5vTQgcLylBG4En0bWt2y8ZDGYoYM2jhXjm3gG3aMuFdtlQuhR8jzB
         DaRBE5KfIuQp0xSSMYJLKGfLRbygCEY6p1V0c1cpuCqgoGmovUovlFe+prCnM0X6BPNB
         +PVXHyYBB2k3LPjV2RW2T7g5bzSgT+naQJZez+QcplItDMasZx2jUL6tsFwUB+5AhN7F
         ib2G2stinAKo5n68lzaufKcoqkSywWMmSevK+IvqOvznWH3Zp/zU7DE+EJkPaaGb4vzd
         VeQEwd8/tgzpM6XDhaJPkeQP2E4UX41oDcn/v6RfcUYadWg5xuGDfxgPR7pOOcoSSxef
         27fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FwxrjihwDso9VTGq02igHbAg21oKtx7KVkNeYEoewUk=;
        b=SEur1ZiJ4IaIIk37nXkMH35U1OBNBFC04NgtOXsgcIoZztF/v4IJA1S+kZ7kfO4w4m
         /63Yru0MHnRMtA0UHE9NAZtd/2NcSLMFSpb5vTBVtfKtfXHJh4SOMGpVl+jAAvAqHzpM
         GvwG3EwgUIz/1EnMe5VbQEi43VoZXTN2lYoOaurBrYqE+U+z23MWvAq/eWzYJsNIUKWB
         y4lVLXluF9+7xYFP7+iiUSdkXJY5aDmUQ2MoHConBAvnRzUODcb2iFiJOvzTtq1NXJS3
         1envi7yhoWE/SoZuK1yCMI2vCxzM+Vcfth5fPBugW5QQnHw5a6YeZppicw7wtzgTs1VJ
         XKOg==
X-Gm-Message-State: ABuFfoj4heMAPnPEBTIoSgbFc5vNt78kaTHh+dInLlDQMrw2z6ZCKDJq
        vki0o96ak+nnUB/LRDHYNk0=
X-Google-Smtp-Source: ACcGV63JVErd/aCdESeZROTmKoExXUsd0GpGQ8tqrqIiZFrQ2BR8fvit7b7Ranx9TXMrY6c5X3oD/w==
X-Received: by 2002:a63:8a41:: with SMTP id y62-v6mr7333854pgd.420.1537998909173;
        Wed, 26 Sep 2018 14:55:09 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 203-v6sm121856pgb.14.2018.09.26.14.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:55:09 -0700 (PDT)
Date:   Wed, 26 Sep 2018 14:55:06 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add enable sysfs nodes
Message-ID: <20180926215504.GC10595@Asurada-Nvidia.nvidia.com>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-3-nicoleotsuka@gmail.com>
 <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
 <20180926180243.GA6329@Asurada-Nvidia.nvidia.com>
 <20180926195817.GA19695@roeck-us.net>
 <20180926202519.GB10595@Asurada-Nvidia.nvidia.com>
 <20180926204455.GA17035@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926204455.GA17035@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:44:55PM -0700, Guenter Roeck wrote:
> On Wed, Sep 26, 2018 at 01:25:20PM -0700, Nicolin Chen wrote:
> > Hello,
> > 
> > On Wed, Sep 26, 2018 at 12:58:17PM -0700, Guenter Roeck wrote:
> > > On Wed, Sep 26, 2018 at 11:02:44AM -0700, Nicolin Chen wrote:
> > > > On Wed, Sep 26, 2018 at 06:06:32AM -0700, Guenter Roeck wrote:
> > > > > On 09/25/2018 11:42 PM, Nicolin Chen wrote:
> > > > > > The inX_enable interface allows user space to enable or disable
> > > > > > the corresponding channel. Meanwhile, according to hwmon ABI, a
> > > > > > disabled channel/sensor should return -ENODATA as a read result.
> > > > > > 
> > > > > > However, there're configurable nodes sharing the same __show()
> > > > > > functions. So this change also adds to check if the attribute is
> > > > > > read-only to make sure it's not reading a configuration but the
> > > > > > sensor data.
> > > >  
> > > > > One necessary high level change I don't see below: With this change,
> > > > > we should no longer drop a channel entirely if it is disabled from
> > > > > devicetree. All channels should be visible but report -ENODATA if
> > > > > disabled. In other words, it should be possible for the 'enable' flag
> > > > > to override settings in DT.
> > > > 
> > > > Hmm...I don't feel so convinced here. The status in DT binding isn't
> > > > exactly a setting but a physical status: if a hardware design leaves
> > > > a channel to be disconnected, I don't really see a point in enabling
> > > > it in the runtime. Or maybe you can shed some light on it?
> > > > 
> > > 
> > > You are making an assumption from your use case. It might as well be that
> > > some or all channels are disabled in DT by default to conserve power,
> > > not because they are disconnected.
> > 
> > I think I probably should update my DT binding somehow to say it
> > explicitly that the property should be only used in cases of the
> > physical disconnections, although I feel the current binding "no
> > input source" already has the same meaning.
> > 
> > In my opinion, disabling channels in DT to save power isn't very
> > plausible, because it sounds more likely a user decision, while,
> > as we know, DT merely describes the hardware design.
> > 
> 
> I try to avoid making such assumptions. All I know is that I'll have
> to deal with the fallout if a single person wants to use the property
> differently.

I can understand your point (or pain lol). But I believe in such
a case, DT maintainers should reject such a DT change. Let's say
if this kinda "default setting" in DT is allowable, other things
such as having a default mode setting between polling or one-shot
modes, and as default critical current settings would be able to
put into DT. But we know that these would be rejected as a reason
of "not being hardware design but a user decision".

> This is similar to disabling an entire subsystem in DT
> because it isn't used in a specific system - say, a SPI or I2C bus
> which has nothing connected on some shipping hardware, even though
> the board has a connector for it. Your argument is that one shall
> not use the status property do disable loading the driver, and that
> one must not remove a set of properties for unused hardware either.
> That doesn't sound very realistic to me.

SPI/I2C is a good example comparing to my case. And you do make
a point. In that case, I think DT overlay is designed for it --
one shall overlay the status property from "disable" (defined in
the DTS of the shipping hardware -- the main board) to "okay" in
the overlay DTS where a connection actually happens.

And even in this case, it makes sense to me to disable both the
status and the driver of SPI/I2C for the main board. Otherwise,
memory could be wasted for standalone main board users at those
unused SPI/I2C buses -- and the memory might be larger than one
could expect depending on where drivers allocate data buffers.

> Point is that I don't _know_ how this is going to be used, so I'd
> rather keep it flexible.

Well, taking one step back, I am okay to follow your way if you
are really firm about it. Just please give me a more reply and
I will merge this change to that v5, dropping the is_visible().

Actually neither the is_visible nor inX_enable is that essential
for me. I am just trying to do what I feel right.

Thank you
Nicolin
