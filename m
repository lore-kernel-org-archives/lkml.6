Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A411C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC21320818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549387165;
	bh=UKZQ9gpyZKyahSKp4k6iwpoEGug+hsjAhmm5Pz+j7io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wYD1prdEbaSKa4yPR5tS/2bGO67tdrVamUKYjWOuxyGPUuiW7r814+Xo8v1+wlGWn
	 Vazh79zuRKgrDknmymOKPMVXOq45PRy6bvfMRyywMXk1g3gKBe2VYGjXpDK1uIkvkO
	 paAHUbHelNQgKHJw6F+AaGSoEdMHkdD7AnzfguF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfBERTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:19:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730365AbfBERTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:19:23 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6538820818;
        Tue,  5 Feb 2019 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549387162;
        bh=UKZQ9gpyZKyahSKp4k6iwpoEGug+hsjAhmm5Pz+j7io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LoHQpLczra6E3Raq8qdhzpNgZYeBe0GDwcbWYpWBrLPx9Eb6viYX4uNVBfbSlxrBu
         wp24sILQeMuAlCcmI7zAJzlHyFdjDyUOyGgoFsEEw0ruu4XAOhtQzZtiBjzXgei0M3
         VA985VXprCmOe+DpQee/ZG0VWHQOC1UtvCXKbZIY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3D5BE4034F; Tue,  5 Feb 2019 14:19:19 -0300 (-03)
Date:   Tue, 5 Feb 2019 14:19:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     William Cohen <wcohen@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Subject: Re: [PATCH] perf vendor events intel: Fix Load_Miss_Real_Latency on
 CLX
Message-ID: <20190205171919.GE10613@kernel.org>
References: <20190129170536.22510-1-wcohen@redhat.com>
 <20190129172348.GS6118@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129172348.GS6118@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 29, 2019 at 09:23:48AM -0800, Andi Kleen escreveu:
> On Tue, Jan 29, 2019 at 12:05:36PM -0500, William Cohen wrote:
> > Fix incorrect event names for the Load_Miss_Real_Latency metric for
> > Cascadelake server in the same manner as commit 91b2b97025 for SKL/SKX.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo
 
> > 
> > Signed-off-by: William Cohen <wcohen@redhat.com>
> > ---
> >  tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > index 36c903faed0b..71e9737f4614 100644
> > --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > @@ -73,7 +73,7 @@
> >      },
> >      {
> >          "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
> > -        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS_PS + MEM_LOAD_RETIRED.FB_HIT_PS )",
> > +        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
> >          "MetricGroup": "Memory_Bound;Memory_Lat",
> >          "MetricName": "Load_Miss_Real_Latency"
> >      },
> > -- 
> > 2.20.1
> > 

-- 

- Arnaldo
