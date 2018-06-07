Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XOqTCOKnGVtdEAAAmS7hNA
	; Thu, 07 Jun 2018 21:47:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A4A2A606FA; Thu,  7 Jun 2018 21:47:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 12E81605A2;
	Thu,  7 Jun 2018 21:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12E81605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeFGVrv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:47:51 -0400
Received: from foss.arm.com ([217.140.101.70]:56544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752774AbeFGVrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:47:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2FEF1435;
        Thu,  7 Jun 2018 14:47:48 -0700 (PDT)
Received: from dupont (dupont.austin.arm.com [10.118.16.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC59E3F557;
        Thu,  7 Jun 2018 14:47:47 -0700 (PDT)
Date: Thu, 7 Jun 2018 16:47:47 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
Message-Id: <20180607164747.7e4bb30f69a1fb4c160b6ef1@arm.com>
In-Reply-To: <39d1089f-585d-bc19-2ecd-c9c9c812f85f@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
        <20180605210710.22227-6-kim.phillips@arm.com>
        <20180606082422.GB19727@kroah.com>
        <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
        <20180606155501.704583e1412996a1a2c6fa61@arm.com>
        <20180607083401.GE16651@kroah.com>
        <3219276b-2703-bc30-92e1-bae80cdc5901@arm.com>
        <20180607091353.GA20438@kroah.com>
        <2f8d233e-8847-ce3d-3a5b-06b175e3944b@arm.com>
        <20180607095322.GA26174@kroah.com>
        <adbabdb0-df2c-be74-3cde-cda4f6bce579@arm.com>
        <20180607121304.017d1d6804466050dd5c0af2@arm.com>
        <39d1089f-585d-bc19-2ecd-c9c9c812f85f@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2018 22:10:07 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> On 06/07/2018 06:13 PM, Kim Phillips wrote:
> > I'm going to assume the series is still valid after this discussion,
> > since technically just this patch can get dropped, and the user is able
> > to shoot themselves in the foot.
> 
> That doesn't mean the kernel can panic() if the user decided to unload 
> the module while the trace session is in progress. It only means that
> the trace session could be stopped in between in the worst case. But
> nothing more harmful to the system.

FWIW, I didn't see the kernel panic in my basic tests; just some bad
accesses: the new remove functions take care of cleaning up most items,
and most drivers still depend on the links and sinks (funnel,
replicator) drivers, so they can't be upset too bad.

> >  This series is for development  purposes, after all.
> 
> Do you mean that this series is for internal development purposes and 
> not upstream ? Making the drivers modular are always helpful, especially 

no, I'm posting them for upstream review because I'd like them upstream.

> for something related to tracing, that allows the module to be unloaded 
> after use. So, it would be good to have this series in, but in a manner 
> which is usable and doesn't cause harm to the overall system usage.
> 
> I think the summary of the discussion is that we need more robust code
> to handle the situation, which also allows unloading the modules without
> any trouble.

Trouble's relative.  My point was since the series is going to be used
mainly by developers testing their code, they already prepare for, and
expect badness to occur anyway.  Greg's point isn't lost here, and in
my interpretation, his review of this patch was that it was in the
wrong direction of safety: it made things unnecessarily too safe, up
front, and that items relative to the perf core should strive to adhere
to the higher standards set in place by the networking subsystem.  So,
this patch doesn't get his ack.

I compiled a new v5 series that omits this patch, and overwrote the v4
series here:

git://linux-arm.org/linux-kp.git, coresight-modules branch

but I'll hold of submitting a v5 for now.

I don't know how the perf core handles AUXTRACE drivers hanging up on
it.  I see intel-pt record support can't be built as a module.  I'm
guessing more testing for actual panics when using perf or sysfs is
what's being sought here?

Kim
