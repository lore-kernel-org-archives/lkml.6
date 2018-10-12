Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93D6C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68CC21470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="onSQ6vDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68CC21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeJLVPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:15:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42297 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbeJLVPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:15:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id b7-v6so11514538edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GHKRQfSzYcmlUqKtkMrjJRIg8df9+xe4ICJnJPR4NCo=;
        b=onSQ6vDGWoN1/D2aGnlR+935Ofc8T2MjkeAckv5H/m5IyA8E5uGLMB2CTxmR6bbwGD
         3GiqI7/3u+hdjxnTJaTkApKNtC1qdkIAF05CfGzWsAKWe4yZfJKoV0JF83e3szI4eEfw
         SVm3ejsUbXNNfOd9094iB/9jvQ+BUGBT2qkVPwgAC46UxyeXibn/qmURENTAtSDjT7Vc
         UvNV/L39DmfUbh/e1Wh/lFF2Vo5pPVKZwG6UMkVQdzmz955Zsspd733YwYT+EW9aAq8P
         2QbhJh3lSPnr2OR6IMbKT8QxtqI9XeCSiKysTjdG8+Xe8ZvFY+/PNmIMmoZTYqXlX96M
         USCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GHKRQfSzYcmlUqKtkMrjJRIg8df9+xe4ICJnJPR4NCo=;
        b=J+blcDrUOymB4W/+vuQ+tG7HeGqV3Nyn04CiIdvRNszJ4z46pRSQghC44DkWsppQld
         0wY47RjAFqNcDATvBj/NlKSnyu+4w4VffitQfvEaL2Lzel2p1eguGEAvBTYKt2G5OsiO
         F+E1u6W2Kwr8z5yAgD7+WKIL9aXnvqoKqxMdJWdGRt5bSJmjqsnTI6BTgQqvXGETTtnb
         RoKUhJtYhuinQl+WoCrfRZZ4P7Ya8RK1nCE1ZZBvvyNUjW+QRFp4jTwf0NDWVQ4G4Ton
         cyDEtqnPM7+7sko80bMmoKiSa5lX91BHzQAyrF0Xn3Ih8LjSk25LjZ25LRDbOM4/5Mm4
         CrgQ==
X-Gm-Message-State: ABuFfoiU+tFRuOLrRNJKdtsWyuRblAWx2L+yyz+pm2ZkDzgKvugIFrIq
        6osgKattquvv3X0es9ivAjTeF1vs6QY=
X-Google-Smtp-Source: ACcGV632WGmWIdG5TO2empAL9bQZQASgNAJgaENR2pmJ2N8W9qlMpeoW+p1RPP/SLHUE8VMpbI1bDA==
X-Received: by 2002:a17:906:4054:: with SMTP id y20-v6mr7247353ejj.30.1539351777768;
        Fri, 12 Oct 2018 06:42:57 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k42-v6sm577292ede.94.2018.10.12.06.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 06:42:57 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirsky <luto@kernel.org>,
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
        linux-efi@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC-resend 2/2] compat: Cleanup in_compat_syscall() callers
Date:   Fri, 12 Oct 2018 14:42:53 +0100
Message-Id: <20181012134253.23266-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181012134253.23266-1-dima@arista.com>
References: <20181012134253.23266-1-dima@arista.com>
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
index ccdb351277ee..4638e8cb6378 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -863,7 +863,7 @@ int get_timespec64(struct timespec64 *ts,
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
index df7ca2dabc48..c3aedf8a99ff 100644
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
-- 
2.13.6

