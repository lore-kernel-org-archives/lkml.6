Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C99C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4C4214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ukNRTZQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4C4214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeHBOQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:16:54 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41971 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbeHBOQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:16:54 -0400
Received: by mail-qk0-f193.google.com with SMTP id n85-v6so1209965qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DCMyHA3qkDdppqTw/RcH7oFWVcJjBHKC8GDSBWiqQtM=;
        b=ukNRTZQVT3U4Phez9QF72NZQmJs6CgsjhoRmbbZKycNnC/voOfHJkjpyd53ruz9v04
         hQ83p9QjGY8DQog19IU5iTY9h61fl9V83yRFODCdbN0JPyxpt8yti9dr1QGBZfRXrV6P
         6Tw8v11zZPi7HkpZneIGe6pq60NH4eass6rp5kgnIg548A4Fcw3TDTkDihjy+x7F6Y89
         lqaUGBpUb/cIr2VufX2V5yf64YN/wm9G1j0lVTg7hD3nspwktFdmzi1EbY9HFCR3mmHW
         s3meXnysNjPPTF6ygSEK/3eyTG7PUKAP+eIZjvE+EyQsJ+IcPmJWe1vJjRZWqprdwaQB
         BENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DCMyHA3qkDdppqTw/RcH7oFWVcJjBHKC8GDSBWiqQtM=;
        b=doY7+GqsU86QRlDJMYJFq6TFSN0ojquaLQfAwRbuFlo4SzXX24qublLLR5Roi0ayzq
         46vTl7F28ijSliUQIOdK2r5rIlVXY4qBl3H3DWolfcQh6nflLPtCmTZTB2P8ju/AtdmZ
         oP4eEpbSJJZdDQss9nR6o40O/+5M9EYTJoBPg5JC4EJvSDDGITfniAQgSkp4UFDuVTmc
         Y7+hkPxCHx/7XuA3zWd8MO3ttY24HbNU4xOWqGTEFSiYTL/3Lb85JWgL/wfwo3TTcSzL
         +LfsKv0uSkf54aKglufaWbGVz5sFMoC51MRkRVKMIJ8jPqWUze+YFBH0WQWhwUMSgj6J
         HyZg==
X-Gm-Message-State: AOUpUlFXHQ+4YCmj2U+H2CtG1hrvZuJaslFDyuq5v0xhHA0Y7WQaGQg0
        xLlq7lHO5ZkcS7LXPeZs4yIa1Q==
X-Google-Smtp-Source: AAOMgpfpCjViLdQPwHog8tUIAA8eJOE8SQkeCe7J5t0J1kdKs+UAynsbmFEjIyGdLelEpgBFsh3lyw==
X-Received: by 2002:a37:dc41:: with SMTP id v62-v6mr2134824qki.109.1533212757132;
        Thu, 02 Aug 2018 05:25:57 -0700 (PDT)
Received: from localhost (pool-96-246-38-36.nycmny.fios.verizon.net. [96.246.38.36])
        by smtp.gmail.com with ESMTPSA id k38-v6sm1571918qtc.45.2018.08.02.05.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 05:25:56 -0700 (PDT)
Date:   Thu, 2 Aug 2018 08:28:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        linux-mm <linux-mm@kvack.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/9] mm: workingset: tell cache transitions from
 workingset thrashing
Message-ID: <20180802122852.GA17974@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-3-hannes@cmpxchg.org>
 <CAJuCfpGZGPD+k+jHDowWyvZPnUXzQ9n98wBycDZLAWOn=vV6Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGZGPD+k+jHDowWyvZPnUXzQ9n98wBycDZLAWOn=vV6Ew@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suren,

On Wed, Aug 01, 2018 at 02:56:27PM -0700, Suren Baghdasaryan wrote:
> On Wed, Aug 1, 2018 at 8:19 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> >         /*
> > -        * The unsigned subtraction here gives an accurate distance
> > -        * across inactive_age overflows in most cases.
> > +        * Calculate the refault distance
> >          *
> > -        * There is a special case: usually, shadow entries have a
> > -        * short lifetime and are either refaulted or reclaimed along
> > -        * with the inode before they get too old.  But it is not
> > -        * impossible for the inactive_age to lap a shadow entry in
> > -        * the field, which can then can result in a false small
> > -        * refault distance, leading to a false activation should this
> > -        * old entry actually refault again.  However, earlier kernels
> > -        * used to deactivate unconditionally with *every* reclaim
> > -        * invocation for the longest time, so the occasional
> > -        * inappropriate activation leading to pressure on the active
> > -        * list is not a problem.
> > +        * The unsigned subtraction here gives an accurate distance
> > +        * across inactive_age overflows in most cases. There is a
> > +        * special case: usually, shadow entries have a short lifetime
> > +        * and are either refaulted or reclaimed along with the inode
> > +        * before they get too old.  But it is not impossible for the
> > +        * inactive_age to lap a shadow entry in the field, which can
> > +        * then can result in a false small refault distance, leading
> 
> "which can then can" - please remove one of the "can".

Good catch, will fix.
