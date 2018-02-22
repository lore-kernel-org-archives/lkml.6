Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226FOIJrNcq3zxD9kkSB0AXU8NFLlucYKF773wyHE7boGMXeO68XCNCViXRyt0/+fE98JuGb
ARC-Seal: i=1; a=rsa-sha256; t=1519300497; cv=none;
        d=google.com; s=arc-20160816;
        b=MYUfZ/BniyWDPLSILssIJ95Zu+s5BtfEB8+L29ykKKCpt43G2ZhZKRFDS+VOC7hMRj
         Dtjt1bsFAfWDwqYtkmkziIp6skgLIFQdikYMdJ48ik9pkxhTo1w4cctcgQ1GOCyfAFeR
         KgXiDy5Hoiqam0N0PHyHFJScIE4EfcTRy1E3LCiA3TfSzE2gAFqYIPvgzJJJk9Mg3Yhy
         VPCLREtD8yIbhzOX0TInS6EVTLslWhStnHwUEkx3L/rU3W1l17ecu73+zWsQ/GJ/M6JX
         VWQbH65SEleeBa2X2PZtmeRB2rb77lYbix6DOBHA8QLYcLK7hW37LNYNXevqomOPHcC7
         7Seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=d0K5PDpkfBusnIkpa/LGaUcRvo71Fpd0jgWCc9wTgOc=;
        b=O5kHX8cjoet/LNdmId6tnlpno637S47JmQlrPDUSS2V9ovtHyHm/TgYaY6Z0vlvThU
         RZI+C9QXbbFZT947e6FvE4SoOMSpMp9XKSwwsJT703YtkDgHqvwF9Pob6HmNpVHU1GOb
         ZPUeJwzP2J1N5KCpe9oFMzRQbSKron6Qacentf/Cw7Q1DX9E9flbPA6hJG7k0jRlstI2
         TSBBf4ZCsrMKKfnRUy8F0ALl92JzqObfjcAVGapzA2wsIUhQW+/FLyOpfXciceuwZSbM
         OXou1NVd5uxaDRP1tW/U77FNMiVfogS+NWgJ1pgttc+ZEifTX8VfdjldSj7x4UJtH0uf
         2m4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=l+wBA2hx;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=l+wBA2hx;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbeBVLyd (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 22 Feb 2018 06:54:33 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43781 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753649AbeBVLyb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Feb 2018 06:54:31 -0500
From: Zong Li <zongbox@gmail.com>
To: shuah@kernel.org, vincent.legoll@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, mcgrof@kernel.org, davem@davemloft.net,
        keescook@chromium.org, fathi.boudra@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: zong@andestech.com, greentime@andestech.com,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH] selftest: fix kselftest-merge depend on 'RUNTIME_TESTING_MENU'
Date: Thu, 22 Feb 2018 19:53:07 +0800
Message-Id: <20180222115307.15063-1-zongbox@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593102038295942155?=
X-GMAIL-MSGID: =?utf-8?q?1593102038295942155?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since the 'commit d3deafaa8b5c ("lib/: make RUNTIME_TESTS a menuconfig
to ease disabling it all")', the make kselftest-merge cannot merge the
config dependencies of kselftest to the existing .config file.

These config dependencies of kselftest need to enable the
'CONFIG_RUNTIME_TESTING_MENU=y' at the same time.

Signed-off-by: Zong Li <zong@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
---
 tools/testing/selftests/bpf/config         | 1 +
 tools/testing/selftests/firmware/config    | 1 +
 tools/testing/selftests/kmod/config        | 1 +
 tools/testing/selftests/lib/config         | 1 +
 tools/testing/selftests/net/config         | 1 +
 tools/testing/selftests/static_keys/config | 1 +
 tools/testing/selftests/sysctl/config      | 1 +
 tools/testing/selftests/user/config        | 1 +
 8 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 983dd25d49f4..d93b82144b19 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -1,3 +1,4 @@
+CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_BPF=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_NET_CLS_BPF=m
diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
index c8137f70e291..01d7445ef007 100644
--- a/tools/testing/selftests/firmware/config
+++ b/tools/testing/selftests/firmware/config
@@ -1 +1,2 @@
+CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_FIRMWARE=y
diff --git a/tools/testing/selftests/kmod/config b/tools/testing/selftests/kmod/config
index 259f4fd6b5e2..37070985e428 100644
--- a/tools/testing/selftests/kmod/config
+++ b/tools/testing/selftests/kmod/config
@@ -1,3 +1,4 @@
+CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_KMOD=m
 CONFIG_TEST_LKM=m
 CONFIG_XFS_FS=m
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index 126933bcc950..d1fe14c2c8cb 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -1,3 +1,4 @@
+CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 7177bea1fdfa..847a99873128 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -1,3 +1,4 @@
+CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_USER_NS=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_TEST_BPF=m
diff --git a/tools/testing/selftests/static_keys/config b/tools/testing/selftests/static_keys/config
index d538fb774b96..732d17f6b9a1 100644
--- a/tools/testing/selftests/static_keys/config
+++ b/tools/testing/selftests/static_keys/config
@@ -1 +1,2 @@
+CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_STATIC_KEYS=m
diff --git a/tools/testing/selftests/sysctl/config b/tools/testing/selftests/sysctl/config
index 6ca14800d755..772ce8c3c0d9 100644
--- a/tools/testing/selftests/sysctl/config
+++ b/tools/testing/selftests/sysctl/config
@@ -1 +1,2 @@
+CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_SYSCTL=y
diff --git a/tools/testing/selftests/user/config b/tools/testing/selftests/user/config
index 784ed8416324..f9f491fa4ae8 100644
--- a/tools/testing/selftests/user/config
+++ b/tools/testing/selftests/user/config
@@ -1 +1,2 @@
+CONFIG_RUNTIME_TESTING_MENU=y
 CONFIG_TEST_USER_COPY=m
-- 
2.16.1

