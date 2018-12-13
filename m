Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DA3C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DF320849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vxPjTDxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DF320849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeLMOEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:04:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48610 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeLMOE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1xIDpfvBryUFGZJwqlARgvbYfUBrfWMTyTLvLb+WPhs=; b=vxPjTDxshp1GGRkYs+jP7nbkH
        Sx406rOu9WbWowjjcqZRs71kcLVu5Q53U86WkA7HXM4RrucomX5PJO/i5SB0+IwRU0PITugdrm4n6
        9AMnqJiOvos4gH0bDDLqlk6kO9VLChZQ5Y+siqry+EO7+B96O2UtE8vPXRJVZNiQJsndvBbiPC1eC
        P45LKWEnMLOsmCMxV6wtpO69FRjPkkQ5qsOVBgQOPOQlcH0anUFwV/CzNRzRSUO818aXOSiC17b26
        GJxt02rBKVZPLsdkdfgG/vEmDW1644NW+JNnVBjdutttoYICpffH45W4JQ0leMBTGGfy9fJ8s/sNK
        tZxe7je4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXRaq-0004YE-ET; Thu, 13 Dec 2018 14:04:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 014EF207264E1; Thu, 13 Dec 2018 15:03:58 +0100 (CET)
Date:   Thu, 13 Dec 2018 15:03:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v10 10/15] sched: Introduce a sysctl for Energy Aware
 Scheduling
Message-ID: <20181213140358.GJ5289@hirez.programming.kicks-ass.net>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-11-quentin.perret@arm.com>
 <20181211141509.GA32005@gmail.com>
 <20181211144901.hio4b6aw3esw3cgw@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211144901.hio4b6aw3esw3cgw@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 02:49:01PM +0000, Quentin Perret wrote:
> Hi Ingo,
> 
> On Tuesday 11 Dec 2018 at 15:15:09 (+0100), Ingo Molnar wrote:
> > 
> > * Quentin Perret <quentin.perret@arm.com> wrote:
> > 
> > > In its current state, Energy Aware Scheduling (EAS) starts automatically
> > > on asymmetric platforms having an Energy Model (EM). However, there are
> > > users who want to have an EM (for thermal management for example), but
> > > don't want EAS with it.
> > 
> > Well, then introduce a new Kconfig variant for EAS, if it's super 
> > important to allow this to be disabled.
> > 
> > Why do we want to disable it - is it not reliable in some circumstances?
> 
> There are people out there using big.little systems who do not care
> about energy. Not very many of them, that is true, but they exist. And
> those people can be interested in having an Energy Model for
> IPA/thermal but also want to spread tasks to minimize latency for
> example. So those guys will appreciate a knob, I think. Otherwise EAS
> gets enabled/disabled only by side effects (by enabling/disabling
> schedutil for example).

Right, also we have a sysctl for numa-balancing, I figured having one
for eas would not be weird.
