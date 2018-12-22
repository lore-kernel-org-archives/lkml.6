Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDBCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BB62054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392739AbeLVRso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:48:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389864AbeLVRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:14 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C73521B1B;
        Sat, 22 Dec 2018 13:16:04 +0000 (UTC)
Date:   Sat, 22 Dec 2018 08:16:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3] string.h: Add str_has_prefix() helper
Message-ID: <20181222081602.22d42b3e@vmware.local.home>
In-Reply-To: <20181222105845.GB130780@gmail.com>
References: <20181221181316.6d32bdc8@gandalf.local.home>
        <20181221190629.6f7fdf74@gandalf.local.home>
        <CAHk-=wgfSR9qhEWf--Do11jUFHyVM+VEmwm5LBS2JsV0F5yakw@mail.gmail.com>
        <20181221193711.1571408e@gandalf.local.home>
        <20181222105845.GB130780@gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 11:58:45 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 21 Dec 2018 16:32:58 -0800
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >   
> > > On Fri, Dec 21, 2018, 16:06 Steven Rostedt <rostedt@goodmis.org wrote:
> > >   
> > > > On Fri, 21 Dec 2018 18:13:16
> > > >
> > > > And I'll make a separate patch that adds:
> > > >
> > > > static __always_inline bool
> > > > str_has_prefix_len(const char *str, const char *prefix, unsigned int *len)  
> > > 
> > > 
> > > Why would this ever be a good idea? What's the advantage over returning the
> > > length?  
> > 
> > Style?
> > 
> > I was just thinking that some people (like Joe) think it's in bad taste
> > to have:
> > 
> > 	if ((len = str_has_prefix(str, "const"))) {
> > 
> > and it might look better to have:
> > 
> > 	if (str_has_prefix_len(str, "const", &len)) {
> > 
> > Honestly, I'm good with either and don't really have a preference.  
> 
> The first one is infinitely more readable and less ambiguous than a 
> random series of arguments with unknown semantics for 'len': does 'len' 
> have to be pre-initialized or does it always get set by the function, is 
> the 'len' return always the same as the str_has_prefix_len() return value 
> or is it a separate error code, etc.
> 
> I have no idea in what universe it's preferrable to pass it as an 
> argument to a function.

I'm working on projects that prefer the second method. But these also
integrate a lot of C++ which using parameters for all I/O is the norm.

> 
> We only punt return parameters to arguments when we are *forced* to, 
> because there's too many of them, or there's some separate error and 
> value path that cannot be encoded via any of the well-known pointer or 
> integer encodings of errors, etc.

Like I said, I no longer have a strong preference and I'm happy with
either. It's like going back and forth between Europe and US and using
Celsius or Fahrenheit. There's really no difference in its use (unlike
meters / grams, which have the conversion advantage, temperature is
just a preference).

-- Steve
