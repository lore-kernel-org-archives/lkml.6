Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FA2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C63C214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNg1q8oE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C63C214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbeKUXZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:25:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729377AbeKUXZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:25:48 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A82921479;
        Wed, 21 Nov 2018 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542804692;
        bh=R1xYUQfjOTLiQy0rX0mqeI+N9MWP94mC73W1v83uKc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jNg1q8oE+wS1gN4N3cAuK7E0S6kJuQr14/yspAaD/IyOS6OlG3V8+Po6+1CmaY138
         rdcXlLJVbEDdM2N1iNv40HTjt7oPG+LfS6eOJCorXqfmwANou8nZbuDLihQr3kqpPE
         SJbc9UIL63ilTYjU5QGoye95QWLbpGiusA1hRSeY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 74FAD1443D6; Wed, 21 Nov 2018 09:51:30 -0300 (-03)
Date:   Wed, 21 Nov 2018 09:51:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 2/2] perf vendor events: Add JSON metrics for Cascadelake
 server
Message-ID: <20181121125130.GD6248@kernel.org>
References: <20181114212416.15665-1-kan.liang@linux.intel.com>
 <20181114212416.15665-2-kan.liang@linux.intel.com>
 <20181115132116.GH9600@krava>
 <3ab97c73-c197-8555-1a35-b54636e667e6@linux.intel.com>
 <20181115151442.GK9600@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115151442.GK9600@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 15, 2018 at 04:14:42PM +0100, Jiri Olsa escreveu:
> On Thu, Nov 15, 2018 at 08:33:27AM -0500, Liang, Kan wrote:
> > 
> > 
> > On 11/15/2018 8:21 AM, Jiri Olsa wrote:
> > > On Wed, Nov 14, 2018 at 01:24:16PM -0800, kan.liang@linux.intel.com wrote:
> > > > From: Kan Liang <kan.liang@linux.intel.com>
> > > > 
> > > > Add JSON metrics (based on event list v1) for Cascadelake server
> > > 
> > > hum mail server probably crippled the email so it won't apply:
> > > 
> > > patching file pmu-events/arch/x86/cascadelakex/cache.json
> > > patching file pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > > patching file pmu-events/arch/x86/cascadelakex/floating-point.json
> > > patching file pmu-events/arch/x86/cascadelakex/frontend.json
> > > patching file pmu-events/arch/x86/cascadelakex/memory.json
> > > patching file pmu-events/arch/x86/cascadelakex/other.json
> > > patching file pmu-events/arch/x86/cascadelakex/pipeline.json
> > > patch: **** malformed patch at line 29879:  ow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
> > > 
> > > I've similar error before and it was because of the 998 chars size
> > > limit for line.. I guess you could either post it as attachment or
> > > change the transfer encoding
> > > 
> > 
> > The patch is attached. Can it be applied?
> 
> yep, that one works

Can I have your reviewed-by for this one as well?

- Arnaldo
