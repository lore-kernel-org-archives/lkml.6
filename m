Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D0DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F79A20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrH4ZYEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfB0Rl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:41:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42053 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbfB0Rl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:41:26 -0500
Received: by mail-qt1-f193.google.com with SMTP id u7so10978439qtg.9;
        Wed, 27 Feb 2019 09:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YiZ2IQQ/0GwK/20x5Yw1mwF0b87g3oM179qo5rAXI/Y=;
        b=KrH4ZYEWkSmS2VyUT4rq8AuvqHDpKfNXMez44XdWqyMwqT3xsP/9CZWXqXqA5JoJzk
         g0LA2IKWWJbB41ZD+gn83E/8d7HtE3zuGh9HZqFeI6mbCLDKxTyaohn+TMSdrI64W0m6
         utJK+kDNksrDh4Qb/ncX/EpSqPTIqC20MrE49N1reNQQ8ewXxy7SiQs95NnODDY2d4Ln
         La7hRo8m2g98UJo38PgQAdliDEUerEybit21pi/bwTMSRm/oyppCudeK9MsCEZKyYgiu
         ewX+Z/+HLTwfuYYsTcVyN6zhzyZYLTvmGCCLIrB2rx5DCNFtU8rZUBRjUzO9bDdanmCh
         MhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YiZ2IQQ/0GwK/20x5Yw1mwF0b87g3oM179qo5rAXI/Y=;
        b=VPRvFRT2rZ+dOWqZD6m7+TmweV+wmConu/z+pu1nJeADL5SmYNh+InlOc/qwIkZ4EH
         Y7s7BpM/nsNXy6C+VzKpKZ1J9gFt2G95I6UHYFlw54zAMyh+b2jx1MXf66U3YeCBy6S0
         5mvB8LQeFcUXI4NLu59NdXykAmO8uMxTyuIFLNs49r7EGSDK3hrWgnTBLvCnwKqAw/hF
         adnf4Hg59GaMX7VxO+28ua/MxRd5/iS983XSa5pwz6gucBA2baQBffYR5n3Y2iw9WXZi
         HHJSrnleBsAeJ+dHW8CWFnGKj39/3Y/0ARU1HqJKqK0ZwA7NOZhppHkGh1s5MvQOo/mv
         TlFg==
X-Gm-Message-State: APjAAAXlFsoAVR1UuvaPLxBnGmFFE9liSvs+nVII9GgTHsGEyMTvNfP0
        LPZx9mIcZ0Ri4RNNdFnKloq5gZ+F
X-Google-Smtp-Source: AHgI3IZ42OmnmHHAqHgcrwczopVbsmGgZBLFy5UhlRNnKtQTudWfHzgZ0tcIn2keKTRgEmho8CxuZg==
X-Received: by 2002:ac8:734a:: with SMTP id q10mr2728202qtp.106.1551289284926;
        Wed, 27 Feb 2019 09:41:24 -0800 (PST)
Received: from quaco.ghostprotocols.net ([187.65.94.38])
        by smtp.gmail.com with ESMTPSA id m128sm9487421qkf.53.2019.02.27.09.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 09:41:23 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A3B44039C; Wed, 27 Feb 2019 14:41:21 -0300 (-03)
Date:   Wed, 27 Feb 2019 14:41:20 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: Support sample context in perf report
Message-ID: <20190227174120.GF13100@kernel.org>
References: <20190226030412.23485-1-andi@firstfloor.org>
 <20190227111801.GA18893@krava>
 <20190227160135.lqcckfqcrrq3aedb@two.firstfloor.org>
 <20190227161658.GA2890@krava>
 <20190227172954.kithpbfndc5jjg33@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227172954.kithpbfndc5jjg33@two.firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 27, 2019 at 09:29:54AM -0800, Andi Kleen escreveu:
> On Wed, Feb 27, 2019 at 05:16:59PM +0100, Jiri Olsa wrote:
> > On Wed, Feb 27, 2019 at 08:01:35AM -0800, Andi Kleen wrote:
> > > > > Also available in
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-2
> > > > 
> > > > your post is missing this patch, it's only in the branch:
> > > >   perf tools: Add utility function to fetch executable
> > > 
> > > Because Arnaldo already merged it. But the branch is still based
> > 
> > can't see it on his perf/core branch,
> > please paste me commit id
> 
> I don't know the commit id, but there was an email from him earlier
> that said "applied". Maybe he hasn't pushed yet.

Perhaps you're referring to this one:

commit 94816add0005595ea33fc8456519be582330401e
Author: Andi Kleen <ak@linux.intel.com>
Date:   Sun Feb 24 07:37:19 2019 -0800

    perf tools: Add perf_exe() helper to find perf binary

    Also convert one existing user.

    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Acked-by: Jiri Olsa <jolsa@kernel.org>


?

- Arnaldo
