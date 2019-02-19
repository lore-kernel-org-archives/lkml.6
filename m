Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C1821848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPZMlI7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbfBSJPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:15:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32950 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfBSJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:15:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id a2so16112986edi.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 01:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s86H8nSKdvNUHevsmacqDA5OoO35I0uPUOpiO/YyEPI=;
        b=NPZMlI7oHNEvS04/Ii6XRlIIkw8gvkE9q1s6Z7wZ74a3x56NH5TNkKuFM7k/FiXSQ1
         h1tjrqMx1ZfqnFqIuFW1XH2PrYmeVOxD4ODvjP2YAQYkooKscoA+tl2gk8lQBAjrr7jX
         MbNDBqV4EyPv+yvWse0ZPCG5lk49bPqlWV+Zc10dxOqDYmOkNXecbCRDTIHLfXaXY3JG
         qTcIENnRQFG29LfVKcuI9kjnwHnfdFzpQ/JGTYPcnqi2qcUwWwwacZ/5dHPYESRWpUJP
         XF+8/OvmJpmM4WkEii1E5PjVO3hFvnacZC7nFw4RU8F2uMhLR6GpGCh4WT6FcYY68Og1
         ZMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s86H8nSKdvNUHevsmacqDA5OoO35I0uPUOpiO/YyEPI=;
        b=JbGRJdvxhZtCheq4zvkfogclfvGVGRQtSYh0OLDP2TSMKTQ2XW7va84o3gTBTcjbh2
         VpwjZzIqWI+2MRylHs+5JIQv+m3fHeHaywtv+E5EnKMCRtBX6sHX32eZrIroSP97vPFk
         yMGs4hIUO2+JaQElGucz8lH5NdJQXEgVug9efm0Rye53m1InvraageJQ1qKGclm8iYZg
         vWoDUUaBCAvum+VPjLzqv6lTovqafWzFvCTL69+hXl2w+PoEM5V/Nu9roxPoXQotmO7U
         yDCE53NZhwdQlaufGAO6Jh10vHUlHe2gxlX67V9KQIfkb8ovAIi7vzLUxT/ACrAUQHH9
         /w0w==
X-Gm-Message-State: AHQUAua8m1NYhJiD3fORr0DjW/334bj6TacHrkAg+CQzeVxBXfvnDQaz
        Z1LMkSq4AKMgKvGUvz6f2Sc=
X-Google-Smtp-Source: AHgI3IbGdwTUwmqeFXz9qhYyrmoTSThfkgSpXJu6CEoPUIn6zeU/avEpCq87b/hQqOWwQNxFClw5NA==
X-Received: by 2002:a50:c408:: with SMTP id v8mr22375954edf.144.1550567732425;
        Tue, 19 Feb 2019 01:15:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id a9sm4321117edl.63.2019.02.19.01.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 01:15:31 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] tee: optee: Initialize some structs using memset instead of braces
Date:   Tue, 19 Feb 2019 02:15:20 -0700
Message-Id: <20190219091520.28990-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/tee/optee/device.c:39:31: warning: suggest braces around
initialization of subobject [-Wmissing-braces]
        struct tee_param param[4] = {0};
                                     ^
                                     {}
drivers/tee/optee/device.c:92:48: warning: suggest braces around
initialization of subobject [-Wmissing-braces]
        struct tee_ioctl_open_session_arg sess_arg = {0};
                                                      ^
                                                      {}
2 warnings generated.

One way to fix these warnings is to add additional braces like Clang
suggests; however, there has been a bit of push back from some
maintainers, who just prefer memset as it is unambiguous, doesn't
depend on a particular compiler version, and properly initializes all
subobjects [1][2]. Do that here so there are no more warnings.

[1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
[2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/

Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
Link: https://github.com/ClangBuiltLinux/linux/issues/370
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/tee/optee/device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 5e4938bbef2b..167839b371f2 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -35,8 +35,11 @@ static int get_devices(struct tee_context *ctx, u32 session,
 		       struct tee_shm *device_shm, u32 *shm_size)
 {
 	u32 ret = 0;
-	struct tee_ioctl_invoke_arg inv_arg = {0};
-	struct tee_param param[4] = {0};
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[4];
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
 
 	/* Invoke PTA_CMD_GET_DEVICES function */
 	inv_arg.func = PTA_CMD_GET_DEVICES;
@@ -89,13 +92,15 @@ int optee_enumerate_devices(void)
 	const uuid_t pta_uuid =
 		UUID_INIT(0x7011a688, 0xddde, 0x4053,
 			  0xa5, 0xa9, 0x7b, 0x3c, 0x4d, 0xdf, 0x13, 0xb8);
-	struct tee_ioctl_open_session_arg sess_arg = {0};
+	struct tee_ioctl_open_session_arg sess_arg;
 	struct tee_shm *device_shm = NULL;
 	const uuid_t *device_uuid = NULL;
 	struct tee_context *ctx = NULL;
 	u32 shm_size = 0, idx, num_devices = 0;
 	int rc;
 
+	memset(&sess_arg, 0, sizeof(sess_arg));
+
 	/* Open context with OP-TEE driver */
 	ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
 	if (IS_ERR(ctx))
-- 
2.21.0.rc1

