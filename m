Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9C5C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 01:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4E720891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 01:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6t3tG2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4E720891
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756798AbeFPB3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 21:29:17 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:50517 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753879AbeFPB3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 21:29:16 -0400
Received: by mail-io0-f201.google.com with SMTP id n15-v6so8569581ioc.17
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 18:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=1LR+ZVtfUkbb935nF86L0EErFw88+Q1SWc2lo40IwH0=;
        b=U6t3tG2YhDsj8/VbnEVDemjOGClwPEHN7OeaFNxhhck44Vv+Fv/y3ov8jjr2JFbQZz
         JSnriWvRjT89b486BkQyUc+mFluxJ5C9wPhJz0mt/UG3CZjVTLgJ1cEXr6TFoNEiHJMy
         Kx+bOYs/eo28oFJnwFQmdOPlzyXR2JEDQJcwNPIQPmrKYVFBY9qUWyCupMCfvVacEyQR
         Jl8xayxnHZjHqkXxeYxOaVNkBkFJrjrzg+jLqelDgkc5mb4fyBkzoIzQ+s+pEjJDiAH1
         iaaLcXdpa83VueSnLwqitbRmslMNe1tgztFe3N2FRQThT68/c5Q+ROmzC1/WaEINXWRI
         00yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=1LR+ZVtfUkbb935nF86L0EErFw88+Q1SWc2lo40IwH0=;
        b=KL4NY2nDmpVWgbAbYVDu9+BvnHuDfyl14wCKMKuI/hcmSMKFvJroouNqhiItEmuV+G
         L9vlVXlLqZxFa18iJ3Y12noRZoahALzukRW1X3XFY81RNT+LtROtW14JAN099BHm7tO2
         /PVKlc8cRSLQ+IZnASBecJ+Y+CtKVfQS6pgXje+OU2NKgYjq3KLtKYUEAmJ0HBDdZ+c9
         uQgYUdB0Y860q21kuJQG3uImFXNbAGd2U3X82dg7luJxw38ARbMArZ+lp531/eOzFnhj
         u3fXUd/fIM3SjWpZ2fe/snU2utlBE4zpBKvVGopSvMT4U4lcgMb3Mc0mvIvszGfbRm1G
         YHIw==
X-Gm-Message-State: APt69E0Cr6pWbr9TShvbLwfkQhz03+UIkSZyDrj2U0pT4BgSbvmhxZYV
        3pXWY4wqPDTBi+05VmtMdcEK8ao8RnyY
X-Google-Smtp-Source: ADUXVKKJgKHJ7epYdxiYjecvLb3jUHn52RrNpmWXTJeoj6eKtqEVDfhJ2UCbm9Hjkr9Gt9oNObTEQ7Bw7sPm
MIME-Version: 1.0
X-Received: by 2002:a24:1609:: with SMTP id a9-v6mr1492797ita.0.1529112555499;
 Fri, 15 Jun 2018 18:29:15 -0700 (PDT)
Date:   Fri, 15 Jun 2018 18:29:10 -0700
Message-Id: <20180616012910.152694-1-rajatja@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH] sysfs: Fix internal_create_group() for named group updates
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
 fs/sysfs/group.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 4802ec0e1e3a..8bd10dc730ae 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -119,12 +119,23 @@ static int internal_create_group(struct kobject *kobj, int update,
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
+				WARN(1,
+				     "Can't update unknown attr grp name: %s/%s\n",
+				     kobj->name, grp->name);
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
@@ -199,7 +210,8 @@ EXPORT_SYMBOL_GPL(sysfs_create_groups);
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

