Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3356ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA1220870
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="clRff0t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA1220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeGMWbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:31:48 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:45834 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGMWbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:31:48 -0400
Received: by mail-yw0-f194.google.com with SMTP id 139-v6so12286668ywg.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 15:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HgM7KHro5Gn8WNFQAxB6p2phFCYiHpaJFw0eoGoMk8o=;
        b=clRff0t/LKxP2MAaKBPTBh6Qov9zX5p9iR/gHqVHyfMmhtD2h1qWXdpw0+wLNLY8a1
         gyeRVdlbeRgCMBW0JNzjxSLveVg4ZFYmX/Xy3qK443tfiRtUSLhKCJMhJhK6Y88culc2
         82lWFICVR9lA99h2Jd++55g0BBv7bMAYw4+SLWlNkMlLUeFBOqf1ynNNEU+Ms9in6A3R
         YpHSJRlqXWceApOimo2I8040rZApFcY1Lyx9IyQhuiHMMqbZnS3NFBQ66WYCT5wrcCXn
         2XfqXnPzZ4ENHl7nw44puDV/wNM5iVlTfZ020t7G/gyrwdI2b21o1UebTVdll5sJUxgN
         eFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HgM7KHro5Gn8WNFQAxB6p2phFCYiHpaJFw0eoGoMk8o=;
        b=uFWYzu5RosdbbvzQdIcuwuMIQPJLXU4XlYjM5vBT8JZDoCMfK4CpgEeAspFc6aM6wQ
         Zi1qxdNEYyJLLUKRo6FSKnjo11bEa9bWsFP0s1svg5tp7T220qkkRsO8UpacdtfQ29tR
         7C+KzaUTy9K3k860010Nc2lRUadK5r/mFAcMNFdlsv2jk3Sg90Qe0o/ke5BlqPTjw12F
         A5vY0RzQoKoadNVJerUYlm+ZS4TMiNmSmulN3Phdd/ljjeGLr+b5Mz9yQQZMdsvrlKaU
         7I4etWAutop44rNyngbRyPMJF70ZjaIVDrs0AUEFs8Tzgt/EEDcwimGYVZ72kgGpaZdx
         9X4w==
X-Gm-Message-State: AOUpUlFfqrpg1OwaeWRxqI1O3k/B55uUpEABCrt4ffuFE2K8fzQ3rJ84
        AG1DqoM6v6UPqUULYz+p4Kk2Fw==
X-Google-Smtp-Source: AAOMgpcpgrpila16ucxTJitXp2c2lsFvQHQJWBrYuiraFQKEg59T0D63lGaco9JYi9PFLPxVKMe0ig==
X-Received: by 2002:a81:2ac2:: with SMTP id q185-v6mr4290585ywq.190.1531520114498;
        Fri, 13 Jul 2018 15:15:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:23bd])
        by smtp.gmail.com with ESMTPSA id g188-v6sm2448033ywg.57.2018.07.13.15.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 15:15:14 -0700 (PDT)
Date:   Fri, 13 Jul 2018 18:17:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH 10/10] psi: aggregate ongoing stall events when
 somebody reads pressure
Message-ID: <20180713221758.GB30013@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-11-hannes@cmpxchg.org>
 <20180712164537.324caee21fd68c47a02af009@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712164537.324caee21fd68c47a02af009@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 04:45:37PM -0700, Andrew Morton wrote:
> On Thu, 12 Jul 2018 13:29:42 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > Right now, psi reports pressure and stall times of already concluded
> > stall events. For most use cases this is current enough, but certain
> > highly latency-sensitive applications, like the Android OOM killer,
> > might want to know about and react to stall states before they have
> > even concluded (e.g. a prolonged reclaim cycle).
> > 
> > This patches the procfs/cgroupfs interface such that when the pressure
> > metrics are read, the current per-cpu states, if any, are taken into
> > account as well.
> > 
> > Any ongoing states are concluded, their time snapshotted, and then
> > restarted. This requires holding the rq lock to avoid corruption. It
> > could use some form of rq lock ratelimiting or avoidance.
> > 
> > Requested-by: Suren Baghdasaryan <surenb@google.com>
> > Not-yet-signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> What-does-that-mean:?

I didn't think this patch was ready for upstream yet, hence the RFC
and the lack of a proper sign-off.

But Suren has been testing this and found it useful in his specific
low-latency application, so I included it for completeness, for other
testers to find, and for possible suggestions on how to improve it.
