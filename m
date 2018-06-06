Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A292E60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeFFP36 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:29:58 -0400
Received: from foss.arm.com ([217.140.101.70]:42004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbeFFP35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:29:57 -0400
Date: Wed, 6 Jun 2018 16:29:51 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180606152950.GH10870@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <b47cb1f1-6ca1-7674-903f-724be43a57a0@arm.com>
 <20180606143739.GF10870@e108498-lin.cambridge.arm.com>
 <20180606152000.GB15894@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606152000.GB15894@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jun 2018 at 17:20:00 (+0200), Juri Lelli wrote:
> > > This brings me to another question. Let's say there are multiple users of
> > > the Energy Model in the system. Shouldn't the units of frequency and power
> > > not standardized, maybe Mhz and mW?
> > > The task scheduler doesn't care since it is only interested in power diffs
> > > but other user might do.
> > 
> > So the good thing about specifying units is that we can probably assume
> > ranges on the values. If the power is in mW, assuming that we're talking
> > about a single CPU, it'll probably fit in 16 bits. 65W/core should be
> > a reasonable upper-bound ?
> > But there are also vendors who might not be happy with disclosing absolute
> > values ... These are sometimes considered sensitive and only relative
> > numbers are discussed publicly. Now, you can also argue that we already
> > have units specified in IPA for ex, and that it doesn't really matter if
> > a driver "lies" about the real value, as long as the ratios are correct.
> > And I guess that anyone can do measurement on the hardware and get those
> > values anyway. So specifying a unit (mW) for the power is probably a
> > good idea.
> 
> Mmm, I remember we fought quite a bit while getting capacity-dmpis-mhz
> binding accepted, and one of the musts was that the values were going to
> be normalized. So, normalized power values again maybe?

Hmmm, that's a very good point ... There should be no problems on the
scheduler side -- we're only interested in correct ratios. But I'm not
sure on the thermal side ... I will double check that.

Javi, Viresh, Eduardo: any thoughts about this ?

Thanks !
Quentin
