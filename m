Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbeEPU1s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:27:48 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34371 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeEPU1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:27:46 -0400
X-Google-Smtp-Source: AB8JxZqIfaWG0FMXguOb2wmUXL8pCKMtWrDZnwD4VGNkzHsuS71iAHnbLjMRiN9RTEWE8cQIhkoOFA==
From: Mathieu Malaterre <malat@debian.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: add __printf verification to bpf_verifier_vlog
Date: Wed, 16 May 2018 22:27:41 +0200
Message-Id: <20180516202741.20861-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__printf is useful to verify format and arguments. ‘bpf_verifier_vlog’
function is used twice in verifier.c in both cases the caller function
already uses the __printf gcc attribute.

Remove the following warning, triggered with W=1:

  kernel/bpf/verifier.c:176:2: warning: function might be possible candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/bpf_verifier.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7e61c395fddf..ebf78f8ddfa1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -197,8 +197,8 @@ struct bpf_verifier_env {
 	u32 subprog_cnt;
 };
 
-void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
-		       va_list args);
+__printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
+				      const char *fmt, va_list args);
 __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
 					   const char *fmt, ...);
 
-- 
2.11.0
