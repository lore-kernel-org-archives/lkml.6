Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C9EC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD212086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/F6eodU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD212086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754053AbeFQFMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:12:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43837 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbeFQFMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:12:12 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so6651396pfm.10;
        Sat, 16 Jun 2018 22:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PA0NrdNsd0KXOdx5GvsA2TB5KoIFGLpO6aMantl+yZM=;
        b=t/F6eodUuQ1CgQ4EAyHLWFOiMLbBX/RWoITrOdrt3z7EfqwJjyNT4mtsnYZrxucDxI
         w/P7ky3W95HpsO4KdhdwRnXl5W3bQlagqQGmnw0Gv4C+6AyDT29O3TleXLL/ufHtFkIw
         dd6DPGcPVnudi1NamTVpAsmKBdUw6ekqRTwdLpB22sP1mfqRYOSrpexZO42SmBb3y+Q0
         Gy79n5hwbZXuX6pNb1uaU715qgwKtktmRQ7CqAyJzz84n8au+HvVeUf1pp60hKtuupAV
         QRm2s/r84BnKzcvX4OBhnsv+TDTMQL80Y1tKsUbP66sbqOwlDrbqRNm1fbzlUXuvt5Tg
         rr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PA0NrdNsd0KXOdx5GvsA2TB5KoIFGLpO6aMantl+yZM=;
        b=X85FoXN1cCU3ZCbeoeoNMEqywHUfkwFrNlmVJWm9vSldkGkYqZGFqGHuF7O1roTxmo
         ozKzehPQ8hfWsmC5PKBgJCOtmgByjpllMVhvdMCLOovrn9/1v/SFFVkdkXjT1TwPSDyR
         kC0bHcS0THwJDob/9ZM9TaI/9hzrhpAKwkXeIAEs9SDd5uqHf1lUrRcTKlcKQlp1pTMZ
         Ckiid4SZfW/t8mqNyhim7OFXj8fw4JyoVBDczjI3ZyZNg5fVl6o3MQE4TlW0yakTn1NL
         QMb0pFK+Wkc4hMRUZxsfmgHBJHH7LniqeM1teCs4X9tVki4lETInQ8WJ7Z9/zP9nU9rl
         ukuQ==
X-Gm-Message-State: APt69E3xKjiAOUwdpI9qLkslRtBmlKR1N72tpm8PjoIbNe59O260Jbou
        gMzB8GlDdnD1098EUZU5eNw=
X-Google-Smtp-Source: ADUXVKIkFvIUtvKbX4NhgpiSJvc4tg5C7H67QIl+fzDrCvRQqSiEN9gY0HPC6M9AXA953yacXC3ydg==
X-Received: by 2002:a62:9385:: with SMTP id r5-v6mr8469038pfk.59.1529212331843;
        Sat, 16 Jun 2018 22:12:11 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id h27-v6sm28354594pfk.160.2018.06.16.22.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 22:12:11 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     arnd@arndb.de, tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH 2/3] time: Enable get/put_compat_itimerspec64 always
Date:   Sat, 16 Jun 2018 22:11:43 -0700
Message-Id: <20180617051144.29756-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617051144.29756-1-deepa.kernel@gmail.com>
References: <20180617051144.29756-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will aid in enabling the compat syscalls on 32-bit
architectures later on.

Also move compat_itimerspec and related defines to compat_time.h.
The compat_time.h file will eventually be deleted.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/compat.h      |  9 ---------
 include/linux/compat_time.h |  9 +++++++++
 kernel/compat.c             | 29 -----------------------------
 kernel/time/time.c          | 21 +++++++++++++++++++++
 4 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index b1a5562b3215..18a13f2df14b 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -109,11 +109,6 @@ typedef	compat_ulong_t		compat_aio_context_t;
 struct compat_sel_arg_struct;
 struct rusage;
 
-struct compat_itimerspec {
-	struct compat_timespec it_interval;
-	struct compat_timespec it_value;
-};
-
 struct compat_utimbuf {
 	compat_time_t		actime;
 	compat_time_t		modtime;
@@ -294,10 +289,6 @@ extern int compat_get_timespec(struct timespec *, const void __user *);
 extern int compat_put_timespec(const struct timespec *, void __user *);
 extern int compat_get_timeval(struct timeval *, const void __user *);
 extern int compat_put_timeval(const struct timeval *, void __user *);
-extern int get_compat_itimerspec64(struct itimerspec64 *its,
-			const struct compat_itimerspec __user *uits);
-extern int put_compat_itimerspec64(const struct itimerspec64 *its,
-			struct compat_itimerspec __user *uits);
 
 struct compat_iovec {
 	compat_uptr_t	iov_base;
diff --git a/include/linux/compat_time.h b/include/linux/compat_time.h
index 31f2774f1994..e70bfd1d2c3f 100644
--- a/include/linux/compat_time.h
+++ b/include/linux/compat_time.h
@@ -17,7 +17,16 @@ struct compat_timeval {
 	s32		tv_usec;
 };
 
+struct compat_itimerspec {
+	struct compat_timespec it_interval;
+	struct compat_timespec it_value;
+};
+
 extern int compat_get_timespec64(struct timespec64 *, const void __user *);
 extern int compat_put_timespec64(const struct timespec64 *, void __user *);
+extern int get_compat_itimerspec64(struct itimerspec64 *its,
+			const struct compat_itimerspec __user *uits);
+extern int put_compat_itimerspec64(const struct itimerspec64 *its,
+			struct compat_itimerspec __user *uits);
 
 #endif /* _LINUX_COMPAT_TIME_H */
diff --git a/kernel/compat.c b/kernel/compat.c
index 702aa846ddac..8e40efc2928a 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -324,35 +324,6 @@ COMPAT_SYSCALL_DEFINE3(sched_getaffinity, compat_pid_t,  pid, unsigned int, len,
 	return ret;
 }
 
-/* Todo: Delete these extern declarations when get/put_compat_itimerspec64()
- * are moved to kernel/time/time.c .
- */
-extern int __compat_get_timespec64(struct timespec64 *ts64,
-				   const struct compat_timespec __user *cts);
-extern int __compat_put_timespec64(const struct timespec64 *ts64,
-				   struct compat_timespec __user *cts);
-
-int get_compat_itimerspec64(struct itimerspec64 *its,
-			const struct compat_itimerspec __user *uits)
-{
-
-	if (__compat_get_timespec64(&its->it_interval, &uits->it_interval) ||
-	    __compat_get_timespec64(&its->it_value, &uits->it_value))
-		return -EFAULT;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(get_compat_itimerspec64);
-
-int put_compat_itimerspec64(const struct itimerspec64 *its,
-			struct compat_itimerspec __user *uits)
-{
-	if (__compat_put_timespec64(&its->it_interval, &uits->it_interval) ||
-	    __compat_put_timespec64(&its->it_value, &uits->it_value))
-		return -EFAULT;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(put_compat_itimerspec64);
-
 /*
  * We currently only need the following fields from the sigevent
  * structure: sigev_value, sigev_signo, sig_notify and (sometimes
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 4e65916e3d13..c7342e313886 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -957,3 +957,24 @@ int put_itimerspec64(const struct itimerspec64 *it,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(put_itimerspec64);
+
+int get_compat_itimerspec64(struct itimerspec64 *its,
+			const struct compat_itimerspec __user *uits)
+{
+
+	if (__compat_get_timespec64(&its->it_interval, &uits->it_interval) ||
+	    __compat_get_timespec64(&its->it_value, &uits->it_value))
+		return -EFAULT;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(get_compat_itimerspec64);
+
+int put_compat_itimerspec64(const struct itimerspec64 *its,
+			struct compat_itimerspec __user *uits)
+{
+	if (__compat_put_timespec64(&its->it_interval, &uits->it_interval) ||
+	    __compat_put_timespec64(&its->it_value, &uits->it_value))
+		return -EFAULT;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(put_compat_itimerspec64);
-- 
2.17.1

