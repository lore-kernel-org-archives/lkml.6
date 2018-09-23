Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CBFECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB36420870
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNtNhNq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB36420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbeIWGp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 02:45:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38597 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeIWGp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 02:45:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so7547128pfh.5;
        Sat, 22 Sep 2018 17:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ppv/Tvu39nrRkYNflRUV2L/7F4sMTKMmB+Aq56Bm9xo=;
        b=WNtNhNq5YjVNE4nPE9Qu/JqAsnVThARFJcwiUNWRZ0TNB1qpGSAJ0NkHFDsNJJ5CjO
         uyezZqKJQ0JXgO23JqKWNKBxWWFNl82lAuOscaP43tzkspeB/glfuevm8CyH9ke64mRP
         i2a5elWIT2WCw1yMbtNJU6CIf3YB1MgC5Vlor913YyknH2jeTSkL10mCWJ3Paeylas+O
         9Km5N1B+V3Z5hWXTwoopvaMNA9QhGrVVES6PvJ077ysFVfhnucbBG2zWjFOeP2AKgxNa
         LidpuffjC1sgyjhxSYH0ZRvUxZQvJRKMCIIC9Qlk4o0QYm250gCslUAtq3BVEp3Fy0/8
         cxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ppv/Tvu39nrRkYNflRUV2L/7F4sMTKMmB+Aq56Bm9xo=;
        b=sMnM6kr8JQrn59e+iE9rOl6ONZVEQWqhhSdZ5WGw2+xcZDWi9kmuDYrY47p6+OM+HK
         8Ifcmk7+N+3dk0exAIkmVOBrPu0DRkX/6MItksuFU2+oxTNa/nI45do2bsPfjOp+MJhI
         8/D2Y9F8n1Dml3rK4eEGuoTsugAbxKv107er7ePiBo+FyqYZn2+VYc5Q+uQL2XlO2B5D
         wf+Zj1mzAGIZMJiCdNxNo6oTKRJvcr0VVZ7UIWTsZKbLTo0a9iUaTXT7HKsvQbBD0EpH
         VFh3Ed4+Y5XkI3gy+5dIi3I3Shi+iuvb4KWQBBXZ8mLJTe8JhvrsnMRbBrvBRDuXMPRQ
         o+SQ==
X-Gm-Message-State: APzg51Bk5KZUYLxq1RxH1hGpskzZIhgEm0gCgIGdn+twqDtoB8+bSRAI
        C04B8OK3EVV7QWPqOSJNmwU=
X-Google-Smtp-Source: ACcGV608ioTE536XSYAHSGadBj852Ou7b58gKcA3CqyhfMladVLdwmAEVkaxM304Z5lO/AHrjx3zrA==
X-Received: by 2002:a62:9ed2:: with SMTP id f79-v6mr4282573pfk.206.1537663823830;
        Sat, 22 Sep 2018 17:50:23 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id k13-v6sm12343835pgf.37.2018.09.22.17.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 17:50:23 -0700 (PDT)
Date:   Sat, 22 Sep 2018 17:50:19 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: ina3221: Read channel input source info
 from DT
Message-ID: <20180923005019.GA11764@Asurada-Nvidia.nvidia.com>
References: <20180921223216.634-1-nicoleotsuka@gmail.com>
 <20180921223216.634-3-nicoleotsuka@gmail.com>
 <a7e6c311-eba4-e9b2-df64-9d02882a1dcb@roeck-us.net>
 <20180922184650.GB9092@Asurada>
 <f8e017c4-10dd-2d0d-84df-b05d3ed03bbf@roeck-us.net>
 <20180923003841.GA10071@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923003841.GA10071@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 05:38:41PM -0700, Nicolin Chen wrote:
> On Sat, Sep 22, 2018 at 04:59:55PM -0700, Guenter Roeck wrote:
> 
> > > > > +	/* Disable channels if their inputs are disconnected */
> > > > > +	for (i = 0, mask = 0; i < INA3221_NUM_CHANNELS; i++) {
> > > > > +		if (ina->inputs[i].disconnected)
> > > > > +			mask |= INA3221_CONFIG_CHx_EN(i);
> > > > > +	}
> > > > 
> > > > Consequently, you should also _enable_ channels which are not explicitly disabled.
> > > 
> > > The register has enabled all channels by default. So I felt it'd
> > > be neat to have disabling code only. My v1 actually had enabling
> > > part as well, but I can add it back if you think it'd be better.
> > > 
> > > > This can be tricky since you'll have to distinguish non-DT and DT configuration
> > > > and retain the original configuration if no channel configuration data is available
> > > > from devicetree.
> 
> > > For non-DT configurations, input->disconnected is always false by
> > > default unless someone adds config for it (through platform_data).
> > > If regmap_update_bits only does disabling like this version does,
> > > non-DT configurations will not get affected since mask = 0. Or if
> > > we change it to do both enabling and disabling, regmap_update_bits
> > > will still ignore since there's no register value changed, though
> > > it won't really hurt even if regmap writes correct configurations
> > > to the register.
> > > 
> > > For DT configurations (without channel input source defined), it's
> > > like the same as non-DT configurations. As we have platforms only
> > > enabled ina3221 via DT while they don't have this new DT binding,
> > > the driver has to be backward compatible, so my change only sets
> > > input->disconnected=true when a status="disabled" is present, i.e.
> > > those platforms are treated as all channels getting enabled until
> > > they update their DTs.
> 
> > I think your assumption may be that the chip is always in its reset state
> > when Linux is loaded. This is not necessarily the case; it may be
> > preconfigured by BIOS or ROMMON, or even by someone using i2cset before
> > loading the driver. If you add enable/disable functionality, you can
> > not make an assumption about the original state of the chip at probe time;
> > you have to read it from the chip itself.
> 
> I see. That made a point. In that case, I think the simplest way
> is probably to do software reset before having configurations.
> 
> The "disconnected" here is to describe the physical connection,
> not exact the switch control status because a channel could be
> connected but disabled. However, a channel would not be enabled
> if it's disconnected. So I think it'd be safe to just disable
> the disconnected channels here as this version does, meanwhile,
> I will add a soft reset to make sure all channels are enabled.

Actually...just a couple of lines before this, the probe() does
soft reset:

537         ret = regmap_field_write(ina->fields[F_RST], true);
538         if (ret) {
539                 dev_err(dev, "Unable to reset device\n");
540                 return ret;
541         }

So I think it'd be okay to just keep disabling disconnected
channels only as this version?
