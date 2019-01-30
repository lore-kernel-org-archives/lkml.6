Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448ECC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125CF20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548868025;
	bh=vWonZD63zHIueYk1mnrhqOa5gX34Z8JCSm1pmbo/rfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kVZzcLzrvPmTM8DBeJlaMinWq0wGmrMGZTEB1oPBXZkpknpR0Pg4QD5RWf/Qyd4Po
	 1MK6E/svUtdMMkVrDDBT9pr+kzFgPiM/K77Ewk1B1kV83AhlKhALTSFaDD7QclBJdo
	 EEdHWQfRUZTuf+IieLzJaZJHt8ujz0/Imp1qA2SI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbfA3RHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:07:03 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39830 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731717AbfA3RHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:07:03 -0500
Received: by mail-yw1-f65.google.com with SMTP id k188so99923ywa.6;
        Wed, 30 Jan 2019 09:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r4FvnOpw+Kp/xo1E/oIUXzj02pZKaUP0vrX/v1MVF3s=;
        b=rQjmckmzAv1TtgaDTf+xwGnxDCZf/qt62fsajJvyFlBof5l/0CVKAG0/RQdHbYUU8Z
         YV3pupMl9wakI8GJ2a6Q6X1czRWRbqRIrvDYdBGenYJH/AT+DrU6hAeWiAJeKafhh47f
         jEDi7+H+xXmSLP+84wuhC/kTT1At/AlXUGMc7YbhpX92ShXurAJwHvoI1VXRc8cN2NoO
         uMKjdB5EwWa9+9c0xWSBmyKrQBV0LdzTOgzkmuI9iU0gbxpf1N+yxqips6zJE2ehg/yz
         2hltgR4GXOpilyhCa+c/RA4A40XOj85aph8KTQMtFbCHYe82rL28IeBb2qbM1WjpktGs
         JPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4FvnOpw+Kp/xo1E/oIUXzj02pZKaUP0vrX/v1MVF3s=;
        b=M43qP5h7yQ8fAgwm+u05Ivs11rDJ6i/fgp+nYNhI9ZWQQ6s+/s5sKD5BkHsIdbgsZL
         Z4TovPKTrqR9BLoHV1DWeHb26VMpEbLLs2Negl56qvtCdfjM2rq9ThueSXJHvbnlRQ7d
         FP2rNg2dlwCuLkhDCARWy/Nux9+ga+0h/1li8O+ox+Qi2OpCy2PLMra3JLSxeC2Q6IZf
         izFjmDKDCrgBnFn25ogGvmc5a7k4o6mFWnpE/hxQ91sXtMJrYpgZiv4fIr6tqvf5bndc
         9Vm0/aHr3HXp+TELwCCjh5xe/+hft0mpR1SBIJQtKBhzwyNo4R2VtaukR6BOsSUObz96
         oS8Q==
X-Gm-Message-State: AJcUukcRLc4rXREAXae5O/XGbIeadPqVE6rWkWkk9MUp216OeUd/c4Ko
        eZj+m6xUNueUIQfTnqxeVIY=
X-Google-Smtp-Source: ALg8bN46/CyjNniPd/uEyCmyWWAS1mahMjoWkazGoUDEhY78foz8Nqb7qCmY2P58ISnLM36C8mVYug==
X-Received: by 2002:a81:3413:: with SMTP id b19mr29798236ywa.297.1548868021695;
        Wed, 30 Jan 2019 09:07:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:e55d])
        by smtp.gmail.com with ESMTPSA id g84sm2015945ywg.9.2019.01.30.09.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 09:07:00 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:06:58 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190130170658.GY50184@devbig004.ftw2.facebook.com>
References: <20190128142816.GM50184@devbig004.ftw2.facebook.com>
 <20190128145210.GM18811@dhcp22.suse.cz>
 <20190128145407.GP50184@devbig004.ftw2.facebook.com>
 <20190128151859.GO18811@dhcp22.suse.cz>
 <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz>
 <20190128174905.GU50184@devbig004.ftw2.facebook.com>
 <20190129144306.GO18811@dhcp22.suse.cz>
 <20190129145240.GX50184@devbig004.ftw2.facebook.com>
 <20190130165058.GA18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130165058.GA18811@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

On Wed, Jan 30, 2019 at 05:50:58PM +0100, Michal Hocko wrote:
> > Yeah, cgroup.events and .stat files as some of the local stats would
> > be useful too, so if we don't flip memory.events we'll end up with sth
> > like cgroup.events.local, memory.events.tree and memory.stats.local,
> > which is gonna be hilarious.
> 
> Why cannot we simply have memory.events_tree and be done with it? Sure
> the file names are not goin to be consistent which is a minus but that
> ship has already sailed some time ago.

Because the overall cost of shitty interface will be way higher in the
longer term.  cgroup2 interface is far from perfect but is way better
than cgroup1 especially for the memory controller.  Why do you think
that is?

> > If you aren't willing to change your mind, the only option seems to be
> > introducing a mount option to gate the flip and additions of local
> > files.  Most likely, userspace will enable the option by default
> > everywhere, so the end result will be exactly the same but I guess
> > it'll better address your concern.
> 
> How does the consumer of the API learns about the mount type?

It's gonna be a mount flag exposed in /sys/kernel/cgroup/features.

Thanks.

-- 
tejun
