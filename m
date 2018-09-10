Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB2EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E8C2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E8C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeIJOtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:49:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55415 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJOtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:49:51 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.123)
 id 9579df7b1aaac1ae; Mon, 10 Sep 2018 11:56:34 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v6 10/14] sched/cpufreq: Refactor the utilization aggregation method
Date:   Mon, 10 Sep 2018 11:53:58 +0200
Message-ID: <3619149.Cl0Cp2apok@aspire.rjw.lan>
In-Reply-To: <20180820094420.26590-11-quentin.perret@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com> <20180820094420.26590-11-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 20, 2018 11:44:16 AM CEST Quentin Perret wrote:
> Schedutil aggregates the PELT signals of CFS, RT, DL and IRQ in order
> to decide which frequency to request. Energy Aware Scheduling (EAS)
> needs to be able to predict those requests to assess the energy impact
> of scheduling decisions. However, the PELT signals aggregation is only
> done in schedutil for now, hence making it hard to synchronize it with
> EAS.
> 
> To address this issue, introduce schedutil_freq_util() to perform the
> aforementioned aggregation and make it available to other parts of the
> scheduler. Since frequency selection and energy estimation still need
> to deal with RT and DL signals slightly differently, schedutil_freq_util()
> is called with a different 'type' parameter in those two contexts, and
> returns an aggregated utilization signal accordingly.

This is complementary to patch [02/14] IMO.

schedutil_freq_util() and map_util_freq() introduced by that patch should
always be used together as they are two parts of one algorithm in my view.

Would it be possible to make that clearer?

Thanks,
Rafael

