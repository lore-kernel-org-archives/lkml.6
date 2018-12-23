Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E62C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7FA2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545535947;
	bh=YLsU/NxlhpF41taezA2HjWV3Z+hbaYc9AR2fuqPVD7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eHW0Au2gYbVlUow6GKokLNULEoA+Uf9iXV/dBWjH3McLtapqWmIeEso3m56E1dyNr
	 7yb7ep96S0UrjfW+k/PuJ007I5/IwyT4NX5G9NVRu/Tzy3HyF6G+FqmNB63Ma/qJ/W
	 eiPoVNSHNMZJPwz39psoxqnZVWzLyIz9Qzd4yr+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404476AbeLWDcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:32:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47070 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbeLWDcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:32:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so4403706pfe.13;
        Sat, 22 Dec 2018 19:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oV3zr4MnLGh2ry7Sv/owO+o1AIiTOg2vmC4Wn6MbKHw=;
        b=WB8nk35Rzx4dEONG/y1UDTj/lP+4xFxg8CsxvKZhqgeCym+Y96SvT6e2wSX1HGj4C0
         u8PDpHNIdDNLoFKubeseIAnI1EMzb+rvWH+RbAPv2ta9L97kvmNOLwxs+06SN+vKdeV7
         KcJEhipHj8gJzTeCP1NWhyIID4L0gUEhXtimS83q0VwBOQFqYsYXxdiNNi/MRwJ02bao
         /Z+TCuYr89QV1nmB9X0FxJpNtcDdOMtHIzQshcSNWk6zLuVcMgcUPeVbJPvGtJ2CFp2A
         fCAOGP8GBrAt6HUUkny/UkE8Q+cI9tUpoeMhEV9633FSR0/YinHIoBd4hF89TO0VdULZ
         imsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oV3zr4MnLGh2ry7Sv/owO+o1AIiTOg2vmC4Wn6MbKHw=;
        b=t41ikhiVNGxAC9/N+b3hIOpeJFyl3XqLWD2+ala7hMagQ5Gowu2E3vKvavWnAIMwV8
         FhJLDhjZovSe9F4a1hA2Y8R+dyid4D8MzsoSPwLlvyRPwLvKK1U6OEis8u6TZPOKArnT
         AK2IoinDTsezKWzqd8xKNT+Mz2zHguzrk8kYbU4plksdC0kF6grMYx5urLRrzisOlrQs
         4ZuEUihu8F95mWpMAUz4vlnAlAxKIAeN16uXxQ7zMOI7c+dLm6iiQK7PZzJXwgY5HOQY
         UFkBmhOyI467Bf6JCctTiHQrBe0/LCSlGe/NrlWUaXelfDKS3uNdY1qxZi48zno/T8Cr
         UwJg==
X-Gm-Message-State: AA+aEWZj0RV592nhLSa2KD0bc+/IiFRCSDdGmqjdDNjmbyNMUBIYqImE
        YqIJhwywkbvo7uhS59qLi2c=
X-Google-Smtp-Source: AFSGD/V+jbbl2Owbc+cIKfhkxqChooBMZM3C3FRtAxYEzYSFEw+HOGWUgFe+CcSlb6fachLl9GccOA==
X-Received: by 2002:a62:62c5:: with SMTP id w188mr8641482pfb.160.1545535943641;
        Sat, 22 Dec 2018 19:32:23 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id 64sm33591750pff.101.2018.12.22.19.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 19:32:22 -0800 (PST)
Date:   Sun, 23 Dec 2018 12:32:17 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Tom Zanussi <zanussi@linux.intel.com>, kernel-team@lge.com
Subject: Re: [for-next][PATCH 2/5] tracing: Use str_has_prefix() helper for
 histogram code
Message-ID: <20181223033217.GD11421@danjae.aot.lge.com>
References: <20181222162007.697862256@goodmis.org>
 <20181222162856.666843139@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181222162856.666843139@goodmis.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 11:20:09AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The tracing histogram code contains a lot of instances of the construct:
> 
>  strncmp(str, "const", sizeof("const") - 1)
> 
> This can be prone to bugs due to typos or bad cut and paste. Use the
> str_has_prefix() helper macro instead that removes the need for having two
> copies of the constant string.
> 
> Cc: Tom Zanussi <zanussi@linux.intel.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index c5448c103770..9d590138f870 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1881,8 +1881,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
>  	if (attrs->n_actions >= HIST_ACTIONS_MAX)
>  		return ret;
>  
> -	if ((strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) ||
> -	    (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0)) {
> +	if ((str_has_prefix(str, "onmatch(")) ||
> +	    (str_has_prefix(str, "onmax("))) {
>  		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->action_str[attrs->n_actions]) {
>  			ret = -ENOMEM;
> @@ -1899,34 +1899,34 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
>  {
>  	int ret = 0;
>  
> -	if ((strncmp(str, "key=", sizeof("key=") - 1) == 0) ||
> -	    (strncmp(str, "keys=", sizeof("keys=") - 1) == 0)) {
> +	if ((str_has_prefix(str, "key=")) ||
> +	    (str_has_prefix(str, "keys="))) {
>  		attrs->keys_str = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->keys_str) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if ((strncmp(str, "val=", sizeof("val=") - 1) == 0) ||
> -		 (strncmp(str, "vals=", sizeof("vals=") - 1) == 0) ||
> -		 (strncmp(str, "values=", sizeof("values=") - 1) == 0)) {
> +	} else if ((str_has_prefix(str, "val=")) ||
> +		   (str_has_prefix(str, "vals=")) ||
> +		   (str_has_prefix(str, "values="))) {
>  		attrs->vals_str = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->vals_str) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "sort=", sizeof("sort=") - 1) == 0) {
> +	} else if (str_has_prefix(str, "sort=")) {
>  		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->sort_key_str) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "name=", sizeof("name=") - 1) == 0) {
> +	} else if (str_has_prefix(str, "name=")) {
>  		attrs->name = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->name) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "clock=", sizeof("clock=") - 1) == 0) {
> +	} else if (str_has_prefix(str, "clock=")) {
>  		strsep(&str, "=");
>  		if (!str) {
>  			ret = -EINVAL;
> @@ -1939,7 +1939,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "size=", sizeof("size=") - 1) == 0) {
> +	} else if (str_has_prefix(str, "size=")) {
>  		int map_bits = parse_map_size(str);
>  
>  		if (map_bits < 0) {
> @@ -3558,7 +3558,7 @@ static struct action_data *onmax_parse(char *str)
>  	if (!onmax_fn_name || !str)
>  		goto free;
>  
> -	if (strncmp(onmax_fn_name, "save", sizeof("save") - 1) == 0) {
> +	if (str_has_prefix(onmax_fn_name, "save")) {
>  		char *params = strsep(&str, ")");
>  
>  		if (!params) {
> @@ -4346,7 +4346,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
>  	for (i = 0; i < hist_data->attrs->n_actions; i++) {
>  		str = hist_data->attrs->action_str[i];
>  
> -		if (strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) {
> +		if (str_has_prefix(str, "onmatch(")) {
>  			char *action_str = str + sizeof("onmatch(") - 1;

You'd better using the return value of str_has_prefix().


>  
>  			data = onmatch_parse(tr, action_str);
> @@ -4355,7 +4355,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
>  				break;
>  			}
>  			data->fn = action_trace;
> -		} else if (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0) {
> +		} else if (str_has_prefix(str, "onmax(")) {
>  			char *action_str = str + sizeof("onmax(") - 1;

Ditto.

Thanks,
Namhyung


>  
>  			data = onmax_parse(action_str);
> -- 
> 2.19.2
> 
> 
