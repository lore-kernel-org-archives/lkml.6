Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B23C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E1620872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfAKKmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:42:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63763 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbfAKKmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:42:33 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id fa1851b8fa0d84f8; Fri, 11 Jan 2019 11:42:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Cc:     viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Date:   Fri, 11 Jan 2019 11:41:45 +0100
Message-ID: <1742153.atePz3IjTa@aspire.rjw.lan>
In-Reply-To: <20190109105945.GA18034@e107155-lin>
References: <20190109104236.6532-1-quentin.perret@arm.com> <20190109105945.GA18034@e107155-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 9, 2019 11:59:45 AM CET Sudeep Holla wrote:
> On Wed, Jan 09, 2019 at 10:42:36AM +0000, Quentin Perret wrote:
> > The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
> > frequency changes to provide scale-invariant load-tracking signals to
> > the scheduler. However, in the slow path, it does so while specifying
> > the current and max frequencies in different units, hence resulting in a
> > broken freq_scale factor.
> > 
> > Fix this by passing all frequencies in KHz, as stored in the CPUFreq
> > frequency table.
> > 
> > Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
> > message protocol")
> 
> Good find.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Applied, thanks!

