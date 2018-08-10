Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6F6C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA3D217CD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA3D217CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeHJPAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:00:33 -0400
Received: from foss.arm.com ([217.140.101.70]:37402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeHJPAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:00:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DC1A7A9;
        Fri, 10 Aug 2018 05:30:49 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F3833F5B3;
        Fri, 10 Aug 2018 05:30:45 -0700 (PDT)
Date:   Fri, 10 Aug 2018 13:30:35 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v5 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20180810123032.ixay2e3hlrayifdy@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <2467271.WAtZ4Z8dKT@aspire.rjw.lan>
 <20180810091216.nieosjtu7l33z4ap@queper01-lin>
 <8482157.ZqyaK8WryI@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8482157.ZqyaK8WryI@aspire.rjw.lan>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 Aug 2018 at 13:13:22 (+0200), Rafael J. Wysocki wrote:
> Something able to say how the numbers used by EM and IPA are related. :-)
> 
> Do you think that IPA and EM will always need to use the same set of data for
> the CPU?

Hmm, I would say yes. Both EAS and IPA basically need some sort of
<frequency, power> table, so hopefully the EM framework can provide them
with that :-).

If the EM framework doesn't accommodate the needs of its two users, then
something needs fixing ... Did you have something specific in mind ?

Thanks,
Quentin
