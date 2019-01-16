Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2B0C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2B720859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrwP4d/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbfAPGDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:03:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41902 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732979AbfAPGDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:03:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so5469342wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 22:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EC9KrM9k3ox1fFJXFIW1CcAAetAf7P/Q5lC3NWU2kYc=;
        b=jrwP4d/Lsl3jXxWbdEDrTfiMvA8pYeE2sb3BG+Mz+WPfhOn6Kg2rryzBXrgfryk2JB
         7t1LIG9uocSlxRZffFHUvKd6jTo1uQ9qd8qhZj+67fODhuoKxFZp+9Dv1A0K8JlkFOFL
         ETns1Qp5zKaRkR6+dkHX3UVq6XPhd44kXfpOkTdnrhG4Wepq++FzVDt8ubu4AjdKLXyG
         PCG/XQYrCyUbVbcHUgTCxZH7tfB019FFpn7aWgRBQiwORaBr5zlJ1PoChyb21h2hJsDS
         RzfHnCZjiUHzZmrP7tD0a3EEBAurP6qd5N4PdnKk8fS7+X0GJUo9mJFaqG13EYxwc01D
         lAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EC9KrM9k3ox1fFJXFIW1CcAAetAf7P/Q5lC3NWU2kYc=;
        b=QLa+gMrnkn+3RIfG8inViRWIK4DNT8ecW3/xyYqCEwW3u6K6KoivZ1Z8MQiCCogGe/
         QbGc0iE5s/Ywq/mxs7N2d+XUUUT2SxBxmFp+Rrjyw1ubClOoFMu3hkHidkdqcvJo4ATd
         CmoFr0ZGjhkHQ6+nzrU1hwABWaGQlwUI7033WY6BKGVu6FKXMUyKeksFCF1G5zQA6SQ1
         cVZyQFWuBQYKQDOU4Hy1yCpHx31nhVz1lE+zItJL8r97iDawQT7IlKD/a9tg4DhkhM4d
         UWmLdqXVUPonPxcXtE1jj8gomW8TsFn5c17iU+KvBjmlNT/1cl7SSjsdzqZj+Lv7LTgO
         dbvw==
X-Gm-Message-State: AJcUukc6twA9Ul1dqypU7dSiTz8YXDnZEEPYPCLsboIiSHxgezzxjeSt
        CiFoU6ZzlRXpqf8NnYsasds=
X-Google-Smtp-Source: ALg8bN5UmJ16dPJp5C+Ps4p8BFi5AAhuoOusm9s1yraUth990kh2+y4pT8fCMLo9Y+rlTlbnM1tqsg==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr5551890wre.94.1547618623946;
        Tue, 15 Jan 2019 22:03:43 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 198sm57076719wmt.36.2019.01.15.22.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 22:03:43 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Fix build error with Clang when inlining is disabled
Date:   Tue, 15 Jan 2019 23:03:02 -0700
Message-Id: <20190116060302.8882-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_NO_AUTO_INLINE was present in linux-next (which added
'-fno-inline-functions' to KBUILD_CFLAGS), an allyesconfig build with
Clang failed at the modpost stage:

ERROR: "is_broadcast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
ERROR: "is_zero_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!
ERROR: "is_multicast_mac_addr" [drivers/staging/rtl8723bs/r8723bs.ko] undefined!

These functions were marked as extern inline, meaning that if inlining
doesn't happen, the function will be undefined, as it is above.

This happens to work with GCC because the '-fno-inline-functions' option
respects the __inline attribute so all instances of these functions are
inlined as expected and the definition doesn't actually matter. However,
with Clang and '-fno-inline-functions', a function has to be marked with
the __always_inline attribute to be considered for inlining, which none
of these functions are. Clang tries to find the symbol definition
elsewhere as it was told and fails, which trickles down to modpost.

To make sure that this code compiles regardless of compiler and make the
intention of the code clearer, use 'static __always_inline' to ensure
that these functions are always inlined. Some alternative solutions
included 'extern __always_inline' or converting these functions to
macros (so the preprocessor deals with them) but I would argue this is
the more "standard" solution.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index bcc8dfa8e672..959e822315b5 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -850,18 +850,18 @@ enum ieee80211_state {
 #define IP_FMT "%pI4"
 #define IP_ARG(x) (x)
 
-extern __inline int is_multicast_mac_addr(const u8 *addr)
+static __always_inline int is_multicast_mac_addr(const u8 *addr)
 {
         return ((addr[0] != 0xff) && (0x01 & addr[0]));
 }
 
-extern __inline int is_broadcast_mac_addr(const u8 *addr)
+static __always_inline int is_broadcast_mac_addr(const u8 *addr)
 {
 	return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&   \
 		(addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff));
 }
 
-extern __inline int is_zero_mac_addr(const u8 *addr)
+static __always_inline int is_zero_mac_addr(const u8 *addr)
 {
 	return ((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) &&   \
 		(addr[3] == 0x00) && (addr[4] == 0x00) && (addr[5] == 0x00));
-- 
2.20.1

