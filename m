Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE93CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B04C2195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390573AbeLVAWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:22:25 -0500
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:57028 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726757AbeLVAWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:22:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 982C3180721AB;
        Sat, 22 Dec 2018 00:22:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stone52_14afdbe3a7a0a
X-Filterd-Recvd-Size: 2099
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Dec 2018 00:22:22 +0000 (UTC)
Message-ID: <d984a6109e9f4a7df7d835850c00c449edf24dcc.camel@perches.com>
Subject: Re: [PATCH v3] string.h: Add str_has_prefix() helper
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 21 Dec 2018 16:22:20 -0800
In-Reply-To: <20181221190629.6f7fdf74@gandalf.local.home>
References: <20181221181316.6d32bdc8@gandalf.local.home>
         <20181221190629.6f7fdf74@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-21 at 19:06 -0500, Steven Rostedt wrote:
> On Fri, 21 Dec 2018 18:13:16 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > +static __always_inline int str_has_prefix(const char *str, const char *prefix)
> 
> I'm thinking it is cleaner to have two helper functions and have them
> both return bool.
> 
> static __always_inline bool str_has_prefix(const char *str, const char *prefix)
> {
> 	return !strncmp(str, prefix, strlen(prefix));
> }
> 
> ( I still like to keep the __always_inline, it doesn't hurt )
> 
> And I'll make a separate patch that adds:
> 
> static __always_inline bool
> str_has_prefix_len(const char *str, const char *prefix, unsigned int *len)
> {
> 	*len = strlen(prefix);
> 	return !strncmp(str, prefix, *len) ? *len : 0;
> }
> 
> Everyone OK with that? 

I guess so as you're the one doing all the work.

Trivia:

Shouldn't the latter function use __kernel_size_t
as that's the actual return type of strlen?

Thanks for keeping at it.

