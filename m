Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A82C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F9720854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5L+j/fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F9720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbeJEFui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:50:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42983 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeJEFui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:50:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so3810132pgq.9;
        Thu, 04 Oct 2018 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oUCuOszvOFqzUM8ixvg4fz6Wi0TCsbgm64iOKKej0Nk=;
        b=e5L+j/fwuID4d2KXPAl7SJ2dLCC3ihDpREEfxtKrQw1faijN8tk4sFJeuaH8TulCPG
         tSGcgr+teQHH/eDSaJCWLZz2Zyz9SfdkR7l5b+WJXB3asTbBRVuEwml+pxfKMFmkOgNo
         8CB9BHjOv50+TvAWLbAZPXZZij2qRN+T2e1ahva+vNFe3mqq+7S1RB12KOlu2ezSEbN5
         nDgf2xIGXdzhc0gm9Ze+TRorQwffr0WDyItCAX10netcLdfZMcceUUvVXXAPYsqdie1w
         vfJoAcYXmgBHO9TrcMZv1rjX5cFTaV1ttsaLo9YA/TdaJFHQlrs28iMgH95v9U9hqZFj
         Gzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oUCuOszvOFqzUM8ixvg4fz6Wi0TCsbgm64iOKKej0Nk=;
        b=f7XXcIxYTjlOr1CB01YzVkNl41zsOiZSnwnztfhCDVF6shTI7qHP1ZF4THcjsfZT2n
         xQhK2j+WVDvEefHmqVX9lhCELCCbRHVTuSvHOZ1l/tVdh205eIHDNG7PGY1yMIvywaZJ
         cVXfSDVRn3IH6J4TnNwqVLo8wOKycADwqaySF+MOzp144egnqZkyX8nEF+OJsgqvkSL5
         RY1AXUOfNY5oFgXK86sTwpR8iC4GsACkD7iEun3rM9M86jt3lUcAK8MwQCKP0/49S48p
         tKo3jUP6KR+nHHnB37nUt1vFX3ayqpMAWhWDFfqEmye/0s4oxx4h/PXqIGPmAjhTlKQR
         +qAA==
X-Gm-Message-State: ABuFfohYEOA9msaKcr+Ot7KERqneh/VQmfp/8omt7pPp+1ISZOllgW2Q
        mYujACqX2SaHqXcVLtOXQZo=
X-Google-Smtp-Source: ACcGV60LKG1T3f9tUOr+fzXIKuiKuaSqslPswkLwoQM0eNKCxwZKpQimcZch4jNvnH2ZGBL8ImMAdQ==
X-Received: by 2002:a62:425b:: with SMTP id p88-v6mr8930472pfa.96.1538693699147;
        Thu, 04 Oct 2018 15:54:59 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q76-v6sm10592452pfa.18.2018.10.04.15.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 15:54:57 -0700 (PDT)
Date:   Thu, 4 Oct 2018 15:54:55 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: mousedev - add a schedule point in
 mousedev_write()
Message-ID: <20181004225455.GC233675@dtor-ws>
References: <20181004154749.111595-1-edumazet@google.com>
 <20181004185949.GA233675@dtor-ws>
 <20181004193407.GK2674@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004193407.GK2674@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 12:34:07PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 04, 2018 at 11:59:49AM -0700, Dmitry Torokhov wrote:
> > Hi Eric,
> > 
> > On Thu, Oct 04, 2018 at 08:47:49AM -0700, Eric Dumazet wrote:
> > > syzbot was able to trigger rcu stalls by calling write()
> > > with large number of bytes.
> > > 
> > > Add a cond_resched() in the loop to avoid this.
> > 
> > I think this simply masks a deeper issue. The code fetches characters
> > from userspace in a loop, takes a lock, quickly places response in an
> > output buffer, and releases interrupt. I do not see why this should
> > cause stalls as we do not hold spinlock/interrupts off for extended
> > period of time.
> > 
> > Adding Paul so he can straighten me out...
> 
> If you are running a !PREEMPT kernel, then you need the cond_resched()
> to allow the scheduler to choose someone else to run if needed and
> to let RCU know that grace periods can end.  Without the cond_resched(),
> if you stay in that loop long enough you will get excessive scheduling
> latencies and eventually even RCU CPU stall warning splats.
> 
> In a PREEMPT (instead of !PREEMPT) kernel, you would be right.  When
> preemption is enabled, the scheduler can preempt and RCU can sense
> lack of readers from the scheduling-clock interrupt handler.  Which
> is why cond_resched() is nothingness in a PREEMPT kernel.
> 
> But because people run !PREEMPT as well as PREEMPT kernels, if that loop
> can run for a long time, you need that cond_resched().

OK, I see. I'll apply the patch then.

I think evdev.c needs similar treatment as it will keep looping while
there is data...

Thanks.

-- 
Dmitry
