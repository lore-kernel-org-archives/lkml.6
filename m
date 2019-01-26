Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063D3C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B68218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 06:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNSGrDiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfAZGnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 01:43:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33884 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfAZGnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 01:43:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so9086194ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 22:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJOuk5AcncxBstCPxEfAKjtxD7x1iPhn0o9sXQTIdUE=;
        b=TNSGrDiNoNKe+SufdNtX9Mwho3IMWfmSuv/8mTMqOINVz2xifkH2oqrAjRRsMgYP72
         OzG9XfySWHj8GPvUlPqhrx80dRaaIdc3Biil9LLnGgqip2opmdSCZB5nqrxEKF5XEL8n
         BNTAF08+OjsPZQodrFifDVkudYytbzuDzmmwOJ9c0Ysglr+mW+Uz4hrBjKuxFqUgLULK
         Hbiy0JfX+K4mcSYIsG08WmTBKb1GpxmvtGkNrspxTusr2kVSzHSauxYtUl3t23qzE5AX
         rhHvyT1h0C135kkpPmKyakrsclFioedu7x0Dvmf1DhmlXgjRt7xE+/Nd/ZixK9E8sRsA
         /4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJOuk5AcncxBstCPxEfAKjtxD7x1iPhn0o9sXQTIdUE=;
        b=mhBIF+U5C100uydLmyU2f89ksjIlQkxKpLp2OWuh7n60QiCaRUwD5fHyb6asKttYU4
         2sKe8uSOVRMZ4hAlCsmml5Ag3bdIMtJZxWg9FQafBpAv/H/2d1N2LzGzoQuESbwGI6L2
         e0giE+UOGt0BjTMgIopLAMVvqXtlVEtV5PsVZZJ5CicihqiuZ3j4z11v/IN16Qeui4ea
         elZZxfBcXD0C1dMmZ4qyYz+UtbtA0nd0XbObpzMnm2C5DivgGhaw/yVi1kqFIZXgZtev
         Vgphrxpj231Ut2dZ15AeTwbiM3wWt7trhb0vYw7U8EqzdhVmTg9GtCtfkkUoPp7pCxMn
         H6cg==
X-Gm-Message-State: AJcUukfgfgvtdpn+0ehmUk+8TAgX5P41ytxXihEZynYzEMZ0Mg77+cQS
        zatNh6Ekr0sOM5Glzi7qZqXiobFDRG4=
X-Google-Smtp-Source: ALg8bN63k30EEnh/BKa+JUB04Rat3mU1Ebfxi+YOi2gd3yUixEoqonDvc1z63/TBiyxW6yC3bHsgfQ==
X-Received: by 2002:a17:906:d191:: with SMTP id c17-v6mr12032689ejz.27.1548485026906;
        Fri, 25 Jan 2019 22:43:46 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id c26sm1075680edb.15.2019.01.25.22.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 22:43:46 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Boaz Harrosh <ooo@electrozaur.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH RESEND] fs/exofs: Remove ignored __weak attribute
Date:   Fri, 25 Jan 2019 23:42:02 -0700
Message-Id: <20190126064201.24625-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20180930205126.25840-1-natechancellor@gmail.com>
References: <20180930205126.25840-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the __weak attribute is going to be ignored on
g_attr_inode_data because it's not in the correct location (needs to be
after the type).

In file included from fs/exofs/dir.c:35:
In file included from fs/exofs/exofs.h:41:
fs/exofs/common.h:186:21: warning: 'weak' attribute only applies to
variables, functions, and classes [-Wignored-attributes]
static const struct __weak osd_attr g_attr_inode_data = ATTR_DEF(
                    ^

Turns out that GCC ignores the attribute too albeit silently because
moving the attribute after either osd_attr or g_attr_inode_data like
all other uses of __weak on variables in the kernel causes a build
error on both GCC and Clang because static variables cannot be weak
since weak definitions rely on not having internal linkage:

In file included from fs/exofs/namei.c:34:
In file included from fs/exofs/exofs.h:41:
fs/exofs/common.h:186:30: error: weak declaration cannot have internal
linkage
static const struct osd_attr __weak g_attr_inode_data = ATTR_DEF(
                             ^

Just remove the attribute because it hasn't been correct since the
initial addition of this file in commit b14f8ab28449 ("exofs: Kbuild,
Headers and osd utils").

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Boaz Harrosh <ooo@electrozaur.com>
---

Andrew, could you please pick this up? This warning is rather noisy when
doing allyesconfig builds.

 fs/exofs/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exofs/common.h b/fs/exofs/common.h
index 7d88ef566213..45da96a1528d 100644
--- a/fs/exofs/common.h
+++ b/fs/exofs/common.h
@@ -183,7 +183,7 @@ struct exofs_fcb {
 #define EXOFS_INO_ATTR_SIZE	sizeof(struct exofs_fcb)
 
 /* This is the Attribute the fcb is stored in */
-static const struct __weak osd_attr g_attr_inode_data = ATTR_DEF(
+static const struct osd_attr g_attr_inode_data = ATTR_DEF(
 	EXOFS_APAGE_FS_DATA,
 	EXOFS_ATTR_INODE_DATA,
 	EXOFS_INO_ATTR_SIZE);
-- 
2.20.1

