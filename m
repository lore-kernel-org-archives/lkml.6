Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD01C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2FE21470
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2FE21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403900AbeHPQgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:36:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36858 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391636AbeHPQgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:36:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E18080D;
        Thu, 16 Aug 2018 06:37:44 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFF9F3F5BC;
        Thu, 16 Aug 2018 06:37:41 -0700 (PDT)
Date:   Thu, 16 Aug 2018 14:37:40 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups
 accounting
Message-ID: <20180816133737.xfwfoenbhb5wnndi@queper01-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-4-patrick.bellasi@arm.com>
 <a24def9b-57bb-d072-5064-0421076d2e43@arm.com>
 <20180814164905.GG2605@e110439-lin>
 <7c45c1a8-24cb-6798-5b6f-3b5dfc9b490d@arm.com>
 <20180815105428.GA7388@e110439-lin>
 <ccd9c53f-55f7-a285-39eb-4303888dafcd@arm.com>
 <20180816133249.GA2964@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816133249.GA2964@e110439-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > IMHO, if this is something which should not happen at all, a BUG_ON() is the
> > right thing to do here.
> 
> I don't agree on that. I agree it should not happen but since it's a
> recoverable error it think we should not panic.

FWIW, if this is a recoverable error, I think Linus will agree with
Patrick on this one :-)

https://lkml.org/lkml/2016/10/4/1
