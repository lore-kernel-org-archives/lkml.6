Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE61C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC1520693
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3a63zlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC1520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeGHVFg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:05:36 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:41263 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeGHVFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:34 -0400
Received: by mail-pf0-f173.google.com with SMTP id c21-v6so7529563pfn.8;
        Sun, 08 Jul 2018 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m+LdV/pmeJyJm9tTxstEoWVA+vZwxwkjj/3avd2tO4Q=;
        b=F3a63zlkqDYlhuVy6amEpPi+cvKITbR+tlZ6twx1Q8ZUKdI0zjuCqDENBK2ylvboZd
         Rda5LfUUHsOn7HxNqEmDIG2D4SU6Rk57l66cOADyyD4hHVgmcRACwf1PG4oHP9DtwnLF
         hn5ki2zn/SA4G6bgPo0togLFOJHN0Y2aJTRnTckYICDltlfPzFe+2Qr81rIRo1MNsFMj
         ZPFNALhs1c3s7VyoGE9h1g/iXp/tABOONrA8fdOjWWeSZokjG6VavFLniE/S9Ob/oHXR
         w1K8C0sLdk+ZySluRJMYMeL/Ra/ZKlegWPUKGDhmrmeN02N+391sRaviSg6NrIkjTtDx
         hA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m+LdV/pmeJyJm9tTxstEoWVA+vZwxwkjj/3avd2tO4Q=;
        b=kOgUStlf6nmPPiBoGooE0cqMi3+8Ropkd+d11jSqRnx8fwagsBq1N0qi5Z5TajW9it
         ffjHLj3/hzDfNnijn4xXUvrpAe4ezOalknUdDwKP116ZP4omxMSRboLFzHdpw77vsCJY
         0put06u07ljqOHyHikj+oh+g4vZHDJh2lDRNk5l7aS2rSB8PlzGl2iDFIS59fCtlwVoT
         LVXoonyygvhdvxb09r6SIkrwJrRqpz5X/rQGD6ZlC+zaNt74buqkfuaijTTOzjYDNXUU
         fUIDqBl+8mgjDt2V0NxUe8rIMOEzdnMpX30VWWgRdp8kEl2y526aq1mF3OOPNLAu1qWe
         CgfA==
X-Gm-Message-State: APt69E1TvKkqeLdJPFusrX1uzrtbavLhCC6l0qQMjfRZ5BEApJ2JoCml
        ZUY4fLfTCoQPxSmi0nvpeNwxMbFK
X-Google-Smtp-Source: AAOMgpfP5p6eeAxypFijvDt3yjD4+5UD1GQJWLfEX2lZM6u9rF64Eo+HeBbuTbBq6v89Yj6t1TxVZA==
X-Received: by 2002:a63:a502:: with SMTP id n2-v6mr16767816pgf.263.1531083933781;
        Sun, 08 Jul 2018 14:05:33 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:33 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 01/18] sysfs: check return value of kernfs_get_tree()
Date:   Sun,  8 Jul 2018 14:01:37 -0700
Message-Id: <20180708210154.10423-2-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Reported-by: syzbot+0977fcb74b8a12a967b8@syzkaller.appspotmail.com
Fixes: a5195193b1e5 ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/sysfs/mount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index 0a016dd49300a..1e1c0ccc6a367 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -27,6 +27,9 @@ static int sysfs_get_tree(struct fs_context *fc)
 	int ret;
 
 	ret = kernfs_get_tree(fc);
+	if (ret)
+		return ret;
+
 	if (kfc->new_sb_created)
 		fc->root->d_sb->s_iflags |= SB_I_USERNS_VISIBLE;
 	return 0;
-- 
2.18.0

