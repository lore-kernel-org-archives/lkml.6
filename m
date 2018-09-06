Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B85C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5422075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aplzBXnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5422075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbeIGBWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:22:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43561 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeIGBWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:22:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so4600250ywb.10;
        Thu, 06 Sep 2018 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z8m+mEIJj3McDnXqQOUT9a15bnp+tQ5IwmM7Yv0JRl4=;
        b=aplzBXnwlI76XyctZYm//zUKqdO0Bscy1fKttYicmoFaQIweIAaTwuYJ6c+e0908L9
         kj3CI+eX7NImufUT2SmVS5tdfW4DBXf6ywReEV49i/D7sScDWBL5doPRZ9gb/m7VHNvE
         JYw80XZL8ho9/N/usYHmK/IrhQ+Zhsx+MJB8IVCndw6/hKp5DBKUk2ZuCdfg1v7u7/yw
         31mtL7wGswKBa6DAyVairUnIdaCthkDGPSv59RhR2CN6SMNPtHdgBdvjWpUnKZw8GsuC
         Hu2lOoGuhjOooSiEVwgfCtsSCamYEOx4Ikactw0ntp9kEJDsz3d9AzvQZmycsBfgJBKH
         bTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z8m+mEIJj3McDnXqQOUT9a15bnp+tQ5IwmM7Yv0JRl4=;
        b=J70YjX7q18C9nX2oJRQRFOXPU03MI6tBOl8fedtRd/Y4RsfUqRCX7c701Tv1wCadQe
         7ScOOl1aG3MCVEermYQ7Xb75jZYfSMGeFwgXy5M4A7dGN7rnlJQo4CirSvZYplAOqTOf
         pjShJvuPuILqIgVlJYpCfZ7U47O1SEGQAUftbBgaUsh6LqNerJTOSbwKm7Enw5I9tHGd
         7DgCS1BA/eCu2YvMQJklPTIBtN6NOXEWCud8V3Xenuz7oKWUiSv6QTZ9Jw8f7lCK6qtM
         6xf26tzlI/JTHQPinOM+SRwHmeS9b5aeaQNvzc8/r3S+OZCsz0qTbs91U6RsU9vAVlLk
         q1+Q==
X-Gm-Message-State: APzg51Ba5BhBK1zJdnmxckQ43ReVbIJRsns6lWGCc/u9yj01w78mGrOb
        fZK1H/aQYGZnL9kqh5Ha8mY=
X-Google-Smtp-Source: ANB0VdbbH8134+fInIRzv9jHffxN3xtgAlGeMh8pTn8qQwbcl+gUNqIazhCeZhsxwSyBj53CahaDvw==
X-Received: by 2002:a81:8641:: with SMTP id w62-v6mr2517215ywf.293.1536266717725;
        Thu, 06 Sep 2018 13:45:17 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:20a])
        by smtp.gmail.com with ESMTPSA id n187-v6sm4341264ywn.76.2018.09.06.13.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 13:45:17 -0700 (PDT)
Date:   Thu, 6 Sep 2018 16:45:15 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] blkcg: remove additional reference to the css
Message-ID: <20180906204514.GC26048@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-12-dennisszhou@gmail.com>
 <20180901002603.GI1488037@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901002603.GI1488037@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 05:26:03PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Thu, Aug 30, 2018 at 09:53:52PM -0400, Dennis Zhou wrote:
> > -	css = cgroup_get_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
> >  
> > -	return __bio_associate_blkg_from_css(bio, css);
> > +	rcu_read_lock();
> > +
> > +	while (true) {
> > +		css = cgroup_e_css(page->mem_cgroup->css.cgroup,
> > +				   &io_cgrp_subsys);
> 
> So, while they seem similar cgroup_e_css() and cgroup_get_e_css()
> behave very differently in terms of locking.  cgroup_e_css() can only
> be used under cgroup_mutex because it is used during migration and has
> to test cgroup_ss_mask().  The right thing to do here would be
> renaming cgroup_e_css() to something else and add a new implementation
> which operates in the same way as cgroup_get_e_css().
> 
> BTW, this should have triggered lockdep warning.  I'd strongly
> recommend testing with lockdep enabled.
> 
> Other than that, looks good to me.
> 

I see. I've renamed the original cgroup_e_css() to
cgroup_e_css_by_mask() and then did what cgroup_get_e_css() did without
the get part in the new cgroup_e_css().

Thanks,
Dennis
