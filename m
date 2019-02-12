Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E812C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFF320821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FA5bIk4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfBLJsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:48:45 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43146 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfBLJso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:48:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id o1-v6so1620234ljc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5KwDzsMcCN5bKZ9gR266BQz8en1Dx9EG+wXdzylMa4=;
        b=FA5bIk4fzFWuchkxIOg4AeLhpmVs7OBfaWMW2sPfi7DpCClDGF4ofrz7loRZ3j/VzS
         Tk2pvtGZn/YZ24/gEOSv82HwpW3gVttqa4fWfyiUXThhgJeSEnhdeImfksKpNk+azSv8
         a6Hxp2udYjXG4wWKrRiGD+Gw4xn5maRsN4/iKJ84T5DFgKb3RFmjWQ3VL+vmktGqGSdy
         UHZfdztxZ8/AMeqRAMoU8k2PQ7v3IlHC4bpCMlzLhSGJ4iybKO1FQZrCrLdE45JXlsDw
         TZ17rO2CawWEB/nAni0zWIEfYAgVS5c1f01QTIwo+fzv7V7XQEKP/HwGRu9C8U78YyHb
         km8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5KwDzsMcCN5bKZ9gR266BQz8en1Dx9EG+wXdzylMa4=;
        b=K0jjjMx8BJ9G/bDxVgr4Rv8yfWuEMtmsAqqNnyVAwSc312MlkJQrzQP7M8XU29BWo+
         QadlC+Z+zRAqaoQGdvpMMYSbj/MvXOyPwFm5X118Uw2uVoEEap5XGsKxelQcIQFpce43
         4jMV/nCHAytx8ZqaAQwPmhnh8lAgTAZl0unbPz0wNm6RMpQ/lhjgGyrVoEe61jKTdwUA
         CMTLLeAz72s3H5fWGqMQSZlfoPfwfbkkBCUYuqqmH9VPxa9WpXHuCHg5DnnWq4Ut3fbd
         9UPzvWL8aZRJbqrGO2aKKPTsq2p65XjWm1MGkRsTp6Gv7r0DPtH7lhvlB4APSMkKU4vq
         iqfg==
X-Gm-Message-State: AHQUAuZxbm+nbo3bPjGUkpBg+Ka+A8o0b/2RStVE/nZaXLTENM+28Le+
        9BT0l5MVpXqlLBk+MTZXetKvVw==
X-Google-Smtp-Source: AHgI3IZlMjfrl7jC2HgNxF9NxbADu+hygxoXPr5sUgRayaHgbR2b6ulEhjT50xjm3CQtCzPea4mO3Q==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr1733377ljd.137.1549964922602;
        Tue, 12 Feb 2019 01:48:42 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id n19sm2840660lfe.64.2019.02.12.01.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:48:42 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] apparmor: fix build error undefined reference to zlib_*
Date:   Tue, 12 Feb 2019 10:48:28 +0100
Message-Id: <20190212094828.8429-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 876dd866c084 ("apparmor: Initial implementation of raw
policy blob compression") and SECURITY_APPARMOR is set to '=y'
ZLIB_DEFLATE must be enabled as well for the linker to see the symbols.

aarch64-linux-gnu-ld: security/apparmor/policy_unpack.o: in function `deflate_compress':
../security/apparmor/policy_unpack.c:1030: undefined reference to `zlib_deflate_workspacesize'
aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1030:(.text+0xe20): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflate_workspacesize'
aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1036: undefined reference to `zlib_deflateInit2'
aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1036:(.text+0xe60): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflateInit2'
aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1053: undefined reference to `zlib_deflate'
aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1053:(.text+0xec0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflate'
aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081: undefined reference to `zlib_deflateEnd'
aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081:(.text+0xf90): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflateEnd'
aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081: undefined reference to `zlib_deflateEnd'
aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081:(.text+0xfb4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflateEnd'
aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081: undefined reference to `zlib_deflateEnd'
aarch64-linux-gnu-ld: ../security/apparmor/policy_unpack.c:1081:(.text+0xfd8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zlib_deflateEnd'
make[1]: *** [Makefile:1023: vmlinux] Error 1
make[1]: Target 'Image' not remade because of errors.
make: *** [Makefile:152: sub-make] Error 2
make: Target 'Image' not remade because of errors.

Rework so when SECURITY_APPARMOR is set to '=y' ZLIB_INFLATE and ZLIB_DEFLATE gets
selected, since both are used by the SECURITY_APPARMOR.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 security/apparmor/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 3de21f46c82a..99c35e22c119 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -5,6 +5,8 @@ config SECURITY_APPARMOR
 	select SECURITY_PATH
 	select SECURITYFS
 	select SECURITY_NETWORK
+	select ZLIB_INFLATE
+	select ZLIB_DEFLATE
 	default n
 	help
 	  This enables the AppArmor security module.
-- 
2.20.1

