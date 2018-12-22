Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1715AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D21218D9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545502762;
	bh=IZ9PYXTdaE5c6jk3D47I+9RAOihhA4f94pBzJVyjX4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BgFu5oyrnnPDBoM122XcRePOFRhja3Zkuqwj0LJ68om3nQ6YUKMpY33Otkn3XE7Mm
	 bovQl4GQHqEXMgG9BBbCI/wgswwlKU+rHtv8jbBAw2M3ZChw6xgpUbPl8V6hSR8iol
	 QkEml/0DifOLf16GPJTA7Hn0PhJ7tD5lV7wSwBs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391337AbeLVSTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:19:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50870 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390825AbeLVSTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:19:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so8113552wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jOBL5gEitBfTmN83EKAeEvjfauj90sIfURLI/nYwnm4=;
        b=tTj8R/tGm08ao0sex1nN1/0YZsHOaOEFsmq0bgOOE9jLOvKXDq8Qao7bSCwAYeJ93Q
         HP/T9IO2bY5/F8dxK/bUTFK/eFKxNJJXVSxa6OfL+jQ04DxNVKW2yGRFk9yeOpk8ZYOm
         tsr4pTbjnmZjw9BbQu8CYo7+nOPdzZjrD1oAfJKagzTXXhHo53G7hIb3qAG53SaHON1h
         pirkwtqSO/oboku6KgB6jrkNg0HDgRI/t1vJ8jg1xZtLvV+KGYD8cE9sxhQnKv2XdWfA
         6Js3lID9ShCczgkp5VJoioKVBrxVADXLxeTGVhRLcbCmPgWxbvZ5HWH7BuyNrtr35sS0
         nhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jOBL5gEitBfTmN83EKAeEvjfauj90sIfURLI/nYwnm4=;
        b=W1aS3be63OtiqBY3TLqbxvBqW63EPfsZGuGa4r6fAPAPnKqpC/fdAleEXIehmJUDKo
         mbrnhSwR+NbFq+GGudLIphGr0jcOSyAAC42RoPdhORrmqPRhNXvrkm0TJOJlSPcSSowu
         /uPxuQe7RulL0tP8XxoHfQrLJntIe+jTt90AVWFWRZqNBD88bM/8CCQSlDzsMMb5nDZI
         E0S8dejA+hOO472vyfw+sEzgGKJMURUnD+r+Zc0qLaio7KrkxeGBThpoYRNBBS3sjVPm
         ucJwt17cRX1LS+PFY4UeH/GF9syG7PgVrYfN6t+NaKDjwluitT1G9jO87lJBGiL8B/iD
         A2fw==
X-Gm-Message-State: AJcUuketVDVYotapwTZYBFtuc9zCBD7Ph4SR8jzJjf9ZF9AHvlp/Y8TQ
        O3mnoEPB/GkMkpRDnhZAoTdCBAeW
X-Google-Smtp-Source: AFSGD/UtaJHQTNczm2aYsXmftARQ4vsfyXR1mvcGGcPDY9kimP5CEb68FtsRGKQ2Pd6E+F7kjM94GA==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr6074692wma.24.1545476328316;
        Sat, 22 Dec 2018 02:58:48 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k23sm9419820wmj.32.2018.12.22.02.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 02:58:47 -0800 (PST)
Date:   Sat, 22 Dec 2018 11:58:45 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3] string.h: Add str_has_prefix() helper
Message-ID: <20181222105845.GB130780@gmail.com>
References: <20181221181316.6d32bdc8@gandalf.local.home>
 <20181221190629.6f7fdf74@gandalf.local.home>
 <CAHk-=wgfSR9qhEWf--Do11jUFHyVM+VEmwm5LBS2JsV0F5yakw@mail.gmail.com>
 <20181221193711.1571408e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221193711.1571408e@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 21 Dec 2018 16:32:58 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Fri, Dec 21, 2018, 16:06 Steven Rostedt <rostedt@goodmis.org wrote:
> > 
> > > On Fri, 21 Dec 2018 18:13:16
> > >
> > > And I'll make a separate patch that adds:
> > >
> > > static __always_inline bool
> > > str_has_prefix_len(const char *str, const char *prefix, unsigned int *len)
> > 
> > 
> > Why would this ever be a good idea? What's the advantage over returning the
> > length?
> 
> Style?
> 
> I was just thinking that some people (like Joe) think it's in bad taste
> to have:
> 
> 	if ((len = str_has_prefix(str, "const"))) {
> 
> and it might look better to have:
> 
> 	if (str_has_prefix_len(str, "const", &len)) {
> 
> Honestly, I'm good with either and don't really have a preference.

The first one is infinitely more readable and less ambiguous than a 
random series of arguments with unknown semantics for 'len': does 'len' 
have to be pre-initialized or does it always get set by the function, is 
the 'len' return always the same as the str_has_prefix_len() return value 
or is it a separate error code, etc.

I have no idea in what universe it's preferrable to pass it as an 
argument to a function.

We only punt return parameters to arguments when we are *forced* to, 
because there's too many of them, or there's some separate error and 
value path that cannot be encoded via any of the well-known pointer or 
integer encodings of errors, etc.

Thanks,

	Ingo
