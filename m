Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893BBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5733A2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549913530;
	bh=cfX8DX3l2wzEnNG//tlP5z7+OR8oD2yFr0C+I8fn1hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bO+RC9mfTeaRB4F+13deiIyVIbqDEZngmqFJyNC8KB7RubnpGn2Deouwp83dx703W
	 DQnP2zReMxr1msSXTjATUQNJ0JtD2eNACRXEIFZciA7Jgrqol65l5fcUeYlyAWUKHL
	 TLCxy2fC/Ew47Uvr+Cs5OPP2U30q9sXF4K1/VKIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388471AbfBKTcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:32:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfBKTcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:32:06 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13BD12186A;
        Mon, 11 Feb 2019 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549913526;
        bh=cfX8DX3l2wzEnNG//tlP5z7+OR8oD2yFr0C+I8fn1hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHy7ykWYPWae0ll8Zqzz+HFhtWiyOmsz0DMBKxKLqNBWTwiXu/IzJGO0/SujmU5w3
         w/faDZbZEcE+RT4DpsE0VvWOKv7QDQagVI2ZXfTzewJ4rOozFHnEroxwdjWgJfDA1J
         Z6iHIO2vrLIdBz8HnYu08RyICDB7tn0f/kDNpra8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 63360410D5; Mon, 11 Feb 2019 16:32:02 -0300 (-03)
Date:   Mon, 11 Feb 2019 16:32:02 -0300
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
Message-ID: <20190211193202.GG3269@kernel.org>
References: <20190204114144.GC18141@krava>
 <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
 <20190204192721.GI5593@kernel.org>
 <CABPqkBTcxkKkxBwLfToenAk0ubp-o08xVq=XqpkfzYHTNqgBkQ@mail.gmail.com>
 <20190204202818.GC4794@krava>
 <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
 <20190205133727.GF4794@krava>
 <20190211101957.GB14253@krava>
 <CABPqkBSkyHRaXN-oVLuJJ=aPEBfqOAunRUReHsxESnC=KKQuPg@mail.gmail.com>
 <20190211185306.GD5046@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211185306.GD5046@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 11, 2019 at 07:53:06PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 11, 2019 at 10:34:16AM -0800, Stephane Eranian wrote:
> > On Mon, Feb 11, 2019 at 2:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > On Tue, Feb 05, 2019 at 02:37:27PM +0100, Jiri Olsa wrote:
> > > I think all could be added and worked around with exception
> > > of BUILD_ID, which we store at the end (after processing
> > > all data) and we need it early in the report phase

> > Buildids are injected after the fact via perf inject when in pipe mode.

> > > maybe it's time to re-think that buildid -> mmap event
> > > association again, because it's pain in current implementation
> > > as well

> > Sure, but what do you propose?

> this:
> 
> > > looks like bpf code is actualy getting build ids and storing
> > > it for the callchains in kernel.. we can check if we can do
> > > something similar for mmap events

kernel/bpf/stackmap.c

/* Parse build ID from 64-bit ELF */
static int stack_map_get_build_id_64(void *page_addr,
                                     unsigned char *build_id)

yeah, wasn't aware of that, good thing doing backports, huh? :-)

So do you thing about having a PERF_SAMPLE_BUILDID in sample_type and go
and stash that thing in PERF_RECORD_MMAP2?

- Arnaldo
