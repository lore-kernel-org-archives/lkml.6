Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5FEC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669D3215EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u87DRgXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669D3215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeHQRxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeHQRxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:53:50 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E0E8215EB;
        Fri, 17 Aug 2018 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534517410;
        bh=0aAZxpYH6muouKr2Dh0ZQT52JKIb0vVxS5IvmeAwjqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u87DRgXTLyB3ayiA4chEzNeGfwd+zgmqkOkkn84ctRs7oLHpLJgxRHQIkbvv06uCt
         oKes7xVOr/ThCIvstYHYhjiaGaTEd1KaqWdNS2wQ4lx7HZ/b10jMx2A9ty04hGn/QJ
         RE3X004A3JINiGs97X96buYkFrQ8u3gecfJc/NSE=
Date:   Fri, 17 Aug 2018 16:50:08 +0200
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
Subject: Re: [PATCH 4/5] perf/hw_breakpoint: Enable breakpoint in
 modify_user_hw_breakpoint
Message-ID: <20180817145007.GD12426@lerouge>
References: <20180810104730.3293-1-jolsa@kernel.org>
 <20180810104730.3293-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810104730.3293-5-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 12:47:29PM +0200, Jiri Olsa wrote:
> Currently we enable the breakpoint back only if the breakpoint
> modification was successful. If it fails we can leave the
> breakpoint in disabled state with attr->disabled == 0.
> 
> We can safely enable the breakpoint back for both the fail
> and success paths by checking the bp->attr.disabled, which
> either holds the new 'requested' disabled state or the
> original breakpoint state.
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Link: http://lkml.kernel.org/n/tip-79p9ttocwy2ju2s6qh25dvre@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks a lot!
