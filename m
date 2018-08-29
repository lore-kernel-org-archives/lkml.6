Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C995BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1AA20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1AA20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeH2SD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:03:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2SD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:03:29 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lo2Ke-1fSI471FYe-00g2CQ; Wed, 29 Aug 2018 16:06:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     paulus@samba.org, linux-ppp@vger.kernel.org, netdev@vger.kernel.org
Cc:     mitch@sfgoth.com, mostrows@earthlink.net, jchapman@katalix.com,
        xeb@mail.ru, davem@davemloft.net, viro@zeniv.linux.org.uk,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Guillaume Nault <g.nault@alphalink.fr>
Subject: [PATCH net-next 4/5] ppp: move PPPIOCSPASS32/PPPIOCSACTIVE32 to ppp_generic.c
Date:   Wed, 29 Aug 2018 16:03:29 +0200
Message-Id: <20180829140409.833488-4-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829140409.833488-1-arnd@arndb.de>
References: <20180829140409.833488-1-arnd@arndb.de>
X-Provags-ID: V03:K1:DvRNG5gWXgWPhNXwSDGxC4ZR/n0iE3AHUvPGwVSdoPl1V6C47fg
 wbUIvPIEk57nNI918KfZZYzX/fQImV5oLquckaj5WS+uFQ6t0pOrg8/geO0trJIn+T90gok
 yjqWvPeFOIjDRPX0NFKeqQhjwqsz/5VaEdD3bfvuiZWkLMcAD3BLXg7YAB0iPm0o50DOeR/
 r4/z/N+MK8v0A5fehjObg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cYWozMrO8hs=:ZKo94HNdWBZTNhlNy8O5L4
 UCU4jEn85h8RtCoFGyZQY6T1jaSCf7iqfwZLJ7D8NWHvzlYuNinjBkbVYjWtEkueNUmvUnLxX
 BO5CfM3xZprfVaf0jsxzBQjvylTrhRO5G7PGLM4LnIQA9azJEE6oFxoL8KNlh91DnCNRAz8RL
 N0+m9BiOjoUlRafdfpOWv+UPqwtl1c36i61GEgI6J72R8jWSG3LiZ9CC5duJ3EhLGzo0mp3uf
 Nl//30B87MMcRfvWjpaB2WPbBOXhQAlFp4mQGOLgm5AJeDo8h9z2fUBdijxpLT6TyqYWH68+V
 oOoHSAXKWLM/IIHAsVzgMNGVDF7f+Sgom5MGAWJjxAVbN+Jt6oT+QQr2yAg3bmY4XXJm74WIG
 7WZE84Ycl900AHyv+nqJ/0/3WHHy7kNh27YRjPFxEiZQeSwXbNJz4UHgvODBINqpyTXwy97XV
 7hCQyfKR9uqwQVxxv6b298j5Xvpqy9HOrTBPHG9qTGVOLGBjCxQtAS0I4zaPmh1CuOYXdaRE4
 tecYL4wyzETlIWLFbzzmqxMa1PQXeAz7pX/DUmQ0pMCvLf6mHz0OiT4ZeBzIBEhRUlQVIIbX8
 Vm4gOlp4PPmgbYH5iwgxRyu/j2j7cSF8csS/Uv21SMABGxnNEeOsGGuZJGjmVC9FIoZBDiNsh
 R+r8cNycD5JJ90x0Q2IULJNnYgXl0ODvJnmROX97mG42r/zp1CqWLC+K5TgyW+q+VfUs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPPIOCSPASS and PPPIOCSACTIVE are implemented in ppp_generic and isdn_ppp,
but the latter one doesn't work for compat mode in general, so we can
move these two into the generic code.

Again, the best implementation I could come up with was to merge
the compat handling into the regular ppp_ioctl() function and
treating all ioctl commands as compatible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ppp/ppp_generic.c | 39 ++++++++++++++++++++++++++++++-----
 fs/compat_ioctl.c             | 37 ---------------------------------
 2 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 8dfe8d47df95..3a7aa2eed415 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -22,6 +22,7 @@
  * ==FILEVERSION 20041108==
  */
 
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
@@ -567,14 +568,36 @@ struct ppp_option_data32 {
 #endif
 
 #ifdef CONFIG_PPP_FILTER
-static int get_filter(void __user *arg, struct sock_filter **p)
+#ifdef CONFIG_COMPAT
+struct sock_fprog32 {
+	unsigned short	len;
+	compat_caddr_t	filter;
+};
+#define PPPIOCSPASS32	_IOW('t', 71, struct sock_fprog32)
+#define PPPIOCSACTIVE32	_IOW('t', 70, struct sock_fprog32)
+#endif
+
+static int get_filter(void __user *arg, struct sock_filter **p, bool compat)
 {
 	struct sock_fprog uprog;
 	struct sock_filter *code = NULL;
 	int len;
 
-	if (copy_from_user(&uprog, arg, sizeof(uprog)))
-		return -EFAULT;
+#ifdef CONFIG_COMPAT
+	if (compat) {
+		struct sock_fprog32 uprog32;
+
+		if (copy_from_user(&uprog32, arg, sizeof(uprog32)))
+			return -EFAULT;
+
+		uprog.len = uprog32.len;
+		uprog.filter = compat_ptr(uprog32.filter);
+	} else
+#endif
+	{
+		if (copy_from_user(&uprog, arg, sizeof(uprog)))
+			return -EFAULT;
+	}
 
 	if (!uprog.len) {
 		*p = NULL;
@@ -772,10 +795,13 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 #ifdef CONFIG_PPP_FILTER
 	case PPPIOCSPASS:
+#ifdef CONFIG_COMPAT
+	case PPPIOCSPASS32:
+#endif
 	{
 		struct sock_filter *code;
 
-		err = get_filter(argp, &code);
+		err = get_filter(argp, &code, cmd != PPPIOCSPASS);
 		if (err >= 0) {
 			struct bpf_prog *pass_filter = NULL;
 			struct sock_fprog_kern fprog = {
@@ -798,10 +824,13 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	case PPPIOCSACTIVE:
+#ifdef CONFIG_COMPAT
+	case PPPIOCSACTIVE32:
+#endif
 	{
 		struct sock_filter *code;
 
-		err = get_filter(argp, &code);
+		err = get_filter(argp, &code, cmd != PPPIOCSACTIVE);
 		if (err >= 0) {
 			struct bpf_prog *active_filter = NULL;
 			struct sock_fprog_kern fprog = {
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index f518dc174dc7..258c6938e80a 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -379,40 +379,6 @@ static int sg_grt_trans(struct file *file,
 }
 #endif /* CONFIG_BLOCK */
 
-struct sock_fprog32 {
-	unsigned short	len;
-	compat_caddr_t	filter;
-};
-
-#define PPPIOCSPASS32	_IOW('t', 71, struct sock_fprog32)
-#define PPPIOCSACTIVE32	_IOW('t', 70, struct sock_fprog32)
-
-static int ppp_sock_fprog_ioctl_trans(struct file *file,
-		unsigned int cmd, struct sock_fprog32 __user *u_fprog32)
-{
-	struct sock_fprog __user *u_fprog64 = compat_alloc_user_space(sizeof(struct sock_fprog));
-	void __user *fptr64;
-	u32 fptr32;
-	u16 flen;
-
-	if (get_user(flen, &u_fprog32->len) ||
-	    get_user(fptr32, &u_fprog32->filter))
-		return -EFAULT;
-
-	fptr64 = compat_ptr(fptr32);
-
-	if (put_user(flen, &u_fprog64->len) ||
-	    put_user(fptr64, &u_fprog64->filter))
-		return -EFAULT;
-
-	if (cmd == PPPIOCSPASS32)
-		cmd = PPPIOCSPASS;
-	else
-		cmd = PPPIOCSACTIVE;
-
-	return do_ioctl(file, cmd, (unsigned long) u_fprog64);
-}
-
 struct ppp_idle32 {
 	compat_time_t xmit_idle;
 	compat_time_t recv_idle;
@@ -1218,9 +1184,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	switch (cmd) {
 	case PPPIOCGIDLE32:
 		return ppp_gidle(file, cmd, argp);
-	case PPPIOCSPASS32:
-	case PPPIOCSACTIVE32:
-		return ppp_sock_fprog_ioctl_trans(file, cmd, argp);
 #ifdef CONFIG_BLOCK
 	case SG_IO:
 		return sg_ioctl_trans(file, cmd, argp);
-- 
2.18.0

