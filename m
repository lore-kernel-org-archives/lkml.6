Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C339CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707F520890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707F520890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbeG3WF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:05:26 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:18204 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbeG3WFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:05:25 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 18FF34139A;
        Mon, 30 Jul 2018 22:28:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id TvBeA4nNQbow; Mon, 30 Jul 2018 22:28:42 +0200 (CEST)
Date:   Mon, 30 Jul 2018 22:28:40 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        rlove@google.com, ben@decadent.org.uk
Subject: Re: [RFC PATCH 0/4] file: export functions for binder module
Message-ID: <20180730202840.GA14693@mailbox.org>
References: <20180730143710.14413-1-christian@brauner.io>
 <20180730163452.GE27761@infradead.org>
 <20180730201224.GA1081@mailbox.org>
 <20180730201947.GB12962@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180730201947.GB12962@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 01:19:47PM -0700, Matthew Wilcox wrote:
> On Mon, Jul 30, 2018 at 10:12:24PM +0200, Christian Brauner wrote:
> > > I don't expect this patch to be mergeable but rather to kick-off a
> > > discussion if we can either simply export them as they are or how we can
> > > get supportable exports that allow access to struct files_struct.
> > 
> > Maybe that wasn't obvious from the first message. Is there any way we
> > can come up with a way to have versions of these functions that you
> > would be fine with exporting?
> > The point is that otherwise we would have to either duplicate the code
> > or come up with something way more complex. If you have any pointer that
> > would already help.
> 
> He said in the first reply this should probably be using an anonfd.
> If you do that, I think all four of these exports go away.

I try and see if that is possible.

> 
> And there was really no reason to post each of the four exports as
> separate patches.  That just makes review harder on everyone.

Sorry about that. It usually depends on the preferences of each
maintainer how fine-grained such minor changes should be.

Christian
