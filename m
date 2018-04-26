Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeDZC1O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:27:14 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33572 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeDZC1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:27:12 -0400
X-Google-Smtp-Source: AIpwx4+gmxQtgDeKVUG9f6dEaNb/ZM9jvdsR9cb3cOQBw23t45dCDA5BCBaf5MTYncyNC2teqS6oWQ==
From: Leo Yan <leo.yan@linaro.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH bpf-next] bpf, doc: Update bpf_jit_enable limitation for CONFIG_BPF_JIT_ALWAYS_ON
Date: Thu, 26 Apr 2018 10:26:51 +0800
Message-Id: <1524709611-29437-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_BPF_JIT_ALWAYS_ON is enabled, kernel has limitation for
bpf_jit_enable, so it has fixed value 1 and we cannot set it to 2
for JIT opcode dumping; this patch is to update the doc for it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/networking/filter.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/networking/filter.txt b/Documentation/networking/filter.txt
index fd55c7d..feddab9 100644
--- a/Documentation/networking/filter.txt
+++ b/Documentation/networking/filter.txt
@@ -483,6 +483,12 @@ Example output from dmesg:
 [ 3389.935851] JIT code: 00000030: 00 e8 28 94 ff e0 83 f8 01 75 07 b8 ff ff 00 00
 [ 3389.935852] JIT code: 00000040: eb 02 31 c0 c9 c3
 
+When CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is set to 1 by default
+and it returns failure if change to any other value from proc node; this is
+for security consideration to avoid leaking info to unprivileged users. In this
+case, we can't directly dump JIT opcode image from kernel log, alternatively we
+need to use bpf tool for the dumping.
+
 In the kernel source tree under tools/bpf/, there's bpf_jit_disasm for
 generating disassembly out of the kernel log's hexdump:
 
-- 
1.9.1
