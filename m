Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058E2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFCE2190A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404899AbeLVAhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbeLVAhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:37:14 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F222190A;
        Sat, 22 Dec 2018 00:37:12 +0000 (UTC)
Date:   Fri, 21 Dec 2018 19:37:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3] string.h: Add str_has_prefix() helper
Message-ID: <20181221193711.1571408e@gandalf.local.home>
In-Reply-To: <CAHk-=wgfSR9qhEWf--Do11jUFHyVM+VEmwm5LBS2JsV0F5yakw@mail.gmail.com>
References: <20181221181316.6d32bdc8@gandalf.local.home>
        <20181221190629.6f7fdf74@gandalf.local.home>
        <CAHk-=wgfSR9qhEWf--Do11jUFHyVM+VEmwm5LBS2JsV0F5yakw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 16:32:58 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Dec 21, 2018, 16:06 Steven Rostedt <rostedt@goodmis.org wrote:
> 
> > On Fri, 21 Dec 2018 18:13:16
> >
> > And I'll make a separate patch that adds:
> >
> > static __always_inline bool
> > str_has_prefix_len(const char *str, const char *prefix, unsigned int *len)
> 
> 
> Why would this ever be a good idea? What's the advantage over returning the
> length?

Style?

I was just thinking that some people (like Joe) think it's in bad taste
to have:

	if ((len = str_has_prefix(str, "const"))) {

and it might look better to have:

	if (str_has_prefix_len(str, "const", &len)) {

Honestly, I'm good with either and don't really have a preference.

Let me know which one you prefer, and I'll work to get a patch out.

-- Steve

