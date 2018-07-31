Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE659C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8F7208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx4HpUUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8F7208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeGaQFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732231AbeGaQFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:05:21 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0FEC20870;
        Tue, 31 Jul 2018 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533047087;
        bh=MUEgzfbFWP/qltExoeBiMnyqOIg9r+QATKhMZLtW2nA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fx4HpUUZVtv77xfE7w/3cwt2SirUnfHXYXuHy4iSf78/bYnvpOuxFIUCNxcBLtKCE
         8nlPFn4I8jEifZGUBjg3zl2QHWcULwQb/Iv8SSUlcZKIcTT/znymQjRwHGCmELR5Zj
         /NB7ZEkHZQWptwzRqr4mM7uH4ZHArU7QQByjC2sA=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 46FE31403B8; Tue, 31 Jul 2018 11:24:45 -0300 (-03)
Date:   Tue, 31 Jul 2018 11:24:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     leo.yan@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH v2 0/6] perf cs-etm: Fix tracing packet handling and
 minor refactoring
Message-ID: <20180731142445.GB4909@kernel.org>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
 <20180723013507.GA27713@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723013507.GA27713@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 23, 2018 at 09:35:07AM +0800, leo.yan@linaro.org escreveu:
> Hi Arnaldo,
> 
> On Wed, Jul 11, 2018 at 03:45:39PM +0800, Leo Yan wrote:
> 
> Just want to confirm, I saw the first two patches in this serise have
> been merged into perf/core branch [1], but the last 4 patches are
> missed.
> 
> Could I know if you have trouble when you apply them?  Or anything
> need me to follow up?  Otherwise you might miss them :)

Just this reminder was enough, checked that it has Mathieu's reviewed-by
tags, applied, will go thru my cross build containers, hopefully all
will test build ok and then it'll go to Ingo's direction.

Thanks,

- Arnaldo
