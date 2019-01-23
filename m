Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2C3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB0A2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548251398;
	bh=wX2igswHfPUUXQe9/KuCEAGIp3PIEdilIjqZB9clAdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GRYaePx3hI78IY3lEY0QJ8PylY1AvsEm/Y64Ho7XhEJVuAxTZSXjS07aok0AxUlr3
	 QRDNU3okXSDSOlmK45DfaIt5PDQEUYoB08GmvyAibH903ZqSmSvl+FJLoBFt5RGHNW
	 p9UHXmehlXLoIpCWJYU3dvX6cPcdYg8r58jPLEyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfAWNt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfAWNt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:49:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 130CD2184B;
        Wed, 23 Jan 2019 13:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548251394;
        bh=wX2igswHfPUUXQe9/KuCEAGIp3PIEdilIjqZB9clAdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPRNUTYNr3fPOQGGsbTD4UJTBT9fHuAjq5Z/FpoFWq7/YQI11Y09XfPXQxtMfIOby
         9VO/0L0kVl7jn4K0sfdnkEEM4KTRC9Ys62gmj94MQIqOJ6iTbljEyfAJk9O8mryYmy
         wZVd4AhCCLcHKW4aADy+GqQpSuCeW+4B6tSHHXQs=
Date:   Wed, 23 Jan 2019 14:49:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190123134952.GA26006@kroah.com>
References: <20190123102702.GA17123@kroah.com>
 <20190123102814.GB17123@kroah.com>
 <20190123110628.GV4087@dhcp22.suse.cz>
 <20190123115535.GA31237@kroah.com>
 <20190123121350.GX4087@dhcp22.suse.cz>
 <20190123122626.GA27968@kroah.com>
 <20190123124024.GY4087@dhcp22.suse.cz>
 <20190123130057.GB21318@kroah.com>
 <20190123130917.GZ4087@dhcp22.suse.cz>
 <20190123134021.GB24700@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123134021.GB24700@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:40:21PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 23, 2019 at 02:09:17PM +0100, Michal Hocko wrote:
> > On Wed 23-01-19 14:00:57, Greg KH wrote:
> > > On Wed, Jan 23, 2019 at 01:40:24PM +0100, Michal Hocko wrote:
> > > > On Wed 23-01-19 13:26:26, Greg KH wrote:
> > > > > On Wed, Jan 23, 2019 at 01:13:50PM +0100, Michal Hocko wrote:
> > > > > > On Wed 23-01-19 12:55:35, Greg KH wrote:
> > > > > > > On Wed, Jan 23, 2019 at 12:06:28PM +0100, Michal Hocko wrote:
> > > > > > > > On Wed 23-01-19 11:28:14, Greg KH wrote:
> > > > > > > > > When an error happens, debugfs should return an error pointer value, not
> > > > > > > > > NULL.  This will prevent the totally theoretical error where a debugfs
> > > > > > > > > call fails due to lack of memory, returning NULL, and that dentry value
> > > > > > > > > is then passed to another debugfs call, which would end up succeeding,
> > > > > > > > > creating a file at the root of the debugfs tree, but would then be
> > > > > > > > > impossible to remove (because you can not remove the directory NULL).
> > > > > > > > > 
> > > > > > > > > So, to make everyone happy, always return errors, this makes the users
> > > > > > > > > of debugfs much simpler (they do not have to ever check the return
> > > > > > > > > value), and everyone can rest easy.
> > > > > > > > 
> > > > > > > > How come this is safe at all? Say you are creating a directory by
> > > > > > > > debugfs_create_dir and then feed the return value to debugfs_create_files
> > > > > > > > as a parent. In case of error you are giving it an invalid pointer and
> > > > > > > > likely blow up unless I miss something.
> > > > > > > 
> > > > > > > debugfs_create_files checks for invalid parents and will just refuse to
> > > > > > > create the file.  It's always done that.
> > > > > > 
> > > > > > I must be missing something because debugfs_create_files does
> > > > > > 	d_inode(parent)->i_private = data;
> > > > > > as the very first thing and that means that it dereferences an invalid
> > > > > > pointer right there.
> > > > > 
> > > > > debugfs_create_file() -> __debugfs_create_file() -> start_creating()
> > > > > and that function checks if parent is an error, which it aborts on, or
> > > > > if it is NULL, it sets parent to a valid value:
> > > > > 
> > > > >         /* If the parent is not specified, we create it in the root.
> > > > >          * We need the root dentry to do this, which is in the super
> > > > >          * block. A pointer to that is in the struct vfsmount that we
> > > > >          * have around.
> > > > >          */
> > > > >         if (!parent)
> > > > >                 parent = debugfs_mount->mnt_root;
> > > > > 
> > > > > I don't see any line that looks like:
> > > > > >       d_inode(parent)->i_private = data;
> > > > > in Linus's tree right now, what kernel version are you referring to?
> > > > 
> > > > Ohh, my bad. I have looked at debugfs_create_files which is a mq helper
> > > > around debugfs_create_file. But that is a good example why this patch is
> > > > dangerous anyway. blk_mq_debugfs_register simply checks for NULL and
> > > > debugfs_create_files doesn't expect ERR_PTR here. So you would have to
> > > > check each and every user to make sure you can do that.
> > > 
> > > Ah, I already have that patch in my "to add a proper changelog" queue,
> > > it's below and fixes that problem.
> > 
> > OK, fair enough. I am just wondering how many more gems like that are
> > lurking there. Do not get me wrong but a broken error handling is rarely
> > fixed by removing it.
> 
> I think you all are the "lucky" one here :)
> 
> I did audit the whole kernel tree already, with the exception of the gpu
> drivers, as they are even more insane than block drivers...
> 
> > And Cc: stable is completely inappropriate IMNSHO. This is just adding a
> > risk without a large benefit.
> 
> What risk?  Again, the _ONLY_ way that NULL is returned here is if you
> are out of memory when you try to create that debugfs file/directory.
> Given that we usually don't even fail small kmallocs, I doubt this can
> even ever happen.

In thinking about it some more, I'll not cc: stable on this, to give
people a chance to get synced up for 5.1 for all of this.

thanks,

greg k-h
