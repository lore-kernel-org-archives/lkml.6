Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1592C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 03:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1972D214C4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 03:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrzcrVbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1972D214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeIWJfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 05:35:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46021 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeIWJfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 05:35:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so7618110pfo.12;
        Sat, 22 Sep 2018 20:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fdJG7igE/Su0jX8DXOutpLKqkchsqWuyaAP6Ngr0saU=;
        b=TrzcrVbMlgMWnObGk/MpL3++esdXhCIKUgRs4+U4rPcdfXSQ22XWE7vSEfDYaKbjgP
         uOt6tyuBIGJGoxfwe71WCi9Wo4NT7eljx1qt5+JaJSjdPlGpgB9yaDy06gUiz6ST/Nf8
         HI6VJ1MPPwFCEKNLb5Sm7PTXofIQY/y3S4++FYXKLCafz75w2suj2Lzriqi3ZfRBqHG5
         voBQktZEnWDcZAW3L+/6+JnghcidvYxqujApUQI6Lm0SnESNiiEaWBVpfODCLAp95Jqg
         liGTN9Z7DVX2H8NCmzkPhUOQRw+60/cQbwp6DTj9W8wd5JG4gsMWJu419SCi9FyFS0YV
         kp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fdJG7igE/Su0jX8DXOutpLKqkchsqWuyaAP6Ngr0saU=;
        b=lx6HK2XM5eXeXeHTzwikH3GyB7SLvvA/g4St/4t7PTHTGJoBYSSy/jpNIGvXNNsyie
         OQIAEqJWjj5JFJ5yO1fx3XsTz9nFRG8oIDroJguBidqmRqCL04UNxN6Y292TclRYYaTE
         NvJm1XJybnR66/+3UhS/8TCwN31O9R8BcKIGAUwvh3HMUHGjpg+cU3bm9piPnkwrRSTY
         ZbY89z1Lhai9EL7sCylAvC0YT0Q+2pwyCy/HqGW8RriOnQ3kBpbicIFYi7S1xDvOxQ6l
         o3EJokqsrvtP406nHMRDWUU5+KnKtjoIlFggi0Nasro+Ho3I8yecGejgF5xh/SSIvyhr
         eAZw==
X-Gm-Message-State: ABuFfoj6HrzetaEZ0z44/C3mWL8k5WU9/8MNj8/q1r3aXVRWXX+7VBr3
        DnMFzSl7EwQVAS9koc0q6cQ=
X-Google-Smtp-Source: ACcGV63ibk9qpxDdNKFTWPr/1db+xk5meZoD4w0ewHSLW+NZm8ua38QqHWAV8lcI0KXyKmcZwjclGw==
X-Received: by 2002:a63:1f0a:: with SMTP id f10-v6mr4121788pgf.313.1537673991331;
        Sat, 22 Sep 2018 20:39:51 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i25-v6sm36171917pgi.31.2018.09.22.20.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 20:39:50 -0700 (PDT)
Date:   Sat, 22 Sep 2018 20:39:46 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: ina3221: Read channel input source info
 from DT
Message-ID: <20180923033945.GA20183@Asurada-Nvidia.nvidia.com>
References: <20180921223216.634-1-nicoleotsuka@gmail.com>
 <20180921223216.634-3-nicoleotsuka@gmail.com>
 <a7e6c311-eba4-e9b2-df64-9d02882a1dcb@roeck-us.net>
 <20180922184650.GB9092@Asurada>
 <f8e017c4-10dd-2d0d-84df-b05d3ed03bbf@roeck-us.net>
 <20180923003841.GA10071@Asurada-Nvidia.nvidia.com>
 <80510b08-0e89-03ce-7d69-fe51f8b6a7b5@roeck-us.net>
 <20180923033300.GA5736@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923033300.GA5736@Asurada>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 08:33:00PM -0700, Nicolin Chen wrote:
> On Sat, Sep 22, 2018 at 07:07:02PM -0700, Guenter Roeck wrote:
> > On 09/22/2018 05:38 PM, Nicolin Chen wrote:
> > >On Sat, Sep 22, 2018 at 04:59:55PM -0700, Guenter Roeck wrote:
> > >
> > >>>>>+	/* Disable channels if their inputs are disconnected */
> > >>>>>+	for (i = 0, mask = 0; i < INA3221_NUM_CHANNELS; i++) {
> > >>>>>+		if (ina->inputs[i].disconnected)
> > >>>>>+			mask |= INA3221_CONFIG_CHx_EN(i);
> > >>>>>+	}
> > >>>>
> > >>>>Consequently, you should also _enable_ channels which are not explicitly disabled.
> > >>>
> > >>>The register has enabled all channels by default. So I felt it'd
> > >>>be neat to have disabling code only. My v1 actually had enabling
> > >>>part as well, but I can add it back if you think it'd be better.
> > >>>
> > >>>>This can be tricky since you'll have to distinguish non-DT and DT configuration
> > >>>>and retain the original configuration if no channel configuration data is available
> > >>>>from devicetree.
> > >
> > >>>For non-DT configurations, input->disconnected is always false by
> > >>>default unless someone adds config for it (through platform_data).
> > >>>If regmap_update_bits only does disabling like this version does,
> > >>>non-DT configurations will not get affected since mask = 0. Or if
> > >>>we change it to do both enabling and disabling, regmap_update_bits
> > >>>will still ignore since there's no register value changed, though
> > >>>it won't really hurt even if regmap writes correct configurations
> > >>>to the register.
> > >>>
> > >>>For DT configurations (without channel input source defined), it's
> > >>>like the same as non-DT configurations. As we have platforms only
> > >>>enabled ina3221 via DT while they don't have this new DT binding,
> > >>>the driver has to be backward compatible, so my change only sets
> > >>>input->disconnected=true when a status="disabled" is present, i.e.
> > >>>those platforms are treated as all channels getting enabled until
> > >>>they update their DTs.
> > >
> > >>I think your assumption may be that the chip is always in its reset state
> > >>when Linux is loaded. This is not necessarily the case; it may be
> > >>preconfigured by BIOS or ROMMON, or even by someone using i2cset before
> > >>loading the driver. If you add enable/disable functionality, you can
> > >>not make an assumption about the original state of the chip at probe time;
> > >>you have to read it from the chip itself.
> > >
> > >I see. That made a point. In that case, I think the simplest way
> > >is probably to do software reset before having configurations.
> > >
> > No. If the chip was configured by the BIOS/ROMMON, it is supposed
> > to be that way. We can not just override that.
> 
> For this driver, it does soft reset in the probe() so we're
> sure that all channels are enabled at the moment of calling
> this regmap_update_bits. So there's no assumption anymore.
> 
> But the case that you mentioned is a good one. It does give
> me some insight about the use case and the things that will
> need to be careful when adding in[123]_enable. Just it'd be
> also possible that BIOS could disable a channel that is not
> explicitly disabled in the DT -- then the driver should not
> enable it.
> 
> Therefore, for both cases, it seems that disabling only the
> disconnected channels as this version is a safe solution.
> 
> And the driver actually won't update input->disconnected as
> this is a physical hardware status that won't be changed. I

[...]
> probably could define the input->disconnected in const type.
[...]

Please ignore this line. It'd be read-only then. I got myself
confused as it's not a pointer like label.

> For in[123]_enable, it'd be safer to read/write the register
> directly.
> 
> Thanks
> Nicolin
> 
> > >The "disconnected" here is to describe the physical connection,
> > >not exact the switch control status because a channel could be
> > >connected but disabled. However, a channel would not be enabled
> > >if it's disconnected. So I think it'd be safe to just disable
> > >the disconnected channels here as this version does, meanwhile,
> > >I will add a soft reset to make sure all channels are enabled.
> > >
> > >Thanks
> > >Nicolin
> > >
> > 
