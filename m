Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D34CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E24223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E24223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbeKPBXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:23:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60839 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387833AbeKPBW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:22:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4FB330034D5;
        Thu, 15 Nov 2018 15:14:45 +0000 (UTC)
Received: from krava (unknown [10.40.205.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2833760BF7;
        Thu, 15 Nov 2018 15:14:42 +0000 (UTC)
Date:   Thu, 15 Nov 2018 16:14:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 2/2] perf vendor events: Add JSON metrics for Cascadelake
 server
Message-ID: <20181115151442.GK9600@krava>
References: <20181114212416.15665-1-kan.liang@linux.intel.com>
 <20181114212416.15665-2-kan.liang@linux.intel.com>
 <20181115132116.GH9600@krava>
 <3ab97c73-c197-8555-1a35-b54636e667e6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab97c73-c197-8555-1a35-b54636e667e6@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 15 Nov 2018 15:14:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 08:33:27AM -0500, Liang, Kan wrote:
> 
> 
> On 11/15/2018 8:21 AM, Jiri Olsa wrote:
> > On Wed, Nov 14, 2018 at 01:24:16PM -0800, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > Add JSON metrics (based on event list v1) for Cascadelake server
> > 
> > hum mail server probably crippled the email so it won't apply:
> > 
> > patching file pmu-events/arch/x86/cascadelakex/cache.json
> > patching file pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > patching file pmu-events/arch/x86/cascadelakex/floating-point.json
> > patching file pmu-events/arch/x86/cascadelakex/frontend.json
> > patching file pmu-events/arch/x86/cascadelakex/memory.json
> > patching file pmu-events/arch/x86/cascadelakex/other.json
> > patching file pmu-events/arch/x86/cascadelakex/pipeline.json
> > patch: **** malformed patch at line 29879:  ow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
> > 
> > I've similar error before and it was because of the 998 chars size
> > limit for line.. I guess you could either post it as attachment or
> > change the transfer encoding
> > 
> 
> The patch is attached. Can it be applied?

yep, that one works

thanks,
jirka
