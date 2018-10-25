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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF2AECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67662205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 01:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZY8gpGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67662205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeJYJbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:31:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44712 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:31:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id d23-v6so3023195pls.11;
        Wed, 24 Oct 2018 18:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=01TXP9ER4UEFM4TI1z35y/RQyrwKadKZNQhGGLqmr78=;
        b=XZY8gpGKBxj2Grj6w0P6pynLFz9U+safpHLbtZihKgjMiFBY1Jc+zbypDqs2ErcL6f
         CcsrIN5B5zRulKVV+3H1Vvpr6RK9KbhxFJALiP5VD/8ZkHT4AdePAF/7DI6MFxNBtYu8
         VzAd+AJVCAtDgxO9mq0NS5mWTDEmCYuCri7jY4JtwV6m21O1BvIYspTM6VIURE0shWML
         bCuAFsaUs3J4DN2FJeIGsewCT1JixXet64m9dJU/aOdmCSkZBUOH/TZR4UR6RXrr7ZAQ
         C66LKtHnEAO/2BKnMlQ9KKxERoE3B/zuza3Kr1QH6NZ0jJq6VDjRYofcWXDADbBTPqUS
         cvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=01TXP9ER4UEFM4TI1z35y/RQyrwKadKZNQhGGLqmr78=;
        b=IIsDzJt/YZ5RDUuWJggTEF44uuGEhb56o1puEq/CndPpaQeWVBDWaFN5gzMeHwL7xJ
         p3aJQLPkfw/piuge4yUp1Kc/hKEB4GPISg0rXj4BORQ3vDyH4emAe1VsTxMWBU0nH3Ly
         F4EgtsvWKkeTiECjW69Vv8Aol5AphgdVJbG94VtQR/LrRJ2tAzWQ+8rOr1mrKyCeyrAr
         BJtbdKohuE0K9zsfCzWZchn0lMUPYC6uzXIha1mrso9sKnPie1jqzEPqbxifI9T6xfnQ
         +HeHXwPGYJkn7/Sdq+5sSQKIu0Zrsm3emFQkD+iYLF1ldqUBQNcGs3H5QpnAhqyf8weA
         Q9HQ==
X-Gm-Message-State: AGRZ1gKHP1kVRVCk33o+YD3OsjdnQN9ymZVpBQfYmnQBll7Hjw68+36E
        XVCD8IWvOJKh8xJxgVTOmhvlhG1b
X-Google-Smtp-Source: AJdET5c33adAyiDIVSesiTPtXDaYtTXS5UOm3IQiuSzvgSb1Urrdn9zasXu7+WOZv79prR9DSgJc6w==
X-Received: by 2002:a17:902:4481:: with SMTP id l1-v6mr959484pld.123.1540429282345;
        Wed, 24 Oct 2018 18:01:22 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id k13-v6sm5891788pgi.40.2018.10.24.18.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 18:01:21 -0700 (PDT)
Date:   Wed, 24 Oct 2018 18:01:17 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] hwmon: (core) Inherit power properties to hdev
Message-ID: <20181025010116.GA4543@Asurada-Nvidia.nvidia.com>
References: <20181024193402.16698-1-nicoleotsuka@gmail.com>
 <20181024193402.16698-2-nicoleotsuka@gmail.com>
 <20181025001301.Horde.VCevVrrSs6rOyXT41xiPOzW@cp2.active-venture.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025001301.Horde.VCevVrrSs6rOyXT41xiPOzW@cp2.active-venture.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:13:01AM +0000, linux@roeck-us.net wrote:

> > +	if (dev) {
> > +		hdev->driver = dev->driver;
> > +		hdev->power = dev->power;
> > +		hdev->pm_domain = dev->pm_domain;
> > +		hdev->of_node = dev->of_node;
> > +	}
> 
> We'l need to dig into this more; I suspect it may be inappropriate to do this.
> With this change, every hwmon driver supporting (runtime ?) suspend/resume
> will have the problem worked around in #5, and that just seems wrong.

Hmm..that's true...thanks for catching it.

Actually I am not sure the reason of having a child device in
the core, but could we use the parent dev pointer in the hwmon
core as hwmon_dev upon confirming parent dev pointer != NULL?

The problem here is that the power directory under each hwmon
directory is tied to the hwmon_dev pointer, not to the parent
dev pointer, and the hwmon core creates all sysfs nodes based
on the child node. So those nodes under power directory won't
be valid unless we copy all pm information, especially PM ops.

There is an option of ignoring this problem though, while all
hwmon drivers will need to be careful of mixing using the dev
pointers. So it'd be a lot of easier if we could just use the
original dev pointer in the core since we mainly just need to
create sysfs nodes.

Another way of doing this might be to pass down the PM pointer
via _info structure instead of linking it to the parent driver,
which then will forbid all hwmon drivers having its own PM ops
callbacks -- the very opposite way of this patch, and it does
not sound fully reasonable and feasible to me...

What do you think about?

Thanks
Nicolin
