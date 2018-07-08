Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E1DC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631C120896
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAUrVSow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631C120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933589AbeGHVHY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:07:24 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35972 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933368AbeGHVFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:43 -0400
Received: by mail-pg1-f181.google.com with SMTP id m19-v6so845643pgv.3;
        Sun, 08 Jul 2018 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQT+lxbnzZ/5JAfVa5mau1dvb6l8qMsV5xYDJNwj17U=;
        b=YAUrVSowZSn3psE8Nqd1Nzss26L+xRYVcO773Py4LV5eKHBFM/cUzJyu7ujSxxoRoi
         YDJNXVyLey+HZBez9TAml2pLpdFV1AeC9NVM+3GeM8wypbdw8RyEu1QAdnCiIgvLxwnG
         eqpSzky41Y54PWhl074kiwxdiU10Z/WLHUVij3ZN0DEJCwE4mkoZaIQ3FiZ1rIQ2dAn1
         X6JbCd0BacI2Qzi9byzFDGSn9h7msIR0VLoeJEnM7u/juAxKuUsX11Z0tvo4UTHTL44U
         mLlR48azxlHge/gzp8DgRZY7b6PveZY5OYb6NJxIE5edzhal4Yp5VSZ2GaFW4v/Mb589
         4XEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DQT+lxbnzZ/5JAfVa5mau1dvb6l8qMsV5xYDJNwj17U=;
        b=O/JLhiSEzYkLu7l5WtYsSkr56rwLCUud3Hq3k6GbSauZx91QZ/slEBnhAzB9nHWTro
         R0QvcvblkK7zfE5OTddx/X+DaHL5OJ3UhIMVbxEk470DXQAwQBnw6icMQsYE+14hcHSL
         holfw3IXBLLgLdhDGk12s6rp87FNQ71lLKfen7dlb+vfNJKqO8sUX1+oDO6aZW/Nd1ZB
         JR2EOga30Ec8byDrWLH9CFYzY8S1JVLQnDPzn9ZByg3TXQsjpxYTGQTtvMwAp66zieG4
         VyRPNZ2oBhqgvB6wFfS8WkAtGPwofJ9YR2s8oCIdXZqycK8i662SvCRlv4mXu5ZTHyMv
         UgAQ==
X-Gm-Message-State: APt69E3BtnQCJqOb+vYFzi36xYH1z5SRT2w2/yWChY78vXZ6bykfWREg
        VNudguVAWVmVBNFojhA3zYw=
X-Google-Smtp-Source: AAOMgpcAedktP1Gi8pQNsiG4iY5dh7wuqPWLROEdjZzm3GZRIAlN/ruLa5H9IphwE4WOgH/b/9mQCA==
X-Received: by 2002:a62:42d7:: with SMTP id h84-v6mr18648787pfd.146.1531083942842;
        Sun, 08 Jul 2018 14:05:42 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:42 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 12/18] fspick: add missing permission check
Date:   Sun,  8 Jul 2018 14:01:48 -0700
Message-Id: <20180708210154.10423-13-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fixes: 99f8421020ac ("vfs: Implement fspick() to select a superblock for reconfiguration")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fsopen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 3e439299ddf79..b3a22848f8eec 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -282,6 +282,9 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 	unsigned int lookup_flags;
 	int ret;
 
+	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
 	if ((flags & ~(FSPICK_CLOEXEC |
 		       FSPICK_SYMLINK_NOFOLLOW |
 		       FSPICK_NO_AUTOMOUNT |
-- 
2.18.0

