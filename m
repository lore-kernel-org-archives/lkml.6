Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1528667-1518062132-2-13008432745889479374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518062131; b=BIjm7EFnL1jkxUqtsierVJEed66loJA+YjJtEdUNiJX9R3U
    ftO+alREqbf5t5Dy7ocEe6nWxKnNm7dDi4CGNPHKQAweu4KHTeTUzyt+VkL5S+vw
    EBGu5SRFaMvJs7tWMjQLlMT5TT/a7k4cmZjnp2dX5/yAYSdb2bTvDm6VEL3RxKC8
    2kyV/M+Ae+8B1Qf1WQ/DMNuCTtMJcwebrBUxglBLL6YqUCMrZBCuoV5S+Crprd9c
    x0gWRIkmY9e6pljcX2mtlrm/6A8NZdxNYsLURu9lnV1AtZRxfcme3zFqLEmgrlZq
    767LgXUGZNVqESODQ6aSI00xJd7rVAw+ECf/YyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518062131; bh=JNdWJHIRr3ZEN2AvaLxTTYUd5C
    4+242U+pIzOJe+xdk=; b=vDVdk+hqBH1VPDazxVCI5Vyh067UehFbjtlOs3w+DS
    r1Rdy6G7TjU2WnjDNLUvlvxWio/XZiP4D3/k8t5rEjQvM2sienudTsidW/A+1g6I
    dKibOb4xfX+UafNlWYov4iHy+ohXckl3tolSokffS2bYT4nQjyhCIu/bnpiMqVKj
    WAFpuZq5YzEKoUfRWmJ0A6dCPpNakfLWT8cY6l82qciYS/dxc5LVw9boOdorQEjG
    zKUhMxi59hl8YkBlckZuS+9C80GKVOcbd+sUv8VnA2FHRj4AtT9FJd9MnePKCcD5
    0P/jVexe5W/Cbk3kF3ozWk0wcTb9PH7Rh4LBkEgopSwg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeBHDzQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 22:55:16 -0500
Received: from regular1.263xmail.com ([211.150.99.137]:59924 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeBHDzP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Feb 2018 22:55:15 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <33bbeb5ba0bb29ada95c25479af84076>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: briannorris@chromium.org, stern@rowland.harvard.edu,
        mka@chromium.org, dianders@chromium.org,
        AMAN DEEP <aman.deep@samsung.com>, stable@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH v6] usb: ohci: Proper handling of ed_rm_list to handle race condition between usb_kill_urb() and finish_unlinks()
Date: Thu,  8 Feb 2018 11:55:01 +0800
Message-Id: <20180208035501.10711-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: AMAN DEEP <aman.deep@samsung.com>

There is a race condition between finish_unlinks->finish_urb() function
and usb_kill_urb() in ohci controller case. The finish_urb calls
spin_unlock(&ohci->lock) before usb_hcd_giveback_urb() function call,
then if during this time, usb_kill_urb is called for another endpoint,
then new ed will be added to ed_rm_list at beginning for unlink, and
ed_rm_list will point to newly added.

When finish_urb() is completed in finish_unlinks() and ed->td_list
becomes empty as in below code (in finish_unlinks() function):

        if (list_empty(&ed->td_list)) {
                *last = ed->ed_next;
                ed->ed_next = NULL;
        } else if (ohci->rh_state == OHCI_RH_RUNNING) {
                *last = ed->ed_next;
                ed->ed_next = NULL;
                ed_schedule(ohci, ed);
        }

The *last = ed->ed_next will make ed_rm_list to point to ed->ed_next
and previously added ed by usb_kill_urb will be left unreferenced by
ed_rm_list. This causes usb_kill_urb() hang forever waiting for
finish_unlink to remove added ed from ed_rm_list.

The main reason for hang in this race condtion is addition and removal
of ed from ed_rm_list in the beginning during usb_kill_urb and later
last* is modified in finish_unlinks().

As suggested by Alan Stern, the solution for proper handling of
ohci->ed_rm_list is to remove ed from the ed_rm_list before finishing
any URBs. Then at the end, we can add ed back to the list if necessary.

This properly handle the updated ohci->ed_rm_list in usb_kill_urb().

Fixes: 977dcfdc6031 ("USB: OHCI: don't lose track of EDs when a controller dies")
Acked-by: Alan Stern <stern@rowland.harvard.edu>
CC: <stable@vger.kernel.org>
Signed-off-by: Aman Deep <aman.deep@samsung.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v6:
This is a resend of Aman Deep's v5 patch [0], which solved the hang we
hit [1]. (Thanks Aman :)

The v5 has some format issues, so i slightly adjust the commit message.

[0] https://www.spinics.net/lists/linux-usb/msg129010.html
[1] https://bugs.chromium.org/p/chromium/issues/detail?id=803749

 drivers/usb/host/ohci-q.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
index b2ec8c399363..4ccb85a67bb3 100644
--- a/drivers/usb/host/ohci-q.c
+++ b/drivers/usb/host/ohci-q.c
@@ -1019,6 +1019,8 @@ static void finish_unlinks(struct ohci_hcd *ohci)
 		 * have modified this list.  normally it's just prepending
 		 * entries (which we'd ignore), but paranoia won't hurt.
 		 */
+		*last = ed->ed_next;
+		ed->ed_next = NULL;
 		modified = 0;
 
 		/* unlink urbs as requested, but rescan the list after
@@ -1077,21 +1079,22 @@ static void finish_unlinks(struct ohci_hcd *ohci)
 			goto rescan_this;
 
 		/*
-		 * If no TDs are queued, take ED off the ed_rm_list.
+		 * If no TDs are queued, ED is now idle.
 		 * Otherwise, if the HC is running, reschedule.
-		 * If not, leave it on the list for further dequeues.
+		 * If the HC isn't running, add ED back to the
+		 * start of the list for later processing.
 		 */
 		if (list_empty(&ed->td_list)) {
-			*last = ed->ed_next;
-			ed->ed_next = NULL;
 			ed->state = ED_IDLE;
 			list_del(&ed->in_use_list);
 		} else if (ohci->rh_state == OHCI_RH_RUNNING) {
-			*last = ed->ed_next;
-			ed->ed_next = NULL;
 			ed_schedule(ohci, ed);
 		} else {
-			last = &ed->ed_next;
+			ed->ed_next = ohci->ed_rm_list;
+			ohci->ed_rm_list = ed;
+			/* Don't loop on the same ED */
+			if (last == &ohci->ed_rm_list)
+				last = &ed->ed_next;
 		}
 
 		if (modified)
-- 
2.11.0


