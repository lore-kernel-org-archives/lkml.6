Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719322-2-5859146388646965832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719321; b=NRd/3OcmnXNfv3UQhFnqLD2f3foU2bI0f92Jd324cvON77H
    R7bNmyYwNQJTnIPIHmzcBIdCoiw5ObupDOTlwAE0aGGYFuY0ov91VVWzdaJmx1mk
    E/OaH9nKmKCNNOpiSOgB8xvhGmz8T7tOWmRnpKUznmVi61tapsgdKXhkLVTPa2Dh
    4KMcFpg4q2pBos6zMKlOBTsCYNEyzK2Emph84/zECQFjDaNIJqSWlSycl/SHGDFI
    0eaHq1lChQhgph6n+iw1tpeIE4LhDXFYxsQG4oiRhXXUgFnwXVtOYq9tWJFwgnJS
    ixJSuy/KymAM4EsxyXDQPv0dicDHkSb62qwI7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719321; bh=0jvdFlRDr6OiE7IsBx8eRWg9dL
    C4sx92R9PjJ+CghwA=; b=UXhmdHlFMLVl2LY9b1dtZlL+/6tpn+9m9iB+4bnquL
    oBftR1M9FyoU/k/XxT25zNcKmSb7FJD8bowpdxp7FI2CCAwOo7Qo69lnkvlZxkvn
    pnScJS2aVB7Vq+9xYQSmd0JKidyI0P5EakdExOuwOvDoXqr0FH1MM6IPqMkyIrSM
    kl0ZTKVWiUe0JdrbuJPsWZrg9AXZ+S0WXlVBcIxXqmwqESmlp82XlPvJH4RYImmk
    PXTCWbL2tCp8rcRksAE8VIeZClheMPSN+WKTfHIzIi7A8xpFG9mISS8Mxu3/gdWT
    bnq6J9RxeIc4XUyAQhNVhOBqSmdOYuyOsFWM5m+uZ9qA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163191AbeBOS2Z (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:28:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163184AbeBOPZ2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:25:28 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.4 094/108] Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"
Date: Thu, 15 Feb 2018 16:17:31 +0100
Message-Id: <20180215151235.503138018@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 7d06d5895c159f64c46560dc258e553ad8670fe0 upstream.

This reverts commit fd865802c66bc451dc515ed89360f84376ce1a56.

This commit causes a regression on some QCA ROME chips. The USB device
reset happens in btusb_open(), hence firmware loading gets interrupted.

Furthermore, this commit stops working after commit
("a0085f2510e8976614ad8f766b209448b385492f Bluetooth: btusb: driver to
enable the usb-wakeup feature"). Reset-resume quirk only gets enabled in
btusb_suspend() when it's not a wakeup source.

If we really want to reset the USB device, we need to do it before
btusb_open(). Let's handle it in drivers/usb/core/quirks.c.

Cc: Leif Liddy <leif.linux@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Daniel Drake <drake@endlessm.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2969,12 +2969,6 @@ static int btusb_probe(struct usb_interf
 	if (id->driver_info & BTUSB_QCA_ROME) {
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
-
-		/* QCA Rome devices lose their updated firmware over suspend,
-		 * but the USB hub doesn't notice any status change.
-		 * Explicitly request a device reset on resume.
-		 */
-		set_bit(BTUSB_RESET_RESUME, &data->flags);
 	}
 
 #ifdef CONFIG_BT_HCIBTUSB_RTL
