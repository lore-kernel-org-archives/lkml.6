Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeERSXi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:23:38 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42702 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeERSXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:23:35 -0400
X-Google-Smtp-Source: AB8JxZp+KpK2l6nT0hUf9uG/uRUm2bT6kBmvApBQqzgZ4m8uOMM2OQjYzNqgFurZeQwIlwxeRIo/ow==
From: Anders Roxell <anders.roxell@linaro.org>
To: ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: config: enable NET_SCH_INGRESS for xdp_meta.sh
Date: Fri, 18 May 2018 20:23:24 +0200
Message-Id: <20180518182324.23827-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running bpf's selftest test_xdp_meta.sh it fails:
./test_xdp_meta.sh
Error: Specified qdisc not found.
selftests: test_xdp_meta [FAILED]

Need to enable CONFIG_NET_SCH_INGRESS and CONFIG_NET_CLS_ACT to get the
test to pass.

Fixes: 22c8852624fc ("bpf: improve selftests and add tests for meta pointer")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 983dd25d49f4..1eefe211a4a8 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -5,3 +5,5 @@ CONFIG_BPF_EVENTS=y
 CONFIG_TEST_BPF=m
 CONFIG_CGROUP_BPF=y
 CONFIG_NETDEVSIM=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_SCH_INGRESS=y
-- 
2.17.0
