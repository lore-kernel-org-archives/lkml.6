Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC12C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADCA21A4E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500471;
	bh=82FABdOcM/G57Ts+ncPpj6ZRoj15+5MHDq5fs9nJRgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V8jiqC1fAyYR9N1KSqJPzlHlY8qnxL71zQ56L5u7dMWyPWBd3u2z8Q3TKre/E1vCA
	 YmWe8NcK80q5KR0rzyRUGPF0FrDa4b1mxsxbSKxo4qJbBx7DADoezmIWV7B0JiKS7z
	 rtgMfs1KyOP+Dx3pUw3vwzRGZW4kemj2wERt1TVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392707AbeLVRlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:41:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45292 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389669AbeLVRlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:41:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so3915576pgc.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Z0vnExjIgk37sqhQmoWZs4Kim5TjQ4s7J2aCJgLvag=;
        b=fbW7dLpyKL5omEs29udrnAtO1bqyX2Y8/pTcfPEKx7qlP9tEIpL3kv6DNpUiPaGUxH
         DgGtGf/cdmDTgIZWTc3xOXsCELtKqQuP9X/NwGpXpqnSN7wRrhmzX7iDBT74lR2wLnpd
         B88e2EI6dg9eATxTBHkPbdILX6Y3WMN/eR0oiXp+mX0VfluWaid4Jdi0ox9QwwajuB10
         1R9HpcaKlrc/B3sRajmUVRUs1uHFmlBLViUlGlrQD6gH1dmzULS2WmQt3LpMpCicEsCy
         ZfHJ31eAh8+Gamdm2bZvqUb+U4TisJBYa0niWkTG29GyK1qNrXeAQVptHHTIw2ytgieM
         jj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Z0vnExjIgk37sqhQmoWZs4Kim5TjQ4s7J2aCJgLvag=;
        b=HGEopw6X217TuorMhx9A2VvIpUaD1Mu6dJsahxH2IpnppObOm0zNC/9Pff77zCaAZT
         8kHSccykD9HNIAjmd8Im1hwQmfzN9adK7GZSZQWETgvRu3igYVijzs9fHdN/my99MKjr
         9UW2mHHOSpxAkeK7Tzomjf5Qj+cXu/irD24xQY6RG9TZ3NK3FB/Z5On7TvksIZjYXU76
         3enGf2hqaQ3vABC0pZogNpdxyFCPNZiCfyt1LCtJPeZWI1Hvjp04LnppR4j498EJSVle
         evIldbsVppAxDSrgrGowuodY0r+nMAqK3jr5G116BC84dd8lr8yZxfjtnbTpkQWsf7Jj
         Qdlw==
X-Gm-Message-State: AJcUukdgCHlRmPzAhyxCkL6qcZ6wjX4DnZrRXxcDDoVCyB9TORKzVgA3
        G9ZDgQpO4SP/h1f7WkGbb2cMoXGY
X-Google-Smtp-Source: AFSGD/X6IIlERyarqF/4HT7Ci9Aev+cdyN9Gu5VtEUPxOSuQjODwCeh+Ttoui7qhIm1Fprl48pYUWQ==
X-Received: by 2002:a62:6f88:: with SMTP id k130mr6600236pfc.234.1545488657863;
        Sat, 22 Dec 2018 06:24:17 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id r66sm39427518pfk.157.2018.12.22.06.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 06:24:17 -0800 (PST)
Date:   Sat, 22 Dec 2018 23:24:11 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>, kernel-team@lge.com
Subject: Re: [PATCH v4] string.h: Add str_has_prefix() helper function
Message-ID: <20181222142411.GA10058@danjae.aot.lge.com>
References: <20181221231924.4583e90b@vmware.local.home>
 <20181222093346.GB7610@danjae.aot.lge.com>
 <20181222072404.27a7e9a3@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181222072404.27a7e9a3@vmware.local.home>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 07:24:04AM -0500, Steven Rostedt wrote:
> On Sat, 22 Dec 2018 18:33:46 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > > +static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
> > > +{
> > > +	size_t len = strlen(prefix);
> > > +	return strncmp(str, prefix, len) == 0 ? len : 0;  
> > 
> > As it already knows the length (and it needs to use it for return
> > value), isn't it (slightly) better using memcmp() instead?
> 
> No, because we don't know the length of str.
> 
> 
> 	[ str = "h\0[bad memory]" ]
> 
> 
> 	str_has_prefix(str, "TEST THIS BIG STRING AT FRONT")
> 
> 
> If we use memcmp(), then we are testing way after str has ended, and
> that can cause a memory fault.

I don't know what's the bad memory causing memory fault but anyway
memcpy() should stop at the NUL character first as it's different, no?

Thanks,
Namhyung
