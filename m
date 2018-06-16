Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B42C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B623A20874
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aeQFXalv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B623A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932508AbeFPISy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 04:18:54 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:46936 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932188AbeFPISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 04:18:52 -0400
Received: by mail-ua0-f202.google.com with SMTP id m1-v6so4071026uao.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 01:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=T3SBQtHO/b26sBIquivD1pc77kYIMRAxo1vAdKNF47Y=;
        b=aeQFXalvppdUHFoUFqz4aDpfbzqnY3R10l6rnQWksAtjMbWc6tyeyVSanusBhVy+LG
         4U+6Pkp11VSR1CURZE6p6GFlgMsNnQ5B2b1RRkSrcSp7jlXzZ/stLV7rBoU+mDWHsIVd
         QPLx+35CgcsdPkZsdntdUdILeWVOj8GLN06hQamyuNSakG9AZ42wE84Q3rrnAfQsylBS
         p6Hs13BH/07l9/6uFNxySGoz4iSRZyRE1csgU/mpJ0FqcdJNXwCG8tVe79u86kURhmep
         Ge3D7ulSciOPxAi9VnCe6jXIg7NgqdPVXv9O97NLrrVoHGFShFtFqN1tAHGop3n3KZJF
         fE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=T3SBQtHO/b26sBIquivD1pc77kYIMRAxo1vAdKNF47Y=;
        b=Fa1WJQKIavwr4IBWf58ULQ8ZBW+H4UywOl8XbaBoP7rvg9NQMOyxyt9KNib9rTr9UZ
         55hKSpvhgyC1rsYB78DLIBxR61ck/iChuIWRet9MuvnxIdShasx+oDz6hmyGZcdCNoZm
         nhwCPwY3MQrFMaZGvqINrWKNtku0c/IopZipX/OqGD1gDQ2u6vcgIEX7QYfKtkgPIumN
         dLwJ+GD98Cgsdnq6nEnAvq9lJjmYLguIhgstUFaotFiFak461kmbIGCyRttSplbRmh2T
         7HZ3xKVROP2XVKp7GabUSenf2msvXXtQMycC9dUu6qzy0HUSNsAvK1aw697hg3w5pcEv
         4shg==
X-Gm-Message-State: APt69E3AX8SZVlralqvTKs3cDea2fXkhAS5ZYHX7C3wRIhjc6jEy5UA/
        tlSZ1xBD1sp/0mWyT1BRxsCFHtTUY3gZ
X-Google-Smtp-Source: ADUXVKKsYZV1EUEdm2jeZKkbEUpIQCgsTnz5g10lcUdV3PQuWNZw0rDzXrTdVUtgkah0KnaPR22WpuKhj8PD
MIME-Version: 1.0
X-Received: by 2002:ab0:4741:: with SMTP id i1-v6mr2042028uac.116.1529137131853;
 Sat, 16 Jun 2018 01:18:51 -0700 (PDT)
Date:   Sat, 16 Jun 2018 01:18:37 -0700
In-Reply-To: <CAA93t1rOdj4zorR=iU1=9qJmzeTeqD9L5GdX8pm7=NHXzSiy_g@mail.gmail.com>
Message-Id: <20180616081837.62730-1-rajatja@google.com>
References: <CAA93t1rOdj4zorR=iU1=9qJmzeTeqD9L5GdX8pm7=NHXzSiy_g@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2] sysfs: Fix internal_create_group() for named group updates
From:   Rajat Jain <rajatja@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of problems with named group updates in the code
today:

* sysfs_update_group() will always fail for a named group, because
  internal_create_group() will try to create a new sysfs directory
  unconditionally, which will ofcourse fail with -EEXIST.

* We can leak the kernfs_node for grp->name if some one tries to:
  - rename a group (change grp->name), or
  - update a named group, to an unnamed group

It appears that the whole purpose of sysfs_update_group() was to
allow changing the permissions or visibility of attributes and not
the names. So make it clear in the comments, and allow it to update
an existing named group.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Use pr_warn() instead of WARN()

 fs/sysfs/group.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 4802ec0e1e3a..2b7d3536e6cb 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -119,12 +119,22 @@ static int internal_create_group(struct kobject *kobj, int update,
 		return -EINVAL;
 	}
 	if (grp->name) {
-		kn = kernfs_create_dir(kobj->sd, grp->name,
-				       S_IRWXU | S_IRUGO | S_IXUGO, kobj);
-		if (IS_ERR(kn)) {
-			if (PTR_ERR(kn) == -EEXIST)
-				sysfs_warn_dup(kobj->sd, grp->name);
-			return PTR_ERR(kn);
+		if (update) {
+			kn = kernfs_find_and_get(kobj->sd, grp->name);
+			if (!kn) {
+				pr_warn("Can't update unknown attr grp name: %s/%s\n",
+					kobj->name, grp->name);
+				return -EINVAL;
+			}
+		} else {
+			kn = kernfs_create_dir(kobj->sd, grp->name,
+					       S_IRWXU | S_IRUGO | S_IXUGO,
+					       kobj);
+			if (IS_ERR(kn)) {
+				if (PTR_ERR(kn) == -EEXIST)
+					sysfs_warn_dup(kobj->sd, grp->name);
+				return PTR_ERR(kn);
+			}
 		}
 	} else
 		kn = kobj->sd;
@@ -199,7 +209,8 @@ EXPORT_SYMBOL_GPL(sysfs_create_groups);
  * of the attribute files being created already exist.  Furthermore,
  * if the visibility of the files has changed through the is_visible()
  * callback, it will update the permissions and add or remove the
- * relevant files.
+ * relevant files. Changing a group's name (subdirectory name under
+ * kobj's directory in sysfs) is not allowed.
  *
  * The primary use for this function is to call it after making a change
  * that affects group visibility.
-- 
2.18.0.rc1.244.gcf134e6275-goog

