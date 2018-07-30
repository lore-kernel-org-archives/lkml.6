Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE593C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD6920892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD6920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbeG3VtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:49:07 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:54746 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbeG3VtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:49:07 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 7570F41261;
        Mon, 30 Jul 2018 22:12:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 1ryoGEQRvRgD; Mon, 30 Jul 2018 22:12:26 +0200 (CEST)
Date:   Mon, 30 Jul 2018 22:12:24 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arve@android.com, tkjos@android.com,
        maco@android.com, rlove@google.com, ben@decadent.org.uk
Subject: Re: [RFC PATCH 0/4] file: export functions for binder module
Message-ID: <20180730201224.GA1081@mailbox.org>
References: <20180730143710.14413-1-christian@brauner.io>
 <20180730163452.GE27761@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180730163452.GE27761@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:34:52AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 30, 2018 at 04:37:06PM +0200, Christian Brauner wrote:
> > Hey,
> > 
> > We currently plan on turning the Android binder and ashmem driver into a
> > module. We have seen more and more requests by users to be able to use
> > the binder and ashmem features without wanting to convince each distro
> > to enable it by default in their kernel. Debian already started to carry
> > patches for turning them into modules.
> 
> Yikes.  I really wish Debian would stick more to upstream rather than
> picking random crap like this up.

Thanks for the review, Christoph. Unfortunately the gist of the message
got cut off:

> I don't expect this patch to be mergeable but rather to kick-off a
> discussion if we can either simply export them as they are or how we can
> get supportable exports that allow access to struct files_struct.

Maybe that wasn't obvious from the first message. Is there any way we
can come up with a way to have versions of these functions that you
would be fine with exporting?
The point is that otherwise we would have to either duplicate the code
or come up with something way more complex. If you have any pointer that
would already help.

Christian
