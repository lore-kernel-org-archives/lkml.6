Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70D4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CB02080D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545502472;
	bh=3bm8Euy/SAhaNjmG5E1aNugGzLbj3K4H5FerKJ33SE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oEv/THp/r/Tpsck7b/tevOJFMqY5WBIZv5eJwwfe/3vlEOcKy6ccjOIdxCL+S2k5f
	 LZgTmHH6rU8HUiVconLkGsDoU7y5VUH++0Y75Halym8fAdJBVRFg67mQix7Gdhwtx0
	 VxncMdHj8SztlLVZW4Vyq0nJrmEfp0kxGKBJefaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390744AbeLVSOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:14:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37780 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbeLVSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:14:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so3946869plr.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 10:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p8wijyBRq2p+xnfMxdAbjzvJMsJ1ju2zFr2YZuH91HM=;
        b=bFO4/c80T39m7A9SO3ZrxnYxidIuP4xdGzWpr3b3wWvRW3S8On3i6LcolxKl6hoKNv
         7ibjqYkGnFd2hJq+kcbf54e6NEpkCfPRabSttzhuMxxtrizdLLK05RHtXiuZSsLYzpwh
         N9S1O2eoJr9Uh4beihzZbAUp/fm22F5PTRCmeZCsDbHyzXpji4divqxXZSTpNwqCuv/K
         XAPFxjY0QZlrxhlXtO+704TcnWoWQNWJB1vQc6UBSfuXeNZgqlN7Df05zvK38yp397i7
         YRiqAtRPdt6wNRvNZ5lCmI+LeXTVqh44S+BZRznUUOnhGek2iIlURrNWcP2AHbMPtbKJ
         u2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p8wijyBRq2p+xnfMxdAbjzvJMsJ1ju2zFr2YZuH91HM=;
        b=tdkiFvrwlRkrnCa3Atq3TMRWgxpOe+40bxc65my6M9bY4nJxFAOYR9IhvMWqa0DJlV
         URKHqDsbCF/rfyLEhESzzbOzTs96GW8hrTGURPHupzZkMcDWfb29pIuC9jOeM2Pebhbf
         T87L2ztfTSTMcoBLU7G6/9oEg+DS/pKwyLzmZrhuEDa1PIkWQ61O+bY+Aiz2iUX0s/b3
         N9oaUb+HUnYiDpZ1mAZIJHKn5D9iDbvn7HAPt6dC99Y+fbrfRjKXxIN5VEUcEO2Dcbkb
         a/68D4eYJKqG3t9Dtk2jPDJkRxoSYLYNtWmhKYLcaL+pIuOUlBHGPQwhUNKZts7HT5rF
         fyLQ==
X-Gm-Message-State: AJcUukc4FgwtNZpx5lNi0KmwqQJbmXZrknt1lnnY1eqdlzRqXHpDIRqo
        8lmgNVM5wqUXgY2LWoyFXfxGgz+5
X-Google-Smtp-Source: ALg8bN7QISYwMn7Sd/rNKmnFK2z7LAZbtkjLT4GczUsp0vsfPehJ4JSKOFgw95fRHBKfhJGJH8k2gQ==
X-Received: by 2002:a17:902:6bc9:: with SMTP id m9mr5747484plt.173.1545470905080;
        Sat, 22 Dec 2018 01:28:25 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id l70sm28901632pgd.20.2018.12.22.01.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 01:28:23 -0800 (PST)
Date:   Sat, 22 Dec 2018 18:28:18 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH v3] string.h: Add str_has_prefix() helper
Message-ID: <20181222092818.GA7610@danjae.aot.lge.com>
References: <20181221181316.6d32bdc8@gandalf.local.home>
 <b77cd7378434bf8ea804f2fd0caa662b9b7d07f0.camel@perches.com>
 <20181221182507.2fdc756f@gandalf.local.home>
 <20181221183817.5b3eecdd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181221183817.5b3eecdd@gandalf.local.home>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, Dec 21, 2018 at 06:38:17PM -0500, Steven Rostedt wrote:
> On Fri, 21 Dec 2018 18:25:07 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 21 Dec 2018 15:19:33 -0800
> > Joe Perches <joe@perches.com> wrote:
> > 
> > > I believe this should be bool.
> > > 
> > > I don't find a use for non-zero assigned len value in the kernel
> > > for strncmp and I believe the function should simply be:
> > > 
> > > static inline bool str_has_prefix(const char *str, const char prefix[])
> > > {
> > > 	return !strncmp(str, prefix, strlen(prefix));
> > > }  
> > 
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index 3bb2b3351e35..e4566b9c2553 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -172,8 +172,8 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
> >  		 * it's not worth the risk */
> >  		return -EINVAL;
> >  
> > -	if (strncmp(buf, temp, sizeof(temp) - 1) == 0) {
> > -		buf += sizeof(temp) - 1;
> > +	if ((len = str_has_prefix(buf, temp))) {
> > +		buf += len;
> >  		sdkp->cache_override = 1;
> >  	} else {
> >  		sdkp->cache_override = 0;
> > 
> > And there's more places like this.
> >
> 
> Heck, even the tracing code would like this. From the code that started
> this entire discussion:
> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 9d590138f870..632410c6e6c0 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4342,12 +4342,13 @@ static int parse_actions(struct hist_trigger_data *hist_data)
>  	unsigned int i;
>  	int ret = 0;
>  	char *str;
> +	int len;
>  
>  	for (i = 0; i < hist_data->attrs->n_actions; i++) {
>  		str = hist_data->attrs->action_str[i];
>  
> -		if (str_has_prefix(str, "onmatch(")) {
> -			char *action_str = str + sizeof("onmatch(") - 1;
> +		if ((len = str_has_prefix(str, "onmatch("))) {
> +			char *action_str = str + len;

IMHO, returning (match) length might confuse people that it might
support partial match and returns the length actually matched rather
than full match.  If I knew it always returns the length of prefix (or
0) why it matters?  Using strlen() in the next line will have same
effect of compiler optimization for the constant strings, no?

		if (str_has_prefix(str, "onmatch(")) {
			char *action_str = str + strlen("onmatch(");

Thanks,
Namhyung


>  
>  			data = onmatch_parse(tr, action_str);
>  			if (IS_ERR(data)) {
> @@ -4355,8 +4356,8 @@ static int parse_actions(struct hist_trigger_data *hist_data)
>  				break;
>  			}
>  			data->fn = action_trace;
> -		} else if (str_has_prefix(str, "onmax(")) {
> -			char *action_str = str + sizeof("onmax(") - 1;
> +		} else if ((len = str_has_prefix(str, "onmax("))) {
> +			char *action_str = str + len;
>  
>  			data = onmax_parse(action_str);
>  			if (IS_ERR(data)) {
