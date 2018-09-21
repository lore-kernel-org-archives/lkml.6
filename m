Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25A2ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BBE21533
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP5P1ODU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BBE21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbeIUHHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:07:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38562 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeIUHHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:07:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so5158984plq.5;
        Thu, 20 Sep 2018 18:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QCEIuH8eULUlSnL4lASgxiFdjHDtgQQoaUfyJdo4kT8=;
        b=IP5P1ODUyuNA/nOaOwiZ7aU9byUHgO41El+4qN++3YXHTJvqWy8/CskHghjEt34mVu
         2ZMdOwxkeDZFcgNonnmwrllsOdsCpmAVG9I4FxNzIwrf2/Uqpgyg3SosE9gQrl/v0IXO
         Zpr/S+kvQT1wJw8PhkZ0Z+DUuPWP4kfLaWVl92Al7hprn9nKeNL1AUI4qPU+qrsObxVR
         KEdE4XVmQik3bu9R7RwIVKVif5ZrCxK4RiWNDbKPC5UaF1fRVuEdliTpDU1Ct7Mnb4yY
         CLGOrlJHWoMHQCbwweD8RPB6Qw2cBDWwBmYnTAXnJrn3DiI3bYXZlVAx65/NT2mAjC7X
         vJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QCEIuH8eULUlSnL4lASgxiFdjHDtgQQoaUfyJdo4kT8=;
        b=f3swhf3ESB21qpIVZHmY3lDfQhLuJ4dxguCCTfUTfr0bO7tatiKArQoZEXVr4qnM5B
         +brEArqk4lZ+mMnK+B5BsC+Wlp6u+uJpfjzz0N2hVIQvK2+ZSyALwvDlVfB5zEBmvNO9
         xcXLNTIho7LV0eDhdQElXcRQnjFpJgT4ogoFjP4t22vz74lIJlT9EW4wr4fuvb8gr+vk
         17zHeYZcHkPoMvW0XlIFgxprmW1Bx1Zw4wnfPhe/5y7mapHaNWHvYwDYTqLUcnyxPS5H
         x/BoAOO2nRz9Ld+XBdTB1Kpw/xoebs9DNaIKaa+Nf/3P9o8Ik/6ATt+53Tm5FiaZB43K
         meQA==
X-Gm-Message-State: APzg51D/yzfB5rarlfmkTkUDLRXHYja7ABIUP5sFW1OBarBQK5agijGK
        IdSyoEXdJXIw+w6hNPycvxE=
X-Google-Smtp-Source: ANB0VdaP64GD08OEmO4O8SYBFuW+6kEM49vsPm86KBzEdrnyjanZjqaKYWQ3mYAX0HSOrbnUKEv6sg==
X-Received: by 2002:a17:902:a58c:: with SMTP id az12-v6mr41838951plb.339.1537492844063;
        Thu, 20 Sep 2018 18:20:44 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d12-v6sm32655011pfn.118.2018.09.20.18.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 18:20:43 -0700 (PDT)
Date:   Thu, 20 Sep 2018 18:20:39 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Get channel names from DT node
Message-ID: <20180921012038.GA23354@Asurada-Nvidia.nvidia.com>
References: <20180921000753.21846-1-nicoleotsuka@gmail.com>
 <20180921000753.21846-3-nicoleotsuka@gmail.com>
 <21a6e8f3-c95d-43d0-ca3f-3f91ddfeff07@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a6e8f3-c95d-43d0-ca3f-3f91ddfeff07@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thanks for the review.

On Thu, Sep 20, 2018 at 05:41:48PM -0700, Guenter Roeck wrote:

> > Meanwhile, channels could be left unconnected based on
> > the hardware design. So the channel name should support
> > NC so the driver could disable the channel accordingly.
> > 
> 
> I am not in favor of such indirect settings. If a channel is
> to be disconnected, define a property for it.

OK. I can add a bool property for it instead.

> I am personally also not in favor of using devicetree to define
> channel names like this, much less so for a single driver.

As DT is used to describe hardware, I felt plausible to put
them in since the names are mentioned in the schematics. Do
you have any advise to handle this better?

> > +	/* Fetch hardware information from Device Tree */
> > +	for (i = 0, g = 0; i < INA3221_NUM_CHANNELS; i++) {
> > +		/* Fetch the channel name */
> > +		sprintf(prop, "ti,channel%d-name", i + 1);
> > +		/* Set a default name on failure */
> > +		if (of_property_read_string(np, prop, &str))
> > +			str = "unknown";
> 
> So if there are no devicetree entries, the user now gets a sequence of
> "unknown" sensors ? I don't think so. Please keep in mind that there are
> users of this chip who don't have devicetree systems, and other users
> may not want to specify any specific name properties (or they use sensors3.conf
> to do it).

Being enlightened by your comments below, maybe adding a
separate group for channel names by attaching is_visible
to it could be acceptable? Then, name nodes can hide from
those who don't want to specify.

> > +		/* Ignore unconnected channels */
> > +		if (!strcmp(str, INA3221_NOT_CONNECTED))
> > +			continue;
> 
> Sorry, I won't accept this. I am sure we can come up with some useful means
> to define in devicetree if individual channels of a hardware monitoring chip
> are enabled or not, but a channel name of "NC" won't be it.

I will try the bool property as you mentioned earlier.

> > +		/* Log connected channels */
> > +		ina->attr_group[g++] = &ina3221_group[i];
> > +		ina->channel_name[i] = str;
> > +		ina->enable[i] = true;
> 
> I also don't see the need for defining the group dynamically. The
> is_visible callback is very well suited for handling optional sysfs
> attributes.

I will add an is_visible callback.

Thanks
Nicolin
