Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA40C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3122184C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfAKLKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:10:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:36086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbfAKLKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:10:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F859ADD7;
        Fri, 11 Jan 2019 11:10:08 +0000 (UTC)
Message-ID: <1547204392.4054.7.camel@suse.com>
Subject: Re: [PATCH] drivers/usb/storage/sddr55.c: Remove duplicate header
From:   Oliver Neukum <oneukum@suse.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     brajeswar.linux@gmail.com, jrdr.linux@gmail.com,
        usb-storage@lists.one-eyed-alien.net, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Fri, 11 Jan 2019 11:59:52 +0100
In-Reply-To: <20190111091037.GB15610@kroah.com>
References: <5c36f6ef.1c69fb81.9d82d.5592@mx.google.com>
         <20190111091037.GB15610@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2019-01-11 at 10:10 +0100, Greg KH wrote:
> On Thu, Jan 10, 2019 at 01:10:25PM +0530, Sabyasachi Gupta wrote:
> > Remove unusual_sddr55.h which is included more than once
> > 
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > ---
> >  drivers/usb/storage/sddr55.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
> > index b8527c5..96bf7ee 100644
> > --- a/drivers/usb/storage/sddr55.c
> > +++ b/drivers/usb/storage/sddr55.c
> > @@ -62,7 +62,6 @@ MODULE_DEVICE_TABLE(usb, sddr55_usb_ids);
> >  }
> >  
> >  static struct us_unusual_dev sddr55_unusual_dev_list[] = {
> > -#	include "unusual_sddr55.h"
> >  	{ }		/* Terminating entry */
> >  };
> 
> As Oliver said on the other patch, this breaks the code.  Please do not
> blindly make changes without understanding what the code does.

Maybe this should be explained. The file that is included does have
a name ending in .h. But it is not simply declarations, for which
newer trendy languages would use a a statement like ¨import".

"unusual_sddr55.h" is a list of devices. This list is used in
multiple places. And it needs to be identical in all those places.
Hence it is included. These are true includes. There is nothing wrong
with that code.

Our complaint is not that your fix is wrong, but there is nothing wrong
with the code as is. Including this list is the good thing to do.
Your wish to clean up the kernel is appreciated. But please find a
place that actually needs to be cleaned up.

	Regards
		Oliver

