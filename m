Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74896C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E442082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E442082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeH3M6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:58:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbeH3M6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:58:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B92D2807A0C2;
        Thu, 30 Aug 2018 08:56:55 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id B2C4A202704E;
        Thu, 30 Aug 2018 08:56:54 +0000 (UTC)
Date:   Thu, 30 Aug 2018 10:56:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 01/10] perf tools: Report itrace options in help
Message-ID: <20180830085654.GD16691@krava>
References: <20180829171834.6590-1-andi@firstfloor.org>
 <20180829171834.6590-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829171834.6590-2-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 08:56:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 08:56:55 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:18:25AM -0700, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index e731f55da072..f3f7ad6ae202 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -576,6 +576,23 @@ static inline void auxtrace__free(struct perf_session *session)
>  	return session->auxtrace->free(session);
>  }
>  
> +#define ITRACE_HELP \
> +"		i	    synthesize instructions events\n"		\
> +"		b	    synthesize branches events\n"		\
> +"		c	    synthesize branches events (calls only)\n"	\
> +"		r	    synthesize branches events (returns only)\n" \
> +"		x	    synthesize transactions events\n"		\
> +"		w	    synthesize ptwrite events\n"		\
> +"		p	    synthesize power events\n"			\
> +"		e	    synthesize error events\n"			\
> +"		d	    create a debug log\n"			\
> +"		g[len]       synthesize a call chain (use with i or x)\n" \
> +"		l[len]       synthesize last branch entries (use with i or x)\n" \
> +"		sNUMBER      skip initial number of events\n"		\
> +"		PERIOD[ns|us|ms|i|t]   specify period to sample stream\n" \
> +"		concatenate multiple options. Default is ibxwpe\n"
> +
> +

Please align this a bit more (perf report usage) and add the ':'

        --itrace[=<opts>]
                          Instruction Tracing options
                i           synthesize instructions events
                b           synthesize branches events
                c           synthesize branches events (calls only)
                r           synthesize branches events (returns only)
                x           synthesize transactions events
                w           synthesize ptwrite events
                p           synthesize power events
                e           synthesize error events
                d           create a debug log
                g[len]       synthesize a call chain (use with i or x)
                l[len]       synthesize last branch entries (use with i or x)
                sNUMBER      skip initial number of events
                PERIOD[ns|us|ms|i|t]   specify period to sample stream
                concatenate multiple options. Default is ibxwpe


like for example for '-g' option:

    -g, --call-graph <print_type,threshold[,print_limit],order,sort_key[,branch],value>
                          Display call graph (stack chain/backtrace):

                                print_type:     call graph printing style (graph|flat|fractal|folded|none)
                                threshold:      minimum call graph inclusion threshold (<percent>)
                                print_limit:    maximum number of call graph entry (<number>)
                                order:          call graph order (caller|callee)
                                sort_key:       call graph sort key (function|address)
                                branch:         include last branch info to call graph (branch)
                                value:          call graph value (percent|period|count)

                                Default: graph,0.5,caller,function,percent


jirka
