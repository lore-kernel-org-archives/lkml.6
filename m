Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934214AbeD0PBk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:01:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42286 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933900AbeD0OFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:05:33 -0400
Date: Fri, 27 Apr 2018 17:04:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] bpf: btf: remove a couple conditions
Message-ID: <20180427140459.GB19583@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8875 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=733
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804270135
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We know "err" is zero so we can remove these and pull the code in one
indent level.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This applies to the BPF tree (linux-next)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e631b6fd60d3..7cb0905f37c2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1973,16 +1973,14 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
 	if (err)
 		goto errout;
 
-	if (!err && log->level && bpf_verifier_log_full(log)) {
+	if (log->level && bpf_verifier_log_full(log)) {
 		err = -ENOSPC;
 		goto errout;
 	}
 
-	if (!err) {
-		btf_verifier_env_free(env);
-		btf_get(btf);
-		return btf;
-	}
+	btf_verifier_env_free(env);
+	btf_get(btf);
+	return btf;
 
 errout:
 	btf_verifier_env_free(env);
