Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45E5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D782063F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfAODMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:12:48 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35421 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbfAODMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:12:48 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x0F3CZGN006430;
        Tue, 15 Jan 2019 04:12:35 +0100
Date:   Tue, 15 Jan 2019 04:12:35 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Kees Cook <keescook@chromium.org>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/8] lkdtm: change snprintf to scnprintf for possible
 overflow
Message-ID: <20190115031235.GA6416@1wt.eu>
References: <20190112152844.26550-1-w@1wt.eu>
 <CAGXu5jLGkPqA+ZY7aFizpsRj9VvOhUSfixWcLLVHXwsAo3PQyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLGkPqA+ZY7aFizpsRj9VvOhUSfixWcLLVHXwsAo3PQyA@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Mon, Jan 14, 2019 at 05:02:51PM -0800, Kees Cook wrote:
> On Sat, Jan 12, 2019 at 7:28 AM Willy Tarreau <w@1wt.eu> wrote:
> >
> > From: Silvio Cesare <silvio.cesare@gmail.com>
> >
> > Change snprintf to scnprintf. There are generally two cases where using
> > snprintf causes problems.
> 
> (I didn't find a 0/8 cover letter, so I'm replying here...)

I didn't add one simply because I didn't have more context info than
the one already present in each of these commits (which were all the
same by the way). These ones were first reported by Silvio on the
security list on November 23rd and came to a stall by lack of proper
Cc and subject lines. So I've ran get_maintainers.pl + git log to
adjust all this and sent them with the available context.

> Many of these fixes are just robustness updates (e.g. the lkdtm case
> below is not current a problem: the size of the static array getting
> displayed is less than PAGE_SIZE). It might be worth noting which are
> actually problems (and include the appropriate Cc: and Fixes: lines).

From what I remember from the thread, these are small bugs causing some
memory disclosure when used with debugfs. I've just found the featured
article :

   http://blog.infosectcbr.com.au/2018/11/memory-bugs-in-multiple-linux-kernel.html

> Are these changes going into someone's single tree, or are they
> intended for individual maintainers to pick up?

The goal was to let the maintainers decide based on the commit message.

That's why it's always better when the reporter sends the information
by himself rather than relying on some third party to polish things up
and forward :-/

Cheers,
Willy
