Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45A5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8595820645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8595820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbeIFSpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:45:05 -0400
Received: from foss.arm.com ([217.140.101.70]:46394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbeIFSpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:45:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE11B80D;
        Thu,  6 Sep 2018 07:09:21 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E89CA3F614;
        Thu,  6 Sep 2018 07:09:17 -0700 (PDT)
Date:   Thu, 6 Sep 2018 15:09:16 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v6 04/14] PM / EM: Expose the Energy Model in sysfs
Message-ID: <20180906140914.noe3yz7xrb4g5sf4@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-5-quentin.perret@arm.com>
 <c012c934-d861-eba6-0c67-63e8308ae37b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c012c934-d861-eba6-0c67-63e8308ae37b@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Wednesday 05 Sep 2018 at 23:56:43 (-0700), Dietmar Eggemann wrote:
> On 08/20/2018 02:44 AM, Quentin Perret wrote:
> > Expose the Energy Model (read-only) of all performance domains in sysfs
> > for convenience. To do so, add a kobject to the CPU subsystem under the
> > umbrella of which a kobject for each performance domain is attached.
> > 
> > The resulting hierarchy is as follows for a platform with two
> > performance domains for example:
> > 
> >     /sys/devices/system/cpu/energy_model
> >     ├── pd0
> >     │   ├── cost
> >     │   ├── cpus
> >     │   ├── frequency
> >     │   └── power
> 
> cpus (cpumask of the perf domain), frequency (OPP's of the perf domain) and
> power (values at those OPP's) are somehow easy to grasp, cost is definitely
> not.
> 
> You have this nice description in em_pd_energy() what cost actually is.
> IMHO, might be worth repeating this at least in the patch header here.

Hmm, this patch introduces the sysfs interface, not the 'cost' field
itself. As long as 'cost' is documented in the patch that introduces it
we should be good no ? I mean this patch header tells you _where_ the
fields of the structure are exposed. _What_ the structure is all about
is a different story.

But yeah, in any case, a reminder shouldn't hurt I guess, if you really
want one :-)

Thanks,
Quentin
