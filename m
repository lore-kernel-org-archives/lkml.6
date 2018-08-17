Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AB12188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5ukd1OJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AB12188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeHQRvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbeHQRvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:51:10 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B242A2188F;
        Fri, 17 Aug 2018 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534517251;
        bh=7JLYyD0D5MUgDOHksZocbYSKZNAR0buHHlYqoCuZ9po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5ukd1OJ6KA3g5pdqgWvxQw+n2sl/5J7iLGi247Q4e7yyIVHSi1pnmdvcgDpFhWeq
         0/ld5dbDswqJ5bIYSSwPp98P/8EoSVH4/YbZWbkTqkiWioz8GNBo7U3FQyctt3UmrU
         wlLlKWLq8cCGARWuX42o+O9+iPPyCPXxnm/JkSag=
Date:   Fri, 17 Aug 2018 16:47:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 3/5] perf/hw_breakpoint: Remove superfluous
 bp->attr.disabled = 0
Message-ID: <20180817144727.GC12426@lerouge>
References: <20180810104730.3293-1-jolsa@kernel.org>
 <20180810104730.3293-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810104730.3293-4-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 12:47:28PM +0200, Jiri Olsa wrote:
> Once the breakpoint was succesfully modified, the attr->disabled
> value is in bp->attr.disabled. So there's no reason to set it
> again, removing that.
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Link: http://lkml.kernel.org/n/tip-v5oaellzsmyszv3rfucuxkp0@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>
