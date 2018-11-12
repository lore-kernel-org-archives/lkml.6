Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2007DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44DE22507
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzxWCMBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44DE22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbeKMJl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbeKMJl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:41:28 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE6822419;
        Mon, 12 Nov 2018 23:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542066363;
        bh=Y+LZn41niJmfe6eZxcVaw0a0aNLycqv0zQqX7Gemh3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzxWCMBmva/DUavx/7GmqmH88lR/81Wq7P7gxTy4tQ4EITSZilAnGC4lFUduQGUNH
         4dKqp3/uV3/wYhqfuN9nnK5pKZbI7Uwax4olpjUUTz7SCQZEDdx8Q0q5w2JGrFYU02
         KP8+EbtZ7rigqZxOyrmrcv1uxq7b9GZUPHBpvjsw=
Date:   Mon, 12 Nov 2018 15:46:03 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: erofs: unzip_vle.c: Replace comparison to
 NULL.
Message-ID: <20181112234603.GB16079@kroah.com>
References: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
 <1542055439-24444-2-git-send-email-sicilia.cristian@gmail.com>
 <20181112224636.GA12671@kroah.com>
 <CACU=YuX3U50uVaitV1Mhn3Dn8pXhPZt-1K7HX4Bn7MUCrgE35w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACU=YuX3U50uVaitV1Mhn3Dn8pXhPZt-1K7HX4Bn7MUCrgE35w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 12:31:58AM +0100, Cristian Sicilia wrote:
> On Mon, Nov 12, 2018 at 11:46 PM Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Nov 12, 2018 at 09:43:57PM +0100, Cristian Sicilia wrote:
> > > Replace equal to NULL with logic unary operator,
> > > and removing not equal to NULL comparison.
> > >
> > > Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
> > > ---
> > >  drivers/staging/erofs/unzip_vle.c | 86
> > +++++++++++++++++++--------------------
> > >  1 file changed, 43 insertions(+), 43 deletions(-)
> > >
> > > diff --git a/drivers/staging/erofs/unzip_vle.c
> > b/drivers/staging/erofs/unzip_vle.c
> > > index 79d3ba6..1ffeeaa 100644
> > > --- a/drivers/staging/erofs/unzip_vle.c
> > > +++ b/drivers/staging/erofs/unzip_vle.c
> > > @@ -20,8 +20,8 @@ static struct kmem_cache *z_erofs_workgroup_cachep
> > __read_mostly;
> > >
> > >  void z_erofs_exit_zip_subsystem(void)
> > >  {
> > > -     BUG_ON(z_erofs_workqueue == NULL);
> > > -     BUG_ON(z_erofs_workgroup_cachep == NULL);
> > > +     BUG_ON(!z_erofs_workqueue);
> > > +     BUG_ON(!z_erofs_workgroup_cachep);
> >
> > Long-term, all of these BUG_ON need to be removed as they imply that the
> > developer has no idea what went wrong and can not recover.  For
> > something like this, we "know" these will be fine and odds are they can
> > just be removed entirely.
> >
> >
> Right, I'm watching how replace the BUG_ON with WARN_ON and check who call
> this functions

No, why would WARN_ON be any better?  Systems run with "panic on warn"
enabled and this would cause the machine to reboot.  Why are these
things even being checked in the first place if they are impossible to
hit?

If they really are impossible, remove the check.  If they are not, then
properly handle the logic if they are true.

Linus said the other day something like "programmers who use BUG_ON()
don't know what their code does", and I agree.  They are a crutch that
we need to fix up in the whole kernel, not just staging.

> > >       destroy_workqueue(z_erofs_workqueue);
> > >       kmem_cache_destroy(z_erofs_workgroup_cachep);
> > > @@ -39,7 +39,7 @@ static inline int init_unzip_workqueue(void)
> > >               WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
> > >               onlinecpus + onlinecpus / 4);
> > >
> > > -     return z_erofs_workqueue != NULL ? 0 : -ENOMEM;
> > > +     return z_erofs_workqueue ? 0 : -ENOMEM;
> >
> > I hate ?: notation that is not in a function parameter, any way you can
> > just change this to:
> >         if (z_erofs_workqueue)
> >                 return 0;
> >         return -ENOMEM;
> >
> >
> I will replace the ?: too
> 
> 
> > Christian, this isn't your fault at all, I'm not rejecting this patch,
> > just providing hints on what else you can do here :)
> >
> 
> 
> but (if I well understand) I will send a different patch for both fix,
> right?

Yes, nothing wrong with this one that I could see.  I'll let the erofs
maintainers review it first before applying it in a few days to my tree.

thanks,

greg k-h
