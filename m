Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD81BECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BB22075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTpfMhHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BB22075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJYKE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:04:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37668 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeJYKEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:04:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so3343211pfi.4;
        Wed, 24 Oct 2018 18:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CtB/AVyV2rVwelwIIF5MarJ9348m/MgB3rHI1/kxVEs=;
        b=tTpfMhHEV2HjS4rhjoJ5ON9D5ReldYnxUwidu8VUf+I28t7KKrutAjdYfrKIccHdmi
         LG5kKY2erkC0mlpBqMIm09UuY/uO3UMpBFb/G90H2B45QemXyJSvcJQmgAzsu/0OkSvk
         ZCdhXTQd3KtUdAInNdeSkAL1H+KAifjqHQKV3fpAdogALCHHGb7V07pKxoNRKreqg9dI
         R73zzelZb2ZZDgGxsPTViHIhHgI5NFoB/Jv2ZnubMem1pCOGhUC+YhBSeS/mEwkzZOE2
         onKjjSFr/eB0K+fbCsYne0vQGOi0aIFuiswhM85E3Lm4mvxN1b/40iYIW8Oao+cAH4Nn
         xmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CtB/AVyV2rVwelwIIF5MarJ9348m/MgB3rHI1/kxVEs=;
        b=GfSGYL/MyIissvbKH52Ito3vLvLXGCmHH6sX2N2Fom1Vg8wNwqxN5nrkFwHYradAQz
         JVzSCl9TO5DuOK7fEyO2+b+sMOmt6RPmAFRyBuGwfbiAHXC/OC9MT4l8CmLz36Ybf4lI
         NMsoTiESAtjJojfIo9dgrNYKuWmbUm0UOh8nCnNhlU62WQT/fWbX6fVh2jBU3vcvg+bT
         9R6rf9CwFtrxjvLA0SFWt2y16y5zeqkXGyvrNsUgl4i9NJZXtjKvIvJrHQ6kXFMNnizH
         Z5PUh3KnvWzL6uoivPGyVIOqoQG4u9W8vARTQs6RXla2AhCSbBCuRRwXiPPmyiEvRJpG
         WDhw==
X-Gm-Message-State: AGRZ1gLQvUjlDDdinehLZCXM4jl/Qb2J5U3+rcllXeHwAJp0OZYYVv8L
        LaB8UqlnIp7W8P8SISmPo7c=
X-Google-Smtp-Source: AJdET5fBuZrEmVROEWsvha+3Jg9fW3ZyLATTUZcw7L4wMVYUo0XWIQ5iLcmBsBfZOTOUtJ+FtdQlVg==
X-Received: by 2002:a63:1f1c:: with SMTP id f28mr2331798pgf.193.1540431235167;
        Wed, 24 Oct 2018 18:33:55 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q25-v6sm10301945pfk.154.2018.10.24.18.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 18:33:54 -0700 (PDT)
Date:   Wed, 24 Oct 2018 18:33:50 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] hwmon: (core) Inherit power properties to hdev
Message-ID: <20181025013349.GA7569@Asurada-Nvidia.nvidia.com>
References: <20181024193402.16698-1-nicoleotsuka@gmail.com>
 <20181024193402.16698-2-nicoleotsuka@gmail.com>
 <20181025001301.Horde.VCevVrrSs6rOyXT41xiPOzW@cp2.active-venture.com>
 <20181025010116.GA4543@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025010116.GA4543@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 06:01:16PM -0700, Nicolin Chen wrote:
> On Thu, Oct 25, 2018 at 12:13:01AM +0000, linux@roeck-us.net wrote:
> 
> > > +	if (dev) {
> > > +		hdev->driver = dev->driver;
> > > +		hdev->power = dev->power;
> > > +		hdev->pm_domain = dev->pm_domain;
> > > +		hdev->of_node = dev->of_node;
> > > +	}
> > 
> > We'l need to dig into this more; I suspect it may be inappropriate to do this.
> > With this change, every hwmon driver supporting (runtime ?) suspend/resume
> > will have the problem worked around in #5, and that just seems wrong.
> 
> Hmm..that's true...thanks for catching it.
> 
> Actually I am not sure the reason of having a child device in
> the core, but could we use the parent dev pointer in the hwmon
> core as hwmon_dev upon confirming parent dev pointer != NULL?

I just noticed that it is used to link to hwmon class. So this
won't work then. I guess it'd be safer to ignore the problem of
the power node, i.e. using parent dev pointer for pm runtime.

Thanks
Nicolin

> The problem here is that the power directory under each hwmon
> directory is tied to the hwmon_dev pointer, not to the parent
> dev pointer, and the hwmon core creates all sysfs nodes based
> on the child node. So those nodes under power directory won't
> be valid unless we copy all pm information, especially PM ops.
> 
> There is an option of ignoring this problem though, while all
> hwmon drivers will need to be careful of mixing using the dev
> pointers. So it'd be a lot of easier if we could just use the
> original dev pointer in the core since we mainly just need to
> create sysfs nodes.
> 
> Another way of doing this might be to pass down the PM pointer
> via _info structure instead of linking it to the parent driver,
> which then will forbid all hwmon drivers having its own PM ops
> callbacks -- the very opposite way of this patch, and it does
> not sound fully reasonable and feasible to me...
> 
> What do you think about?
> 
> Thanks
> Nicolin
