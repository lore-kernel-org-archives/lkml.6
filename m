Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F4CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB19222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550149084;
	bh=+3AKeeRIr7ZsdX2FfRqjA2gzgf6gue7z7ycSYG+ZsJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SHvMUuUfBgEl+xcRMlHx8yX1PqWPRcrQ4WyjA6dIrcnzMEKN+nxH+k+v3opXo/nVP
	 4OJiE7+Eq1pSkq+hHmirBCWMK5ktHAh7YC3cS/z1rFe56SITJOipfiZ67yJtXixDpx
	 b2Vl++0dBrGDBHXxYOI2aO5emwt6j4DoDELrkdTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438577AbfBNM6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:58:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388169AbfBNM6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:58:03 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BB5621900;
        Thu, 14 Feb 2019 12:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550149082;
        bh=+3AKeeRIr7ZsdX2FfRqjA2gzgf6gue7z7ycSYG+ZsJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjzgYCHahay4ZuHCxAq1ZY9z+4xvvsvh/7WtM5gXGuNIN0lx+fVRdAgnWp2FbpISZ
         BOduHZYCfN8lskZt2boX2+I3rQ5GXL0EnuWg8SodErX3YaCxTAKNe8N6EI8NDqa+AU
         wl0609/g0YGucHeazbosezkLnBAMWT3vWBM3EthM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 437E9410D5; Thu, 14 Feb 2019 09:57:59 -0300 (-03)
Date:   Thu, 14 Feb 2019 09:57:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in
 directory
Message-ID: <20190214125759.GS3269@kernel.org>
References: <20190204202818.GC4794@krava>
 <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
 <20190205133727.GF4794@krava>
 <20190211101957.GB14253@krava>
 <CABPqkBSkyHRaXN-oVLuJJ=aPEBfqOAunRUReHsxESnC=KKQuPg@mail.gmail.com>
 <20190211185306.GD5046@krava>
 <20190211193202.GG3269@kernel.org>
 <20190211201831.GE5046@krava>
 <CABPqkBRdmfOde793id4GEuwD=eYL8TLKe1p8k07xWAh1MPD3AQ@mail.gmail.com>
 <20190214113450.GC26714@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214113450.GC26714@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 14, 2019 at 12:34:50PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 11, 2019 at 12:43:22PM -0800, Stephane Eranian wrote:
> > On Mon, Feb 11, 2019 at 12:18 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > I thought having new MMAP3 event version with buildid field in it
> > > if available and/or enabled by bit in perf_event_attr

> > I think MMAP3 is a cleaner approach, though it adds yet another MMAP event.
 
> actually I realized this might not help at the end at all
 
> what we do now is that we scan the data (after it's recorded)

We wouldn't have to do that scan of the data at the end if we have the
build-id in the MMAP3 records.

> to get the list of binaries that got touched during the profile
> and store those in .debug cache based on the build ids
 
> we can't just store ALL of the binaries that the session comes
> across via mmap events

We don't have to, we never did that at 'perf record' time, this is
something for 'perf archive' to do, see below.

> I can see the build id in mmap helping to resolve the race
> issue when some binary change during the profile session and
> we have no idea and report on wrong one.. but I dont see
> people complaining about this at all

But with the build id in the MMAPs we wouldn't need to scan anything at
'perf record' time, just at 'perf archive' time, where we would scan
everything, and as soon as we find a hit, we add that DSO to the list of
things we need to put in the tarball.

- Arnaldo
