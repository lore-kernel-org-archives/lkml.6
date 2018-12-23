Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31F2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6D7218E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405167AbeLWDxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:53:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389248AbeLWDxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:53:41 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5855D218D9;
        Sun, 23 Dec 2018 03:53:40 +0000 (UTC)
Date:   Sat, 22 Dec 2018 22:53:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [for-next][PATCH 2/5] tracing: Use str_has_prefix() helper for
 histogram code
Message-ID: <20181222225338.34cc579c@vmware.local.home>
In-Reply-To: <1545501821.4383.2.camel@kernel.org>
References: <20181222162007.697862256@goodmis.org>
        <20181222162856.666843139@goodmis.org>
        <20181222130107.43aaac9c@gandalf.local.home>
        <1545501821.4383.2.camel@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 12:03:41 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Steve,
> 
> On Sat, 2018-12-22 at 13:01 -0500, Steven Rostedt wrote:
> > On Sat, 22 Dec 2018 11:20:09 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > The tracing histogram code contains a lot of instances of the
> > > construct:
> > > 
> > >  strncmp(str, "const", sizeof("const") - 1)
> > > 
> > > This can be prone to bugs due to typos or bad cut and paste. Use
> > > the
> > > str_has_prefix() helper macro instead that removes the need for
> > > having two
> > > copies of the constant string.
> > > 
> > > Cc: Tom Zanussi <zanussi@linux.intel.com>  
> > 
> > I have no idea why I copied your intel email. The linux.intel.com
> > appears to be no longer active. I'm going to rebase to fix this email
> > address.  
> 
> linux.intel.com is active, but there's no zanussi there, just
> tom.zanussi ;-)
> 
> So tom.zanussi@linux.intel.com should work fine.

BTW, would you give me your ack-by?

-- Steve

