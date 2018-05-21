Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeEUH5R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 03:57:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37865 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750883AbeEUH5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 03:57:14 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] bpf: check NULL for sk_to_full_sk()
Date: Mon, 21 May 2018 15:55:58 +0800
Message-ID: <20180521075558.11968-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

like commit df39a9f106d5 ("bpf: check NULL for sk_to_full_sk() return value"),
we should check sk_to_full_sk return value against NULL.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/bpf-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 30d15e6..fd3fbeb 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -91,7 +91,7 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled && sk && sk == skb->sk) {		       \
 		typeof(sk) __sk = sk_to_full_sk(sk);			       \
-		if (sk_fullsock(__sk))					       \
+		if (__sk && sk_fullsock(__sk))				       \
 			__ret = __cgroup_bpf_run_filter_skb(__sk, skb,	       \
 						      BPF_CGROUP_INET_EGRESS); \
 	}								       \
-- 
2.7.0
