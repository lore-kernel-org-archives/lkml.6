Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BFBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866F920836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549869128;
	bh=SurXBioIG9bkykEJHB2uJy37R8++tidaJ+mZDARg9wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IST7Q60Oe3fFC/zsM4OzR3LpwAShL5QkT+4syN+rVBq5eI+mkhvKU2QqbnspbVe3d
	 vy7w0AYySL7OcCiOqvyuDezQvWw6jenAlZERTheJiqMItuEry+lXkCbNDOi4X+5Cx6
	 qx5SUYU+7TRd/ryop5R46dVXGmOiF1U7+CndGUx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfBKHMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:12:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52426 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfBKHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:12:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so15356359wml.2;
        Sun, 10 Feb 2019 23:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BK4Sm1vYAP/cUQnaGA8IV1A1wXMg4Z4Mq4IDBe+5Fz0=;
        b=iLc0oI6v6Cc382OU0fdlNtw/4hwzwv60nfBQ5KbKbVaS4A61E93cSWC8jo2x/WEl1a
         /7iNgiNDbixuFiTPVQxi8pc+/7fGx7pcuID+pMESwbpBB58ja3pRwNYGtoteTRn6cyHX
         VckXzbs5q4+RkIKdXXafDtC0IPMQNYgZCtrdvLgHeBBkHD9tEw/VRJq1p441jPtIqSIQ
         IJ/q1mwZcAvFB2yG85C6ntvl+UYgPG+r8dkD4WtUr93nSoN1GOE9cAmp6aCYRXO1Q3Ue
         sMgUko0pVzP2JoCJuinZBMQqE+COBfHkCMgJfh+JRAGW8JHu+EFVr4Ml2wOSRNsdda4K
         M0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BK4Sm1vYAP/cUQnaGA8IV1A1wXMg4Z4Mq4IDBe+5Fz0=;
        b=aXPXTWepw5C65YSO0Z+hGaqGpQzvlwB3K2G9pWJr3O9RNLjmnMnlTCXDZfBjKTQUI4
         D4RA7MMTU98ZelE9Qm4sj7wfAEdzXni/CtiVODeo5EZnsweOcmnryP0hEVW9wF552IcV
         JWGEeGqOTuYXCuEMAoxsLF2UMRRAm2BSgNJ5fTfwpHJ0zSnqVwm2vBsn1YNW0Cy3e2Iu
         DCBUIh6FI51EqIhYa8LXsWJbtdwA0KjM2f+g4CBx0Q4b3FeHl+QfTX1WqB1rdxljFx5V
         H+q8Navkcsz66wXXy9XN2Af91OtUbaFAsVdp1lE93T0kOfz2iU8QjCIZ++Kd1SKdgc2M
         q5XQ==
X-Gm-Message-State: AHQUAubFmIH3IM22xxWk3ZnjVjeN3JNUM7vXFDEY8Sj58FISjCVjmFL2
        PF4b2OonTZqPL/TgxGKoKDZVZ2gL
X-Google-Smtp-Source: AHgI3IYKyZH/baZMa5ziJeeQ06x4xxi+rhZ/xrB3f4ycB4qyp+lAO8FS4iZNzqjB6VFbBo/ZmJWgew==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr24796464wrj.91.1549869123278;
        Sun, 10 Feb 2019 23:12:03 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a184sm9956832wmh.37.2019.02.10.23.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 23:12:02 -0800 (PST)
Date:   Mon, 11 Feb 2019 08:11:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211071159.GA55579@gmail.com>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> On 02/10/2019 09:00 PM, Waiman Long wrote:
> > As the generic rwsem-xadd code is using the appropriate acquire and
> > release versions of the atomic operations, the arch specific rwsem.h
> > files will not be that much faster than the generic code as long as the
> > atomic functions are properly implemented. So we can remove those arch
> > specific rwsem.h and stop building asm/rwsem.h to reduce maintenance
> > effort.
> >
> > Currently, only x86, alpha and ia64 have implemented architecture
> > specific fast paths. I don't have access to alpha and ia64 systems for
> > testing, but they are legacy systems that are not likely to be updated
> > to the latest kernel anyway.
> >
> > By using a rwsem microbenchmark, the total locking rates on a 4-socket
> > 56-core 112-thread x86-64 system before and after the patch were as
> > follows (mixed means equal # of read and write locks):
> >
> >                       Before Patch              After Patch
> >    # of Threads  wlock   rlock   mixed     wlock   rlock   mixed
> >    ------------  -----   -----   -----     -----   -----   -----
> >         1        27,373  29,409  28,170    28,773  30,164  29,276
> >         2         7,697  14,922   1,703     7,435  15,167   1,729
> >         4         6,987  14,285   1,490     7,181  14,438   1,330
> >         8         6,650  13,652     761     6,918  13,796     718
> >        16         6,434  15,729     713     6,554  16,030     625
> >        32         5,590  15,312     552     6,124  15,344     471
> >        64         5,980  15,478      61     5,668  15,509      58
> >
> > There were some run-to-run variations for the multi-thread tests. For
> > x86-64, using the generic C code fast path seems to be a liitle bit
> > faster than the assembly version especially for read-lock and when lock
> > contention is low.  Looking at the assembly version of the fast paths,
> > there are assembly to/from C code wrappers that save and restore all
> > the callee-clobbered registers (7 registers on x86-64). The assembly
> > generated from the generic C code doesn't need to do that. That may
> > explain the slight performance gain here.
> >
> > The generic asm rwsem.h can also be merged into kernel/locking/rwsem.h
> > as no other code other than those under kernel/locking needs to access
> > the internal rwsem macros and functions.
> >
> > Signed-off-by: Waiman Long <longman@redhat.com>
> 
> I have decided to break the rwsem patchset that I sent out on last
> Thursday into 3 parts. This patch is part 0 as it touches a number of
> arch specific files and so have the widest distribution. I would like to
> get it merged first. Part 1 will be patches 1-10 (except 4) of my
> original rwsem patchset. This part moves things around, adds more
> debugging capability and lays the ground work for the next part. Part 2
> will contains the remaining patches which are the real beef of the whole
> patchset.

Sounds good to me - I've merged this patch, will push it out after 
testing.

Thanks,

	Ingo
