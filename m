Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBB5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B4120666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQUxJMw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B4120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJCBip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:38:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36331 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeJCBio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:38:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id n23-v6so3223695wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7OX2FKpRpwJ5//TX7qQawxC9lPW5jvwnOTTCtKw9BYk=;
        b=ZQUxJMw30aQKshkVjkHWJd0DUuSTSITo6Vwy5kr6RxfiM9I2a7spvxL32x0TNuKfgC
         NMfgQNjeDELFjZ8DEItvtyM0NOkMTnjpNlkA208y0tPlvr/faRmjEBjngiuWOC2grgC4
         AYB6XTq0GsXNtzMS4EW7iNScKiE7fGMK6VMf6kwgmtJ8jqaDY48fNUzpyHNAZ6haP/Jr
         k/I61jLHptpIPgUbgYBZQ8S1q47XiORxC4SIx0iyzlJJ0ihkBmfeCOZsaT9/Ig1SzaiW
         gMsk33sv1EsLEJxVkX1h2ALlMsPckiCFPe8YCSX+/r8p+NV4qIURWGHRGhwKNsfd76c9
         izAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7OX2FKpRpwJ5//TX7qQawxC9lPW5jvwnOTTCtKw9BYk=;
        b=DPC4NxmPzCdqxemO6t7e725RhkxsyKWLeu/P+2f7rz2G+/mw0cKWjjKQuF2PBkGt+h
         P0sSQeZIbYuBXy7o05Be8vka2GDEOKZr6ZEFHaLwCD70fq+GMGuA1I0JGejpdSVs8GFH
         PtJ2sHS7/ZKMFRWewme2D8maXZwmskTjOOcmvPvFabP5Uh1lw7e7hkGbDlDGILgiT1Ak
         O8Ui97mRVE68fhdjwNKNmkYc+JZHsxfl9cJh1tg6yWg3kSpm0VD4clCnvVwXlLo0uCy7
         IIpaKadbhEuWAuAj5iNU/1x4dU6QWOHvZim1/53YYD616Q6g9m4+5ncPzb6OEU8Up562
         F92A==
X-Gm-Message-State: ABuFfoi2ViJb9iuZj7mf+1vgzbJhIltZjzqUGjLZmiLKo3ZRdoi+PN1G
        9m+PDWXo3yUDlv0UwvxP0rU=
X-Google-Smtp-Source: ACcGV60Oi1GgjZkpLPT01iFneCuNAwHuUbq6V4ERXtIK7kaRm+dyaaDMPhT1nKYToxwtfznKJDEVEA==
X-Received: by 2002:a1c:2681:: with SMTP id m123-v6mr2573541wmm.129.1538506436369;
        Tue, 02 Oct 2018 11:53:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 185-v6sm16842961wmy.38.2018.10.02.11.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 11:53:55 -0700 (PDT)
Date:   Tue, 2 Oct 2018 20:53:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/5] locking/lockdep: Make class->ops a percpu counter
Message-ID: <20181002185353.GA36596@gmail.com>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
 <1538157201-29173-5-git-send-email-longman@redhat.com>
 <20181002093907.GV3439@hirez.programming.kicks-ass.net>
 <20181002095543.GA55344@gmail.com>
 <dbc5a70a-91bb-d365-8977-2d88049e39bb@redhat.com>
 <20181002142809.GH26858@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002142809.GH26858@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Oct 02, 2018 at 10:10:48AM -0400, Waiman Long wrote:
> > One alternative is to group it under CONFIG_DEBUG_LOCKDEP again. This
> > metric was originally under CONFIG_DEBUG_LOCKDEP, but was moved to
> > CONFIG_LOCKDEP when trying to make other lock debugging statistics
> > per-cpu counters. It was probably because this metric is per lock class
> > while the rests are global.
> > 
> > By doing so, you incur the memory cost only when CONFIG_DEBUG_LOCKDEP is
> > defined.
> > 
> > What do you think?
> 
> Works for me.

Sounds good to me too!

Thanks,

	Ingo
