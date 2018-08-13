Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715E2C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0DE2175A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+LQ65cZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0DE2175A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeHMVXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730087AbeHMVXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:23:14 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AF732175A;
        Mon, 13 Aug 2018 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534185590;
        bh=V1xNaw3rFB3glFtd/hHhBWID5kUJ/xFE6M9FAt6hHGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+LQ65cZ1rlIzyl7hNpEJWBL/jOEgeCpMk+x46rMK0uH2rK0gel0JafqnOwFCC3wz
         2544ufWG8Lu44/cAOtl1NcH8LVfvTchWAQEi57k0We/Hfwuzx2DvGKUpVff33IAoj5
         W77wmKxSUF4mWXKyMwT4SHBkeJ4X2jT0CMRxNjmQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 26808140A1C; Mon, 13 Aug 2018 15:39:48 -0300 (-03)
Date:   Mon, 13 Aug 2018 15:39:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Benno Evers <bevers@mesosphere.com>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf tools: Check for null when copying nsinfo.
Message-ID: <20180813183948.GA4499@kernel.org>
References: <20180810133614.9925-1-bevers@mesosphere.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810133614.9925-1-bevers@mesosphere.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 10, 2018 at 03:36:13PM +0200, Benno Evers escreveu:
> The argument to nsinfo__copy() was assumed to be valid, but some code paths
> exist that will lead to NULL being passed.
> 
> In particular, running 'perf script -D' on a perf.data file containing an
> PERF_RECORD_MMAP event associating the '[vdso]' dso with pid 0 earlier in
> the event stream will lead to a segfault.
> 
> Since all calling code is already checking for a non-null return value,
> just return NULL for this case as well.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Benno Evers <bevers@mesosphere.com>

Thanks, applied.

- Arnaldo
