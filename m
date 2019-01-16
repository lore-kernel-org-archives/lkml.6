Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EBAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD00120651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A35gzNlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393136AbfAPNVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:21:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43003 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731240AbfAPNVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:21:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so6873254wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I0lt4mD5OcyX81VtmmWYheQDT1zYhYmVMzzfir3nPYo=;
        b=A35gzNlkh4vZV/Q/Vkz+BYe5R0+7b5+ZJvO//CNVXz9nbpzScxPfL2qLiNREv2GeQF
         hNDA8VoWqtsTjYIq4rJHff+XsizLYGs9TBMUnrwln6rStqaPeonMFyYoCITd8tMtdMZB
         4jaE2ZZngs85r7i9uBs+AGIBU70vRunogDPuoKFDYeYenli6jktguhNMZQNBUoXXFwzv
         b22zwE3xEiXrwLF7LZIEc3Vpy3TEgFlwvB+Q4rmCagRIU8VyNfQ6me2X5UdUZsHbhv32
         FLc/11kVQqyrAHdQVYEKMXHCnueMKAw/XTNYAcwOhLS7WksVwjlcjplfrGEkPVYaJiT9
         W2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I0lt4mD5OcyX81VtmmWYheQDT1zYhYmVMzzfir3nPYo=;
        b=Jw3BLlygZpwp2sKP9Rh8cNOKqbKC+vbW60wyibJSP9FNkFvVG+/5PkltaUBYxq/vqP
         RRKKb/U4e7GdXcBUAsKjIvoB9OlaAN3GdOmRJo5upRoeqcmyUKn7SlOIo5cWVH50iLAe
         +IutIJn2CIrkhWzmtxZkEB6WGVENou+bmJeYFTTIV297K9C6B0nkVHa8WtCAV5Ky7G6N
         eV6rG/5GgRTNFfpQLyZE//gMl1D7qq3Cq9h0X9XLLIhX6MzR3lL/86TSNhhjCFOZ3Iyb
         zTe/EY8Igf239udpXRmGw3U97d4rO6xz2gHp6aMEiwnCHoL/Ty3AI8tDN57snt81L62Q
         UtsA==
X-Gm-Message-State: AJcUukcEfHJDEPOvlbB70LTAUQzhtUbOvXaW663LwYxFMmSEANhe1NMY
        QnhoDpX7kEJsgJWNHmee7o+hi9PrpEc=
X-Google-Smtp-Source: ALg8bN6Xj3KnQ6z4LdGXXcL5xhPTG0MDUVUs4WVZDM4uBeX1d85/iBD3MI4G6INcXfy5MDe3HHDwXQ==
X-Received: by 2002:adf:9c01:: with SMTP id f1mr7887144wrc.286.1547644871792;
        Wed, 16 Jan 2019 05:21:11 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l19sm35883721wme.21.2019.01.16.05.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:21:11 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: Fix build error with Clang when inlining is disabled
Date:   Wed, 16 Jan 2019 06:20:11 -0700
Message-Id: <20190116132010.31395-1-natechancellor@gmail.com>
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
intention of the code clearer, use 'static' to ensure these functions
are always defined, regardless of inlining. Additionally, silence a
checkpatch warning by switching from '__inline' to 'inline'.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Don't add __always_inline.

 drivers/staging/rtl8723bs/include/ieee80211.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index bcc8dfa8e672..9efb4dcb9d3a 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -850,18 +850,18 @@ enum ieee80211_state {
 #define IP_FMT "%pI4"
 #define IP_ARG(x) (x)
 
-extern __inline int is_multicast_mac_addr(const u8 *addr)
+static inline int is_multicast_mac_addr(const u8 *addr)
 {
         return ((addr[0] != 0xff) && (0x01 & addr[0]));
 }
 
-extern __inline int is_broadcast_mac_addr(const u8 *addr)
+static inline int is_broadcast_mac_addr(const u8 *addr)
 {
 	return ((addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&   \
 		(addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff));
 }
 
-extern __inline int is_zero_mac_addr(const u8 *addr)
+static inline int is_zero_mac_addr(const u8 *addr)
 {
 	return ((addr[0] == 0x00) && (addr[1] == 0x00) && (addr[2] == 0x00) &&   \
 		(addr[3] == 0x00) && (addr[4] == 0x00) && (addr[5] == 0x00));
-- 
2.20.1

