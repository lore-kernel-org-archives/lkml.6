Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A67C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57620878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT6tyLGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F57620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLFRI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:08:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33303 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLFRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:08:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so457605plo.0;
        Thu, 06 Dec 2018 09:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kk4RbzqHHzQDb9vXoUHlKfqVsZCOyY4+FfrWgQJsLBc=;
        b=hT6tyLGzyhbVX8Ulu+o51Fb1IncgzS8ELhJ+UJ1CUbHWZ+WOo4XguGbP6vCJsn5xRq
         Lpuv30OOK1t4yxlbn0E664n4kwGki6XLl1oM8mz6M1H61aFoA8MTkN0a18hg8a+0pAIE
         zzhRcIbiLL2mIC+A3hw5SPiPtqN2Yzi+UOO6K2gTbZqm8aCHoD1F0Qh/kk8hjGJaQuj0
         HD+WB3AQ6Z+h+uZstlmgHUV1560ZB4Dm1VRSG11lHdy/JA0rNavEdwSOvl6wDOEKCr7S
         04GFBN8GKIGsjsH3iuM41CZ15eLZRDF+cuY4Sp4+DDDamGEZ8TrYyWRao5ACBRZ8zJQJ
         +KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kk4RbzqHHzQDb9vXoUHlKfqVsZCOyY4+FfrWgQJsLBc=;
        b=jWsECSwJKUgzXIhjLS6yNwN/BWIY85Snrav6c58J6/bUKrKl/k/AB79vHU9Jm/FQVb
         tAB0zNosfFlajSHVORFTyj6tD9VZBaNy2nVyHFO9LsYZ02Eq/Bkk0e+n0m6lI2DHRLz8
         LqpVOLhhbj5UCqw01+TKnJGEqquC9GQcYOMmU6ckg0kR7MJs9O0X1ChsEldTZ2NPd6Ro
         8TSOu6oaAKUeZkMEdi0uy7DcHP8G0R+NrgO+VxTIFMde9RL20rZbnq6a3Nn9bq1kkkak
         IzDgTr0ALl2NbZnt4csXv+lVdN7CIqOYav4TnS2yaXV1Li38398zD54CEtUunkDtsMc5
         yCbQ==
X-Gm-Message-State: AA+aEWbD0KZaOldBjRMHvcA1lXErkFA1+fwRv8WkOG4iGzOvizgHTMOd
        xpr60r6lidBWDUim/osWGdQ=
X-Google-Smtp-Source: AFSGD/UdS1j3px80R43foHsDZJZekcVUArVHsluefG90xGP6PWVOJmhFuKQ53lbHPx/m4T3oOMqfzA==
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr28204948plo.59.1544116106830;
        Thu, 06 Dec 2018 09:08:26 -0800 (PST)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id y1-v6sm1271992pfb.81.2018.12.06.09.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 09:08:25 -0800 (PST)
Date:   Thu, 6 Dec 2018 09:08:23 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        fenghua.yu@intel.com, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 21/34] kernfs, sysfs, cgroup, intel_rdt: Support
 fs_context [ver #12]
Message-ID: <20181206170822.GA15790@gmail.com>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754758187.17872.2791003837321822804.stgit@warthog.procyon.org.uk>
 <20181119042340.GA31532@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20181119042340.GA31532@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 08:23:42PM -0800, Andrei Vagin wrote:
> On Fri, Sep 21, 2018 at 05:33:01PM +0100, David Howells wrote:
> > @@ -1993,57 +2009,53 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask, int ref_flags)
> >  	return ret;
> >  }
> >  
> > -struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
> > -			       struct cgroup_root *root, unsigned long magic,
> > -			       struct cgroup_namespace *ns)
> > +int cgroup_do_get_tree(struct fs_context *fc)
> >  {
> > -	struct dentry *dentry;
> > -	bool new_sb;
> > +	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
> > +	int ret;
> >  
> > -	dentry = kernfs_mount(fs_type, flags, root->kf_root, magic, &new_sb);
> > +	ctx->kfc.root = ctx->root->kf_root;
> > +
> > +	ret = kernfs_get_tree(fc);
> > +	if (ret < 0)
> > +		goto out_cgrp;
> >  
> >  	/*
> >  	 * In non-init cgroup namespace, instead of root cgroup's dentry,
> >  	 * we return the dentry corresponding to the cgroupns->root_cgrp.
> >  	 */
> > -	if (!IS_ERR(dentry) && ns != &init_cgroup_ns) {
> > +	if (ctx->ns != &init_cgroup_ns) {
> >  		struct dentry *nsdentry;
> >  		struct cgroup *cgrp;
> >  
> >  		mutex_lock(&cgroup_mutex);
> >  		spin_lock_irq(&css_set_lock);
> >  
> > -		cgrp = cset_cgroup_from_root(ns->root_cset, root);
> > +		cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
> >  
> >  		spin_unlock_irq(&css_set_lock);
> >  		mutex_unlock(&cgroup_mutex);
> >  
> > -		nsdentry = kernfs_node_dentry(cgrp->kn, dentry->d_sb);
> > -		dput(dentry);
> > -		dentry = nsdentry;
> > +		nsdentry = kernfs_node_dentry(cgrp->kn, fc->root->d_sb);
> > +		if (IS_ERR(nsdentry))
> > +			return PTR_ERR(nsdentry);
> > +		dput(fc->root);
> > +		fc->root = nsdentry;
> >  	}
> >  
> > -	if (IS_ERR(dentry) || !new_sb)
> > -		cgroup_put(&root->cgrp);
> 
> I don't see where this cgroup_put() has been moved.

David, have you looked at this problem? It isn't fixed in linux-next
yet.

https://travis-ci.org/avagin/linux/jobs/463960763

Thanks,
Andrei

> 
> With this patch, the next script works only once, on the second attempt
> it hangs up on mounting a cgroup file system.
> 
> This is the only suspicious place in this patch what I have found.
> 
> [root@fc24 ~]# cat fs-vs-cg 
> d=$(mktemp -d /tmp/cg.XXXXXX)
> mkdir $d/a
> mkdir $d/b
> mount -t cgroup -o none,name=xxxx xxx $d/a
> mount -t cgroup -o none,name=xxxx xxx $d/b
> umount $d/a
> umount $d/b
> 
> [root@fc24 ~]# unshare -m --propagation private bash -x fs-vs-cg
> ++ mktemp -d /tmp/cg.XXXXXX
> + d=/tmp/cg.yUfagS
> + mkdir /tmp/cg.yUfagS/a
> + mkdir /tmp/cg.yUfagS/b
> + mount -t cgroup -o none,name=xxxx xxx /tmp/cg.yUfagS/a
> + mount -t cgroup -o none,name=xxxx xxx /tmp/cg.yUfagS/b
> + umount /tmp/cg.yUfagS/a
> + umount /tmp/cg.yUfagS/b
> [root@fc24 ~]# unshare -m --propagation private bash -x fs-vs-cg
> ++ mktemp -d /tmp/cg.XXXXXX
> + d=/tmp/cg.ippWUn
> + mkdir /tmp/cg.ippWUn/a
> + mkdir /tmp/cg.ippWUn/b
> + mount -t cgroup -o none,name=xxxx xxx /tmp/cg.ippWUn/a
> ^Z
> [1]+  Stopped                 unshare -m --propagation private bash -x fs-vs-cg
> 
> [root@fc24 ~]# ps
>   PID TTY          TIME CMD
>   556 pts/0    00:00:00 bash
>   591 pts/0    00:00:00 bash
>   595 pts/0    00:00:00 mount
>   596 pts/0    00:00:00 ps
> 
> [root@fc24 ~]# bg
> [1]+ unshare -m --propagation private bash -x fs-vs-cg &
> 
> [root@fc24 ~]# cat /proc/595/stack 
> [<0>] msleep+0x38/0x40
> [<0>] cgroup1_get_tree+0x4e1/0x72c
> [<0>] vfs_get_tree+0x5e/0x140
> [<0>] do_mount+0x326/0xc70
> [<0>] ksys_mount+0xba/0xd0
> [<0>] __x64_sys_mount+0x21/0x30
> [<0>] do_syscall_64+0x60/0x210
> [<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [<0>] 0xffffffffffffffff
> 
