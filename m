Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B119C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368C521855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900337;
	bh=0vp5hLSWpl0cFwWVUdXrq2uvEcFvRCxDIXnKMfvr62k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RCWHUV0Sq7f2B7NG6qSe5mpDZ/+ck6SC3nnIEx+n7hHcX8P7JvzAtOFmfw5hWebci
	 xkWxDKx3eK4Hpvzd3eVnWhWWsFG0jCd0q9jl2+OalWZMh1/m0Jgy3Syfu3mSGew+yz
	 34rmWAxjOJ5XZpzMPLYhq2d5OkoMXZ35tqt1VaXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbfBKPwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:52:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbfBKPwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:52:12 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43FF3218A4;
        Mon, 11 Feb 2019 15:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549900331;
        bh=0vp5hLSWpl0cFwWVUdXrq2uvEcFvRCxDIXnKMfvr62k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0LbGj3cbp3GjIK3cocjZ+p3RzrE+e5pXuJ+OnkGDr0ZBY8lyrp3V2zlRFt/gPXBAE
         H5TGBtAcPqDT/HTI2QzFthSItaaFQonFsdRxrYreLIDhfTYPcFAjKX7qKz1dvEfsK5
         VJw/ibXUmJFAD5OqD5sE1yXv8hJuRWbZC0dQg3Hs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C8ACD410D5; Mon, 11 Feb 2019 12:52:05 -0300 (-03)
Date:   Mon, 11 Feb 2019 12:52:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Paul Clarke <pc@us.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com,
        mpe@ellerman.id.au, cel@us.ibm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 0/4] [powerpc] perf vendor events: Add JSON metrics
 for POWER8
Message-ID: <20190211155205.GD3269@kernel.org>
References: <20190207175314.31813-1-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207175314.31813-1-pc@us.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 07, 2019 at 12:53:10PM -0500, Paul Clarke escreveu:
> The patches define metrics and metric groups for computation by "perf" for
> POWER8 processors.
> 
> Paul Clarke (4):
>   [powerpc] perf vendor events: Add JSON metrics for POWER8 1/4
>   [powerpc] perf vendor events: Add JSON metrics for POWER8 2/4
>   [powerpc] perf vendor events: Add JSON metrics for POWER8 3/4
>   [powerpc] perf vendor events: Add JSON metrics for POWER8 4/4
> 
> v2:
> The content of these patches was sent previously, to LKML and linux-perf-users,
> but never showed up at linux-perf-users, so I split it into smaller patches
> and am resending.
> 
>  .../arch/powerpc/power8/metrics.json          | 2245 +++++++++++++++++
>  1 file changed, 2245 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/metrics.json

Thanks, applied, next time please CC:

[acme@quaco perf]$ scripts/get_maintainer.pl tools/perf
Peter Zijlstra <peterz@infradead.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM)
Ingo Molnar <mingo@redhat.com> (supporter:PERFORMANCE EVENTS SUBSYSTEM)
Arnaldo Carvalho de Melo <acme@kernel.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM)
Alexander Shishkin <alexander.shishkin@linux.intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Jiri Olsa <jolsa@redhat.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Namhyung Kim <namhyung@kernel.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
[acme@quaco perf]$

So that it gets to my main inbox and may get slightly faster processing.

- Arnaldo
