Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520954983-2-9275289266517821680
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520954982; b=CZ7slycms01fYVXCSyr91kCpqPk7lVw9MoQY9HhjdFXq3cq
    DujhRCEy+EGLhnpvq4Hiz1hIhkoaqW96QMuLlYv6j04EG1AhCS7aXdJOUEmymjil
    piciWIrmkMtMMoFNUasHLMBjRehDY0xQlI28ppU3d6CfXFTpfw8udb5jIzrUmFO0
    iwsZuDghMpNXqA7Tr0oHzdHf179KyJrjkmzsj3R7Ce+NyOox6WwE180+dXiNEswN
    nyJQM0Oxcai0xGVooO/8ARPdPEEUzilOkxxsHOrtEegmbc+EIm8K7XRxMmluqjq3
    2GCsYJZ6mrrc2ieJAAvV5EvalpBgO2bqOXAQqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520954982; bh=lBwtu8HQTl0L6lfDdsiR6VIU2w
    heaD1cxKFqDzDyWK0=; b=JuEI1gnVoP6y1AC4ZWlky+8B+ZY/7ZLBT9kFTnemPh
    QnasLa7kSo4viTAUGsJN4M2jQGcBCW0RBzVngTEHaD8iol6OXQf44glJm6RX6m5z
    tDfN5f89m8Y1fhEt49Mkqj7VZ7fwtElVC8Cm3zXz3KmjsEY9QwjhYC0dqh0lPZCT
    QWtrRRBAPFgrH4XRj19s0h8BmN6aRyRwEitdrKxcGne3xgu3R6Onj/HAg8ChEPpK
    MJjxtetjPXMMzueps0Dc1FpTszw56dQILu0xAsQPGXdVkoCD6jqsLR4Q33+nd9Zo
    IWBpVJWQujr4NeIAI/nJEZ0G+73ZDjYOEBY4nL4L+tZA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932951AbeCMP3k (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:29:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932995AbeCMP3j (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:29:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tejun Heo <tj@kernel.org>, Lyude Paul <lyude@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 4.15 020/146] workqueue: Allow retrieval of current tasks work struct
Date: Tue, 13 Mar 2018 16:23:07 +0100
Message-Id: <20180313152322.037126532@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 27d4ee03078aba88c5e07dcc4917e8d01d046f38 upstream.

Introduce a helper to retrieve the current task's work struct if it is
a workqueue worker.

This allows us to fix a long-standing deadlock in several DRM drivers
wherein the ->runtime_suspend callback waits for a specific worker to
finish and that worker in turn calls a function which waits for runtime
suspend to finish.  That function is invoked from multiple call sites
and waiting for runtime suspend to finish is the correct thing to do
except if it's executing in the context of the worker.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Link: https://patchwork.freedesktop.org/patch/msgid/2d8f603074131eb87e588d2b803a71765bd3a2fd.1518338788.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/workqueue.h |    1 +
 kernel/workqueue.c        |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -465,6 +465,7 @@ extern bool cancel_delayed_work_sync(str
 
 extern void workqueue_set_max_active(struct workqueue_struct *wq,
 				     int max_active);
+extern struct work_struct *current_work(void);
 extern bool current_is_workqueue_rescuer(void);
 extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
 extern unsigned int work_busy(struct work_struct *work);
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4169,6 +4169,22 @@ void workqueue_set_max_active(struct wor
 EXPORT_SYMBOL_GPL(workqueue_set_max_active);
 
 /**
+ * current_work - retrieve %current task's work struct
+ *
+ * Determine if %current task is a workqueue worker and what it's working on.
+ * Useful to find out the context that the %current task is running in.
+ *
+ * Return: work struct if %current task is a workqueue worker, %NULL otherwise.
+ */
+struct work_struct *current_work(void)
+{
+	struct worker *worker = current_wq_worker();
+
+	return worker ? worker->current_work : NULL;
+}
+EXPORT_SYMBOL(current_work);
+
+/**
  * current_is_workqueue_rescuer - is %current workqueue rescuer?
  *
  * Determine whether %current is a workqueue rescuer.  Can be used from
