Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB213C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F46E2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544793088;
	bh=OlHmjanRrh66c2+oTHke/nuyN5aCYv3fJxCjHsxrbv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mRye17SfbnhKDFCByG/z21es75Z+Zz7wK4CXKc7GKA197R3O+p8TAzNII1GypMA0r
	 zmls8NKoKGo9zmQ0ORtZ3kd3i9hyDwbMrtCpEPhbg1A8HFFgqrQ4za1MfUpmYOxp/x
	 UxPqvMqzKLOratqxgXOL0SLxdaGcyRE2XOf2OFdM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F46E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeLNNL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:11:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbeLNNL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:11:26 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5B020672;
        Fri, 14 Dec 2018 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544793085;
        bh=OlHmjanRrh66c2+oTHke/nuyN5aCYv3fJxCjHsxrbv4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lacGME2LdA8GCDuFiNVcwBDfvs5bxqApVzx6CsvEx1gLPDNOgR7+GASrxTGxE2oE3
         8+8Q0JYL3HLppg59Ym+3tX87aCD/QUK/HbGpB5fxAKLAtofYpaqUyBKK5BXjQCeboD
         yKpxdhqTUTWCWM0ZTDfpXNNGyTkM19mjgfx5wFQA=
Date:   Fri, 14 Dec 2018 22:11:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v8 03/22] tracing: Add hist trigger handler.action
 documentation to README
Message-Id: <20181214221121.6e3d56b7ada3b5fed6124d28@kernel.org>
In-Reply-To: <aed0a478f683ac4a7669c62d72e8a01d975e525b.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
        <aed0a478f683ac4a7669c62d72e8a01d975e525b.1544483272.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Mon, 10 Dec 2018 18:01:17 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add abbreviated documentation for handlers and actions to README.

This change itself is good to me, and I would rather like to see this
in the patch which does actual change, since user (or test code) may
check this to decide whether the kernel supports this feature or not.

If we separate this from the change, the test code may fail when bisecting.

Thank you,

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 911470ad9e94..1abde13a7eab 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4698,6 +4698,7 @@ static const char readme_msg[] =
>  	"\t            [:size=#entries]\n"
>  	"\t            [:pause][:continue][:clear]\n"
>  	"\t            [:name=histname1]\n"
> +	"\t            [:<handler>.<action>]\n"
>  	"\t            [if <filter>]\n\n"
>  	"\t    When a matching event is hit, an entry is added to a hash\n"
>  	"\t    table using the key(s) and value(s) named, and the value of a\n"
> @@ -4739,7 +4740,16 @@ static const char readme_msg[] =
>  	"\t    The enable_hist and disable_hist triggers can be used to\n"
>  	"\t    have one event conditionally start and stop another event's\n"
>  	"\t    already-attached hist trigger.  The syntax is analagous to\n"
> -	"\t    the enable_event and disable_event triggers.\n"
> +	"\t    the enable_event and disable_event triggers.\n\n"
> +	"\t    Hist trigger handlers and actions are executed whenever a\n"
> +	"\t    a histogram entry is added or updated.  They take the form:\n\n"
> +	"\t        <handler>.<action>\n\n"
> +	"\t    The available handlers are:\n\n"
> +	"\t        onmatch(matching.event)  - invoke on addition or update\n"
> +	"\t        onmax(var)               - invoke if var exceeds current max\n\n"
> +	"\t    The available actions are:\n\n"
> +	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
> +	"\t        save(field,...)                      - save current event fields\n"
>  #endif
>  ;
>  
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
