Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75394ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2194D20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UTkzpyh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2194D20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbeGQBUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:20:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39926 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbeGQBUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:20:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id w14-v6so31320246eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 17:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dgc7kEa+JGt88jRzrDOJlowcWCsWtrOOkbYInvyDa4Q=;
        b=UTkzpyh8wrCCYrmUE5EHyGhIbfNd15pEzWEItHCiVK1IcSnCZbh0e5sQqPhdEemG7V
         +I+kIN7oRruPX9iQAYtTboImDFTncnRG/2ZqGoetJUVHETJ73ES+CIaTi4uIfNykBoWp
         /L4LqYF+lO/Mj68wPhXdCU55zAlg7ke8Nv9jnmomBpF7GgHpOQrDXju/WXrTuEPRtRp1
         PJ1+/V2QmbqZTedYJDi6Nuq+NIWCqOPbmqMG7gpn1oSeeJR2183UytuPY8p0SeloctB+
         YkWJ6H7sGUgR7SCvjSDZg901GHSIKWxNyfjODQiMPkeqCM1Ctc99E7/FMsQlfnSxJVDs
         nFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dgc7kEa+JGt88jRzrDOJlowcWCsWtrOOkbYInvyDa4Q=;
        b=MTVIAz1P6eEUKzUrwVAJLbRC64EtKBYcQyWIRfTK8zlAV2JxrnC+uw60fW2GKjbzW3
         9zunou15JXR4XIApFDyBevJvHGSnIcOdGiz9P9rujHzDFSW3cRQMK1mk2DUQJLtK4Xnb
         TEJw2ROhuzbTLA7JEm+42HFuDStP1RSXjEygypcWtz0zpPTfHaBbbHCYQLas1iRfyf7Z
         Ovx6FkAJWcO7tjtz7pLZQkLUvO0RPSCG+KaEq0KMoNg3PNtiWbJ3Ac65gIrC9g4UEd5L
         H9YktLwpuxcsV6+nlO4YJWVCXe489Yi7gwXTXlUDtP7HG4jqIX94O4B8/dI37O14oQuB
         S9dA==
X-Gm-Message-State: AOUpUlEUlv48yJA9Xcm35hk4SL63kVjKIIXPBm9WTQ50kH6FFhAmjBGT
        USRni6l8BWXLJxHmCyNenrincF7bBPg=
X-Google-Smtp-Source: AAOMgpcufz9arqP6lIYz41Fv6wOyV4j9+l5qGL0oI3ehaN9fmlwrH9D6DZULv3nUQ4LeKlPsowp/Ow==
X-Received: by 2002:a50:88a6:: with SMTP id d35-v6mr19731242edd.239.1531788608819;
        Mon, 16 Jul 2018 17:50:08 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z4-v6sm15063842edi.90.2018.07.16.17.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 17:50:08 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-efi@vger.kernel.org, netdev@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [RFC 2/2] compat: Cleanup in_compat_syscall() callers
Date:   Tue, 17 Jul 2018 01:50:04 +0100
Message-Id: <20180717005004.25984-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180717005004.25984-1-dima@arista.com>
References: <20180717005004.25984-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that in_compat_syscall() == false on native i686, it's possible to
remove some ifdeffery and no more needed helpers.

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

