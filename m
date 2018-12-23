Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FEFC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1D121721
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545535418;
	bh=yoYFtkPWqI9ro6gSClUotZ3H/P5iBx8+Qq1G5qW57gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xyd50zaaygAGtWFRZBEHFlMXYI6MN3QGPrLaiWqrBtC6Ig+fXN2rk6Cl7JV/7x9XE
	 242DW38tXqs/YF2MhkN75Wj8DtBO1FsgpZSLHQ7liHxE1A2fT/ztkp6iW758dRGBEe
	 elBzvdeXIiRTMjFQvNadBxRIvxeW41AnUEdHX0zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405142AbeLWDXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:23:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37180 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbeLWDXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:23:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so4266795pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 19:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y9AjmqrYNRfGQajveIDmHJ2nyoVN4IjbXkZ0NOTtg5A=;
        b=lrmXRlmmxI8l/Dn/FbEX71BLt6ubBC2xR3sbRpQkN/1gks0ZhaeB6KQ8YhzVMVmfu8
         cFZC58F51gFEfl4zAKdchrloxRTnb0uHxtW7CUjgGED3XyiKeMnz1oEGmv4ByoI9wasy
         9KYHT+xwJiw8hZVbbtJVXp96ABSAyaMOuVUX0xSX0K4vc0ytcnAf9oStFjcCi4VvDfMn
         al6yHRw1ocaaty5Qhbzd7niQ9QUgdaEQNaZ0gMAl5VXZASUJpCq7FgruEYFjyDVYLqEj
         jWDCfPs7cLkQ+itNlAwuxwwsEBFnXIwZ585QntQL0moOuK2QiW2tO8iT9BU1sZFtE/k1
         f36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y9AjmqrYNRfGQajveIDmHJ2nyoVN4IjbXkZ0NOTtg5A=;
        b=nXrfBUOxaidqBru7Ajk7AtfLyUFoSBhyzahzifpOn+ceOaIUqgM14ljFxqvDe+Z50Y
         79pSsIPNXC1whik8Iw16gJu1vWB19bbieNM4LZ6jdproFmIfuvNdHs13fsd6Uv9LdJh2
         gOxvejAibbJn7VEkCXBeg796a4uU/88HLGm24rD9N0j6Nn+wj2KMpYau7ZLM3865+GzY
         drwx11jT0yrBFZ7aoJp3VMhA1v/TVxcEzkawKXNaRfRmr4DSXoY1QCfcZ145vyjcgoDC
         zs+aGMe52syRvgTLIMrwvPpdO1vK7TXTGWdxV+cGQXxISlW9IctAgd9l+WsT0zHtYg1J
         TWaQ==
X-Gm-Message-State: AA+aEWb0+qSG3Wx+5q3et+CGuLOhUG9x+PPpqk3wqxmjAMelcJfQ4ZXt
        E0/zj+LIktjxjeYERhkBQSw=
X-Google-Smtp-Source: AFSGD/Xy9tZVdvJQW+vYfT5GlFVEh18znS84+OG4Xqbig4qxGp2UKzGCaNAH0CPQXG+HIatWi2kkNA==
X-Received: by 2002:a62:c42:: with SMTP id u63mr8380777pfi.73.1545535414775;
        Sat, 22 Dec 2018 19:23:34 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id 64sm33576662pff.101.2018.12.22.19.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 19:23:33 -0800 (PST)
Date:   Sun, 23 Dec 2018 12:23:28 +0900
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
Message-ID: <20181223032328.GC11421@danjae.aot.lge.com>
References: <20181221181316.6d32bdc8@gandalf.local.home>
 <b77cd7378434bf8ea804f2fd0caa662b9b7d07f0.camel@perches.com>
 <20181221182507.2fdc756f@gandalf.local.home>
 <20181221183817.5b3eecdd@gandalf.local.home>
 <20181222092818.GA7610@danjae.aot.lge.com>
 <20181222072207.1fe78930@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181222072207.1fe78930@vmware.local.home>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 07:22:07AM -0500, Steven Rostedt wrote:
> On Sat, 22 Dec 2018 18:28:18 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > >  
> > >  	for (i = 0; i < hist_data->attrs->n_actions; i++) {
> > >  		str = hist_data->attrs->action_str[i];
> > >  
> > > -		if (str_has_prefix(str, "onmatch(")) {
> > > -			char *action_str = str + sizeof("onmatch(") - 1;
> > > +		if ((len = str_has_prefix(str, "onmatch("))) {
> > > +			char *action_str = str + len;  
> > 
> > IMHO, returning (match) length might confuse people that it might
> > support partial match and returns the length actually matched rather
> > than full match.  If I knew it always returns the length of prefix (or
> > 0) why it matters?  Using strlen() in the next line will have same
> > effect of compiler optimization for the constant strings, no?
> > 
> > 		if (str_has_prefix(str, "onmatch(")) {
> > 			char *action_str = str + strlen("onmatch(");
> 
> The reason to return the length was to get rid of the need for
> duplicating the strlen("xxxx") because it's a burden to keep the two
> the same. Not only that, a lot of places just do "str + 7" because it's
> easier to type.
> 
> Yes, it has the same effect on the compiler, but that's not what we are
> trying to solve. We are trying to get rid of the duplication, because
> that requires humans to get it right, and humans are not good at that.

Then I'm ok with that. :)

Thanks,
Namhyung
