Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C759C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176EC21A5B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt9jabvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176EC21A5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbeHFUmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731697AbeHFUmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:42:53 -0400
Received: from jouet.infradead.org (unknown [177.79.80.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A01A21A52;
        Mon,  6 Aug 2018 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533580353;
        bh=D58SY5RGwd34cg4l054xFyn3LTip8873xZYiE/mejx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jt9jabvEIMcvBrwU4p9xe7v5oLElSxNk57jX90hPtzHJQ113z5NgPZfBdXrMhfg9X
         LrfS45ttGIqBZl7IoZIsMHauTZcy/uxZQElo17crck/lUIvc1mJ4hzRXwqy22UzK4q
         vyJEgwWMjcBdsjTIDsTqmzHMRBrkCKMsp0tfmch8=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 4589F140A1C; Mon,  6 Aug 2018 15:32:29 -0300 (-03)
Date:   Mon, 6 Aug 2018 15:32:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 19/20] perf annotate: Add --percent-type option
Message-ID: <20180806183229.GD22917@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-20-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804130521.11408-20-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 04, 2018 at 03:05:20PM +0200, Jiri Olsa escreveu:
> Adding --percent-type option to set annotation percent type
> from following choices:
>   global-period, local-period, global-hits, local-hits
> 
> Examples:
>   $ perf annotate --percent-type period-local --stdio | head -1
>    Percent         |      Source code ... es, percent: local period)
>   $ perf annotate --percent-type hits-local --stdio | head -1
>    Percent         |      Source code ... es, percent: local hits)
>   $ perf annotate --percent-type hits-global --stdio | head -1
>    Percent         |      Source code ... es, percent: global hits)
>   $ perf annotate --percent-type period-global --stdio | head -1
>    Percent         |      Source code ... es, percent: global period)
> 
> The local/global keywords set if the percentage is computed
> in the scope of the function (local) or the whole data (global).
> 
> The period/hits keywords set the base the percentage is computed
> on - the samples period or the number of samples (hits).

Thanks, tested, applied.

- Arnaldo
