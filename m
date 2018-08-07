Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3CAC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07E921757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0w4IRUxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07E921757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbeHGP31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbeHGP31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:29:27 -0400
Received: from jouet.infradead.org (unknown [179.95.176.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E99B2150F;
        Tue,  7 Aug 2018 13:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533647709;
        bh=SPAsKMpylxP5e9qftOv8cYxVA4qaBdYllkeHaGJFrkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0w4IRUxNjT5Lrx3/LRjty8Wh/ODOp0LCcLJPdFxNcra5CMIo8CUWeQGSWlT4q1Nra
         WekIbQME7x1l9PfFlTL2ZonKgZr8l771UAHtPad3f0G4PBP9qC7MzWFCeDHYkyru1J
         PTyyYUPv0+pXRgNdHg9EcNE3vdb3EA7wW5AC4PAQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 6C49E140A1C; Tue,  7 Aug 2018 10:15:07 -0300 (-03)
Date:   Tue, 7 Aug 2018 10:15:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/2] perf map: synthesize maps only for thread group
 leader
Message-ID: <20180807131507.GA4173@kernel.org>
References: <153363294102.396323.6277944760215058174.stgit@buzz>
 <20180807124334.GD7716@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807124334.GD7716@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 07, 2018 at 02:43:34PM +0200, Jiri Olsa escreveu:
> On Tue, Aug 07, 2018 at 12:09:01PM +0300, Konstantin Khlebnikov wrote:
> > Threads share map_groups, all map events are merged into it.
> > 
> > Thus we could send mmaps only for thread group leader.
> > Otherwise it took ages to attach and record something from
> > processes with many vmas and threads.
> > 
> > Thread group leader could be already dead,
> > but it seems perf cannot handle this case anyway.
> 
> nice, could mention in the changelog that we actualy
> synthesize the group leader (if we found one) for the
> thread even if it's not present in the thread_map,
> so the process maps are always in data
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

I'll add your notes, thanks everyone,

- Arnaldo
