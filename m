Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7EFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F352082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZCqx2/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F352082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeJCAEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:04:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53055 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJCAEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:04:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so3070684wmw.2;
        Tue, 02 Oct 2018 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UEX6dGxZs5jBMbrm6UyBsjP37qpkhDhyVt/DYXLWISk=;
        b=fZCqx2/FAm6EYQkl7cU8cOGfog+Gukc7dX3d/5QeeumkFwNo1Ze2Z9bc9E6QJDdi/W
         FmZgJF8J08Eaf6Rnyq6Yk3etCBR4k21kvolzqWWe8OKkdfE0sJDqOE3AGw8hKTmjtDHg
         eP2TQTqvCJ2UMvNABig0MtC99jnK7SMFHzCvTUwewtabJjP+pj9xb0y6Jh413qYQQDLv
         KJc9gBvAbuzNvH1mLbP59PMOkLNBTXQDS3FOPR0WLlNZJr+PiZ1mZNVYGNdHtMVTzj7U
         OuRvQJIX/Po4glVyR5SUqwwlOZvBOPMe7sC2Qo/H5G49KBcp72XtUtEVpu8KcagvEvxg
         nDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UEX6dGxZs5jBMbrm6UyBsjP37qpkhDhyVt/DYXLWISk=;
        b=XbQ+JqnlMdw4t5ZOcF4SyDLEnionizHXa5E08nDCoENP4OqcxzUfoK7UfzaCKdaQEo
         Yz/qnmwJFOYQApu1abB9i/EyxcAO7cR4pNmaCu5lyC25b/KQEmPdE2wBAsWsmPa9fTpK
         pVrNiYvnmgC2W22684vQ7PDk8wdSUd/gbmdRngWf/zntDE8lF6PR/ig7q+1Oq7ITw8AP
         txbr7cuDed2B8/mYCAk0iPQlLtyKKv0XqBH6kDkQuTSzXh5+u6KHpreizKJE+ViUavxb
         +XS39fDGOnYT0wJ1/XSbwciyWPxJLIiVtdyBzwzzHXQZv80Fsu7szT1EADulY1DCUo5E
         PhUg==
X-Gm-Message-State: ABuFfogFJbJWo+pwtdvg29WF9i+p7oZHyk1fdzipohv2ma7S6N3w6JeY
        RnChrYnsbwHWY2MRMrfghzGNlLtyaRSagQ==
X-Google-Smtp-Source: ACcGV63Ydk7gDvWHBH4YM+u/Kxh/MahVvwsva2p8Ws1PBJ8r/bbxdZmwPAieaS923YGqcL/ZNPl4gA==
X-Received: by 2002:a1c:a187:: with SMTP id k129-v6mr2650091wme.111.1538500822422;
        Tue, 02 Oct 2018 10:20:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x186-v6sm28115019wmx.24.2018.10.02.10.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 10:20:21 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH RESEND] drbd: avoid clang warning about pointless switch statement
Date:   Tue,  2 Oct 2018 10:14:48 -0700
Message-Id: <20181002171447.10765-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The drbd code causes warnings that we cannot easily disable when building with clang:

In file included from drivers/block/drbd/drbd_debugfs.c:10:
In file included from drivers/block/drbd/drbd_int.h:48:
In file included from include/linux/drbd_genl_api.h:53:
In file included from include/linux/genl_magic_struct.h:237:
include/linux/drbd_genl.h:300:1: warning: no case matching constant switch condition '0'

There is nothing wrong with the code, and adding 'default:' labels
in the right place is enough to let clang shut up about the warning.

Fixes: ec2c35ac1ea2 ("drbd: prepare the transition from connector to genetlink")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

This was recently resent by Philipp Klocke but the attribution on it
was incorrect (had Arnd's signoff but no From: line) and linux-block
wasn't cc'd, who presumably should take this patch since this file was
introduced by commit ec2c35ac1ea2 ("drbd: prepare the transition from
connector to genetlink"). If that is the case, perhaps these files
should be added to the drbd MAINTAINERS entry since they were introduced
by drbd and have been the only consumers since; I'd be happy to send a
patch if others agree.

It was acked by Lars on https://lore.kernel.org/patchwork/patch/756723/
so I don't know if this patch should carry

Acked-by: Lars Ellenberg <lars.ellenberg@linbit.com>

or not. I'll leave that up to the maintainer to decide.

Thanks!
Nathan

 include/linux/genl_magic_struct.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index 5972e4969197..c11f42179c63 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -191,6 +191,7 @@ static inline void ct_assert_unique_operations(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	default:
 		;
 	}
 }
@@ -209,6 +210,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	default:
 		;
 	}
 }
@@ -219,6 +221,7 @@ static inline void ct_assert_unique_ ## s_name ## _attributes(void)	\
 {									\
 	switch (0) {							\
 		s_fields						\
+		default:						\
 			;						\
 	}								\
 }
-- 
2.19.0

