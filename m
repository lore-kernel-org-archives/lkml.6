Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8F4C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 17:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F7920895
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 17:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HjnN9QqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F7920895
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeFPRtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 13:49:52 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:52849 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbeFPRtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 13:49:51 -0400
Received: by mail-qt0-f202.google.com with SMTP id m4-v6so10299945qtn.19
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=G9SwumVn9dGJhv55WcLrC5eA4b3IA8ok87ZlbiK/fYQ=;
        b=HjnN9QqP7iEwPyT1NgklepQCyJF0Yrgpf4VA/6PfwFAilSnt+jDqjShifWkoZHon8k
         4NAzUxuN6veAszPa2ZrXkCwtetX3ymU57tcj1RxexAPQtspp3Ho7BTQ2wc3a6kmSQQSV
         wyEmeovuWhEpnTAYr97sshbzqsmaOQLrt+JyapAjhX7BDdnuX41OCyRlQj2M/Bm11rS7
         Y1ySDmywCdTfNcEGFon382ltlpF43ckv2kPgjJTEPQ+B51Ir4sWOzbIRNL4CcCbDV7D+
         nE9oC4uH0qZ40QlJFyHL9p3f7p+C49DBP8nm5kgdYJM45Y/6F3FZKsWBVXs0N+l3+hGi
         ahYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=G9SwumVn9dGJhv55WcLrC5eA4b3IA8ok87ZlbiK/fYQ=;
        b=kVoXraUcPjzCzOiFvlJJWkYXBkDqfwF3Vp5VGtGr7bx4MCAkRN1/epvRZiv0GkPQbU
         m3ZJJB91t+d2UmGxP6K2b/rrKerR2bKNOR0C0othHBF05Jsq4E8lYTmrZh2vTywdn253
         891Olpu40VOB8qDoP1y3p+H170VmVpZqGjuwzfUnL9XNZX8bMqSpX4W/z/auNcZSmAoQ
         noiN8TIuguSthz0wTYo45lqQujzdPLX6RdYRIayc+tTQ+knEIWnSMf1T8lGhVSldGA3F
         8MfdRmhIWme+LG4VGsu3in1SvGUWk/fdBRyN+SYuuR+IPEiNe++7UtSI0zMj2YjkkKJ9
         f7mw==
X-Gm-Message-State: APt69E2L+de8pJfdvTsYce8opkQ8H53nvOGvpc8XBv4AXUzBoRVxnfvK
        kOvMXkbpqMKN3VvEZXnqeYRWYefPPIvN
X-Google-Smtp-Source: ADUXVKI0HUC950e+DNBL5j/Q90Xj9ZVm3PHvZn+Swzp5+k+icQ+Kvy+la65+jftFroBZyZOa+664jONhbTIJ
MIME-Version: 1.0
X-Received: by 2002:ac8:3558:: with SMTP id z24-v6mr3365937qtb.21.1529171390859;
 Sat, 16 Jun 2018 10:49:50 -0700 (PDT)
Date:   Sat, 16 Jun 2018 10:49:46 -0700
In-Reply-To: <20180616083740.GA23039@kroah.com>
Message-Id: <20180616174946.175109-1-rajatja@google.com>
References: <20180616083740.GA23039@kroah.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v3] sysfs: Fix internal_create_group() for named group updates
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
v3: drop the extra reference taken by kernfs_find_and_get()

 fs/sysfs/group.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 4802ec0e1e3a..38240410f831 100644
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
@@ -135,6 +145,10 @@ static int internal_create_group(struct kobject *kobj, int update,
 			kernfs_remove(kn);
 	}
 	kernfs_put(kn);
+
+	if (grp->name && update)
+		kernfs_put(kn);
+
 	return error;
 }
 
@@ -199,7 +213,8 @@ EXPORT_SYMBOL_GPL(sysfs_create_groups);
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

