Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFFCC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844862084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844862084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeGSLad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:30:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51194 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeGSLac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:30:32 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 2b18aa271d5b56b3; Thu, 19 Jul 2018 12:47:57 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Prakash, Prashanth" <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org
Subject: Re: [PATCH v4] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date:   Thu, 19 Jul 2018 12:46:17 +0200
Message-ID: <1932970.0qede6EoN4@aspire.rjw.lan>
In-Reply-To: <41a6e3c7-db85-9ff1-daf4-07569c11fc8c@codeaurora.org>
References: <1531375675-52623-1-git-send-email-george.cherian@cavium.com> <41a6e3c7-db85-9ff1-daf4-07569c11fc8c@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, July 14, 2018 12:20:43 AM CEST Prakash, Prashanth wrote:
> Hi George,
> 
> This version looks good. Thanks!
> 
> On 7/12/2018 12:07 AM, George Cherian wrote:
> > Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
> > feedback via set of performance counters. To determine the actual
> > performance level delivered over time, OSPM may read a set of
> > performance counters from the Reference Performance Counter Register
> > and the Delivered Performance Counter Register.
> >
> > OSPM calculates the delivered performance over a given time period by
> > taking a beginning and ending snapshot of both the reference and
> > delivered performance counters, and calculating:
> >
> > delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
> >
> > Implement the above and hook this to the cpufreq->get method.
> >
> > Signed-off-by: George Cherian <george.cherian@cavium.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Prashanth Prakash <pprakash@codeaurora.org>
> 

Patch applied, thanks!


