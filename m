Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72268C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C35207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C35207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeJWTjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:39:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36866 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeJWTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:39:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id c15-v6so1228737eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YQlIoQEvZV2c0KzstEoIq+zMWcSi8VGplQrKjXZ4Yr0=;
        b=MCHEow8hN+hLdQUg0Fbl0gdtjDGO96NcVlXM7ZIv/CEtG+mnOGbi+NrxEDUFrc0zkQ
         fVdErUnTP4Q/aD+MdlFVQNf43itLQDTPbbWnBXBMosFfyS/qf+bFVpkbiRCl5IMDYAkY
         Jgj+pMJ+9JaSmcY5nCJ280E4Yw5N9PwjBJo8Ih3IBWy2ZfpSHriKQN9xE0gywaWuLdJc
         2dPEvbydEsMqza75Kurdik7bnGoX4Fi2p0oYMkLVhytA2bY9ttXN3QyLJvK736jWohYW
         WTktIT8Fbmio8V3Dqb1+4X+EP3UbPvq7XU4zYBR4z7Lt/7skJMfwLx0fGSGBlZbzzpuG
         iQMQ==
X-Gm-Message-State: ABuFfogmr12sx5Ig00eXQukUP66mWIk1SG6qKKVplrMK+w12zEy9pAzq
        gqZRi3jR3PqDMVgB86E9K1s=
X-Google-Smtp-Source: ACcGV63ygUP1HqyhINhvWF7+CDcSAX2sOF/IJxiNhWUZ/79MQSZ80r4qe6umNrqkS3dZqRcxlPuyFw==
X-Received: by 2002:a17:906:4591:: with SMTP id t17-v6mr724921ejq.84.1540293402524;
        Tue, 23 Oct 2018 04:16:42 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id t15-v6sm305298ejf.27.2018.10.23.04.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:16:41 -0700 (PDT)
From:   efremov@linux.com
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Denis Efremov <efremov@linux.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] security: fix documentation for the path_chmod hook
Date:   Tue, 23 Oct 2018 14:16:33 +0300
Message-Id: <20181023111633.490-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

The path_chmod hook was changed in the commit
"switch security_path_chmod() to struct path *" (cdcf116d44e7).
The argument @mnt was removed from the hook, @dentry was changed
to @path. This patch updates the documentation accordingly.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 include/linux/lsm_hooks.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a598e601ccb3..596351f7c3d1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -304,8 +304,7 @@
  *	Return 0 if permission is granted.
  * @path_chmod:
  *	Check for permission to change DAC's permission of a file or directory.
- *	@dentry contains the dentry structure.
- *	@mnt contains the vfsmnt structure.
+ *	@path contains the path structure.
  *	@mode contains DAC's mode.
  *	Return 0 if permission is granted.
  * @path_chown:
-- 
2.17.2

