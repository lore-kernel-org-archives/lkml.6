Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70783C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0DD20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0DD20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbeKAVLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:11:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60463 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbeKAVLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:11:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA1C7SnH2805816
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Nov 2018 05:07:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA1C7RHp2805813;
        Thu, 1 Nov 2018 05:07:27 -0700
Date:   Thu, 1 Nov 2018 05:07:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dmitry Safonov <tipbot@zytor.com>
Message-ID: <tip-98f76206b33504b934209d16196477dfa519a807@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org,
        steffen.klassert@secunet.com, davem@davemloft.net, dima@arista.com,
        rostedt@goodmis.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, herbert@gondor.apana.org.au,
        sboyd@kernel.org, 0x7f454c46@gmail.com, oleg@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, john.stultz@linaro.org,
        ard.biesheuvel@linaro.org
Reply-To: davem@davemloft.net, steffen.klassert@secunet.com,
          luto@kernel.org, linux-kernel@vger.kernel.org,
          herbert@gondor.apana.org.au, kirill.shutemov@linux.intel.com,
          dima@arista.com, rostedt@goodmis.org, hpa@zytor.com,
          sboyd@kernel.org, 0x7f454c46@gmail.com, tglx@linutronix.de,
          john.stultz@linaro.org, mingo@kernel.org,
          ard.biesheuvel@linaro.org, oleg@redhat.com
In-Reply-To: <20181012134253.23266-3-dima@arista.com>
References: <20181012134253.23266-3-dima@arista.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] compat: Cleanup in_compat_syscall() callers
Git-Commit-ID: 98f76206b33504b934209d16196477dfa519a807
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  98f76206b33504b934209d16196477dfa519a807
Gitweb:     https://git.kernel.org/tip/98f76206b33504b934209d16196477dfa519a807
Author:     Dmitry Safonov <dima@arista.com>
AuthorDate: Fri, 12 Oct 2018 14:42:53 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Nov 2018 13:02:21 +0100

compat: Cleanup in_compat_syscall() callers

Now that in_compat_syscall() is consistent on all architectures and does
not longer report true on native i686, the workarounds (ifdeffery and
helpers) can be removed.

Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-efi@vger.kernel.org
Cc: netdev@vger.kernel.org
Link: https://lkml.kernel.org/r/20181012134253.23266-3-dima@arista.com

---
 drivers/firmware/efi/efivars.c | 16 ++++------------
 kernel/time/time.c             |  2 +-
 net/xfrm/xfrm_state.c          |  2 --
 net/xfrm/xfrm_user.c           |  2 --
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index 3e626fd9bd4e..8061667a6765 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -229,14 +229,6 @@ sanity_check(struct efi_variable *var, efi_char16_t *name, efi_guid_t vendor,
 	return 0;
 }
 
-static inline bool is_compat(void)
-{
-	if (IS_ENABLED(CONFIG_COMPAT) && in_compat_syscall())
-		return true;
-
-	return false;
-}
-
 static void
 copy_out_compat(struct efi_variable *dst, struct compat_efi_variable *src)
 {
@@ -263,7 +255,7 @@ efivar_store_raw(struct efivar_entry *entry, const char *buf, size_t count)
 	u8 *data;
 	int err;
 
-	if (is_compat()) {
+	if (in_compat_syscall()) {
 		struct compat_efi_variable *compat;
 
 		if (count != sizeof(*compat))
@@ -324,7 +316,7 @@ efivar_show_raw(struct efivar_entry *entry, char *buf)
 			     &entry->var.DataSize, entry->var.Data))
 		return -EIO;
 
-	if (is_compat()) {
+	if (in_compat_syscall()) {
 		compat = (struct compat_efi_variable *)buf;
 
 		size = sizeof(*compat);
@@ -418,7 +410,7 @@ static ssize_t efivar_create(struct file *filp, struct kobject *kobj,
 	struct compat_efi_variable *compat = (struct compat_efi_variable *)buf;
 	struct efi_variable *new_var = (struct efi_variable *)buf;
 	struct efivar_entry *new_entry;
-	bool need_compat = is_compat();
+	bool need_compat = in_compat_syscall();
 	efi_char16_t *name;
 	unsigned long size;
 	u32 attributes;
@@ -495,7 +487,7 @@ static ssize_t efivar_delete(struct file *filp, struct kobject *kobj,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	if (is_compat()) {
+	if (in_compat_syscall()) {
 		if (count != sizeof(*compat))
 			return -EINVAL;
 
diff --git a/kernel/time/time.c b/kernel/time/time.c
index e3a7f7fd3abc..ad204cf6d001 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -842,7 +842,7 @@ int get_timespec64(struct timespec64 *ts,
 	ts->tv_sec = kts.tv_sec;
 
 	/* Zero out the padding for 32 bit systems or in compat mode */
-	if (IS_ENABLED(CONFIG_64BIT_TIME) && (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()))
+	if (IS_ENABLED(CONFIG_64BIT_TIME) && in_compat_syscall())
 		kts.tv_nsec &= 0xFFFFFFFFUL;
 
 	ts->tv_nsec = kts.tv_nsec;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index b669262682c9..dc4a9f1fb941 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2077,10 +2077,8 @@ int xfrm_user_policy(struct sock *sk, int optname, u8 __user *optval, int optlen
 	struct xfrm_mgr *km;
 	struct xfrm_policy *pol = NULL;
 
-#ifdef CONFIG_COMPAT
 	if (in_compat_syscall())
 		return -EOPNOTSUPP;
-#endif
 
 	if (!optval && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ca7a207b81a9..c9a84e22f5d5 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2621,10 +2621,8 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	const struct xfrm_link *link;
 	int type, err;
 
-#ifdef CONFIG_COMPAT
 	if (in_compat_syscall())
 		return -EOPNOTSUPP;
-#endif
 
 	type = nlh->nlmsg_type;
 	if (type > XFRM_MSG_MAX)
