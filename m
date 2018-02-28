Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834763-2-10663595566970897254
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834763; b=LO8uBkpZFe43Igmd2ubxUtjnNIPhvXa6CmSUEVCjtsE8ekh
    YSe0QdplZatgUbZjo0hEn9T5JFao5umnvM3HPPCvkEYuoFU0kunfkHkCvJ7cupaK
    9KKwZQphoD1BBqEL05oElOsN5WKH3pMCh39W30mMvcNb1LlPPy6WXEeN5Fh0CrMr
    Cja0q0IrwHDBz9XdY1iI27rwSxI8TrvOI5V0sgqYkZ01wnClm8Zn8HNUc3Zd0Ir5
    5NCktnsKb6lY5CYG+SU8w+TFYdQQk+ckmocsG5BjbksVIO1MDliopeSFEZIYJNPw
    vUvZchkv1lWgjOYfI3GZowS1QqFtkoIW/Rhom4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834763; bh=UM7BHowCip/1HYZrkyT
    NwaEkO+LQI/D5DyUenLim6r0=; b=NZ2MgzNObhoAi2Iett+UfNu6IlIMnhuv6Hi
    aMCbD7lxb35X9dXzR8kiB0v6pSsxD3LeKCSgDD0VBHDxasycwhOsRhZ+L8yfzpiT
    kOoHmD1OgahkCN/RGy6NtQIB7tM9hwZRP4rD6IBSb70ITKfllQRP4Zbw1KaD/cRd
    HTvB1d3A91eXwdUqKPGbXMBOJnehKArjf3hRrU/CwWmUGyFjKiApS0K6qtn91pLf
    rf7DHHiIyyEeMsGMBK69QoHnhv+QUnuPEPjtpFG/AlGQ9IW1GT+1RQ0BCO1VrpGR
    DDvW/9vv4suG2WZaf+liiOOGr/0qu16ORgTv+wBo58aTa68oYbQ==
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
        id S933036AbeB1QR7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:17:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35273 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932298AbeB1QR5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:17:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.44380173@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 046/254] xhci: Don't show incorrect WARN message
 about events for empty rings
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit e4ec40ec4b260efcca15089de4285a0a3411259b upstream.

xHC can generate two events for a short transfer if the short TRB and
last TRB in the TD are not the same TRB.

The driver will handle the TD after the first short event, and remove
it from its internal list. Driver then incorrectly prints a warning
for the second event:

"WARN Event TRB for slot x ep y with no TDs queued"

Fix this by not printing a warning if we get a event on a empty list
if the previous event was a short event.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/xhci-ring.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2442,12 +2442,16 @@ static int handle_tx_event(struct xhci_h
 		 */
 		if (list_empty(&ep_ring->td_list)) {
 			/*
-			 * A stopped endpoint may generate an extra completion
-			 * event if the device was suspended.  Don't print
-			 * warnings.
+			 * Don't print wanings if it's due to a stopped endpoint
+			 * generating an extra completion event if the device
+			 * was suspended. Or, a event for the last TRB of a
+			 * short TD we already got a short event for.
+			 * The short TD is already removed from the TD list.
 			 */
+
 			if (!(trb_comp_code == COMP_STOP ||
-						trb_comp_code == COMP_STOP_INVAL)) {
+			      trb_comp_code == COMP_STOP_INVAL ||
+			      ep_ring->last_td_was_short)) {
 				xhci_warn(xhci, "WARN Event TRB for slot %d ep %d with no TDs queued?\n",
 						TRB_TO_SLOT_ID(le32_to_cpu(event->flags)),
 						ep_index);
