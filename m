Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23481C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64B620881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64B620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeIJPVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:21:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53643 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeIJPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:21:03 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.123)
 id ac07e22a11415715; Mon, 10 Sep 2018 12:27:38 +0200
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
Date:   Mon, 10 Sep 2018 12:25:02 +0200
Message-ID: <26961140.kuCyhvbGLP@aspire.rjw.lan>
In-Reply-To: <20180910100719.uan6gskxpgu25dj5@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com> <3619149.Cl0Cp2apok@aspire.rjw.lan> <20180910100719.uan6gskxpgu25dj5@queper01-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 10, 2018 12:07:21 PM CEST Quentin Perret wrote:
> On Monday 10 Sep 2018 at 11:53:58 (+0200), Rafael J. Wysocki wrote:
> > On Monday, August 20, 2018 11:44:16 AM CEST Quentin Perret wrote:
> > > Schedutil aggregates the PELT signals of CFS, RT, DL and IRQ in order
> > > to decide which frequency to request. Energy Aware Scheduling (EAS)
> > > needs to be able to predict those requests to assess the energy impact
> > > of scheduling decisions. However, the PELT signals aggregation is only
> > > done in schedutil for now, hence making it hard to synchronize it with
> > > EAS.
> > > 
> > > To address this issue, introduce schedutil_freq_util() to perform the
> > > aforementioned aggregation and make it available to other parts of the
> > > scheduler. Since frequency selection and energy estimation still need
> > > to deal with RT and DL signals slightly differently, schedutil_freq_util()
> > > is called with a different 'type' parameter in those two contexts, and
> > > returns an aggregated utilization signal accordingly.
> > 
> > This is complementary to patch [02/14] IMO.
> > 
> > schedutil_freq_util() and map_util_freq() introduced by that patch should
> > always be used together as they are two parts of one algorithm in my view.
> 
> I agree.
> 
> > Would it be possible to make that clearer?
> 
> I could squash the two at the beginning of the series in a preparatory
> patch that refactors schedutil for EAS all in one go, with a clear
> mention of what we intend to do (make EAS depend on sugov) in the commit
> message.
> 
> Would that work ?

I think so.

Thanks,
Rafael

