Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54AFC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C9021738
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545536165;
	bh=86gH3bvAJib7Xa4h5JN3H25N/U7ZHsqVqLixSCwM0Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m1KEWxMjoisTX+6h+nfPOqR3+5JJtSzzeOYIsRGXTy83RC/dU85rBdF1lWMFFceLo
	 JoCComhGw+YCMDWhkeCui0wTLQMbDR0uL2qBnpeN4XGJzk/TJm89NZLle10YiLpSOH
	 xwnioVgiNm+yp+QfKgNNvqN8OZ/whCYVRtMzoYuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404510AbeLWDgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:36:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33888 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404455AbeLWDgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:36:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so4279452pga.1;
        Sat, 22 Dec 2018 19:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AHbqowbkMoQ3c2QbXVsH5NwHfnLVRazHZSHubUVlEhw=;
        b=hKskbj4f9sYxiWju8xkNUWABrGPc4jre1Tt9bXEBGZAJqrxaJaWlgrTW8QJ4zOJnZq
         sL+SJWZgUDZhmk1KBnztITHGwwaF+HFhPlTzdAJbMXVLaPvxEv5MWRDS2XIMM8feTos1
         UAO6JHYc/psXTHfsaCYRg78BP1JZxkT4oQiMoxIxthwTaZdTztUG3ob5Wym30ZDHRXhU
         wCxNc5EZmykTYenp9jQ/bS9ka6MqBsTzGKGOEUvbhTonywES70FXfqeNGfvIQwXdjReb
         s3SXNE9NzWjGs5Hqzt7vf5ntB/Qe8z2adjE77zT53YIR4BHBZMngtEa/TMM3nI66HKQ8
         kE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AHbqowbkMoQ3c2QbXVsH5NwHfnLVRazHZSHubUVlEhw=;
        b=J4rEtObvIJkYKnAb2YTy4V2llUY5d6FtWW6o1GDjsY0dvLeUmYc25sEvBm5d9ZuxCS
         fugXBv/HIXDddq/Wwd+uCvoqWQy1Raf+fa0X8qKNk2BoCCQH7TyTjHKIQVgrhpgLMS9g
         rzY7F0td7N7sp/IlMmBuKfeZdQN6HpxaQcDEpQvAHTA7MVdZvr55Cl+RBjImNo6vw0d8
         th9HftAIvYTqdV77lKmk7Fp3Dv6hcryiqHDrYA67UcsTlg5CcR59dB83+Q/4NvauibHe
         mRpkiDqLHVFKIyhuU92rdJRjYdBLEaXjgYdbO/Bjnl5QzTcP+6474rVErJyExOkux3Mw
         Pzig==
X-Gm-Message-State: AA+aEWZifS42B2V0eJTiIt8UgzzWFWGpM4lZpHgnrSXHgINHNhvIC2jc
        vYtyxBdNBYH7iFXHyeGmXss=
X-Google-Smtp-Source: AFSGD/VugTeCSZs5XaLsJ+dbrXER9L0y5595Y/X4lZlaHzkkUheN7vhNNjAVCSPZr8guBgsbkstBQg==
X-Received: by 2002:a62:528e:: with SMTP id g136mr8940190pfb.111.1545536162947;
        Sat, 22 Dec 2018 19:36:02 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id i123sm46460239pfg.164.2018.12.22.19.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 19:36:02 -0800 (PST)
Date:   Sun, 23 Dec 2018 12:35:56 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>, kernel-team@lge.com
Subject: Re: [for-next][PATCH 4/5] tracing: Have the historgram use the
 result of str_has_prefix() for len of prefix
Message-ID: <20181223033556.GE11421@danjae.aot.lge.com>
References: <20181222162007.697862256@goodmis.org>
 <20181222162856.972056232@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181222162856.972056232@goodmis.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 11:20:11AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> As str_has_prefix() returns the length on match, we can use that for the
> updating of the string pointer instead of recalculating the prefix size.
> 
> Cc: Tom Zanussi  <zanussi@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 0d878dcd1e4b..449d90cfa151 100644
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

Ah you did it here.

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
> -- 
> 2.19.2
> 
> 
