Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0755C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF9B2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546507590;
	bh=HjWtj5FjfbsJj6gIH5lEqYnIcppI3FkQdMgD6ayTm2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GENX8z+HUI+DNvytzpZ1Sroi1wh6pH77V1fJxqNe1K3VEUePXJ0hQWZNLPDLbfBIi
	 z43T+MXSCFcjqDvroPIf0xHDI+W2FM2yuzbh1wdyyaKpmUl+24IqcSxtfdBMIDvbXH
	 8NS6ykOwpMWCR2ZnhPWjUhjHHTaPUGTtKtPRVqi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfACJ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:26:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfACJ0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:26:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E3AC21019;
        Thu,  3 Jan 2019 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546507585;
        bh=HjWtj5FjfbsJj6gIH5lEqYnIcppI3FkQdMgD6ayTm2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozzmUrjmWB3lRX5E6fBZMbZ62OCA/H6Kdf6pXtm78r9UfwYK4wHARYOUkoSBxKxRg
         78sKRkBVVioAOPr9/GjqpHhfXiVPWVn1IDaqQIc7KEbJDCHiiNYInGRbhMKJCaF0Tt
         kGxnC6xVsmoboxWQ2yBYS2dsSmQd+5q4N/mA6KH0=
Date:   Thu, 3 Jan 2019 10:26:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Alban Bedel <albeu@free.fr>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
Subject: Re: [LKP] [mtd] c4dfa25ab3: kernel_BUG_at_fs/sysfs/file.c
Message-ID: <20190103092622.GA6262@kroah.com>
References: <20190102005704.GC17624@shao2-debian>
 <CAHk-=wh2sparb1qw4h5QTCR+YF7xsssLgZtNtthRA6QiJjKfbA@mail.gmail.com>
 <CAJZ5v0hXEqtaiV56sGCOd1VzsRETkS39YiLV-OfnFWiZH4tcAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hXEqtaiV56sGCOd1VzsRETkS39YiLV-OfnFWiZH4tcAQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 10:44:50PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 2, 2019 at 8:53 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> 
> [cut]
> 
> > Greg, Rafael: it does strike me that the "BUG_ON()" in
> > sysfs_create_file_ns() could easily have been a
> >
> >         if (WARN_ON(..))
> >                 return -EINVAL;
> >
> > which would have made the machine boot and probably make things easier
> > for normal users to report. The kernel test robot doesn't care, but
> > non-booting kernels are usually not nice to debug or report for normal
> > human beings..
> 
> I agree.
> 
> This isn't a good enough reason to crash the kernel IMO.

I agree too.

Here's a patch for this, I'll queue it up after -rc1 is out.  Rafael,
look good to you?

--------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] sysfs: convert BUG_ON to WARN_ON

It's rude to crash the system just because the developer did something
wrong, as it prevents them from usually even seeing what went wrong.

So convert the few BUG_ON() calls that have snuck into the sysfs code
over the years to WARN_ON() to make it more "friendly".  All of these
are able to be recovered from, so it makes no sense to crash.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/sysfs/dir.c     | 3 ++-
 fs/sysfs/file.c    | 6 ++++--
 fs/sysfs/group.c   | 3 ++-
 fs/sysfs/symlink.c | 3 ++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index feeae8081c22..aa85f2874a9f 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -43,7 +43,8 @@ int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
 	kuid_t uid;
 	kgid_t gid;
 
-	BUG_ON(!kobj);
+	if (WARN_ON(!kobj))
+		return -EINVAL;
 
 	if (kobj->parent)
 		parent = kobj->parent->sd;
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index bb71db63c99c..51398457fe00 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -325,7 +325,8 @@ int sysfs_create_file_ns(struct kobject *kobj, const struct attribute *attr,
 	kuid_t uid;
 	kgid_t gid;
 
-	BUG_ON(!kobj || !kobj->sd || !attr);
+	if (WARN_ON(!kobj || !kobj->sd || !attr))
+		return -EINVAL;
 
 	kobject_get_ownership(kobj, &uid, &gid);
 	return sysfs_add_file_mode_ns(kobj->sd, attr, false, attr->mode,
@@ -537,7 +538,8 @@ int sysfs_create_bin_file(struct kobject *kobj,
 	kuid_t uid;
 	kgid_t gid;
 
-	BUG_ON(!kobj || !kobj->sd || !attr);
+	if (WARN_ON(!kobj || !kobj->sd || !attr))
+		return -EINVAL;
 
 	kobject_get_ownership(kobj, &uid, &gid);
 	return sysfs_add_file_mode_ns(kobj->sd, &attr->attr, true,
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 1eb2d6307663..57038604d4a8 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -112,7 +112,8 @@ static int internal_create_group(struct kobject *kobj, int update,
 	kgid_t gid;
 	int error;
 
-	BUG_ON(!kobj || (!update && !kobj->sd));
+	if (WARN_ON(!kobj || (!update && !kobj->sd)))
+		return -EINVAL;
 
 	/* Updates may happen before the object has been instantiated */
 	if (unlikely(update && !kobj->sd))
diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
index 215c225b2ca1..c4deecc80f67 100644
--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -23,7 +23,8 @@ static int sysfs_do_create_link_sd(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn, *target = NULL;
 
-	BUG_ON(!name || !parent);
+	if (WARN_ON(!name || !parent))
+		return -EINVAL;
 
 	/*
 	 * We don't own @target_kobj and it may be removed at any time.
-- 
2.20.1

