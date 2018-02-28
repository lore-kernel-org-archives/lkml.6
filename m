Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeB1Af3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:35:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36174 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB1Af2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:35:28 -0500
From: Tushar Dave <tushar.n.dave@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        netdev@vger.kernel.org, linux-selftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Add bpf_probe_read_str to bpf_helpers.h
Date: Tue, 27 Feb 2018 16:33:44 -0800
Message-Id: <1519778024-3113-1-git-send-email-tushar.n.dave@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=954
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280004
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using bpf_probe_read_str() from samples/bpf causes compiler warning.
e.g.
warning: implicit declaration of function 'bpf_probe_read_str' is invalid in C99
      [-Wimplicit-function-declaration]
        num = bpf_probe_read_str(buf, sizeof(buf), ctx->di);
              ^
1 warning generated.

Add bpf_probe_read_str() to bpf_helpers.h so it can be used by
samples/bpf programs.

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index dde2c11..65a266d 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -65,6 +65,8 @@ static int (*bpf_xdp_adjust_head)(void *ctx, int offset) =
 	(void *) BPF_FUNC_xdp_adjust_head;
 static int (*bpf_xdp_adjust_meta)(void *ctx, int offset) =
 	(void *) BPF_FUNC_xdp_adjust_meta;
+static int (*bpf_probe_read_str)(void *dst, int size, void *unsafe_ptr) =
+	(void *) BPF_FUNC_probe_read_str;
 static int (*bpf_setsockopt)(void *ctx, int level, int optname, void *optval,
 			     int optlen) =
 	(void *) BPF_FUNC_setsockopt;
-- 
1.9.1
