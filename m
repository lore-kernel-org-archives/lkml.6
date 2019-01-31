Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8193C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA465218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfAaJe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:34:28 -0500
Received: from foss.arm.com ([217.140.101.70]:40330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfAaJe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:34:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A5D1A78;
        Thu, 31 Jan 2019 01:34:28 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C6933F71E;
        Thu, 31 Jan 2019 01:34:26 -0800 (PST)
Date:   Thu, 31 Jan 2019 09:34:21 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, sudeep.holla@arm.com,
        rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190131093418.umsbh4eevgod42sh@queper01-lin>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
 <20190130190703.GM81583@google.com>
 <20190131072209.nhbgid3cystvr2p5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131072209.nhbgid3cystvr2p5@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 Jan 2019 at 12:52:09 (+0530), Viresh Kumar wrote:
> On 30-01-19, 11:07, Matthias Kaehlcke wrote:
> > On Wed, Jan 30, 2019 at 05:05:02PM +0000, Quentin Perret wrote:
> > > +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> > > +					 int cpu)
> > 
> > why __maybe_unused?
> 
> Yeah, it isn't required I think. He probably added it for the case
> where CONFIG_ENERGY_MODEL=n, but even then an inline routine is
> defined which will accept it as argument and wouldn't do anything with
> it. Had it been a macro, we would have required __maybe_unused but not
> now.

The thing is, the EM_DATA_CB() macro _is_ stubbed for
CONFIG_ENERGY_MODEL=n:

https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L165

So, without __maybe_unused you get do get a compiler warning.

Thanks,
Quentin

> 
> -- 
> viresh
