Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0725325063
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AME6pOCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0725325063
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbeGBUvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:51:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41867 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeGBUvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:51:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id a17-v6so10408746ljd.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3x4TKU/msyOdS9y5ELY4/PoNqIvOuXlmEPzWzIN99oY=;
        b=AME6pOCD/LyTIre/kVdvRUyRfDU1rTde5wP2eBEPUBNBubWkg5X834jQui+bV31RBg
         HGaCjJGoBVHuU4n4cDbzXLabQYP0EdXaAfKX3p7gZVG5xsHVyB3VUFup3a8ClCkE/y5l
         0gxkxn28oQlEt4eiVlwckNSAK3pl36w9qgBnt/xxPkIic7VzQtpwpE8UVMz/cI6C/0SW
         s9AaH3i2simIUvYzC2QF0uIBLt0oDuQAmcvEuYDAq1RIhQupRRlYFk81toDQn6wWulgP
         6L9HfYK71vHGjA1kfJFAIe3B6iY2+5Pm7R8kyIbsck81vhGxhT5HqVRxPQF2XiWhVJhO
         02WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3x4TKU/msyOdS9y5ELY4/PoNqIvOuXlmEPzWzIN99oY=;
        b=Bglf5DnM+dPxvKSvnXjplbsriEc8K0CVvaeKsgqwwMl7eCBFuoJOOn5xtPD5Lpibij
         Z1zBCzUVuDn0qdB2PRd3cj1mGPlPtve1E7uHNLnwFXnomHYv9ZdutMysVJDj3wK6haey
         N/+pFUGkqqQ6rX+2gTgHOEwqSy/pe/RwrvIPCxk7kEnx0eXDQiPgvP79jnx/nj+ij5vG
         TAwXwaRSAQHrCKyLtjhKlm3z9GZ+IDF85ft1qfopkscZpVYMg28vkdZsH4wAV4P10TZN
         JB/TrYANmrPtzyfATKosY44rRr6UbojEF15XSC6R4DjiQiDPwRDD7VOesc3RgP80dZuQ
         A5xw==
X-Gm-Message-State: APt69E1z4ItDBmVDZOiup39KabPr6ZlQm0d+6B1GkK3q7/h6uVRyq/OM
        wTJqatTGedeE77du6BrCATl6juUBpS4W7zeqgS1e
X-Google-Smtp-Source: AAOMgpc0llu5iIgMV6O0ajUkcOeGxLApWQOLATn9/XY7DViFNeEzR2PpwVTBTHJmfBzTwp+jdZ1no6OKq9Exj8ac9B0=
X-Received: by 2002:a2e:4242:: with SMTP id p63-v6mr9019518lja.83.1530564696289;
 Mon, 02 Jul 2018 13:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
In-Reply-To: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Jul 2018 16:51:25 -0400
Message-ID: <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com>
Subject: Re: [PATCH] selinux: Use pr_fmt to prefix "SELinux: "
To:     joe@perches.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, peter.enderborg@sony.com,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 2:39 AM Joe Perches <joe@perches.com> wrote:
> pr_fmt can be used with the pr_<level> macros to prefix
> arbitrary content to logging messages.
>
> So add '#define pr_fmt(fmt) "SELinux: " fmt' to selinux files
> that use pr_<level> and remove embedded "SELinux: " prefixes
> from the format strings.
>
> Miscellanea:
>
> o Coalesce formats and realign arguments
> o Add missing space to a coalesced format
> o Remove "SELinux: " from SEL_MOUNT_FAIL_MSG as that is directly
>   used only in pr_warn
> o Add missing terminating \n to some formats
> o Consistently use single space after logging prefixes
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  security/selinux/avc.c            |   7 ++-
>  security/selinux/hooks.c          | 124 +++++++++++++++++---------------------
>  security/selinux/netif.c          |   7 ++-
>  security/selinux/netlink.c        |   7 ++-
>  security/selinux/netnode.c        |   4 +-
>  security/selinux/netport.c        |   4 +-
>  security/selinux/selinuxfs.c      |  33 +++++-----
>  security/selinux/ss/avtab.c       |  61 +++++++++----------
>  security/selinux/ss/conditional.c |  18 +++---
>  security/selinux/ss/ebitmap.c     |  20 +++---
>  security/selinux/ss/policydb.c    | 123 +++++++++++++++++--------------------
>  security/selinux/ss/services.c    | 110 +++++++++++++--------------------
>  security/selinux/ss/sidtab.c      |  12 ++--
>  13 files changed, 247 insertions(+), 283 deletions(-)

...

> @@ -1644,13 +1640,12 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>
>                                 if (rc == -EINVAL) {
>                                         if (printk_ratelimit())
> -                                               pr_notice("SELinux: inode=%lu on dev=%s was found to have an invalid "
> -                                                       "context=%s.  This indicates you may need to relabel the inode or the "
> -                                                       "filesystem in question.\n", ino, dev, context);
> +                                               pr_notice("inode=%lu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
> +                                                         ino, dev, context);

Please split up lines like this.  I realize that there isn't much room
left, but this message wraps a silly amount in my 80-char terminal; if
you need to wrap, please limit it to a word or two.

To stop the argument before it starts, I don't care what checkpatch.pl
says about splitting printk format strings like this.  Split the line
please.

> @@ -3124,9 +3117,9 @@ static int selinux_validate_for_sb_reconfigure(struct fs_context *fc)
>                 rc = security_context_str_to_sid(&selinux_state, mount_options[i],
>                                                  &sid, GFP_KERNEL);
>                 if (rc) {
> -                       pr_warn("SELinux: security_context_str_to_sid"
> -                               "(%s) failed for (dev %s, type %s) errno=%d\n",
> -                               mount_options[i], sb->s_id, sb->s_type->name, rc);
> +                       pr_warn("security_context_str_to_sid(%s) failed for (dev %s, type %s) errno=%d\n",
> +                               mount_options[i],
> +                               sb->s_id, sb->s_type->name, rc);
>                         goto inval;
>                 }

What tree did you base your patch on?  Please base SELinux patches
either on the SELinux tree or Linus' tree.  The SELinux tree can be
found at the links below:

* git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
* https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

--
paul moore
www.paul-moore.com
