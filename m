Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C21E20877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKvgMznO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C21E20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeGQEpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:45:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44454 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeGQEpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:45:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id k21-v6so2471608pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QlpvFHK8aHZhIPNe3gj8CUGLLWno8RSEqV69yA+7fPg=;
        b=IKvgMznOi1AuC44Re2wJ1ffS/gLU8WCOdnm0unSdKPJrqisiQGpE/Wg8Vcb5LiT4+d
         RA0ceRNpX2wqCaKTGrpDaltU85AhwFIu6rB8gjNB8AOQgHPjZ6+vETjX/UlyHlhd0yfo
         tioITRj7v5dD7E37GiwxR/lgwTqh/viviDnCADHAIV5m0mNPcK2LDVMAazHAJDfSwwnA
         7h1QR69pEQibbw+UFh+gaPUDaKrW5fW0eIfVr59bkb/wuyrxVH/aCcJKRl0ZFTmUhmYS
         OVf3CKFu7u2bd1KPoIOXlc8Nswhs7QvJ/tOJEUyVDcd+TXRQvXXaYYN7fNMQKU4GIPH7
         W86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QlpvFHK8aHZhIPNe3gj8CUGLLWno8RSEqV69yA+7fPg=;
        b=efc2/3wR8mnMdNbAprD4QkrVcpMFV8rH8JBeKjA53UGcIEX9FSU4GAyU18C7LtMPxJ
         FgVR8TevW9t9l7Uo1p08OOegAOfUurOCdT1fUoIknqkV4n8jO9MMtHrhYcshhWo01FOw
         4iCIswdQKrgfFgL0Utidfp/mbClvanlEpn4wV4MakdlhdXDna67YvWkPwooXisZtADkj
         EqyOYzAla7S5OuFUKG30bMQWjbQqnbACaZDd8w8xvf+hXs//o0uGstGbIPdVq+/xAgZW
         DZqCAwJCePeOt3SzAg9CzMMXysF3DqF/XjEb8G/KEIWqOTJFnA/9NZNL+l0oWhlZlJz0
         EKMw==
X-Gm-Message-State: AOUpUlGZI1FtD8GzkDgU03okCiE/JJZR3S/qpRQdqtWm/L2KDY0Y1vA6
        GStXlQS62L4+I6lkmjYY94RGyA==
X-Google-Smtp-Source: AAOMgpe2u1QivY/2sDYzGfpjBpvBd6Eled95IuxNBLIONTLl0AsuAeukA5E04Hu/ItQpV6bavHdz+A==
X-Received: by 2002:a63:8dca:: with SMTP id z193-v6mr5627pgd.228.1531800871059;
        Mon, 16 Jul 2018 21:14:31 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 16-v6sm11885341pfo.164.2018.07.16.21.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:14:30 -0700 (PDT)
Date:   Mon, 16 Jul 2018 21:14:29 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm] mm, oom: remove oom_lock from exit_mmap
In-Reply-To: <20180713142612.GD19960@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1807162111490.157949@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1807121432370.170100@chino.kir.corp.google.com> <20180713142612.GD19960@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018, Michal Hocko wrote:

> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 0fe4087d5151..e6328cef090f 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -488,9 +488,11 @@ void __oom_reap_task_mm(struct mm_struct *mm)
> >  	 * Tell all users of get_user/copy_from_user etc... that the content
> >  	 * is no longer stable. No barriers really needed because unmapping
> >  	 * should imply barriers already and the reader would hit a page fault
> > -	 * if it stumbled over a reaped memory.
> > +	 * if it stumbled over a reaped memory. If MMF_UNSTABLE is already set,
> > +	 * reaping as already occurred so nothing left to do.
> >  	 */
> > -	set_bit(MMF_UNSTABLE, &mm->flags);
> > +	if (test_and_set_bit(MMF_UNSTABLE, &mm->flags))
> > +		return;
> 
> This could lead to pre mature oom victim selection
> oom_reaper			exiting victim
> oom_reap_task			exit_mmap
>   __oom_reap_task_mm		  __oom_reap_task_mm
> 				    test_and_set_bit(MMF_UNSTABLE) # wins the race
>   test_and_set_bit(MMF_UNSTABLE)
> set_bit(MMF_OOM_SKIP) # new victim can be selected now.
> 

This is not the current state of the code in the -mm tree: MMF_OOM_SKIP 
only gets set by the oom reaper when the timeout has expired when the 
victim has failed to free memory in the exit path.

> Besides that, why should we back off in the first place. We can
> race the two without any problems AFAICS. We already do have proper
> synchronization between the two due to mmap_sem and MMF_OOM_SKIP.
> 

test_and_set_bit() here is not strictly required, I thought it was better 
since any unmapping done in this context is going to be handled by 
whichever thread set MMF_UNSTABLE.
