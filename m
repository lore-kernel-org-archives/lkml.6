Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFBAECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98E320661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKd/Q5pA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98E320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbeGTVJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:09:51 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:45083 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbeGTVJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:09:51 -0400
Received: by mail-pl0-f46.google.com with SMTP id 94-v6so5631773ple.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Tnx9P5KGceNoyiA0P8tZAW3VLDN0abPVOLZ3EQElqFw=;
        b=aKd/Q5pANHCJ18E/PS0V0st+ypnLynqCMIq+MVKmC6M4dblmcUSaWyX02ccP4mS5nT
         xA3DJjQTiPGZdsADiKuCwtGiFxlnEvHe+qLltsfDamhVZFspToZ7WQ7F4TSIbgdW/wXS
         xqQ9AsMwj13bViKNwLcqtdJF+BZYzHmwKdbvXF4EBEG92r6AaTc58sxyg1eJ3tdkKfVR
         FgAKnP8nIM2pKTIb9w+csxdyzptG9UuIlOr8i1WAB3l0DszlTkI+x2zkTs63br4SqXVZ
         /3wljpLmRN7KSZPDyfk0jAQF2almlU039AjV5ltOc4Dioke7UPpI0ukClKxr38WKGngz
         sTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Tnx9P5KGceNoyiA0P8tZAW3VLDN0abPVOLZ3EQElqFw=;
        b=SvcM2GME4zzDD/eL9ePmYcpdxSeXomK5BkCEcQe4djt0KBLQGb3x7oDq3I3sksXwSQ
         1yvaSRt4GbKnx3OvFtTw2lZOt7gGQU/vLbg2IyQxqVDkelh2saxXExA3xyYmkdo46Uup
         ojW4AIIA7s/dfLYa0lmryEm3oOMsj7e3VYJ+muTU+UQTYVWtoc6vSn7Zfm6TqWjiHRRu
         TkeDD96Brd4eHkGYsxYgNl37dWM4JwaNkR4h8Dar9+J9agRLw3sHBweWCaDxZoMYLNPu
         h8Qb6Tfbad6GfGuOzEJD2N1ULz8TRoZamlopwmTL1CwhxH+lGw27UXbCiukecjB5y9GL
         ue6w==
X-Gm-Message-State: AOUpUlFppn2dFBA0F9FtdXKyc49c8cnYgDoWNS/wMHrRZSN8568dL6PB
        gj6bxnTWjExqaot8IQOqkLfUFg==
X-Google-Smtp-Source: AAOMgpep02ZC04I9H6nhywTf9cYRmR72fv+q7YrnzFfovn/3ODz+XMyQqVDt0EOMrB16HevksHlqrw==
X-Received: by 2002:a17:902:9302:: with SMTP id bc2-v6mr3417611plb.280.1532118000312;
        Fri, 20 Jul 2018 13:20:00 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n5-v6sm3439392pgr.24.2018.07.20.13.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 13:19:59 -0700 (PDT)
Date:   Fri, 20 Jul 2018 13:19:59 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <9ab77cc7-2167-0659-a2ad-9cec3b9440e9@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1807201315580.231119@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com> <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807181317540.49359@chino.kir.corp.google.com> <a78fb992-ad59-0cdb-3c38-8284b2245f21@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807200133310.119737@chino.kir.corp.google.com> <9ab77cc7-2167-0659-a2ad-9cec3b9440e9@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018, Tetsuo Handa wrote:

> > Absent oom_lock serialization, this is exactly working as intended.  You 
> > could argue that once the thread has reached exit_mmap() and begins oom 
> > reaping that it should be allowed to finish before the oom reaper declares 
> > MMF_OOM_SKIP.  That could certainly be helpful, I simply haven't 
> > encountered a usecase where it were needed.  Or, we could restart the oom 
> > expiration when MMF_UNSTABLE is set and deem that progress is being made 
> > so it give it some extra time.  In practice, again, we haven't seen this 
> > needed.  But either of those are very easy to add in as well.  Which would 
> > you prefer?
> 
> I don't think we need to introduce user-visible knob interface (even if it is in
> debugfs), for I think that my approach can solve your problem. Please try OOM lockup
> (CVE-2016-10723) mitigation patch ( https://marc.info/?l=linux-mm&m=153112243424285&w=4 )

The issue I am fixing has nothing to do with contention on oom_lock, it 
has to do with the inability of the oom reaper to free memory for one or 
more of several reasons: mlock, blockable mmus, ptes, mm->mmap_sem 
contention, and then the setting of MMF_OOM_SKIP to choose another victim 
before the original victim even reaches exit_mmap().  Thus, removing 
oom_lock from exit_mmap() will not fix this issue.

I agree that oom_lock can be removed from exit_mmap() and it would be 
helpful to do so, and may address a series of problems that we have yet to 
encounter, but this would not fix the almost immediate setting of 
MMF_OOM_SKIP that occurs with minimal memory freeing due to the oom 
reaper.
