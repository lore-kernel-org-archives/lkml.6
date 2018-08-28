Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A34C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AF92087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Cz+lMmN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AF92087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeH1Upg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:45:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40088 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeH1Upg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:45:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id z25-v6so1010748pgu.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zsI0N8d6XaWcnXSwZgdyQFKz077wgOGNcZfnHjOocFo=;
        b=Cz+lMmN5+eKH1GSeb09b3pMbkrs6ZLLaRNHabGUH5pCVlX6zgKeeuKnhaKon5no7v9
         dzMhf/BVkdSTCl5BrjTQq/7tM5C+R4jljy8LzrtI1o8GAoXpH1E+lOPzy8P05th7UIyt
         6V1Nme/0Imipu5QQrakQ6bui1paW9OL9FRj2g3ZB+LOnA/hGv8QSgL7AL75tTSPxpF3l
         gYIbJse5EOtGyE1vDWVMlV4OKYJ+yurX4//qqtQaVbvJXPBcvMvK6lNmmHi7eOyCsoqX
         cWHw+6A7BVznSrbS7nUadbk+evidJwT3Z2ZEqT1NbReahqJ3i3Mb9CEdYbe/zS2TVruX
         89sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zsI0N8d6XaWcnXSwZgdyQFKz077wgOGNcZfnHjOocFo=;
        b=KNltxEC1bWfg4vgWKvWGFWxrDhLNIyg/xPlI51o5Eyjg8JXk7iIlWY6sRRq7aRAzOY
         KTDUcRk+qSm00WQf3xUtCw6U572lKX94rjt9nPtJY6aikKc4LcrUGYPz7AgsodR6bteG
         jZeUZ6baLTQB0O1dV5MSuzFAAeLwoDlTsRD5LfR9vyLGppBGRc5GJy/aRfsj12ARkEP+
         aO4teuFvdu9IXD1HW5Gv29bd4g3jrjwYSiyUrZN8y6HNViWnhVo80Y2E+9sD5w3MrK2J
         iewNPUYfPC43GRRjYDD8IqZAL9XUsiTBNkFDlIaZ0cb+4KBFKc5Ia0BY7M+3+gf1znwm
         dIHg==
X-Gm-Message-State: APzg51D4hmOb+MGsPMLHrhjOv35yMi2OFHEaf9JhsKsgcpXIeSQEg4s3
        +RCyNtd8V5dKckOBzVpdSbA/a0w7SOur4A==
X-Google-Smtp-Source: ANB0VdYTHBAj5vFtuWmlay1kLdPCOTNaysF3HKLagNID+T9SIIbd+BD09YOupQj33xH69L2Jq6kMuA==
X-Received: by 2002:a62:a6cc:: with SMTP id r73-v6mr2407698pfl.60.1535475184441;
        Tue, 28 Aug 2018 09:53:04 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id u11-v6sm3265658pgj.71.2018.08.28.09.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 09:53:04 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v5 1/3] overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
Date:   Tue, 28 Aug 2018 09:52:56 -0700
Message-Id: <20180828165259.211474-1-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assumption never checked, should fail if the mounter creds are not
sufficient.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

v5:
- dependency of "overlayfs: override_creds=off option bypass creator_cred"
---
 fs/overlayfs/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index c993dd8db739..84982b6525fb 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -193,6 +193,11 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
 	if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
 		return NULL;
 
+	if (!capable(CAP_DAC_READ_SEARCH)) {
+		origin = ERR_PTR(-EPERM);
+		goto out;
+	}
+
 	bytes = (fh->len - offsetof(struct ovl_fh, fid));
 	real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
 				  bytes >> 2, (int)fh->type,
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

