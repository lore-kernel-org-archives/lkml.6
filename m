Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3999FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C55A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547559959;
	bh=LYRp5sC/i9SVfDZ5UUI+unE0W0RddiJ3ZBaxhOo+awI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=tgWJUuMNYrwrXJ9CZyzCX7aPBAwHj+NB+r3DUXkHimiyKfIdXF6Lkcq1Dl9/FOS6W
	 rWXAUe/KbVO959j05vtRHXlg0Wwn2YauJt5/YFEm5FuBnkBLWe52bh0rvgLiwJdLJP
	 cbHt/sd+B0jR6sQzHh4zVwP2JahrRo5fOIVKITXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfAONp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:45:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbfAONp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:45:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39B2D20651;
        Tue, 15 Jan 2019 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547559956;
        bh=LYRp5sC/i9SVfDZ5UUI+unE0W0RddiJ3ZBaxhOo+awI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=xXscI3YLQo8P4CSZiD6crkg3MskX6zgBurN0xlx6aa3UPYeEISdDL7jYJthoYWnN2
         DwRoBLeKryfm7OM4HtIOpsVGH/wGJDC3bhV/Zff0nzlDe/gosh3QLhjbM2fM0JL/xB
         S/D653t4SPnd0Y7cVk3W/sQ7R6Qljg1dsI0WGVaA=
Date:   Tue, 15 Jan 2019 14:45:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
Subject: Re: [PATCH 1/2] staging/vboxvideo: Don't set
 FBINFO_MISC_ALWAYS_SETPAR
Message-ID: <20190115134553.GD30742@kroah.com>
References: <20190115102755.16183-1-daniel.vetter@ffwll.ch>
 <20190115103829.GC18959@kroah.com>
 <20190115121228.GO10517@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115121228.GO10517@phenom.ffwll.local>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 01:12:28PM +0100, Daniel Vetter wrote:
> On Tue, Jan 15, 2019 at 11:38:29AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 15, 2019 at 11:27:54AM +0100, Daniel Vetter wrote:
> > > It's a debug hack flag useful to work around driver bugs. That's not a
> > > good idea for a new driver. Especially for a new drm driver.
> > > 
> > > Aside: the fbdev support should probably be converted over to the new
> > > generic fbdev support.
> > > 
> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> > > ---
> > >  drivers/staging/vboxvideo/vbox_fb.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > 
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Since Hans wants to destage vboxvideo this cycle probably best I merge
> this through drm-misc? Just to make sure it's not lost.

Feel free to do so!

thanks,

greg k-h
