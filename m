Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9244BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D43E24053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YgLGF+qR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D43E24053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754221AbeGERG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:06:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37088 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754071AbeGERGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:06:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id n17-v6so12056418wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wpeJFQAXVQlH+H/mGB26++XrajgOrz307ujkuW3sBf8=;
        b=YgLGF+qRzi4Vw0pxQ4m+0grxEwKRb0Ko/qDEfzg2pbaqVupFCmN133YxwwgAU1Lfhr
         MtxR/+jzhXu1i8JB4HE4abpnBXqZPg8hDbVL+TiLIoLbdnIIjr8l86DwlX5ty6G9vUKJ
         Jw+boTxYAkzRq5OlBt9RdpuwDtIHXL03h6uuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wpeJFQAXVQlH+H/mGB26++XrajgOrz307ujkuW3sBf8=;
        b=qy+zRvyC3xyFbFhDyvYBGwlM7V7CwIEqHMA8I3zoCNaMU8ZTgSwE2kE1867WdBmwuJ
         q5EZrUhzbdAB++LoTT9OoAHJTsi0Y7D01JbEBTeqYmsBK0nd7HEoQKFRdUaqsDOdWuzj
         wg8DcxrgAf/9pJHR/E2AnBlB8K+T0BVU58FmDzFxZKmz7Ok48Hz1nq0WYjT0DyfJwvnW
         nA1MFg/mc2oaHAZmiG63xKm3IIFnr7tNmeT6VAFe/xtVO02kxOp6nzmdIYK/CSGXzHcN
         kpiT9GcHarrY53ZNePG1Gi5yFcnN9lVTjDIMWjBJ1IPthFxNznvTmVofiXXmBoWFEwhL
         Lcug==
X-Gm-Message-State: APt69E1iUAYofPH7MqoUiTub0Dy6FC8YbGV/eGVtcp8a48RVrOOakH3R
        4rZIFN0CORrl7zNNUsRHueCYZA==
X-Google-Smtp-Source: AAOMgpcLEBALWSR8EATKoVjyZzmpCR5r9/lNYICnqhq+B1qS3ZZbAFshUmomnXgYp+2FTVGoB7C5Uw==
X-Received: by 2002:a1c:9e8a:: with SMTP id h132-v6mr4462862wme.48.1530810408011;
        Thu, 05 Jul 2018 10:06:48 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4143349wrr.14.2018.07.05.10.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 10:06:47 -0700 (PDT)
Date:   Thu, 5 Jul 2018 19:06:36 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        dlustig@nvidia.com
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180705170636.GA2380@andrea>
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
 <20180705153140.GO3593@linux.vnet.ibm.com>
 <20180705153906.GA2345@andrea>
 <20180705165848.GR3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705165848.GR3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 09:58:48AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 05, 2018 at 05:39:06PM +0200, Andrea Parri wrote:
> > > > At any rate, it looks like instead of strengthening the relation, I
> > > > should write a patch that removes it entirely.  I also will add new,
> > > > stronger relations for use with locking, essentially making spin_lock
> > > > and spin_unlock be RCsc.
> > > 
> > > Only in the presence of smp_mb__after_unlock_lock() or
> > > smp_mb__after_spinlock(), correct?  Or am I confused about RCsc?
> > 
> > There are at least two definitions of RCsc: one as documented in the header
> > comment for smp_mb__after_spinlock() or rather in the patch under review...,
> > one as processor architects used to intend it. ;-)
> 
> Searching isn't working for me all that well this morning, so could you
> please send me a pointer to that patch?

Sorry, I meant in _this patch_: "RCsc" as ordering everything except for
W -> R, without the barriers above (_informally, the current LKMM misses
the W -> W order only).

  Andrea

> 
> 							Thanx, Paul
> 
