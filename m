Return-Path: <SRS0=gsCl=F4=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-891914-1520357738-2-9133569879203517573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=gsCl=F4=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520357738; b=kzugHwrW7KeIkGrfnIBmRDWGxuzp795zyioJ0mFDL/FURMx
    NtIPHTq3Qbz1RCmrXOMJhYSjzsX/mBo2l0PPciqH6gqEkYoGBc4wfSt2awwVDKMq
    mivDqj/WGzUqQcbg1vg8DDpMAiDRNDxrp/2vxmZjziTuuPNcWjtgnMSdCdQBjUS0
    dV74S5ngaQ1RIB+mGgx9ao56LMKH2bve9qDyGkhvR1UeWyCBYGMRwYO2tYbBjJdV
    SJcxWSNUMMkzDtN3uQUnldu7ndoW5Poo7prIwXbWRFxs/FbKchotd2MyoyD/883m
    DdV7GMgnyr1dQqK02POOJW0L1Lu7THNb4MvDOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1520357738; bh=3CyxaJO8E+X
    TkBdfgxgAHHS+kn0i2yjWoH7HjmfplFY=; b=PNaoLeBH6HP0pJOWcNj31nBEbVe
    SSl6ai/vtimEnO0H4Ee4kIP7hBTrP/o92DUfMJtYtFyb8kbPG7ZUM/sxmeJfsMfe
    R5KvATEhU9Q2k0Y/0qa14HRN4kwnvju2kk6xCEal0TQVLLf5wVh6UGKmhIFVHKYc
    6ZCrnzHTKaLBmdyJSzWTJHpGu2+nQ2u2bkRpIy7XpgdKqDRDE4WTMdCU3VK+k3F+
    +lxsu0zzwE9c91+mmDeO4b7MaJrwwIL9ZHgBGiRWjiTvZPuGursdHHr0KPZuHxOp
    PYOxUSSgGtuM2HPpwA9FUmGBXOpN1Lzt9HwP84ZyKNhNos/HIOtRoi4a8sQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=htUYcz24 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m7sNfHHT;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=htUYcz24 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=m7sNfHHT;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3FD20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELuT+az+hzSxv3UfaW671jo8MOocH4XsFdQVQVmtxw6/zF/gs7yQQAxeILfvzSd4vD2sHhB3fw==
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	jannh@google.com,
	paulmck@linux.vnet.ibm.com,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com
Cc: security@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@fb.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/7] percpu_ref: Update doc to dissuade users from depending on internal RCU grace periods
Date: Tue,  6 Mar 2018 09:33:15 -0800
Message-Id: <20180306173316.3088458-6-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180306173316.3088458-1-tj@kernel.org>
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

percpu_ref internally uses sched-RCU to implement the percpu -> atomic
mode switching and the documentation suggested that this could be
depended upon.  This doesn't seem like a good idea.

* percpu_ref uses sched-RCU which has different grace periods regular
  RCU.  Users may combine percpu_ref with regular RCU usage and
  incorrectly believe that regular RCU grace periods are performed by
  percpu_ref.  This can lead to, for example, use-after-free due to
  premature freeing.

* percpu_ref has a grace period when switching from percpu to atomic
  mode.  It doesn't have one between the last put and release.  This
  distinction is subtle and can lead to surprising bugs.

* percpu_ref allows starting in and switching to atomic mode manually
  for debugging and other purposes.  This means that there may not be
  any grace periods from kill to release.

This patch makes it clear that the grace periods are percpu_ref's
internal implementation detail and can't be depended upon by the
users.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/percpu-refcount.h | 18 ++++++++++++------
 lib/percpu-refcount.c           |  2 ++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 864d167..009cdf3 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -30,10 +30,14 @@
  * calls io_destroy() or the process exits.
  *
  * In the aio code, kill_ioctx() is called when we wish to destroy a kioctx; it
- * calls percpu_ref_kill(), then hlist_del_rcu() and synchronize_rcu() to remove
- * the kioctx from the proccess's list of kioctxs - after that, there can't be
- * any new users of the kioctx (from lookup_ioctx()) and it's then safe to drop
- * the initial ref with percpu_ref_put().
+ * removes the kioctx from the proccess's table of kioctxs and kills percpu_ref.
+ * After that, there can't be any new users of the kioctx (from lookup_ioctx())
+ * and it's then safe to drop the initial ref with percpu_ref_put().
+ *
+ * Note that the free path, free_ioctx(), needs to go through explicit call_rcu()
+ * to synchronize with RCU protected lookup_ioctx().  percpu_ref operations don't
+ * imply RCU grace periods of any kind and if a user wants to combine percpu_ref
+ * with RCU protection, it must be done explicitly.
  *
  * Code that does a two stage shutdown like this often needs some kind of
  * explicit synchronization to ensure the initial refcount can only be dropped
@@ -113,8 +117,10 @@ void percpu_ref_reinit(struct percpu_ref *ref);
  * Must be used to drop the initial ref on a percpu refcount; must be called
  * precisely once before shutdown.
  *
- * Puts @ref in non percpu mode, then does a call_rcu() before gathering up the
- * percpu counters and dropping the initial ref.
+ * Switches @ref into atomic mode before gathering up the percpu counters
+ * and dropping the initial ref.
+ *
+ * There are no implied RCU grace periods between kill and release.
  */
 static inline void percpu_ref_kill(struct percpu_ref *ref)
 {
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 30e7dd8..9f96fa7 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -322,6 +322,8 @@ EXPORT_SYMBOL_GPL(percpu_ref_switch_to_percpu);
  * This function normally doesn't block and can be called from any context
  * but it may block if @confirm_kill is specified and @ref is in the
  * process of switching to atomic mode by percpu_ref_switch_to_atomic().
+ *
+ * There are no implied RCU grace periods between kill and release.
  */
 void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 				 percpu_ref_func_t *confirm_kill)
-- 
2.9.5
