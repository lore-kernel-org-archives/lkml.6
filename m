Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CDAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4181121B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900660;
	bh=srDxmm21zNghckUEntW3I48s2MKukUD0iQ2inuM+Jzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rq0bddd4BYwmhiOLyqHAtvQ3/4cOXjwJiU1hEzqobLuJt/BU0ncbg590vGzS5oTRy
	 WKsJkwA8MGSmK8mMpZc6qDQFiRLRqQe/BWIQmagTsq8Wa3XfBZ6OTzyLM2Cs8Om+T/
	 xg64awFpFu0WTiPg7YbLBg9tjkq9dYE+meTQS5xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfBKP5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730568AbfBKP5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:57:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6233621B24;
        Mon, 11 Feb 2019 15:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549900656;
        bh=srDxmm21zNghckUEntW3I48s2MKukUD0iQ2inuM+Jzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0gpJbU67nuvcpEEP2+cd/y8KLzCEwo4mXNQXhYR+8Ys0yo5X0GuDxxeiKGyEdLdB
         PHhF0gCcbRl3/TUc8knYzfw7IfMCybqY+hh/naSLURZ0vxBLWTyAQHGWLeZuqj7STD
         B3UWZcVWv7Z0JEZfRS9/jqNxTbZVWNdwSw8i4tso=
Date:   Mon, 11 Feb 2019 16:57:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com, maco@android.com,
        christian@brauner.io
Subject: Re: [PATCH] staging: android: vsoc: Remove
 VSOC_WAIT_FOR_INCOMING_INTERRUPT
Message-ID: <20190211155734.GA18078@kroah.com>
References: <20190211152602.GA5591@jordon-HP-15-Notebook-PC>
 <20190211154044.GA16105@kroah.com>
 <CAFqt6zYh2qxBKyOCH3xZmS_Jq5nU+nZyLhbmGOey4Y-VAk+ZoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYh2qxBKyOCH3xZmS_Jq5nU+nZyLhbmGOey4Y-VAk+ZoQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:21:19PM +0530, Souptick Joarder wrote:
> On Mon, Feb 11, 2019 at 9:10 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 11, 2019 at 08:56:02PM +0530, Souptick Joarder wrote:
> > > As mentioned in TODO list, Removed VSOC_WAIT_FOR_INCOMING_INTERRUPT
> > > ioctl. This functionality has been superseded by the futex and is
> > > there for legacy reasons.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > ---
> > >  drivers/staging/android/uapi/vsoc_shm.h | 7 -------
> > >  drivers/staging/android/vsoc.c          | 5 -----
> > >  2 files changed, 12 deletions(-)
> >
> > So userspace is all fixed up now and this ioctl can be dropped?  Any
> > pointers to the userspace commit that did this?
> 
> I am not sure about user space part.

Then we can not just delete the ioctl :)

