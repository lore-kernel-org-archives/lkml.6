Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67460C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30ECC20685
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406162AbfBOOOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:14:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfBOOOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:14:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB245A0B99;
        Fri, 15 Feb 2019 14:14:07 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-32.phx2.redhat.com [10.3.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 198345D9CA;
        Fri, 15 Feb 2019 14:14:07 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 8D6EE55C4; Fri, 15 Feb 2019 12:14:07 -0200 (BRST)
Date:   Fri, 15 Feb 2019 12:14:07 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v2 perf,bpf 01/11] perf, bpf: consider events with
 attr.bpf_event as side-band events
Message-ID: <20190215141407.GA5784@redhat.com>
References: <20190214235624.2579307-1-songliubraving@fb.com>
 <20190214235840.2587123-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214235840.2587123-1-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 15 Feb 2019 14:14:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 14, 2019 at 03:58:40PM -0800, Song Liu escreveu:
> Events with bpf_event should be considered as side-band event, as they
> carry information about BPF programs.
> 
> Fixes: 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  kernel/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0a8dab322111..9403bdda5f8c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4238,7 +4238,8 @@ static bool is_sb_event(struct perf_event *event)
>  	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
>  	    attr->comm || attr->comm_exec ||
>  	    attr->task || attr->ksymbol ||
> -	    attr->context_switch)
> +	    attr->context_switch ||
> +	    attr->bpf_event)

What about attr->ksymbol?

- Arnaldo

>  		return true;
>  	return false;
>  }
> -- 
> 2.17.1
