Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14717C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCB220839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCB220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIKRcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:32:07 -0400
Received: from foss.arm.com ([217.140.101.70]:43032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeIKRcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:32:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48BC018A;
        Tue, 11 Sep 2018 05:32:59 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 301003F71F;
        Tue, 11 Sep 2018 05:32:55 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:32:50 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v6 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20180911123248.mjcaxrycfdelypo2@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-4-quentin.perret@arm.com>
 <20180829100435.GP2960@e110439-lin>
 <20180829132811.iacfltcos6kfgp7e@queper01-lin>
 <20180911093456.GA27352@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911093456.GA27352@andrea>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Tuesday 11 Sep 2018 at 11:34:56 (+0200), Andrea Parri wrote:
> FYI, the directory "tools/memory-model/" provides an "automated
> memory-barriers.txt": in short, you encode your "memory ordering
> questions" into "litmus tests" to be passed to the tool/simulator;
> the tool will then answer with "Yes/No" (plus other information).
> 
> Some preparation is required to set up and learn how to use the
> LKMM tools, but once there, I expect them to be more "efficient"
> than reading memory-barriers.txt... ;-)

Thanks for pointing this out, I'll have a look.

> Please don't hesitate
> to contact me/the LKMM maintainers if you need help with this.

And thanks for that too.

> You'd need some info in order to write down a _well-formed litmus
> test, e.g., matching barrier/synchronization and interested memory
> accesses on the reader side (IAC, the replacement "store-release
> -> store-once+smp_wmb" discussed above is suspicious...).

Regarding the disccusion above, I was actually planning on removing the
smp_wmb entirely and rely on WRITE_ONCE + mutex_{un}lock here. Do you
see something obviously wrong with that ?

I guess the LKMM tools should give me the yes/no answer I want, but if
that's a no, I'd also like to understand why ... :-)

Thanks,
Quentin
