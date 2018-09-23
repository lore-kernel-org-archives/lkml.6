Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8206ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 03:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECAF214DC
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 03:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyFTYMy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECAF214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeIWJ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 05:29:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32819 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeIWJ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 05:29:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so7639785pfn.0;
        Sat, 22 Sep 2018 20:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ROc0hzvsvs/yqQen/JNbczqdQDvPT8s3kHl7I51Osi8=;
        b=tyFTYMy0bUZtlL4ZkS4aBprBiQcHFNI7ehSxKyHkZwlj3ktpdpmi+sTe1EWlsW5IFF
         nljna/Fg0EnFffx5G2Gv/T8yHrYHNlNjKxOQfZB7+PzquV6GOkCRpbAadp2AoMPWn6dv
         +hnzAHIbpOlnBIuPB6VfcPONblpK6HFK83XhI77ri1WzAeaA6A8d4b9Wk/rhfwnY1zD6
         kL4m9rvUAse1kDJmMKzdrlLpO8W+hZ5yF8M0LLBQUQPJEGTspjJFqnyrgErTEYqaA8Uo
         bPEvDc+ZlgVYyWzAkDERUOzdwMfDFEqhYKoq6oFfuJt+RnPPE2PhYJBo/8u8GPR6OPSa
         Sagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ROc0hzvsvs/yqQen/JNbczqdQDvPT8s3kHl7I51Osi8=;
        b=EyfMsduT5qAbTabGzOIc3nKmVnY60dB84KMYe7O/gRy51N7yyNE8kQdQZvSMzs4FZO
         7kouc4m1zvg8eN+uYkjSISH8WNHWVUZOHcwQTN5/LZadtirKiJraHQbEot87owfsNXxV
         /1lDnJR5Crgp8exfOhBsQia4jkl8yPkgarIGKt8GJJXHtyOV3SWNLkNWvvv47D1HDPMX
         SXD3R3C4J4VOo3DYgdzPxuPSj1NVZqAM0eGJadvXlkuYqTRSMQVEf9wsQMfoGszHm9X2
         WuILRXdDAcfc7hL603mFzifEOuudTPAQCDUp1gPIpjlVh+TCTqBZRFMp1By3GGC1R8tf
         rJ1w==
X-Gm-Message-State: ABuFfojB1As/VYMjNKbJEj27bx1LyaopJKb0QM0EzV2jWglS2fEGb/Lo
        X3+rZAo1Bbz+wPtOiHUcUec=
X-Google-Smtp-Source: ACcGV60c3Qd6tsUeTx6Tvy9rAmfSF/rc6fnNEycW6q6PZF6I3mP2PAnse+SRlLGydg51cXkVkVxzfA==
X-Received: by 2002:a63:ad44:: with SMTP id y4-v6mr4145938pgo.138.1537673586826;
        Sat, 22 Sep 2018 20:33:06 -0700 (PDT)
Received: from Asurada (c-73-231-2-134.hsd1.ca.comcast.net. [73.231.2.134])
        by smtp.gmail.com with ESMTPSA id l85-v6sm54261860pfk.34.2018.09.22.20.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 20:33:06 -0700 (PDT)
Date:   Sat, 22 Sep 2018 20:33:00 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: ina3221: Read channel input source info
 from DT
Message-ID: <20180923033300.GA5736@Asurada>
References: <20180921223216.634-1-nicoleotsuka@gmail.com>
 <20180921223216.634-3-nicoleotsuka@gmail.com>
 <a7e6c311-eba4-e9b2-df64-9d02882a1dcb@roeck-us.net>
 <20180922184650.GB9092@Asurada>
 <f8e017c4-10dd-2d0d-84df-b05d3ed03bbf@roeck-us.net>
 <20180923003841.GA10071@Asurada-Nvidia.nvidia.com>
 <80510b08-0e89-03ce-7d69-fe51f8b6a7b5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80510b08-0e89-03ce-7d69-fe51f8b6a7b5@roeck-us.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 07:07:02PM -0700, Guenter Roeck wrote:
> On 09/22/2018 05:38 PM, Nicolin Chen wrote:
> >On Sat, Sep 22, 2018 at 04:59:55PM -0700, Guenter Roeck wrote:
> >
> >>>>>+	/* Disable channels if their inputs are disconnected */
> >>>>>+	for (i = 0, mask = 0; i < INA3221_NUM_CHANNELS; i++) {
> >>>>>+		if (ina->inputs[i].disconnected)
> >>>>>+			mask |= INA3221_CONFIG_CHx_EN(i);
> >>>>>+	}
> >>>>
> >>>>Consequently, you should also _enable_ channels which are not explicitly disabled.
> >>>
> >>>The register has enabled all channels by default. So I felt it'd
> >>>be neat to have disabling code only. My v1 actually had enabling
> >>>part as well, but I can add it back if you think it'd be better.
> >>>
> >>>>This can be tricky since you'll have to distinguish non-DT and DT configuration
> >>>>and retain the original configuration if no channel configuration data is available
> >>>>from devicetree.
> >
> >>>For non-DT configurations, input->disconnected is always false by
> >>>default unless someone adds config for it (through platform_data).
> >>>If regmap_update_bits only does disabling like this version does,
> >>>non-DT configurations will not get affected since mask = 0. Or if
> >>>we change it to do both enabling and disabling, regmap_update_bits
> >>>will still ignore since there's no register value changed, though
> >>>it won't really hurt even if regmap writes correct configurations
> >>>to the register.
> >>>
> >>>For DT configurations (without channel input source defined), it's
> >>>like the same as non-DT configurations. As we have platforms only
> >>>enabled ina3221 via DT while they don't have this new DT binding,
> >>>the driver has to be backward compatible, so my change only sets
> >>>input->disconnected=true when a status="disabled" is present, i.e.
> >>>those platforms are treated as all channels getting enabled until
> >>>they update their DTs.
> >
> >>I think your assumption may be that the chip is always in its reset state
> >>when Linux is loaded. This is not necessarily the case; it may be
> >>preconfigured by BIOS or ROMMON, or even by someone using i2cset before
> >>loading the driver. If you add enable/disable functionality, you can
> >>not make an assumption about the original state of the chip at probe time;
> >>you have to read it from the chip itself.
> >
> >I see. That made a point. In that case, I think the simplest way
> >is probably to do software reset before having configurations.
> >
> No. If the chip was configured by the BIOS/ROMMON, it is supposed
> to be that way. We can not just override that.

For this driver, it does soft reset in the probe() so we're
sure that all channels are enabled at the moment of calling
this regmap_update_bits. So there's no assumption anymore.

But the case that you mentioned is a good one. It does give
me some insight about the use case and the things that will
need to be careful when adding in[123]_enable. Just it'd be
also possible that BIOS could disable a channel that is not
explicitly disabled in the DT -- then the driver should not
enable it.

Therefore, for both cases, it seems that disabling only the
disconnected channels as this version is a safe solution.

And the driver actually won't update input->disconnected as
this is a physical hardware status that won't be changed. I
probably could define the input->disconnected in const type.
For in[123]_enable, it'd be safer to read/write the register
directly.

Thanks
Nicolin

> >The "disconnected" here is to describe the physical connection,
> >not exact the switch control status because a channel could be
> >connected but disabled. However, a channel would not be enabled
> >if it's disconnected. So I think it'd be safe to just disable
> >the disconnected channels here as this version does, meanwhile,
> >I will add a soft reset to make sure all channels are enabled.
> >
> >Thanks
> >Nicolin
> >
> 
