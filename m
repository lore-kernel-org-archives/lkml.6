Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17B5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDA0214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695984;
	bh=Dy79b9BOySQUAkmNiupOrcXUtTCXyfqV2T4UzczNN/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n6YCvjTm7S9ucKAKP/EUGtMt/ujWIn0kStXRg3Pxa7b1poti8LYgLb9gPRe4JTFpB
	 5C58sUcJYhG7vGXEteU9DrmjsqBAvi7b5XOUJzlKydFOTZjtlcdev8pvaqaChe0t9T
	 ZF7Ny7ajVWBLDPqADJYmDsD6LprWLE0cC4+iWNa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfA1RTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:19:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731044AbfA1RTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:19:41 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB37E20989;
        Mon, 28 Jan 2019 17:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548695981;
        bh=Dy79b9BOySQUAkmNiupOrcXUtTCXyfqV2T4UzczNN/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdTD9FpKOf+hv1LjRoX4+SOcV/z3UeUhqTtt1f8nPyhEtW/1C+FDHfoeRZp0lX1Uu
         v71bH15zJP9J2H6ozhI61PaHNbaNPqm61FvRbuolNNCnttvZos7SDZi3V2yH2RlFue
         En/cElPJ3Ap6xTwIucRmNMmk60aPWeEdoiJXrJ/I=
Date:   Mon, 28 Jan 2019 12:19:39 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, adharmap@codeaurora.org,
        chris.redpath@arm.com, currojerez@riseup.net,
        dietmar.eggemann@arm.com, edubezval@gmail.com,
        gregkh@linuxfoundation.org, javi.merino@kernel.org,
        joel@joelfernandes.org, juri.lelli@redhat.com,
        patrick.bellasi@arm.com, pkondeti@codeaurora.org,
        rjw@rjwysocki.net, skannan@codeaurora.org, smuckle@google.com,
        srinivas.pandruvada@linux.intel.com, thara.gopinath@linaro.org,
        tkjos@google.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.20 163/304] sched/topology: Add lowest CPU
 asymmetry sched_domain level pointer
Message-ID: <20190128171939.GC3973@sasha-vm>
References: <20190128154341.47195-1-sashal@kernel.org>
 <20190128154341.47195-163-sashal@kernel.org>
 <20190128161415.4r4b2gq54o6qdrxa@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190128161415.4r4b2gq54o6qdrxa@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:14:17PM +0000, Quentin Perret wrote:
>Hi Sasha,
>
>On Monday 28 Jan 2019 at 10:41:20 (-0500), Sasha Levin wrote:
>> From: Quentin Perret <quentin.perret@arm.com>
>>
>> [ Upstream commit 011b27bb5d3139e8b5fe9ceff1fc7f6dc3145071 ]
>>
>> Add another member to the family of per-cpu sched_domain shortcut
>> pointers. This one, sd_asym_cpucapacity, points to the lowest level
>> at which the SD_ASYM_CPUCAPACITY flag is set. While at it, rename the
>> sd_asym shortcut to sd_asym_packing to avoid confusions.
>>
>> Generally speaking, the largest opportunity to save energy via
>> scheduling comes from a smarter exploitation of heterogeneous platforms
>> (i.e. big.LITTLE). Consequently, the sd_asym_cpucapacity shortcut will
>> be used at first as the lowest domain where Energy-Aware Scheduling
>> (EAS) should be applied. For example, it is possible to apply EAS within
>> a socket on a multi-socket system, as long as each socket has an
>> asymmetric topology. Energy-aware cross-sockets wake-up balancing will
>> only happen when the system is over-utilized, or this_cpu and prev_cpu
>> are in different sockets.
>
>Although I'm not really confident about the process for those AUTOSEL
>patches, I think this one alone won't help anybody without the other ~10
>EAS patches. And I assume you definitely don't want to mark those as
>stable, so I'm not sure if this one is a good candidate either.

I'll drop it then, thanks for the heads-up.

>On a side note, the best description I could find of AUTOSEL with a
>5 min Google search is this:  https://lwn.net/Articles/750057/
>Do you have any pointers to a doc where I can read up about AUTOSEL ?

For written material, this is based on Julia Lawall's work:
https://soarsmu.github.io/papers/icse12-patch.pdf .

We did a talk last year which is more recent than the paper:
https://www.youtube.com/watch?v=KWholDv6-Rw .

--
Thanks,
Sasha
