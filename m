Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325507-2-9601875446498108350
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
    t=1518325506; b=toaLvzVvSvQYcykaaSE/KYcCjcYpWNoTENPhJU1ufM5o+eT
    WhxaFsZPhTsZrcmbB4YCY3OIPiWJbIu603CKN8Q1qcWFULatVT5yaGVlUzzPG1gw
    3bQEWhFQwdQo7Bk6JSKHE06rWqsE7ijGvY1FgzdpOZreskmlee6/HrfyOyHz+kv4
    nNEX0DhUBw5yojmlxCXXr7xBz8n3SLNL73DZh0Tf8qT9muKNsb/bK4waqZSYOvVr
    7RaI47QsQhWQYbJvdPiw07oO85sGjqVdjcoflCCURJ5auz9cMOdSZ/rVt/m4Vynx
    ZRoTwjM2DNIRJfnozN731kobxELvXsJYkXC1jAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325506; bh=bAAQT61YP8gwCQiL5W+
    0DT7tUYypHv0SDvqgiNBY7IA=; b=JsYzsEumTUeedysn5vdJMsDMuhdv81F4SIW
    Sl/iyBDMsUU5ihrqepeQ/ATKg7DlbwJy0ZHiQboEqDQ0Um01wE0v+Z5gt6OvuIOh
    tZE9KHv2Y1tFJvr5yN6CiwRKIXVQvj3u7FqtMoJlhCMvc8t2/jxdWHHpVA4fGoSa
    25X+6VnF50Ur4QhiScjRgLHBtYO9qNg0D9BsxhyABMnAfRHIij0tYzTNol/TRKW1
    aD+F7k6QQuYuz4EYR5vL0XprUlsc1YrVIQ2a2bkEWWuQZbxrloPh3Rrn+YcLHxiw
    DHEAHhr2Ek4g8ANRWV4chy93TXrfJ6wQBo9A3zOvSCXsoYnVi+w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbeBKFEl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:04:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41495 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752675AbeBKEdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:43 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Richard Genoud" <richard.genoud@gmail.com>,
        "Stanislaw Gruszka" <sgruszka@redhat.com>,
        "Kalle Valo" <kvalo@codeaurora.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.426550123@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 33/79] rt2x00usb: mark device removed when get ENOENT
 usb error
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislaw Gruszka <sgruszka@redhat.com>

commit bfa62a52cad93686bb8d8171ea5288813248a7c6 upstream.

ENOENT usb error mean "specified interface or endpoint does not exist or
is not enabled". Mark device not present when we encounter this error
similar like we do with ENODEV error.

Otherwise we can have infinite loop in rt2x00usb_work_rxdone(), because
we remove and put again RX entries to the queue infinitely.

We can have similar situation when submit urb will fail all the time
with other error, so we need consider to limit number of entries
processed by rxdone work. But for now, since the patch fixes
reproducible soft lockup issue on single processor systems
and taken ENOENT error meaning, let apply this fix.

Patch adds additional ENOENT check not only in rx kick routine, but
also on other places where we check for ENODEV error.

Reported-by: Richard Genoud <richard.genoud@gmail.com>
Debugged-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Tested-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 3.2: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/rt2x00/rt2x00usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/rt2x00/rt2x00usb.c
@@ -64,7 +64,7 @@ int rt2x00usb_vendor_request(struct rt2x
 		 * -ENODEV: Device has disappeared, no point continuing.
 		 * All other errors: Try again.
 		 */
-		else if (status == -ENODEV) {
+		else if (status == -ENODEV || status == -ENOENT) {
 			clear_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
 			break;
 		}
@@ -311,7 +311,7 @@ static bool rt2x00usb_kick_tx_entry(stru
 
 	status = usb_submit_urb(entry_priv->urb, GFP_ATOMIC);
 	if (status) {
-		if (status == -ENODEV)
+		if (status == -ENODEV || status == -ENOENT)
 			clear_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
 		set_bit(ENTRY_DATA_IO_FAILED, &entry->flags);
 		rt2x00lib_dmadone(entry);
@@ -400,7 +400,7 @@ static bool rt2x00usb_kick_rx_entry(stru
 
 	status = usb_submit_urb(entry_priv->urb, GFP_ATOMIC);
 	if (status) {
-		if (status == -ENODEV)
+		if (status == -ENODEV || status == -ENOENT)
 			clear_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
 		set_bit(ENTRY_DATA_IO_FAILED, &entry->flags);
 		rt2x00lib_dmadone(entry);
