Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1047503-1519204550-2-16006728333015778473
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519204550; b=b4tFpnQcvCg/2E/3HjjbgTheCib61VQUIa+wIXZK23kvgjL
    AhxPIX2jjIg6KXHbk4Oj3QxLmZGMCCbPOhlNfxOf0UpSqx4m/3WFLCcoEorGS9lf
    iCn6vojcS0vSGUW2ln2LxY3HnUTGG8aXyPIkVQUhfcXpTZJk83Bfr4ZMev7zjlfs
    /du2H6BAtfnigLEgZZq2tMwd8fYFMzehRO2OxYwTe09s+Ujah8DVRueOLvS2V8zj
    J+53fZahKPCUPW3THDkZRU+veE6yShChDWpMT66KRofLu8TNNepwwz3/y3UCQLL1
    E6KvkkTy17kwM1BICxCIAv3SV/Z2TJQMbbLcpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519204550; bh=VQpgG7ASSAlymaDYObKPZI4qeZ
    OeKJxkF+SNgyF5m7w=; b=uaFDbjMwlakT6sajRe3GS9D4hT/Df8RV0eFoX8BL/4
    LL4+aG8pSthwhRxl2e9SyrmwdYV0whUiZVvnXuxCIDWWKMYysEWPHskEUTF+5PXJ
    W6kBQr1XA6mVjmeVfbjBPz9KCxgK7HtoOsmV408ZNzTYHj4RzcjCwcC30oMdOpwA
    whoMcA2F880vxkjzUwqjo6mMIisSYJIsw4y0JvH5a5FlWZLimIit2wJRrYqkwKDq
    iyD0UH+5Zx0nh/O1GzackZ+CvepweNspSMuFpc79JfouaHintkKygc6ALMXr5gDq
    UBRjzIp04kk3iyYlBhxaX03lBLu6Fhz/ip2+Stn2/73g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=HA0dtqEa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=HA0dtqEa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeBUJPp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 04:15:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbeBUJPP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 04:15:15 -0500
Date: Wed, 21 Feb 2018 10:15:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, linux-audit@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, rgb@redhat.com
Subject: Re: [PATCH 4.10 070/111] audit: fix auditd/kernel connection state
 tracking
Message-ID: <20180221091503.GK25181@hirez.programming.kicks-ass.net>
References: <20170328122915.640228468@linuxfoundation.org>
 <20170328122918.597715642@linuxfoundation.org>
 <20180220123757.GE25314@hirez.programming.kicks-ass.net>
 <CAHC9VhTOxzcJpVSFDign56jkkruQjujTp7GQzk107FNWYTXRYg@mail.gmail.com>
 <20180220140640.GE25201@hirez.programming.kicks-ass.net>
 <CAHC9VhS40=qNxjNJSBqz2GwrqrvTqLKpdOWUrJ5iUDFp8ERO-A@mail.gmail.com>
 <20180220151849.GG25201@hirez.programming.kicks-ass.net>
 <CAHC9VhQUGF+W0sZemeCstPDUHxwQrD7Pmbu5SnAHZVdkCPdMwg@mail.gmail.com>
 <20180221084601.scnvgiiv32s2pgye@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221084601.scnvgiiv32s2pgye@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 09:46:02AM +0100, Ingo Molnar wrote:
> AFAICS the primary problem appears to be this code path:
> 
>   audit_receive() -> audit_receive_msg() -> AUDIT_TTY_SET -> audit_log_common_recv_msg() -> audit_log_start()
> 
> where we can arrive already holding the lock.
> 
> I.e. recursive mutex, kinda.

I _think_ something like the below ought to work, but I've no idea how
to even begin testing audit.

---
 kernel/audit.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 227db99b0f19..24175754f79d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -184,6 +184,9 @@ static char *audit_feature_names[2] = {
 /* Serialize requests from userspace. */
 DEFINE_MUTEX(audit_cmd_mutex);
 
+static struct audit_buffer *__audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
+				     int type, bool recursive);
+
 /* AUDIT_BUFSIZ is the size of the temporary buffer used for formatting
  * audit records.  Since printk uses a 1024 byte buffer, this buffer
  * should be at least that large. */
@@ -357,7 +360,7 @@ static int audit_log_config_change(char *function_name, u32 new, u32 old,
 	struct audit_buffer *ab;
 	int rc = 0;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
+	ab = __audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE, true);
 	if (unlikely(!ab))
 		return rc;
 	audit_log_format(ab, "%s=%u old=%u", function_name, new, old);
@@ -1024,7 +1027,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
 		return;
 	}
 
-	*ab = audit_log_start(NULL, GFP_KERNEL, msg_type);
+	*ab = __audit_log_start(NULL, GFP_KERNEL, msg_type, true);
 	if (unlikely(!*ab))
 		return;
 	audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
@@ -1057,7 +1060,7 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
 	if (audit_enabled == AUDIT_OFF)
 		return;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
+	ab = __audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE, true);
 	audit_log_task_info(ab, current);
 	audit_log_format(ab, " feature=%s old=%u new=%u old_lock=%u new_lock=%u res=%d",
 			 audit_feature_names[which], !!old_feature, !!new_feature,
@@ -1578,6 +1581,12 @@ static int __init audit_enable(char *str)
 
 	if (audit_default == AUDIT_OFF)
 		audit_initialized = AUDIT_DISABLED;
+	/*
+	 * Normally audit_set_enabled() would need to be called under
+	 * @audit_cmd_mutex, however since audit_do_config_change() will not in
+	 * fact call audit_log_config_change() when 'audit_enabled ==
+	 * AUDIT_OFF', we can use it here without issue.
+	 */
 	if (audit_set_enabled(audit_default))
 		panic("audit: error setting audit state (%d)\n", audit_default);
 
@@ -1690,8 +1699,8 @@ static inline void audit_get_stamp(struct audit_context *ctx,
  * will be written at syscall exit.  If there is no associated task, then
  * task context (ctx) should be NULL.
  */
-struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
-				     int type)
+static struct audit_buffer *__audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
+				     int type, bool recursive)
 {
 	struct audit_buffer *ab;
 	struct timespec64 t;
@@ -1703,6 +1712,9 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 	if (unlikely(!audit_filter(type, AUDIT_FILTER_TYPE)))
 		return NULL;
 
+	if (recursive)
+		lockdep_assert_held(&audit_cmd_mutex);
+
 	/* NOTE: don't ever fail/sleep on these two conditions:
 	 * 1. auditd generated record - since we need auditd to drain the
 	 *    queue; also, when we are checking for auditd, compare PIDs using
@@ -1710,8 +1722,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 	 *    using a PID anchored in the caller's namespace
 	 * 2. generator holding the audit_cmd_mutex - we don't want to block
 	 *    while holding the mutex */
-	if (!(auditd_test_task(current) ||
-	      (current == __mutex_owner(&audit_cmd_mutex)))) {
+	if (!(auditd_test_task(current) || recursive)) {
 		long stime = audit_backlog_wait_time;
 
 		while (audit_backlog_limit &&
@@ -1753,6 +1764,12 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 	return ab;
 }
 
+struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
+				     int type)
+{
+	return __audit_log_start(ctx, gfp_mask, type, false);
+}
+
 /**
  * audit_expand - expand skb in the audit buffer
  * @ab: audit_buffer
