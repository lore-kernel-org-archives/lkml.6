Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA959C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D9B208E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXZKtRvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D9B208E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbeHPDAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 23:00:35 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36544 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbeHPDAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 23:00:35 -0400
Received: by mail-yw1-f67.google.com with SMTP id v197-v6so2207819ywg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVIrTKZc3diJ/rbC18LScnx/GT5nB9y5AwhQHrUMVmE=;
        b=CXZKtRvjrcrWCxnC9Vtz5m6cpZGQy5R085gid0FbON/wb2ot+7dkBi2M6ZqKN2avfD
         iecEh7ypyPvO5BFVpLdwVNUS7GseZxOAwinYlQ8WaHeLVYFRyFPSD0TUfkBH+7kaKfps
         DPqp8nNLOQxlKyP8A/OxfbPnrvUtTgPFUFamDmYNsianZ2UPBZdrcEZtZsUTDveoXvt6
         ySlSXRp1215HyHu1ryaKgXNfwor+jXkev10jEDunjzT3PvP57S3wa7EghGoulMXzEkM1
         vHxTEFGz9XNn+VaoMlGEfjyfxFJ4067qJBAHn069IlJC47kqJIvG5FFG5nlVoIGBDUuo
         HkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVIrTKZc3diJ/rbC18LScnx/GT5nB9y5AwhQHrUMVmE=;
        b=ZQ8je13UtqiKGwzpT2n7JLl3LBktvRsZN4WJYwzLFdpguwIGw+/uTpjuvHvdhlEI/Z
         C1M5LHdb1ytREpIsr57f4q633Ef5p7pP+duBo+iklOl3ThhQBE4NGwWoI+ATZrxGfGXx
         XU7kcAVBHfd+uQVW+hx7gCqezbTVxP+85N2rVNoPiJrN8KplCQE/eqlPkzQFnQAILsVQ
         QGmF1mP+ir58RQdo4f1LhjHJjeoOJio+UxZtPOH+DhBbQpHZjvf8rGsShRj6kSogcqEL
         LK02Pmn/BAKlD+RlYdHBwiM8v5YDPK6Xfu19k3trp5jwxJH+CS1copcP91OKlfQlWFea
         uzzQ==
X-Gm-Message-State: AOUpUlF/RXeZTJ/o3rWXwZgD5sIsMVhG4tG3Or6WERNnf0awB/+gulpi
        dYzsKdOiCPtVUZMcX+FFHurlwhbTU8Qsd8q8Q4TkPg==
X-Google-Smtp-Source: AA+uWPy9yDdbeczKvDbRoAZMQd4icvmdkUyRbjVGxk/ISDyBl4JxN8kiEJIkLNKNttOQ7O7axq9KO/Sk9Dsl7CospjY=
X-Received: by 2002:a81:f102:: with SMTP id h2-v6mr16480195ywm.297.1534377960050;
 Wed, 15 Aug 2018 17:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180723151224.69a73892@canb.auug.org.au> <20180723062046.GA2577@kroah.com>
 <20180816094254.6e0bd68c@canb.auug.org.au>
In-Reply-To: <20180816094254.6e0bd68c@canb.auug.org.au>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 15 Aug 2018 17:05:23 -0700
Message-ID: <CACK8Z6GbNozvdyrXdZyBEKKMC-U=puggpaPzMRWF0MAqC0Lf_g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 net-next tree
To:     sfr@canb.auug.org.au
Cc:     greg@kroah.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 4:43 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Mon, 23 Jul 2018 08:20:46 +0200 Greg KH <greg@kroah.com> wrote:
> >
> > On Mon, Jul 23, 2018 at 03:12:24PM +1000, Stephen Rothwell wrote:
> > >
> > > Today's linux-next merge of the driver-core tree got a conflict in:
> > >
> > >   fs/sysfs/group.c
> > >
> > > between commit:
> > >
> > >   5f81880d5204 ("sysfs, kobject: allow creating kobject belonging to arbitrary users")
> > >
> > > from the net-next tree and commit:
> > >
> > >   c855cf2759d2 ("sysfs: Fix internal_create_group() for named group updates")
> > >
> > > from the driver-core tree.
> > >
> > > I fixed it up (I think - see below) and can carry the fix as
> > > necessary. This is now fixed as far as linux-next is concerned, but any
> > > non trivial conflicts should be mentioned to your upstream maintainer
> > > when your tree is submitted for merging.  You may also want to consider
> > > cooperating with the maintainer of the conflicting tree to minimise any
> > > particularly complex conflicts.
> > >
> > > --
> > > Cheers,
> > > Stephen Rothwell
> > >
> > > diff --cc fs/sysfs/group.c
> > > index c7a716c4acc9,38240410f831..000000000000
> > > --- a/fs/sysfs/group.c
> > > +++ b/fs/sysfs/group.c
> > > @@@ -122,15 -118,23 +122,24 @@@ static int internal_create_group(struc
> > >                     kobj->name, grp->name ?: "");
> > >             return -EINVAL;
> > >     }
> > >  +  kobject_get_ownership(kobj, &uid, &gid);
> > >     if (grp->name) {
> > > -           kn = kernfs_create_dir_ns(kobj->sd, grp->name,
> > > -                                     S_IRWXU | S_IRUGO | S_IXUGO,
> > > -                                     uid, gid, kobj, NULL);
> > > -           if (IS_ERR(kn)) {
> > > -                   if (PTR_ERR(kn) == -EEXIST)
> > > -                           sysfs_warn_dup(kobj->sd, grp->name);
> > > -                   return PTR_ERR(kn);
> > > +           if (update) {
> > > +                   kn = kernfs_find_and_get(kobj->sd, grp->name);
> > > +                   if (!kn) {
> > > +                           pr_warn("Can't update unknown attr grp name: %s/%s\n",
> > > +                                   kobj->name, grp->name);
> > > +                           return -EINVAL;
> > > +                   }
> > > +           } else {
> > >  -                  kn = kernfs_create_dir(kobj->sd, grp->name,
> > >  -                                         S_IRWXU | S_IRUGO | S_IXUGO,
> > >  -                                         kobj);
> > > ++                  kn = kernfs_create_dir_ns(kobj->sd, grp->name,
> > > ++                                            S_IRWXU | S_IRUGO | S_IXUGO,
> > > ++                                            uid, gid, kobj, NULL);
> > > +                   if (IS_ERR(kn)) {
> > > +                           if (PTR_ERR(kn) == -EEXIST)
> > > +                                   sysfs_warn_dup(kobj->sd, grp->name);
> > > +                           return PTR_ERR(kn);
> > > +                   }
> > >             }
> > >     } else
> > >             kn = kobj->sd;
> >
> >
> > I think this is correct.  Rajat, can you verify it please?

Sorry, I saw this very late. Yes, this is correct.

>
>
> This is now a conflict between Linus' tree and the driver-core tree.

Greg, please let me know if there is anything I need to do about this.

Thanks & Best Regards,

Rajat

> --
> Cheers,
> Stephen Rothwell
