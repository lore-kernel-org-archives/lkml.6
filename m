Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFBFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E5A218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ToEybDjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeLSOAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:00:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42135 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbeLSOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:00:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so17468684lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 06:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VkwhrtHK+/Xs38/nSuArtykjmfNSxZJzJE7YwYf1RrI=;
        b=ToEybDjl/6/bBB/EqKzkhQYAN1sOmFdiGH2+2CJQwaLxw4pBrgR+P2nyg5Jrr9hyN+
         sdxbqf7ZYyihec/UPQ78SStVQ4bYKV1hiGqX8WnqjDfjtiKDXmqa4zsJ53QF27Xj3IFv
         7Qc/8+iejQ60QRP32EK8UqxvrwQYYPnQrGkIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VkwhrtHK+/Xs38/nSuArtykjmfNSxZJzJE7YwYf1RrI=;
        b=iREKf4C2Yl6lA2zPgIOd/uLvCHvdoOwhQfxhTigv56J946OPiYzu5zdLVmFYoy2iK3
         9IGUio+r0ktJgr0q6VvVbrTL/jUT17iwRsfhD/Hhfka1I6wzHMuJhIWRoIdw2fU7Uo8G
         nmyicnhT2Sf0aUodJVIsYrECkxo90Bz7mz4crakZjlQxuO3shvcccqQRKMH5HwnFmd4k
         MSBGo+Yp9hay4V92dthSoYVP/6CjEbxB1wyypzbq95T6pWTxXqAa8WixC/dePvluNYsD
         xn7kuSk08sUN5+NIHQWcJIcqV1Cg7VpYtb88TA4uesjr7CmA+jTA9JMBTbJMGzJSrk5h
         Ryjg==
X-Gm-Message-State: AA+aEWaZDOmz6hN06m9x/tQSdgt6/mALQNW1RpDAntzr0LYhfFOaugai
        FRx3lb6Kes1xf4JaxhfVxG3yHw==
X-Google-Smtp-Source: AFSGD/XBY7o/8NTmTNqwHepi7caKf+MlEZUmbBjr8oHvWq3S4g84bKDDBPJiYBjbWKBsA/HD5tiHvQ==
X-Received: by 2002:a2e:c41:: with SMTP id o1-v6mr12830581ljd.152.1545228045755;
        Wed, 19 Dec 2018 06:00:45 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id t9-v6sm3573224ljj.87.2018.12.19.06.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 06:00:44 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] samples: Kconfig: readd BROKEN to SAMPLE_STATX
Date:   Wed, 19 Dec 2018 15:00:40 +0100
Message-Id: <20181219140040.8637-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c1cae12e6b4a ("vfs: Add a sample program for the new mount API")
introduced a build error (regression) when building an allmodconfig
kernel. Before that SAMPLE_STATX had a "depends on BROKEN", and it got
removed in the patch.

When building an allmodconfig kernel, option SAMPLE_VFS gets enabled
and produce the following build error:

In file included from /usr/include/x86_64-linux-gnu/sys/stat.h:446,
                 from ../samples/vfs/test-statx.c:28:
/usr/include/x86_64-linux-gnu/bits/statx.h:25:8: error: redefinition of ‘struct statx_timestamp’
 struct statx_timestamp
        ^~~~~~~~~~~~~~~
In file included from ../samples/vfs/test-statx.c:26:
./usr/include/linux/stat.h:56:8: note: originally defined here
 struct statx_timestamp {
        ^~~~~~~~~~~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/stat.h:446,
                 from ../samples/vfs/test-statx.c:28:
/usr/include/x86_64-linux-gnu/bits/statx.h:36:8: error: redefinition of ‘struct statx’
 struct statx
        ^~~~~
In file included from ../samples/vfs/test-statx.c:26:
./usr/include/linux/stat.h:99:8: note: originally defined here
 struct statx {
        ^~~~~
../samples/vfs/test-statx.c:40:9: error: conflicting types for ‘statx’
 ssize_t statx(int dfd, const char *filename, unsigned flags,
         ^~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/stat.h:446,
                 from ../samples/vfs/test-statx.c:28:
/usr/include/x86_64-linux-gnu/bits/statx.h:87:5: note: previous declaration of ‘statx’ was here
 int statx (int __dirfd, const char *__restrict __path, int __flags,
     ^~~~~
make[3]: *** [scripts/Makefile.host:90: samples/vfs/test-statx] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:492: samples/vfs] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/srv/src/kernel/testing/Makefile:1065: samples] Error 2

Rework so that SAMPLE_STATX depends on BROKEN, and SAMPLE_VFS enables
the newly added test.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 samples/Kconfig      | 7 +++++++
 samples/vfs/Makefile | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index dc4eb5355fad..8253c8ce7632 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -147,6 +147,13 @@ config SAMPLE_VFIO_MDEV_MBOCHS
 	  Specifically it does *not* include any legacy vga stuff.
 	  Device looks a lot like "qemu -device secondary-vga".
 
+config SAMPLE_STATX
+	bool "Build example extended-stat using code"
+	depends on BROKEN
+	depends on SAMPLE_VFS
+	help
+	  Build example userspace program to use the new extended-stat syscall.
+
 config SAMPLE_VFS
 	bool "Build example programs that use new VFS system calls"
 	help
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 4ac9690fb3c4..fe510c6d5e52 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,6 +1,7 @@
 # List of programs to build
 hostprogs-$(CONFIG_SAMPLE_VFS) := \
-	test-fsmount \
+	test-fsmount
+hostprogs-$(CONFIG_SAMPLE_STATX) := \
 	test-statx
 
 # Tell kbuild to always build the programs
-- 
2.19.2

