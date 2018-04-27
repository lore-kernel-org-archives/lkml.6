Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932627AbeD0KDQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:03:16 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33601 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757657AbeD0KDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:03:14 -0400
X-Google-Smtp-Source: AB8JxZoDkb9qx9w38H7HRzrXLbJcQhZncLfQVSYVT+hu0oO3hA7j6rAcDb8zwI5xAqmE4I7aXpnb1g==
From: Leo Yan <leo.yan@linaro.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH bpf-next v2] bpf, doc: Update bpf_jit_enable limitation for CONFIG_BPF_JIT_ALWAYS_ON
Date: Fri, 27 Apr 2018 18:02:54 +0800
Message-Id: <1524823374-6174-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_BPF_JIT_ALWAYS_ON is enabled, kernel has limitation for
bpf_jit_enable, so it has fixed value 1 and we cannot set it to 2
for JIT opcode dumping; this patch is to update the doc for it.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/networking/filter.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/networking/filter.txt b/Documentation/networking/filter.txt
index fd55c7d..5032e12 100644
--- a/Documentation/networking/filter.txt
+++ b/Documentation/networking/filter.txt
@@ -483,6 +483,12 @@ Example output from dmesg:
 [ 3389.935851] JIT code: 00000030: 00 e8 28 94 ff e0 83 f8 01 75 07 b8 ff ff 00 00
 [ 3389.935852] JIT code: 00000040: eb 02 31 c0 c9 c3
 
+When CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is permanently set to 1 and
+setting any other value than that will return in failure. This is even the case for
+setting bpf_jit_enable to 2, since dumping the final JIT image into the kernel log
+is discouraged and introspection through bpftool (under tools/bpf/bpftool/) is the
+generally recommended approach instead.
+
 In the kernel source tree under tools/bpf/, there's bpf_jit_disasm for
 generating disassembly out of the kernel log's hexdump:
 
-- 
1.9.1
