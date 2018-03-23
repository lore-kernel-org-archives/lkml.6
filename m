Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804774-2-3950567152942934156
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
    t=1521804773; b=WL/zxdPZlj3XMRjw2jRoLB0WjyScz4ZKyr+9fS56HusYCxo
    UDZWJGQWFcxgQkFGPwyNCNY0ZX/U8pt9SPMumEzn3a817pmedq8Kxzny7h7Yi3PW
    TuFe2KUkfMW7Wd7jZsIbGtJwpyD1n1DibnweZyCI3vWy4jvCklZDfl0ZNJBeRK+A
    QVNAxlkenCwQLM+4/6R2A4Hob13ewacfPuJN4Mdx9FazO8qUHGuNxIIaTqQttbHF
    gZktnM4R0y6uh3YUGbVAINoeFUazN2Up9+6hhkHnl7IRj7H6GZQxgOsgnvuaGEq4
    8sWKbl4ICw4kq8BdCzd4aqh8TQF1Cw9HAGyUTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804773; bh=GV1nGJRN6e6ng0sDaExD4+UOA8
    WZiaq1KOFm1t3lE0A=; b=C9qeoAwO/Wtmt6Ne6dV+fPFA7xmg18+UzdR1FPFqct
    LTKKf4OwVjiRe9qr5aTu+l8EChcwHT+VGbjYxtXrYxRCrbMIjJsuZ9vZ8eFebbv5
    8Ln3FDK8swQNrc/tgKwQcyeuVIYM3un1Yq3bntQM60bhMKi2G+vIK/nnPD0qIwED
    jrn8TmiggtZREjRCRiVRN3geyV747JSJiecB4WBWy4v1/wgdIc0rNN9g+3GIZNaL
    tvy5JccgSmkkxxvMZxr684hSSZ0n2VDv1vWjcE8w5GY/0D0Mdy78H8nbkU5/On97
    qHYcYyrGF1yv4RmT7qdX0Rv81f7lrrP6M/ByhIfeP4rA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755086AbeCWKFt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40298 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755081AbeCWKFr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 030/177] iwlwifi: split the handler and the wake parts of the notification infra
Date: Fri, 23 Mar 2018 10:52:38 +0100
Message-Id: <20180323094206.514615728@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>


[ Upstream commit 2220fb2960b72915e7fd9da640a4695dceff238c ]

The notification infrastructure (iwl_notification_wait_*
functions) allows to wait until a list of notifications
will come up from the firmware and to run a special handler
(notif_wait handler) when those are received.

The operation mode notifies the notification infrastructure
about any Rx being received by the mean of
iwl_notification_wait_notify() which will do two things:
1) call the notif_wait handler
2) wakeup the thread that was waiting for the notification

Typically, only after those two steps happened, the
operation mode will run its own handler for the notification
that was received from the firmware. This means that the
thread that was waiting for that notification can be
running before the operation mode's handler was called.

When the operation mode's handler is ASYNC, things get even
worse since the thread that was waiting for the
notification isn't even guaranteed that the ASYNC callback
was added to async_handlers_list before it starts to run.
This means that even calling
iwl_mvm_wait_for_async_handlers() can't guarantee that
absolutely everything related to that notification has run.
The following can happen:

Thread sending the command        Operation mode's Rx path
--------------------------        ------------------------
iwl_init_notification_wait()
iwl_mvm_send_cmd()
                                  iwl_mvm_rx_common()
                                  iwl_notification_wait_notify()
iwl_mvm_wait_for_async_handlers()
// Possibly free some data
// structure
                                  list_add_tail(async_handlers_list);
                                  schedule_work(async_handlers_wk);
                                  // Access the freed structure

Split the 'run notif_wait's handler' and the 'wake up the
thread' parts to fix this. This allows the operation mode
to do the following:

Thread sending the command        Operation mode's Rx path
--------------------------        ------------------------
iwl_init_notification_wait()
iwl_mvm_send_cmd()
                                  iwl_mvm_rx_common()
                                  iwl_notification_wait()
                                  // Will run the notif_wait's handler
                                  list_add_tail(async_handlers_list);
                                  schedule_work(async_handlers_wk);
                                  iwl_notification_notify()
iwl_mvm_wait_for_async_handlers()

This way, the waiter is guaranteed that all the handlers
have been run (if SYNC), or at least enqueued (if ASYNC)
by the time it wakes up.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.c |   10 +++-----
 drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.h |   25 ++++++++++++++++----
 2 files changed, 24 insertions(+), 11 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.c
@@ -76,8 +76,8 @@ void iwl_notification_wait_init(struct i
 }
 IWL_EXPORT_SYMBOL(iwl_notification_wait_init);
 
-void iwl_notification_wait_notify(struct iwl_notif_wait_data *notif_wait,
-				  struct iwl_rx_packet *pkt)
+bool iwl_notification_wait(struct iwl_notif_wait_data *notif_wait,
+			   struct iwl_rx_packet *pkt)
 {
 	bool triggered = false;
 
@@ -118,13 +118,11 @@ void iwl_notification_wait_notify(struct
 			}
 		}
 		spin_unlock(&notif_wait->notif_wait_lock);
-
 	}
 
-	if (triggered)
-		wake_up_all(&notif_wait->notif_waitq);
+	return triggered;
 }
-IWL_EXPORT_SYMBOL(iwl_notification_wait_notify);
+IWL_EXPORT_SYMBOL(iwl_notification_wait);
 
 void iwl_abort_notification_waits(struct iwl_notif_wait_data *notif_wait)
 {
--- a/drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-notif-wait.h
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2015 Intel Deutschland GmbH
+ * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -32,6 +32,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -89,10 +90,10 @@ struct iwl_notif_wait_data {
  *
  * This structure is not used directly, to wait for a
  * notification declare it on the stack, and call
- * iwlagn_init_notification_wait() with appropriate
+ * iwl_init_notification_wait() with appropriate
  * parameters. Then do whatever will cause the ucode
  * to notify the driver, and to wait for that then
- * call iwlagn_wait_notification().
+ * call iwl_wait_notification().
  *
  * Each notification is one-shot. If at some point we
  * need to support multi-shot notifications (which
@@ -114,10 +115,24 @@ struct iwl_notification_wait {
 
 /* caller functions */
 void iwl_notification_wait_init(struct iwl_notif_wait_data *notif_data);
-void iwl_notification_wait_notify(struct iwl_notif_wait_data *notif_data,
-				  struct iwl_rx_packet *pkt);
+bool iwl_notification_wait(struct iwl_notif_wait_data *notif_data,
+			   struct iwl_rx_packet *pkt);
 void iwl_abort_notification_waits(struct iwl_notif_wait_data *notif_data);
 
+static inline void
+iwl_notification_notify(struct iwl_notif_wait_data *notif_data)
+{
+	wake_up_all(&notif_data->notif_waitq);
+}
+
+static inline void
+iwl_notification_wait_notify(struct iwl_notif_wait_data *notif_data,
+			     struct iwl_rx_packet *pkt)
+{
+	if (iwl_notification_wait(notif_data, pkt))
+		iwl_notification_notify(notif_data);
+}
+
 /* user functions */
 void __acquires(wait_entry)
 iwl_init_notification_wait(struct iwl_notif_wait_data *notif_data,
