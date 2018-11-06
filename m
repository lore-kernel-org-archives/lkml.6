Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EC8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158872085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158872085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbeKFVQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:16:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729878AbeKFVQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:16:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E2BD811A9;
        Tue,  6 Nov 2018 11:51:24 +0000 (UTC)
Received: from krava (unknown [10.40.205.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id BCE3417D5F;
        Tue,  6 Nov 2018 11:51:22 +0000 (UTC)
Date:   Tue, 6 Nov 2018 12:51:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181106115121.GD3164@krava>
References: <20181104201821.GA22049@krava>
 <20181104.165039.878682622135788379.davem@davemloft.net>
 <20181105203447.GA25674@krava>
 <20181105.194542.476367332910923203.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105.194542.476367332910923203.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 06 Nov 2018 11:51:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 07:45:42PM -0800, David Miller wrote:
> From: Jiri Olsa <jolsa@redhat.com>
> Date: Mon, 5 Nov 2018 21:34:47 +0100
> 
> > I pushed it in perf/fixes branch in:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> 
> Build fix for sparc below, I'm playing with this now.
> 
> perf: Use PRIu64 for printing top lost events count.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

will add this one, thanks

jirka

> 
> diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
> index db3413e..2c8eac8 100644
> --- a/tools/perf/util/top.c
> +++ b/tools/perf/util/top.c
> @@ -46,7 +46,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
>  							samples_per_sec;
>  		ret = SNPRINTF(bf, size,
>  			       "   PerfTop:%8.0f irqs/sec  kernel:%4.1f%%"
> -			       "  exact: %4.1f%% lost: %lu [", samples_per_sec,
> +			       "  exact: %4.1f%% lost: %" PRIu64 " [", samples_per_sec,
>  			       ksamples_percent, esamples_percent, top->lost);
>  	} else {
>  		float us_samples_per_sec = top->us_samples / top->delay_secs;
