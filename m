Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6168CC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0567220989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="fqvkf7Wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0567220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeIXAJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 20:09:53 -0400
Received: from one.firstfloor.org ([193.170.194.197]:48274 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeIXAJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 20:09:53 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 3CE4086F02; Sun, 23 Sep 2018 20:11:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1537726292;
        bh=UTQd1LgKVrWffTLf79H8MVxoOWCMq3nE77+HLrSPJx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqvkf7WkHwBwebzqcCBfaq4Ba8WOlCHT/oulYKQgTDIO7gnzMykAVUcwUEpEN3dox
         V0V5Ch1y8CAngyzCOA6Ao+L6bsXGg6RGkpZjt6rsqVDZ9deLDtLa58pawDmZGlOBsM
         Tr9XHWD/w8AFnQShe2YQktRLyMRgUWDnhc1a5pcQ=
Date:   Sun, 23 Sep 2018 11:11:32 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] perf tools: Do not zero sample_id_all for group members
Message-ID: <20180923181131.74hgadvfsbgtjf2f@two.firstfloor.org>
References: <20180923150420.27327-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923150420.27327-1-jolsa@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 05:04:20PM +0200, Jiri Olsa wrote:
> Andi reported following malfunction:
> 
>   # perf record -e '{ref-cycles,cycles}:S' -a sleep 1
>   # perf script
>   non matching sample_id_all
> 
> That's because we disable sample_id_all bit for non-sampling
> group members. We can't do that, because it needs to be the
> same over the whole event list. This patch keeps it untouched
> again.
> 
> Fixes: e9add8bac6c6 ("perf evsel: Disable write_backward for leader sampling group events")
> Reported-by: Andi Kleen <andi@firstfloor.org>
> Link: http://lkml.kernel.org/n/tip-y7hc1i6en4saxqxuwr2g24f1@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Tested-by: Andi Kleen <ak@linux.intel.com>

Should be also cc stable please

-Andi
