Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794FEC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF3120685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jndkFCTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF3120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeJAD0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 23:26:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40754 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbeJAD0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 23:26:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8-v6so11600203wrh.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ba8h3yekmv44OBdFm4Un1Ykq66eXWxZMyUjDTuozp0M=;
        b=jndkFCTBjZaeyQz+9De9Qt0fphLsutSn98cvldSRALSS8bKbfwk7CTJ0iyr48dW4eE
         83KcQB5rYTBWLe46JtkINwgKctxzMIY4sHVMoMBOX1QxX2KEqxmpBez3cKcdZ7L7rELP
         6Rtobw98v1G7AOcuwvrXgv7iyyscMoMtyBPhf79+HSePe1OwbhDHLBRB2p9UJVO50NTB
         VDAZW5CfbkAIiJFqnlsqvUY/zxvPD+R6V+XMIZ+QomLIbiXi0gLeeQiB/cM5ImylviVh
         xucBx9AUHzRoLnZvZ7D3XIuoiHfr4YIrV/zzrn7G4og8GTHLT1Ic4dvFtWx/ra9+Fvu9
         hgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ba8h3yekmv44OBdFm4Un1Ykq66eXWxZMyUjDTuozp0M=;
        b=WdjzQBui6USg1CyrMORWwBZ9gk1fA9HZ0maQ8W/C5PFjiHGd5hYNc1czNQjdsoz3SA
         oa7j9wN23+On+fe8uWhZcLUJZqGKvEK5XXFyDp47VRBTNWqWdVccLtUBVwQNboqngqTN
         RElD/WpBWWNglc6qknRVPw1akxEljk57jM3MY5Kd0AfKKgLf6IO0iG08VUULx6z1sPUK
         v6QBFnfBjx5GmTiK059lV97bwUj3mzrkX0CFTPZAXy+2dec2FthHDYBxcOQI/vI+lGT9
         B9wjkDfbB9fiAqMR94b1SX9UbUw+mprY9qECHEIzDF8sb5Orxw77vzfXuhN85WQdxsa6
         X8Vw==
X-Gm-Message-State: ABuFfoiSv2G4B4ZIYN8+W3nLl3B/7Cdw7JTwFa9douw4iqpEcGLK2ZEG
        ZFUeayeU7VEdBpFwqjfCQRH024nn
X-Google-Smtp-Source: ACcGV639Zeea+m5KFfF0+LWARI2hs/EsoiFJmC5Bw38J+J1npe5C1eZ1SyOrGJeGF7vbXUl3qn5cXQ==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr5163770wrj.3.1538340701987;
        Sun, 30 Sep 2018 13:51:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l125-v6sm9586478wmb.1.2018.09.30.13.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 13:51:41 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Boaz Harrosh <ooo@electrozaur.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] fs/exofs: Remove ignored __weak attribute
Date:   Sun, 30 Sep 2018 13:51:26 -0700
Message-Id: <20180930205126.25840-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
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
---
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
2.19.0

