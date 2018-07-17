Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1DFECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4DB21470
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4DB21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeGQJoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:44:06 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:55584 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeGQJoF (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 17 Jul 2018 05:44:05 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 11:12:26 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 10:11:54 +0100
Date:   Tue, 17 Jul 2018 11:11:52 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Message-ID: <20180717091152.l4ixicbp6imvqtsr@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <CAJZ5v0ihkNKPrtzKynt8jgQi1JjwCm+SdoUnu4XqoPSkOroHvA@mail.gmail.com>
 <CAJZ5v0gG5XNmpR_0U+6EOFHPeVz+EhunLoQ0-sXDCBg8QL3mQw@mail.gmail.com>
 <20180717085039.kqxwbkgruhj5qxtx@suselix>
 <CAJZ5v0ivJiPhuh7Gk3KpujKjvFGAY6EYQrNdu8=kao59xqsgHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ivJiPhuh7Gk3KpujKjvFGAY6EYQrNdu8=kao59xqsgHw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:06:29AM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 17, 2018 at 10:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> 
> [cut]
> 
> >
> > On balance before this commit users could use pcc-cpufreq but had
> > already suboptimal performance (compared to say intel_pstate driver
> > which can be used changing BIOS options).
> 
> BTW, I wonder why you need to change the BIOS options for intel_pstate to load.

I think this is because of (in intel_pstate_init()):

        /*
         * The Intel pstate driver will be ignored if the platform
         * firmware has its own power management modes.
         */
        if (intel_pstate_platform_pwr_mgmt_exists())
                return -ENODEV;


> It should be initialized before pcc-cpufreq (according to their
> respective initcall levels), so in theory intel_pstate should be used
> by default on the affected systems anyway.

> What BIOS settings need to be changed for that?

Already answered in other mail.


Andreas
