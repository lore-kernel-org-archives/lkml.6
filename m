Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1276C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F276214C4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjyH/2kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F276214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeIWGeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 02:34:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42403 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeIWGeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 02:34:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id x20-v6so2014806pln.9;
        Sat, 22 Sep 2018 17:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b0TRjfAwL5QPGwvdhPzt3vnHHmJkyVGLznB2dvGxGOY=;
        b=DjyH/2kjS6kzJ0IidGLY/U4T9glBHvxRlFiIjVaNR0H/yRnoLlbaLHj8vVPCmuPIw/
         IWf7ixm2d9DM/VJ67qwSRU1RfW4MhO2oJXO0Byu2/oxabyc8zzzdvraG0J8BhHe42WvH
         ZrHUwwlgY5lPg86awebisuNrnuZirD0aCtKMc3ZH+zisRi7Hjzu1eUl3o8hCRrxF+sz1
         4PXkopmpnrWhzmB+HDnO0+J71+0HkMCx2PKeUonXd6iqCLIIknUSo56jMcthDuHeSNfK
         LWQ6dn3nteBDzm5mruoNlN4oT1cwPdNrEtdjZ/Wm4RUpN6eF+TBuFnJlZg783/fJrjGM
         cgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b0TRjfAwL5QPGwvdhPzt3vnHHmJkyVGLznB2dvGxGOY=;
        b=epF6bTlPUw9WMgewn57Zr1c63Wd/UJhncbuSkgkUwA+2c3OHlREHhQNmQJ9cx+XPNr
         0R/1rwKpeww8zsSc5RfsEkbRTGXBGixC2R2FKNUtaK6+XVDa0y8JxylwC06PMUjobwoQ
         hk9WvrWbgRVklTXIXVKM1QgbesbMQb7ZFIE1KQ/kAXsObHsPjTnzBTdmG0Qi934hWwiJ
         BeH6gYCzE/3XsoxreP1TuC3/JMmpTRf5wZ2IqeIwo9yHbCLcCb7xsRCIVAR3+LNKRPYB
         inzOwB2DkTBAecgaidc83KAUEMV5WstPmBiPMMBAeDzB62Kp4pEu35mqqTrh4qJmVNTw
         TNUg==
X-Gm-Message-State: ABuFfoiXa8lkEcC6jn05x1Q/yeHnVP90Ciye++EbHhOmwABuL19YJBzK
        PKTtOGNKuu7K/kFIBckv9AY=
X-Google-Smtp-Source: ACcGV62D9SmiUS27L8/MVeGUWbJj9cgG4soAUzZvLpLj5OlOOqq99CQQVzM5ymmxGb5nVibB9d+ERw==
X-Received: by 2002:a17:902:b783:: with SMTP id e3-v6mr2255480pls.134.1537663126711;
        Sat, 22 Sep 2018 17:38:46 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h82-v6sm46409162pfa.173.2018.09.22.17.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 17:38:46 -0700 (PDT)
Date:   Sat, 22 Sep 2018 17:38:42 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: ina3221: Read channel input source info
 from DT
Message-ID: <20180923003841.GA10071@Asurada-Nvidia.nvidia.com>
References: <20180921223216.634-1-nicoleotsuka@gmail.com>
 <20180921223216.634-3-nicoleotsuka@gmail.com>
 <a7e6c311-eba4-e9b2-df64-9d02882a1dcb@roeck-us.net>
 <20180922184650.GB9092@Asurada>
 <f8e017c4-10dd-2d0d-84df-b05d3ed03bbf@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e017c4-10dd-2d0d-84df-b05d3ed03bbf@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 04:59:55PM -0700, Guenter Roeck wrote:

> > > > +	/* Disable channels if their inputs are disconnected */
> > > > +	for (i = 0, mask = 0; i < INA3221_NUM_CHANNELS; i++) {
> > > > +		if (ina->inputs[i].disconnected)
> > > > +			mask |= INA3221_CONFIG_CHx_EN(i);
> > > > +	}
> > > 
> > > Consequently, you should also _enable_ channels which are not explicitly disabled.
> > 
> > The register has enabled all channels by default. So I felt it'd
> > be neat to have disabling code only. My v1 actually had enabling
> > part as well, but I can add it back if you think it'd be better.
> > 
> > > This can be tricky since you'll have to distinguish non-DT and DT configuration
> > > and retain the original configuration if no channel configuration data is available
> > > from devicetree.

> > For non-DT configurations, input->disconnected is always false by
> > default unless someone adds config for it (through platform_data).
> > If regmap_update_bits only does disabling like this version does,
> > non-DT configurations will not get affected since mask = 0. Or if
> > we change it to do both enabling and disabling, regmap_update_bits
> > will still ignore since there's no register value changed, though
> > it won't really hurt even if regmap writes correct configurations
> > to the register.
> > 
> > For DT configurations (without channel input source defined), it's
> > like the same as non-DT configurations. As we have platforms only
> > enabled ina3221 via DT while they don't have this new DT binding,
> > the driver has to be backward compatible, so my change only sets
> > input->disconnected=true when a status="disabled" is present, i.e.
> > those platforms are treated as all channels getting enabled until
> > they update their DTs.

> I think your assumption may be that the chip is always in its reset state
> when Linux is loaded. This is not necessarily the case; it may be
> preconfigured by BIOS or ROMMON, or even by someone using i2cset before
> loading the driver. If you add enable/disable functionality, you can
> not make an assumption about the original state of the chip at probe time;
> you have to read it from the chip itself.

I see. That made a point. In that case, I think the simplest way
is probably to do software reset before having configurations.

The "disconnected" here is to describe the physical connection,
not exact the switch control status because a channel could be
connected but disabled. However, a channel would not be enabled
if it's disconnected. So I think it'd be safe to just disable
the disconnected channels here as this version does, meanwhile,
I will add a soft reset to make sure all channels are enabled.

Thanks
Nicolin
