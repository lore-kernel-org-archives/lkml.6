Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7513B2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550589694;
	bh=LoG2TMKE/N/1Q2xs7ssnnTaD3zx/y+526d0T7lRIIP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pkuz+H7lyO4oaggGnUitvB9lEwbhut7E4997nmLncGdh89web09Uhpk8rmpH3ZDhD
	 mn8lotPwdQJ/G54czfz882/wKInswiMoxbE5WgVlZqpHga4S8y2eueNsLeUBhe7g6p
	 FW9yeASCmJT6yRQeECdkJK0bxsqLV3yVU/bkKuAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfBSPVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:21:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSPVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:21:32 -0500
Received: from quaco.ghostprotocols.net (unknown [179.162.130.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF95C20818;
        Tue, 19 Feb 2019 15:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550589692;
        bh=LoG2TMKE/N/1Q2xs7ssnnTaD3zx/y+526d0T7lRIIP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2IEkvKSvkRGsUL82dZNsiKEEx8mlKHvVzkRvc2pif2/F7OtPCYvFYkNg01Ov3/Nam
         5B83HjnGpM9MFR7x5KNe7//NVKJvgRMt8cCxlbVrmN4SqJTGoEcQbJjU7hZkvSyiIi
         FFpcjNuSTv8Z/XVqfZaSRjSuGSP419bhTRAKec/Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C021F410D5; Tue, 19 Feb 2019 12:21:28 -0300 (-03)
Date:   Tue, 19 Feb 2019 12:21:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCHv3 0/4] perf tools: Assorted fixes
Message-ID: <20190219152128.GA31177@kernel.org>
References: <20190219095815.15931-1-jolsa@kernel.org>
 <CAM9d7cjJ59Uyv5TtosZYQBm4F5eFadyCpuxHioU99=3HH7xg9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjJ59Uyv5TtosZYQBm4F5eFadyCpuxHioU99=3HH7xg9Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 19, 2019 at 11:28:31PM +0900, Namhyung Kim escreveu:
> Hi Jirka,
> 
> On Tue, Feb 19, 2019 at 6:58 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > sending assorted general fixes that queued
> > up in my other branches.
> >
> > v3 changes:
> >   - fix for fixes found by Namhyung
> >   - new patch to use sysfs__mountpoint
> >
> > v2 changes:
> >   - renamed the interface to struct cpu_topology/numa_topology
> >     plus related changes in function names
> >   - adding missing Fixes tag
> >
> > Also available in here:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/fixes
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > Jiri Olsa (4):
> >       perf header: Fix wrong node write in NUMA_TOPOLOGY feature
> >       perf tools: Add cpu_topology object
> >       perf tools: Add numa_topology object
> >       perf tools: Use sysfs__mountpoint() when reading cpu topology
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, added and applied.

- Arnaldo
