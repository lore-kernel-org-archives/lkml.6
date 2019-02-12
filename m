Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1672222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549996350;
	bh=N0JPzLwjEXXG65mqj5yugZBr2I960YKVnANv7FcWrWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=baipcEuvvLbLc2Ed8d5+JQulX+ZqUlCIYcSmIvJz5Dhd2+sIzAxCWOhu4OlFiMBZX
	 UE3eivUR9Mrgorbx9Y/PWxymOPDQvVRFFDz/OT4m7cQiq2149p4KGhFGTavKBeBOz8
	 5f5/TUxQKtbmRUxSkz/+EssSyuwVdJTc9GN97Gig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfBLSc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:32:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729933AbfBLSc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:32:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEB40222BB;
        Tue, 12 Feb 2019 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549996348;
        bh=N0JPzLwjEXXG65mqj5yugZBr2I960YKVnANv7FcWrWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPXynVxhjNiiiBBVrOO+EdliNcu9g8ZMFEo9GMrPNk3boggiEVsKUBIGH9Fh44wlq
         7lWktMAmzov/95+r8XzwPsiWFXJM010fJHGvkJkmm85DlAz2UG7y/6cZbZYa/HIwcj
         owNJfijgIFlLA/3DwXlpbgjcf4kIt44qHAAmfa8k=
Date:   Tue, 12 Feb 2019 19:32:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgxu519 <cgxu519@gmx.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] chardev: showing minor range for chardev in the
 output of /proc/devices
Message-ID: <20190212183225.GA14528@kroah.com>
References: <20190212084739.27602-1-cgxu519@gmx.com>
 <20190212084739.27602-2-cgxu519@gmx.com>
 <20190212090212.GE31657@kroah.com>
 <a8332299-818e-571c-efc9-7885f18eddb8@gmx.com>
 <20190212152053.GA25804@kroah.com>
 <f6f02cb9-79ad-aeb0-a911-89dfb1f90aae@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f02cb9-79ad-aeb0-a911-89dfb1f90aae@gmx.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:41:35PM +0800, cgxu519 wrote:
> On 2/12/19 11:20 PM, Greg KH wrote:
> > On Tue, Feb 12, 2019 at 11:18:22PM +0800, cgxu519 wrote:
> > > On 2/12/19 5:02 PM, Greg KH wrote:
> > > > On Tue, Feb 12, 2019 at 04:47:39PM +0800, Chengguang Xu wrote:
> > > > > Currently chardev allows to share major, showing
> > > > > major with minor range for chardev will be more
> > > > > helpful.
> > > > > 
> > > > > Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> > > > > ---
> > > > >    fs/char_dev.c | 4 +++-
> > > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/char_dev.c b/fs/char_dev.c
> > > > > index b25b1da097d5..6f00acdeb308 100644
> > > > > --- a/fs/char_dev.c
> > > > > +++ b/fs/char_dev.c
> > > > > @@ -55,7 +55,9 @@ void chrdev_show(struct seq_file *f, off_t offset)
> > > > >    	mutex_lock(&chrdevs_lock);
> > > > >    	for (cd = chrdevs[major_to_index(offset)]; cd; cd = cd->next) {
> > > > >    		if (cd->major == offset)
> > > > > -			seq_printf(f, "%3d %s\n", cd->major, cd->name);
> > > > > +			seq_printf(f, "%3d %s (%u-%u)\n", cd->major, cd->name,
> > > > > +				   cd->baseminor,
> > > > > +				   cd->baseminor + cd->minorct - 1);
> > > > You are changing the format of a userspace file, what tools are going to
> > > > break when you do this?
> > > I'll remove this part in V2. Do you have any idea how to get the minor
> > > range info for particular major? Or adding a similar file to somewhere
> > > under /sys is acceptable?
> > Why do you need to know the minor range?  What can userspace do with
> > this that actually matters?
> 
> Assume that when we try to load a driver module and fail with -EBUSY
> because of minor range overlapping, then what can we do for this case?
> we even don't know what range has occupied and what range is available.

Why would drivers ever have minor range overlapping?  Either they are
using a reserved range which is properly documented in the kernel file,
or they are using a dynamic range and that will never overlap as they
are allocated as needed.

So when has this ever happened in the real world?

> Also, I think we can obviously notice range overlapping bugs by showing
> all registered minor ranges.

Again, how can a range overlap?  If so, that's a bug that we can fix
now and has nothing to do with the proc file, which will not show an
overlap as that can not happen at runtime.

thanks,

greg k-h
