Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494CAC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1509E213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1509E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeJJEiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:38:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:37497 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbeJJEiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:38:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 14:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,361,1534834800"; 
   d="scan'208";a="79853430"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 09 Oct 2018 14:18:39 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id AEF97300B47; Tue,  9 Oct 2018 14:18:39 -0700 (PDT)
Date:   Tue, 9 Oct 2018 14:18:39 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC] perf tools: Wrong filter_band* values in json calculation"
Message-ID: <20181009211839.GK32651@tassilo.jf.intel.com>
References: <20181003072046.29276-1-jolsa@kernel.org>
 <20181003143456.GE31725@krava>
 <20181003144550.GI32651@tassilo.jf.intel.com>
 <20181009100144.GG6499@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009100144.GG6499@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 12:01:44PM +0200, Jiri Olsa wrote:
> On Wed, Oct 03, 2018 at 07:45:50AM -0700, Andi Kleen wrote:
> > > note there's couple of changes that actually changed
> > > the number completely, like:
> > > 
> > > -        "Filter": "edge=1,filter_band2=4000",
> > > +        "Filter": "edge=1,filter_band2=30",
> > 
> > Thanks. Looks good. I'll fix the scripts to generate the uncore events.
> 
> hi,
> any idea when you could post an update for this?

Can just use your patch for the existing event lists. You can add

Acked-by: Andi Kleen <ak@linux.intel.com>

I was mainly worried about future updates, but it doesn't seem to be a problem.

-Andi
