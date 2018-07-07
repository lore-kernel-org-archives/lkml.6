Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E142C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E70621A16
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivZZ7vr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E70621A16
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbeGGAFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 20:05:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36413 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbeGGAFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 20:05:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so3516897plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 17:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6wQuN62ccyfs9nr9jUlD6eYsJahyFhmLIYXwZ6NcS28=;
        b=ivZZ7vr00JX7COz+MH5y5MYVkFNHAtsrEnM6hsMKlW5Vg/3+Q6AkAi+/4L02ED3Occ
         mcFFL3GtR4iRE2TYAaaXE2TaV2dA91+K3u0W1mTrO93ELGYDN+ql8TJW6udbBxg1LU/n
         8Dxw9sSimQo6JXf2uyGt/K2j7xoCJbdsBIub088cA6Kdjtq+rn3QUH7CNWMAklwanIxl
         nvT1aI3i6zUFFwDaOdlsxaal5+af3YqFDXr5uDh05cyP/khlZVTyZvRto/wvd0ibdbiy
         EPkd2V1NnPMtkGcWN7+cKTb8HCLTmH9H1pMSv44sZ9oQnkgE6rMhPxiZWrP4gftSU059
         deDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6wQuN62ccyfs9nr9jUlD6eYsJahyFhmLIYXwZ6NcS28=;
        b=dGzwXFeQ/Dc/il5PiRM5QjHODvm0HWuIS/sRTyoXUYCHFKdBrQZV48RTLI8ifO2aZl
         +y6wXLuNj4D9+IWujYAFcwTBEuG1iVSH6yS9hir3ITUy6bBlw93Paezqangp0jWTgWPi
         JCogAcP45D9pl0PBlC4sAspWgwWy/T8up/NGI0K1BEhzi937oerhrrCpW3MRdsq/iIbQ
         hLWClMtzqkvU792XH7VEeearKBajwXUimFoxYo71gvUShfGdN9MokGjT6c4IxBlT52hN
         C3kaf7wjYsYi2fOVFW99QJaEpl91nDCfA+vUWkjP4vR68885L3qd0Z7MSuLLje9N0bW8
         wTjg==
X-Gm-Message-State: APt69E1FMGjl14bzvb3Bgskusomb11b/tQ+P15oXWYd3K9FMuOmYjB5G
        RyzP/dgjAfIwpJ3KzeTafw2vUg==
X-Google-Smtp-Source: AAOMgpeCf67ZnY5wlCMHoP4VIRjbSLvrhewAjuYmAXh+uRC0C/lRHVCmFNQTJ75ZnxeDtgyauDanmA==
X-Received: by 2002:a17:902:6802:: with SMTP id h2-v6mr11862027plk.113.1530921940448;
        Fri, 06 Jul 2018 17:05:40 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l85-v6sm21986297pfk.79.2018.07.06.17.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 17:05:39 -0700 (PDT)
Date:   Fri, 6 Jul 2018 17:05:39 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     kbuild test robot <fengguang.wu@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <20180705164621.0a4fe6ab3af27a1d387eecc9@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1807061652430.71359@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com> <20180705164621.0a4fe6ab3af27a1d387eecc9@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018, Andrew Morton wrote:

> > +#ifdef CONFIG_DEBUG_FS
> > +static int oom_free_timeout_ms_read(void *data, u64 *val)
> > +{
> > +	*val = oom_free_timeout_ms;
> > +	return 0;
> > +}
> > +
> > +static int oom_free_timeout_ms_write(void *data, u64 val)
> > +{
> > +	if (val > 60 * 1000)
> > +		return -EINVAL;
> > +
> > +	oom_free_timeout_ms = val;
> > +	return 0;
> > +}
> > +DEFINE_SIMPLE_ATTRIBUTE(oom_free_timeout_ms_fops, oom_free_timeout_ms_read,
> > +			oom_free_timeout_ms_write, "%llu\n");
> > +#endif /* CONFIG_DEBUG_FS */
> 
> One of the several things I dislike about debugfs is that nobody
> bothers documenting it anywhere.  But this should really be documented.
> I'm not sure where, but the documentation will find itself alongside a
> bunch of procfs things which prompts the question "why it *this* one in
> debugfs"?
> 

The only reason I have placed it in debugfs, or making it tunable at all, 
is to appease others.  I know the non-default value we need to use to stop 
millions of processes being oom killed unnecessarily.  Michal suggested a 
tunable to disable the oom reaper entirely, which is not what we want, so 
I found this to be the best alternative.

I'd like to say that it is purposefully undocumented since it's not a 
sysctl and nobody can suggest that it is becoming a permanent API that we 
must maintain for backwards compatibility.  Having it be configurable is 
kind of ridiculous, but such is the nature of trying to get patches merged 
these days to prevent millions of processes being oom killed 
unnecessarily.

Blockable mmu notifiers and mlocked memory is not the extent of the 
problem, if a process has a lot of virtual memory we must wait until 
free_pgtables() completes in exit_mmap() to prevent unnecessary oom 
killing.  For implementations such as tcmalloc, which does not release 
virtual memory, this is important because, well, it releases this only at 
exit_mmap().  Of course we cannot do that with only the protection of 
mm->mmap_sem for read.

This is a patch that we'll always need if we continue with the current 
implementation of the oom reaper.  I wouldn't suggest it as a configurable 
value, but, owell.

I'll document the tunable and purposefully repeat myself that this is 
addresses millions of processes being oom killed unnecessarily so the 
rather important motivation of the change is clear to anyone who reads 
this thread now or in the future.  Nobody can guess an appropriate value 
until they have been hit by the issue themselves and need to deal with the 
loss of work from important processes being oom killed when some best 
effort logging cron job uses too much memory.  Or, of course, pissed off 
users who have their jobs killed off and you find yourself in the rather 
unfortunate situation of explaining why the Linux kernel in 2018 needs to 
immediately SIGKILL processes because of an arbitrary nack related to a 
timestamp.

Thanks.
