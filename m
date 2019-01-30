Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D8C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23C02087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azkJLUZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387533AbfA3TL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:11:58 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46499 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfA3TL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:11:57 -0500
Received: by mail-yb1-f193.google.com with SMTP id 7so245810ybp.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4j223sTiX4eMGkNGmN1WWkhqrWqcQOSV+aX1N0vGfU=;
        b=azkJLUZ8/StL/5E53v70C5unuQk4f6Ciqs5ZgN9hYqf0WgprVCpGmJfw35DSNFFigH
         JVmOK/jHtzt8P/JqqIEwed/TX1ZFf0ud6XffSASmHI6C8ghY79KgnZYb6Isd5RNkClua
         FQaIW69ilbPoeutkgd0gm95mrYy1COvWQrd88dpMGnxQ/PkebF5X5yUvjgS2yoSNBlUN
         OM0upjn5ctZEGvNWDVcPkYrC2dDtFHVzqK69UsO8y+FvOF106czYSuDNEtf1vGESZlVM
         koBSwBSPYR2tcLjlCvJxtcRP7SRjAYCkyAf0Ruy8coYoG1kClerdGq0mQntTghNaeEoZ
         /Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4j223sTiX4eMGkNGmN1WWkhqrWqcQOSV+aX1N0vGfU=;
        b=WJKX6/c2JhxXXOEHIBRyILcJqOFdFGqv1d4rY4WOwGp3lJdnQ+QTmXuYt43qvUW186
         50seVVKogwP5X3GSRHAwGPsaLiej9ywx2cG0GE/LzrywgIaAv9KH35Vbk+kMN1/CEuRi
         NNMZwclq++hWtc/QDRCFuIkx0FQKCnhoaPaAwNIC0njOWeQTue4s5cRFE/5HbXdddT9t
         WEhixBvexgdhhKl4q0ZYolXWWp2isZUuGoYfIr9vVQTm24pqQqBePiMJ+NvHy9LvDTwh
         DRgBx8fgRzF2B50n3glEVFN1UeP02LhpUHbQdMQDTCmwH+fc4UOG2EeHg+BKePt56vlw
         BZNw==
X-Gm-Message-State: AJcUukcuWPtOpBujwhLcdsLO5wfXVrm1nV71Upy86ZhNAr+PR2hTlcBk
        GadGy2kEdIKu1sGiXFlvgC/mMV38lA4CTcGHBXq47g==
X-Google-Smtp-Source: ALg8bN7h5YVXFcOyF0zDnaKnKlQI+SKdghtxY8KdSlfgBjAb4L5Eo4ra6uGIeVkTzTMf2C553vztFJkeE8sMkZo4rY0=
X-Received: by 2002:a25:6f8b:: with SMTP id k133mr29606576ybc.496.1548875515746;
 Wed, 30 Jan 2019 11:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20190128142816.GM50184@devbig004.ftw2.facebook.com>
 <20190128145210.GM18811@dhcp22.suse.cz> <20190128145407.GP50184@devbig004.ftw2.facebook.com>
 <20190128151859.GO18811@dhcp22.suse.cz> <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz> <20190128174905.GU50184@devbig004.ftw2.facebook.com>
 <20190129144306.GO18811@dhcp22.suse.cz> <20190129145240.GX50184@devbig004.ftw2.facebook.com>
 <20190130165058.GA18811@dhcp22.suse.cz> <20190130170658.GY50184@devbig004.ftw2.facebook.com>
In-Reply-To: <20190130170658.GY50184@devbig004.ftw2.facebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 30 Jan 2019 11:11:44 -0800
Message-ID: <CALvZod5ma62fRKqrAhMcuNT3GYT3FpRX+DCmeVr2nDg1u=9T8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Wed, Jan 30, 2019 at 9:07 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Michal.
>
> On Wed, Jan 30, 2019 at 05:50:58PM +0100, Michal Hocko wrote:
> > > Yeah, cgroup.events and .stat files as some of the local stats would
> > > be useful too, so if we don't flip memory.events we'll end up with sth
> > > like cgroup.events.local, memory.events.tree and memory.stats.local,
> > > which is gonna be hilarious.
> >
> > Why cannot we simply have memory.events_tree and be done with it? Sure
> > the file names are not goin to be consistent which is a minus but that
> > ship has already sailed some time ago.
>
> Because the overall cost of shitty interface will be way higher in the
> longer term.  cgroup2 interface is far from perfect but is way better
> than cgroup1 especially for the memory controller.  Why do you think
> that is?
>

I thought you are fine with the separate interface for the hierarchical events.

https://lkml.kernel.org/r/20190128161201.GS50184@devbig004.ftw2.facebook.com

Is that not the case?

Shakeel
