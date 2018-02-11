Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325115-2-15544074209782126358
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325114; b=nELOkCQKx393Ht8up9CnXNmC2pmig7NNfQZSwlYtksv++5Q
    q7xUfYJCAjyu6pRLfZu8XXwHip2hVV2BRct8nxt8+sHqeRrmvPW8VFwhnJbnCdUc
    oomiOc6EtU9W1oMlbSVw1YwxRBgW7+0imkkGDTSAXxF0PYnxUUA/cNJUNRyxD24J
    yxW4FVyMe0PmzHPhXLeU1nODlWDMyWvIegts2S69H5l1oTeBuWDcyUrEPMXyKCrN
    hlh5NrF8kJk1TugAsfWOh52mF6MJFV1DKCe0Q5S9hOexAcjhTEGpsK9fXJohl5DC
    1HG77DrwIVkDzsVVnpg0nBp6w+13foejGqhmLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325114; bh=k6YdINCHCTm1o+HNO3p
    ap+/9nmzjeM0i5lsZi9hJYcs=; b=Wt3M5S+XXFtZwQZWbOZJXugw9odkWE7pWig
    hnPHSWRuNBRnnwAAcZwAw13nDg1Z5yrC5oKK5ziNtCs+ggTwlN1wsx4nDU3KLIwS
    Mvih57eludmygKDIiTrALgn0Q2SQhPtshpp4cBpO1X19Asfwi+y3aOJpKfvOn0f7
    GsEbUuevmCob3prAqMLXbWZS+wZhUK9Ye/Ho9fv0L40/MaWQkGY0IaQyHuqCtCof
    +JNYHZVViJd5P9kQZrrJrw54kchBtOJLGl9KZe6fEX6/6C/EyC4n8Ed5BbX3rHYl
    wm9CAwdcl9BiDAwvOhANJcDr8k699lfdEpKHjnunCV6ynWVfuRw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeBKE6F (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:58:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41672 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752781AbeBKEd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Christian Lamparter" <chunkeey@googlemail.com>,
        "Kalle Valo" <kvalo@codeaurora.org>,
        "Andrey Konovalov" <andreyknvl@google.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.998044846@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 015/136] p54: don't unregister leds when they are not
 initialized
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Konovalov <andreyknvl@google.com>

commit fc09785de0a364427a5df63d703bae9a306ed116 upstream.

ieee80211_register_hw() in p54_register_common() may fail and leds won't
get initialized. Currently p54_unregister_common() doesn't check that and
always calls p54_unregister_leds(). The fix is to check priv->registered
flag before calling p54_unregister_leds().

Found by syzkaller.

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 1 PID: 1404 Comm: kworker/1:1 Not tainted
4.14.0-rc1-42251-gebb2c2437d80-dirty #205
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:16
 dump_stack+0x292/0x395 lib/dump_stack.c:52
 register_lock_class+0x6c4/0x1a00 kernel/locking/lockdep.c:769
 __lock_acquire+0x27e/0x4550 kernel/locking/lockdep.c:3385
 lock_acquire+0x259/0x620 kernel/locking/lockdep.c:4002
 flush_work+0xf0/0x8c0 kernel/workqueue.c:2886
 __cancel_work_timer+0x51d/0x870 kernel/workqueue.c:2961
 cancel_delayed_work_sync+0x1f/0x30 kernel/workqueue.c:3081
 p54_unregister_leds+0x6c/0xc0 drivers/net/wireless/intersil/p54/led.c:160
 p54_unregister_common+0x3d/0xb0 drivers/net/wireless/intersil/p54/main.c:856
 p54u_disconnect+0x86/0x120 drivers/net/wireless/intersil/p54/p54usb.c:1073
 usb_unbind_interface+0x21c/0xa90 drivers/usb/core/driver.c:423
 __device_release_driver drivers/base/dd.c:861
 device_release_driver_internal+0x4f4/0x5c0 drivers/base/dd.c:893
 device_release_driver+0x1e/0x30 drivers/base/dd.c:918
 bus_remove_device+0x2f4/0x4b0 drivers/base/bus.c:565
 device_del+0x5c4/0xab0 drivers/base/core.c:1985
 usb_disable_device+0x1e9/0x680 drivers/usb/core/message.c:1170
 usb_disconnect+0x260/0x7a0 drivers/usb/core/hub.c:2124
 hub_port_connect drivers/usb/core/hub.c:4754
 hub_port_connect_change drivers/usb/core/hub.c:5009
 port_event drivers/usb/core/hub.c:5115
 hub_event+0x1318/0x3740 drivers/usb/core/hub.c:5195
 process_one_work+0xc7f/0x1db0 kernel/workqueue.c:2119
 process_scheduled_works kernel/workqueue.c:2179
 worker_thread+0xb2b/0x1850 kernel/workqueue.c:2255
 kthread+0x3a1/0x470 kernel/kthread.c:231
 ret_from_fork+0x2a/0x40 arch/x86/entry/entry_64.S:431

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/p54/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/p54/main.c
+++ b/drivers/net/wireless/p54/main.c
@@ -851,12 +851,11 @@ void p54_unregister_common(struct ieee80
 {
 	struct p54_common *priv = dev->priv;
 
-#ifdef CONFIG_P54_LEDS
-	p54_unregister_leds(priv);
-#endif /* CONFIG_P54_LEDS */
-
 	if (priv->registered) {
 		priv->registered = false;
+#ifdef CONFIG_P54_LEDS
+		p54_unregister_leds(priv);
+#endif /* CONFIG_P54_LEDS */
 		ieee80211_unregister_hw(dev);
 	}
 
