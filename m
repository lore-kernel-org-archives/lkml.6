Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F9EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243102088F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpSkkcR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243102088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeILPBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:01:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52590 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeILPBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:01:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id y139-v6so1671039wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/w+RZ6oitCiPc722zWO6Di1OkqxrJozKz5a6QgXVw8s=;
        b=RpSkkcR8VDT9cpdAQwgdxHEInJGL87M3ihex2Rj5YfOoCAoYmgasyt0kkNWz8nWUIh
         r04bqvynegKVrcY9hP6oYhxVCxMMVS02F8ZTL8QBdVu1CZFVINEVtegXWxzbKsHFxXnY
         j/3wfCe0RIa4etNVOXXdze5OVeEAIgAGhfN3c2mrlh/3xXLigF2U9I4xj6we7XO9i0ZA
         CC0Tk82l8E0SdVR5q61Noat0OlMSYWbQOuIkAxXyZZUy+lO4TTpw9xywzLs5e2tXsae4
         rIOjA7tMC8q0ec1mCkMvt4y30aAfodlIuiY+KqZLrH4FhdGGrEHn0MXSm+eXy9+c8Xba
         a2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/w+RZ6oitCiPc722zWO6Di1OkqxrJozKz5a6QgXVw8s=;
        b=iuemU0P/FkJaBbuurINFylH02ecP9OZBUGxnl0qvuIqUhu/eIUXTcZm7ogP2sm5duZ
         w4Z8z1VgH1lN2+1nrN2ZhlY0suHdMtdMIWMsw8oG/nwUMTN3gWOVEKnf4kSkZIeav6BD
         m0E2NqCF89oLdybq+XlH+pqTFvP6l1Bw8uvdFWCLc02V/k0B2Bp50fa0sCCYaahfMTfC
         qiVwaonpHUQl4HNWbQZ3GVeWSkTs6yLrgrkG629VM8CwAlphfPFVss1G+LGc6holQmXs
         Cg/3/Ua9jbUpi3LCr6+XMhjO0sooKz0XS1zkR8DOJ5GsAxpOijvr25bgrfXIRyRvL8KC
         QriA==
X-Gm-Message-State: APzg51C1TjPgF2jxDi4NT25Mx+lqMJ+YggrPaq3PdmNGzEvCREOBceiI
        SgEy+P4/8FrMeOa2TpPWwEAo+nWI
X-Google-Smtp-Source: ANB0VdbMZldqRTyUfJ3loSGOTgMGxFFGUBm0eZvpGyhv+5AsJHKoVcfu+IqYXWuNrPIqZh4LUANR7A==
X-Received: by 2002:a1c:32c4:: with SMTP id y187-v6mr1053055wmy.31.1536746265522;
        Wed, 12 Sep 2018 02:57:45 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x24-v6sm1149643wrd.13.2018.09.12.02.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:57:44 -0700 (PDT)
Date:   Wed, 12 Sep 2018 11:57:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Do not move imbalanced load purely on
 the basis of an idle CPU
Message-ID: <20180912095742.GA3333@gmail.com>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907101139.20760-5-mgorman@techsingularity.net>
 <20180907113309.GU24106@hirez.programming.kicks-ass.net>
 <20180907123739.GE1719@techsingularity.net>
 <20180910094147.GH1719@techsingularity.net>
 <20180912065410.GA5352@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912065410.GA5352@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> * Mel Gorman <mgorman@techsingularity.net> [2018-09-10 10:41:47]:
> 
> > On Fri, Sep 07, 2018 at 01:37:39PM +0100, Mel Gorman wrote:
> > > > Srikar's patch here:
> > > > 
> > > >   http://lkml.kernel.org/r/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> > > > 
> > > > Also frobs this condition, but in a less radical way. Does that yield
> > > > similar results?
> > > 
> > > I can check. I do wonder of course if the less radical approach just means
> > > that automatic NUMA balancing and the load balancer simply disagree about
> > > placement at a different time. It'll take a few days to have an answer as
> > > the battery of workloads to check this take ages.
> > > 
> > 
> > Tests completed over the weekend and I've found that the performance of
> > both patches are very similar for two machines (both 2 socket) running a
> > variety of workloads. Hence, I'm not worried about which patch gets picked
> > up. However, I would prefer my own on the grounds that the additional
> > complexity does not appear to get us anything. Of course, that changes if
> > Srikar's tests on his larger ppc64 machines show the more complex approach
> > is justified.
> > 
> 
> Running SPECJbb2005. Higher bops are better.
> 
> Kernel A = 4.18+ 13 sched patches part of v4.19-rc1.
> Kernel B = Kernel A + 6 patches (http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com)
> Kernel C = Kernel B - (Avoid task migration for small numa improvement) i.e
> 	http://lore.kernel.org/lkml/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> 	+ 2 patches from Mel
> 	(Do not move imbalanced load purely)
> 	http://lore.kernel.org/lkml/20180907101139.20760-5-mgorman@techsingularity.net
> 	(Stop comparing tasks for NUMA placement)
> 	http://lore.kernel.org/lkml/20180907101139.20760-4-mgorman@techsingularity.net

We absolutely need the 'best' pre-regression baseline kernel measurements as well - was it 
vanilla v4.17?

Thanks,

	Ingo
