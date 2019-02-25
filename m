Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33909C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C732146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfBYM4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:56:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfBYM4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:56:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47FA23DE07;
        Mon, 25 Feb 2019 12:56:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9039A10018F9;
        Mon, 25 Feb 2019 12:56:36 +0000 (UTC)
Date:   Mon, 25 Feb 2019 13:56:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 07/11] perf tools report: Support running scripts for
 current time range
Message-ID: <20190225125635.GL19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-8-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-8-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 25 Feb 2019 12:56:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:18AM -0800, Andi Kleen wrote:

SNIP

> +			endtime += 1*1000000;
> +		}
> +		timestamp__scnprintf_usec(starttime, start, sizeof start);
> +		timestamp__scnprintf_usec(endtime, end, sizeof end);
> +		n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
> +	}
> +
>  	script_browse(script_opt);
> +	free(script_opt);
>  	return 0;
>  }
>  
>  static int
> -add_script_opt(struct hist_browser *browser __maybe_unused,
> +add_script_opt_2(struct hist_browser *browser __maybe_unused,
>  	       struct popup_action *act, char **optstr,
> -	       struct thread *thread, struct symbol *sym)
> +	       struct thread *thread, struct symbol *sym,
> +	       const char *tstr)
>  {
> +
>  	if (thread) {
> -		if (asprintf(optstr, "Run scripts for samples of thread [%s]",
> -			     thread__comm_str(thread)) < 0)
> +		if (asprintf(optstr, "Run scripts for samples of thread [%s]%s",
> +			     thread__comm_str(thread), tstr) < 0)
>  			return 0;
>  	} else if (sym) {
> -		if (asprintf(optstr, "Run scripts for samples of symbol [%s]",
> -			     sym->name) < 0)
> +		if (asprintf(optstr, "Run scripts for samples of symbol [%s]%s",
> +			     sym->name, tstr) < 0)
>  			return 0;
>  	} else {
> -		if (asprintf(optstr, "Run scripts for all samples") < 0)
> +		if (asprintf(optstr, "Run scripts for all samples%s", tstr) < 0)
>  			return 0;

can't see the time ranges in the menu.. what's the path
to get them listed?

thanks,
jirka
