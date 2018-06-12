Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ED94DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE95F208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE95F208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754387AbeFLPB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:01:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58429 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754257AbeFLPB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:01:58 -0400
Received: from 79.184.255.56.ipv4.supernova.orange.pl (79.184.255.56) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 8e0a70d02d9ef3cb; Tue, 12 Jun 2018 17:01:56 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: ACPI: make function acpi_cpufreq_fast_switch static
Date:   Tue, 12 Jun 2018 17:00:55 +0200
Message-ID: <1707897.EI8LSjriHK@aspire.rjw.lan>
In-Reply-To: <20180604071141.wzxjtxa2hwlbkaw3@vireshk-i7>
References: <20180601130512.30857-1-colin.king@canonical.com> <20180604071141.wzxjtxa2hwlbkaw3@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 4, 2018 9:11:41 AM CEST Viresh Kumar wrote:
> On 01-06-18, 14:05, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The function acpi_cpufreq_fast_switch is local to the source and does
> > not need to be in global scope, so make it static.
> > 
> > Cleans up sparse warning:
> > drivers/cpufreq/acpi-cpufreq.c:468:14: warning: symbol
> > 'acpi_cpufreq_fast_switch' was not declared. Should it be static?
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index 9449657d72f0..32ba4bc972e7 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -465,8 +465,8 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
> >  	return result;
> >  }
> >  
> > -unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> > -				      unsigned int target_freq)
> > +static unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> > +					     unsigned int target_freq)
> >  {
> >  	struct acpi_cpufreq_data *data = policy->driver_data;
> >  	struct acpi_processor_performance *perf;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Patch applied, thanks!


