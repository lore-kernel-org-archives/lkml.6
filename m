Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16428C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6C020895
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YPAIBMch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6C020895
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeGZDqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41352 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeGZDqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id s24-v6so329910edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TK6fI7PqrQao33jIcIyqNNGwCLMMWJwDh63V9YY0f0A=;
        b=YPAIBMchW5X5t0ZP1WtmjWtkiNJMUK7OpW2aR99PK417k3zkm+cWg2u/A3+R6YwHu4
         UGYgKOKObl3mzN8r+iZWjRYlGeAR4So3kHPAkU0FoQXeFNsZK3HxCcQ6lI3CUCab1Nsa
         2kcpyiL3SHbiSGu9MiTS5ToG1e4j3XhtcxhaItjqqmftcnfapUkHbRXUXL784OKbQqm5
         s5T8WgwEzQIKhwKYudTyno8+Wkvwdw64Tf+tg0yLBbZ6VPqJfWbGJMyrRLpOT08ItHGx
         cMx5YGzI6leBFcEqcvV2MG9qBY6WZ5NcO2tKlrsWbJsINz3sUzrTUMvtue5DFeI6uh3k
         6rJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TK6fI7PqrQao33jIcIyqNNGwCLMMWJwDh63V9YY0f0A=;
        b=lLBMQKO5wuTpOACHBRXsHFX/9vCGV/VAvlzd4AaHtxWTiXyUJ+Ak8Sku2uH/8HP41f
         4Mnfnln/rv7/reWzPLtv73l6XEqX7UX3MLmomi0fwKXbScmZAWrO2lXnqzMQNzX5iJYf
         7ejHcMTShAjgu2rr3b2HT/2IWTYk2bo+gyL4JVNLVSAQ9HEewCw4XvskJBHFfy5SKx9y
         lzHwYz78FTM9riTuoZn+PS4ZyUYmexjT+pUvHqo/pnOqpyX9Evqwh7D+c4JXoSBiS5Vx
         1gOa+ZltgnvJDZegnzZT8w4Hb0p+Ou+wCdal4qQCLg9CEfA+TJdRkzyVkYhfCZsCcJ4H
         vueQ==
X-Gm-Message-State: AOUpUlGwIDsS4l4Jz62nc8iIiw2tZ7+h8b10BV+v5lKewQFckLwKLmnw
        skVWznQTYqLzrGA4uGzrFVeN6RN/Uz8=
X-Google-Smtp-Source: AAOMgpenTTOTD001ROhGaWPaFdnUnqD+Y8b7JYmkyNCCjNUbGPgqOOd5Am5jHvc/Oom3NSuKNlPPvA==
X-Received: by 2002:a50:8466:: with SMTP id 93-v6mr506099edp.304.1532572308921;
        Wed, 25 Jul 2018 19:31:48 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:31:48 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH 02/18] compat: Cleanup in_compat_syscall() callers
Date:   Thu, 26 Jul 2018 03:31:28 +0100
Message-Id: <20180726023144.31066-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that in_compat_syscall() == false on native i686, it's possible to
remove some ifdeffery and no more needed helpers.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-efi@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
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
index 2b41e8e2d31d..d59caa6d03e6 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -865,7 +865,7 @@ int get_timespec64(struct timespec64 *ts,
 	ts->tv_sec = kts.tv_sec;
 
 	/* Zero out the padding for 32 bit systems or in compat mode */
-	if (IS_ENABLED(CONFIG_64BIT_TIME) && (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()))
+	if (IS_ENABLED(CONFIG_64BIT_TIME) && in_compat_syscall())
 		kts.tv_nsec &= 0xFFFFFFFFUL;
 
 	ts->tv_nsec = kts.tv_nsec;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 8308281f3253..3f48a6925606 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2057,10 +2057,8 @@ int xfrm_user_policy(struct sock *sk, int optname, u8 __user *optval, int optlen
 	struct xfrm_mgr *km;
 	struct xfrm_policy *pol = NULL;
 
-#ifdef CONFIG_COMPAT
 	if (in_compat_syscall())
 		return -EOPNOTSUPP;
-#endif
 
 	if (!optval && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 080035f056d9..2677cb55b7a8 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2546,10 +2546,8 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	const struct xfrm_link *link;
 	int type, err;
 
-#ifdef CONFIG_COMPAT
 	if (in_compat_syscall())
 		return -EOPNOTSUPP;
-#endif
 
 	type = nlh->nlmsg_type;
 	if (type > XFRM_MSG_MAX)
-- 
2.13.6

