Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F70C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C85021537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuHTZVJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C85021537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeI0CkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:40:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44386 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeI0CkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:40:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so150104pgu.11;
        Wed, 26 Sep 2018 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BKUWWStW9NPF5Dizm7cG+ztt1itZejl2kIXCPVrGxBI=;
        b=AuHTZVJ4VebzFF/6T+CmvmpxLejnVn8/zrVb/Sn+N2hubirzKU7LVyo3XaKJI8WmiV
         GL2PTdHIqxPMmbxYhbffSAGiw09eZmrxrsKN9GYr5KA8nu0UjXahXkNfxMzev/r6GbF8
         VaAyuF5m9VTsEM8jiTWuAdejRi9OcPHL3VoKf/OP2sZr1hdBnBMYN85fb5FgJJVzxuvU
         Py4SOyBZO3KcYuvbkR0Kl6idiTQ5Jjxj7LCXAkVUzqgiU87pcrboa6EBtSvkBQQC0/Cc
         jYBulHgqhNIVp7BaVcIg05KVPRmcvZ/IiveCES8aDZzKTY+J81dPzzsgjzkwXejfu3du
         p+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BKUWWStW9NPF5Dizm7cG+ztt1itZejl2kIXCPVrGxBI=;
        b=Bwj8Y+vPbBhVX5jp/G0CpBOEI+veNjsTXBYG8ffXnSBv2mpLqby+sAD260/jsmZ6lm
         XzGx+XECujxBNF3V3cl6ace1IlVsxxLpKE7eMD9UGAkAB2orFctnRCfe0lmE1+y+lfye
         3hobCuWy4jcugrvxInW5XbefwSXaQUOqVqlRpLQx1olgAuw3PVrZzU1dlRBONc2pgI3N
         5RXlrd/+vXd05gpMkHAy+l0t/Hu5+Y+RmIYu28XhFlWz0s9FM6BBPp+5OiAxFbu0K7AD
         WdaXGC8oloW1NibPbW7m0tDYqYlDiUPIc9Yl7zEJo4L23uIkLxLDy/KFlANfi40MExwp
         JZ/A==
X-Gm-Message-State: ABuFfoil4I4GpjnoA5JG5mVkgvIFXMQhiANfAFidxFPfj85H0Ni9wXy1
        ZCWR7i8nASkErQddnoUqYdU=
X-Google-Smtp-Source: ACcGV63sL8/q2s++3oQ94+tKz6mwoDb8uPs4L+xYuCAgBcaZ0VCdbFdcAT7RaHs9ysFD43lqdRZZ9g==
X-Received: by 2002:a62:b604:: with SMTP id j4-v6mr7840305pff.199.1537993522950;
        Wed, 26 Sep 2018 13:25:22 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id s187-v6sm8896045pgc.64.2018.09.26.13.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:25:22 -0700 (PDT)
Date:   Wed, 26 Sep 2018 13:25:20 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add enable sysfs nodes
Message-ID: <20180926202519.GB10595@Asurada-Nvidia.nvidia.com>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-3-nicoleotsuka@gmail.com>
 <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
 <20180926180243.GA6329@Asurada-Nvidia.nvidia.com>
 <20180926195817.GA19695@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926195817.GA19695@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Sep 26, 2018 at 12:58:17PM -0700, Guenter Roeck wrote:
> On Wed, Sep 26, 2018 at 11:02:44AM -0700, Nicolin Chen wrote:
> > On Wed, Sep 26, 2018 at 06:06:32AM -0700, Guenter Roeck wrote:
> > > On 09/25/2018 11:42 PM, Nicolin Chen wrote:
> > > > The inX_enable interface allows user space to enable or disable
> > > > the corresponding channel. Meanwhile, according to hwmon ABI, a
> > > > disabled channel/sensor should return -ENODATA as a read result.
> > > > 
> > > > However, there're configurable nodes sharing the same __show()
> > > > functions. So this change also adds to check if the attribute is
> > > > read-only to make sure it's not reading a configuration but the
> > > > sensor data.
> >  
> > > One necessary high level change I don't see below: With this change,
> > > we should no longer drop a channel entirely if it is disabled from
> > > devicetree. All channels should be visible but report -ENODATA if
> > > disabled. In other words, it should be possible for the 'enable' flag
> > > to override settings in DT.
> > 
> > Hmm...I don't feel so convinced here. The status in DT binding isn't
> > exactly a setting but a physical status: if a hardware design leaves
> > a channel to be disconnected, I don't really see a point in enabling
> > it in the runtime. Or maybe you can shed some light on it?
> > 
> 
> You are making an assumption from your use case. It might as well be that
> some or all channels are disabled in DT by default to conserve power,
> not because they are disconnected.

I think I probably should update my DT binding somehow to say it
explicitly that the property should be only used in cases of the
physical disconnections, although I feel the current binding "no
input source" already has the same meaning.

In my opinion, disabling channels in DT to save power isn't very
plausible, because it sounds more likely a user decision, while,
as we know, DT merely describes the hardware design.

Otherwise, if we want something like a setting for this purpose,
we should probably use a different property for DT binding, bool
type "disable-on-boot" for example.

> > Meanwhile, I believe the enable nodes are necessary in either way as
> > users could decide to disable the connected channels, based on their
> > use cases, to save power.
> > 
> Agreed, though I would not say "necessary". "Useful" seems to be more
> appropriate.

Yea..
