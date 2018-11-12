Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DBEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED5A21780
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTAH6fQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED5A21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbeKLPX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:23:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46628 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbeKLPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:23:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id 74-v6so7817081wrb.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OTIRveiOjC8fzLFygIGVh61OudQJly+kRua8jx4o5yI=;
        b=aTAH6fQbd0avr5qYlHySAcrBo5QSVxORa9UMAmvcbBzcrPi4CWj28rU61luXF7Ay23
         8Rwq0wx8+WxdJskqVL4N47syE05U0fAfLS8HN5d56R1Z2mJk7m7eiFJYTUmc3H8PqWxH
         137CAXEa5MShzeLaA0rscULfOQw7sm4H3LtGIi2CTkmO8TABletDJjvK7BHlSl2Bf9aN
         1QEoFu/qZFxUA/G5VPSKfzWcaX2yo0dyHIjQAuIyjWR4ZCXG+gymwrzbX+h9RnfgllYO
         C6po8UPemAHXTURwyMhH23l2dvqFJ6wyxpeA3f9YTpz41+Qo/ZjjZxYjb0Vm2VcqZiOZ
         rJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OTIRveiOjC8fzLFygIGVh61OudQJly+kRua8jx4o5yI=;
        b=ac0q+G6kLsLVKlSnKi5xE8ZSIPuvreqJi8ytUEpZWEl73bKuhIlO90l79ZzqxOSw12
         hxSjPp/2Xbidn+zXgMSeyQI89/pscoNrNQ9Bp4Nc5H3qH5GVZFaTiq+STx6l2ZDkx0Vc
         sszaY9ucyk/euzB3EK6Cd5GD5U58zJfHRobeio4zHetYwnCMYR/r+w3i+LuSudsri8tn
         0t6Tp+EUuuRs/WWWCy9kEB0kt+Z5YFaIHsj9ygbUDd82tgwmdBShY+xEwcGEpcd1ny6K
         ue3Pr75Wx21uDIiBgiSN9iK9ckWYeGXF2K1rtDauRYE2B9g3q3Yq9RT68it//uL6fmBG
         KL4A==
X-Gm-Message-State: AGRZ1gLmt9y9Jp2EIoGpGkKHFPeuX0eUtBAq1l6xaf/+1eT/d5k93cOG
        NwRiC0iu/OefjDFVkD6XZeM=
X-Google-Smtp-Source: AJdET5dyQi+k9840Uc4YbKgWXiIarDFV7BlJJq6MfsnZettn+UzJLQqgELTmcddK445O5TQv9ga5sA==
X-Received: by 2002:a5d:4182:: with SMTP id m2-v6mr17168700wrp.8.1542000710875;
        Sun, 11 Nov 2018 21:31:50 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q20-v6sm7204047wmc.33.2018.11.11.21.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 21:31:50 -0800 (PST)
Date:   Mon, 12 Nov 2018 06:31:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v1 2/2] proc: add /proc/<pid>/thread_state
Message-ID: <20181112053147.GA78520@gmail.com>
References: <1541528590-30296-1-git-send-email-aubrey.li@intel.com>
 <1541528590-30296-2-git-send-email-aubrey.li@intel.com>
 <20181108063246.GA13233@gmail.com>
 <20181108101729.GP9761@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108101729.GP9761@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Nov 08, 2018 at 07:32:46AM +0100, Ingo Molnar wrote:
> > 
> > * Aubrey Li <aubrey.li@intel.com> wrote:
> > 
> > > Expose the per-task cpu specific thread state value, it's helpful
> > > for userland to classify and schedule the tasks by different policies
> > 
> > That's pretty vague - what exactly would use this information? I'm sure 
> > you have a usecase in mind - could you please describe it?
> 
> Yeah, "thread_state" is a pretty terrible name for this. The use-case is
> detectoring which tasks use AVX3 such that a userspace component (think
> job scheduler) can cluster them together.

I'd prefer the kernel to do such clustering...

Thanks,

	Ingo
