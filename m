Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDC4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298EA20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaRZCXIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298EA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeLCKw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:52:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51346 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeLCKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:52:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id s14so5269515wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r6uB0Si4hPYNdPDLm5hKZ/qA9rvQbX0yhcqEzm42F3g=;
        b=KaRZCXIxKj3/dg0cXM5PbV3hgd5XT9vsbAl3+uhj2QyBCn2A3MK8pqc2FngLF8WaHo
         iLfx11ItW9Y8wonFuL/R6EW6V88cKu0/31ZkD8S4k0B6VcM3c/AWxW7hbDBTY4fuPP23
         k4kbyu/lPrqc8RX7KnGD/CoZbEfoehs4ZrsjJuDOnWUEkqJbWlRRyoEefE6Z62nmmFZq
         oH7JSq+EBrq+VibQxvpelpkjqVGsGHecYZkSV0+aP2w3gc9yT0xWhYxTvmpoXY4NGC/1
         h3JJfUR+6I0bvomONZ5Uriaew1FlfHb1SAZnM21C43IoXSJATsYS3F77PmLUZJJHRsm2
         SoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r6uB0Si4hPYNdPDLm5hKZ/qA9rvQbX0yhcqEzm42F3g=;
        b=e7M2owTukVeGaP2lMGM0G7byfQyzOwiWzTNy4eKAx01z5/4G/KNGqsKFbUJs+9okxm
         an8LeJ5S658EE3JOLR9CD9ekXY01UfoaNFygB34JNwsTB+zUTG7ZafDwAU7HTfz2tpwB
         G56jv2kOWGvTA9kWukx7+5CWlvGkkDF9jf0ChKFmQk4kk2c0lfVwmImodkGujdMkd51e
         OUJz1EXf4NEx4hoNV9+7oOaSRcsznPKkddpaF90WcFY42OX59MjIazuK3Die3MDWYAi8
         /6WUa4dcWCieUHC4B0Sml5numVz0EcN7EcbRCpSz8ftUjFaI5JwSE6u0eh0Fm3YfKEmZ
         irkw==
X-Gm-Message-State: AA+aEWYeW8BY7mG2qNvP39+Btk3BMKyUtBPf3Up9Dk/1Z/WdnShjSS3Z
        4FPZPkzKK1F8o/CjUwOrm3w=
X-Google-Smtp-Source: AFSGD/VkcakojrnVGNYT9MIhmI/IDQOzEPDYK1JtaOrjG7AJ4DFVCYbmRm8C7zPP/moPUpIyuJfxCg==
X-Received: by 2002:a1c:b456:: with SMTP id d83mr8249440wmf.115.1543834342881;
        Mon, 03 Dec 2018 02:52:22 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t131sm9776177wmt.1.2018.12.03.02.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 02:52:22 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:52:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@infradead.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] tools: Fix diverse typos
Message-ID: <20181203105219.GA104329@gmail.com>
References: <20181203102200.GA104797@gmail.com>
 <20181203103107.GC11573@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203103107.GC11573@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Dec 03, 2018 at 11:22:00AM +0100, Ingo Molnar wrote:
> > Go over the tools/ files that are maintained in Arnaldo's tree and
> > fix common typos: half of them were in comments, the other half
> > in JSON files.
> > 
> > ( Care should be taken not to re-import these typos in the future,
> >   if the JSON files get updated by the vendor without fixing the typos. )
> 
> >  .../perf/pmu-events/arch/x86/broadwell/cache.json  |  4 +--
> >  .../pmu-events/arch/x86/broadwell/pipeline.json    |  2 +-
> >  .../pmu-events/arch/x86/broadwellde/cache.json     |  4 +--
> >  .../pmu-events/arch/x86/broadwellde/pipeline.json  |  2 +-
> >  .../perf/pmu-events/arch/x86/broadwellx/cache.json |  4 +--
> >  .../pmu-events/arch/x86/broadwellx/pipeline.json   |  2 +-
> >  tools/perf/pmu-events/arch/x86/jaketown/cache.json |  4 +--
> >  .../pmu-events/arch/x86/jaketown/pipeline.json     |  2 +-
> >  .../pmu-events/arch/x86/knightslanding/cache.json  | 30 +++++++++++-----------
> >  .../pmu-events/arch/x86/sandybridge/cache.json     |  4 +--
> >  .../pmu-events/arch/x86/sandybridge/pipeline.json  |  2 +-
> >  .../pmu-events/arch/x86/skylakex/uncore-other.json | 12 ++++-----
> 
> Yeah, so I think those are generated from somewhere, fixing them here
> isn't going to nessecarily help much.

It's in our source code, the output is visible to our users, so such 
typos should be fixed.

But yes, I agree that the fixes should also be applied at the Intel 
source of the JSON definitions.

Thanks,

	Ingo
