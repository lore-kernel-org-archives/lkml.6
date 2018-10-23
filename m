Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01990C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80AE2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="itbAAzwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80AE2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeJXBx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:53:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35005 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbeJXBx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:53:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id a10-v6so2468324qtp.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p+GUZjTRskiLlmKpga5pTHMTouwhMfYvT279qB1hK60=;
        b=itbAAzwpNKBDUm2qri1EI6NDeyb6tJAFb0npG0uiL1Bq600UD6HkQpy+vxvjN4HUXB
         n83zpzv9aJikA4zNrmza5FkAr1idSFSEqp5RAeOi6YFUHJxwHcXX6pm0rQcGFCDv1AZw
         zcjNGkV488c3szCN7bC4kNlbtxWBnKjP6dNTnk5ETWDvVCyecCLmR0Cz+vwVb6vFKR8J
         kUdg65uNQrXS1rtZUQWPh7w+rZo0TX1NClFYees36oCx6xP7lSdUJ2uOUcT/4rzqMpNv
         SDRJ09r+Bcg1HbK24GY5pp02AGGs7At29N6iFDmRWrEp1RyDpp0niZ4FXKLHcuvr5zzR
         SqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p+GUZjTRskiLlmKpga5pTHMTouwhMfYvT279qB1hK60=;
        b=GM5HFGn9i4qE6VnqcKLAWpYtmh8cEYONI/OWBzIVwGPj/ilgDWFqFdW2dg/EUZW3my
         tdh16tj5pR7uRmknKmoxG0sCRo/5SF/8nI4U22yhVM+a4WDKh7G1K8vctcRxQy4yyatg
         almwaTVPnQPF8CNhGrCZ/Z8j6aN/RUwuTKO9Vk8B+Rs5+IEjXUMTwt8oF8sKLKJP3ABW
         DEyA0+5bLE+Yxx1deBCmfDw65+drwPEASw0IlagetjE9YuQEwlO24s3qFQjgURZcFxbX
         QP2Vyblc2rnG2A021ecBs9aTOzr9k2O76H0taZsGhQ1+u/FyIYNoWEnU2A6jH91tGFse
         U/ww==
X-Gm-Message-State: AGRZ1gIirm3niPuEpIDLnRvOhhYnd9mEEUDsya+SWwxsluM/KDP4jzI/
        VYS1Js8EBhEVvhGmVNaJ7c+mAw==
X-Google-Smtp-Source: AJdET5fyJw6mXg99ekIXHY1ylZISwJmmgE9mgBTfkvkets8V+Y2ZiBifNWgXLYifplxduyDyrfukaA==
X-Received: by 2002:ac8:7257:: with SMTP id l23-v6mr123525qtp.280.1540315777472;
        Tue, 23 Oct 2018 10:29:37 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id l28-v6sm1340308qkj.33.2018.10.23.10.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 10:29:36 -0700 (PDT)
Date:   Tue, 23 Oct 2018 13:29:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
Message-ID: <20181023172937.GA21443@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20181018190710.fcea1c5f9c3b0c15d37ee762@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018190710.fcea1c5f9c3b0c15d37ee762@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:07:10PM -0700, Andrew Morton wrote:
> On Tue, 28 Aug 2018 13:22:49 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > This version 4 of the PSI series incorporates feedback from Peter and
> > fixes two races in the lockless aggregator that Suren found in his
> > testing and which caused the sample calculation to sometimes underflow
> > and record bogusly large samples; details at the bottom of this email.
> 
> We've had very little in the way of review activity for the PSI
> patchset.  According to the changelog tags, anyway.

Peter reviewed it quite extensively over all revisions, and acked the
final version. Peter, can we add your acked-by or reviewed-by tag(s)?

The scheduler part accounts for 99% of the complexity in those
patches. The mm bits, while somewhat sprawling, are mostly mechanical.
