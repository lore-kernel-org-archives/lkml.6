Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18448C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8ED2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qSyLwTef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8ED2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbeGST3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:29:18 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33216 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeGST3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:29:18 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so3672048ybb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 11:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KT+qQrhkPOdj9KSwdKORNY3MjeHa+bwmY9V62UKACe4=;
        b=qSyLwTefz1F9TPIo0gk+DUZXG4yRjqXcQZsvLgEKB+sNMIr5swUVfQ7adGSohUr8vp
         KZmO+M123GTQ/EkbtgtPJB7lxuPiMt8t/5XzWrBi33+7gqvPtrAYf3tdQ718nSjj8WPD
         i51upaQ/EQYRix520UiB8CSUMwv+85YBF+D/k2rkuUM/+rj7Z06WDvrPe7H4aWiUYj+e
         NZ/xSqe0h+aPLr/52Fv3Cyq4nuTkVNqSglK/FBoPPMBUMlUT/myRJ2UN8cKsv9QJ6g1j
         nSE0jo4ufIALI3oF+iYhTht4YMH9tecf59oZlZu35arj4AmZZqkYwop1csWp+wjOz+e+
         ySoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KT+qQrhkPOdj9KSwdKORNY3MjeHa+bwmY9V62UKACe4=;
        b=biMb7GyDvQQuoisWk5hCogkrm/5eXljl6hqAOkVR/P/BN+lgzl26VxqRq18BOytnC5
         TKgibRRxzum6DdzFsb5z2uJIWXqw1s8PtSi1guVoPf9SrSKcJbaFKwLLMB5nmGxG+7Eh
         Kvy/8Y0IxQCogPFYNFDfqCbKqMH1hU6iglb7ovz+X27CcjdTUxePjOlCZJZ/iDRR4CYQ
         4MiRASATWMPcJf/9IzJecmm21Pi5l/rQUDQ6OX5aiIl8xSjfnghiAJMssKe6C9I2fHJ1
         DBzXde4PedDcjGBzvRphRENZNHAaLyVoMA5ytiiP9fTF7M3f0EG81KomicKQNT1I0iCR
         Ia7Q==
X-Gm-Message-State: AOUpUlEDwEBaK2UiOKB/HliLdX/teSN9+WRbjTK9l5cZlajSZ7w8EKfz
        0JMrHuEy5Wnr8AEwu7Bv4jy/+g==
X-Google-Smtp-Source: AAOMgpcU8WfabDS3CWKBM4oiIbdqs5UCg5TSmTi90D+8RfHGFRCBkYiQD2RrhSoU1PM/ag6X8T05Wg==
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr6310111ybz.410.1532025892747;
        Thu, 19 Jul 2018 11:44:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:3a18])
        by smtp.gmail.com with ESMTPSA id b135-v6sm5813939ywh.24.2018.07.19.11.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 11:44:51 -0700 (PDT)
Date:   Thu, 19 Jul 2018 14:47:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180719184740.GA26291@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718120318.GC2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718120318.GC2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 02:03:18PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > +	/* Update task counts according to the set/clear bitmasks */
> > +	for (to = 0; (bo = ffs(clear)); to += bo, clear >>= bo) {
> > +		int idx = to + (bo - 1);
> > +
> > +		if (tasks[idx] == 0 && !psi_bug) {
> > +			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d idx=%d tasks=[%u %u %u] clear=%x set=%x\n",
> > +					cpu, idx, tasks[0], tasks[1], tasks[2],
> > +					clear, set);
> > +			psi_bug = 1;
> > +		}
> 
> 		WARN_ONCE(!tasks[idx], ...);

It's just open-coded because of the printk_deferred, since this is
inside the scheduler.

It actually used to be a straight-up WARN_ONCE() in older
versions. Recursive scheduling bugs are no fun to debug ;)
