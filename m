Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2024708-1521833258-2-2203101633150669939
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES caenfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521833258; b=o5DZ7OhP88YSjd8VU07eWysBWirmAt5Nl/GSZbpBSmu0jNz
    yl5LIh6xfIV9RWegal1JXG70fsNO5vloT1U/tf8lrfxj3UkEESAz9HURIYo/VjTC
    5+vK2GJ/iypL8Zm2Hu040EdTu8rZbM1CBKc93hzzELOL/FwJz8XOl04i5wWdheo+
    VpMcyCuSZco93UNBhhblfwl4YFBUSrob0ieX/DFkxXBE7c7jGo7lTkaN3jPIWAeY
    tzyoPeN5zqM34Kw2mIe387dGMpBSNlv+uSwyDetOJZj+xv6UXlzqogmx9uEi4ZtY
    lB2ObHLEU1UyhVsnr4lYGxzYB8gMAFqWlNgQRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521833258;
    bh=eVZjUxR+1crmndowVSMFsS739aVmeGtV94Lm0udYwT8=; b=VIHj+bA4uKoG
    vg7dZyVbTLTE3Dq8S3D3ZRBveJOF9+L+UryZAVAmuOYBrPuLxT1Sc+IWbZ/iWThU
    VfM7pW2GzinrQJ3kGGzRC+bbUlGR5OILCOXoqIGEkg/aHVZF/woKLTSBH/vfIk8E
    JPF21tOO0Vf4RSx3S1w6k5pSp0c9z4w8Yo+PTUWNsfIvPulF5EJTK7AsTX+0ZT54
    SuGdlgo0R1qko85YYjXnKLEIWe6q15oKhy6DwB81s0M7As5N2YwY4W2LNzVSalvB
    mU54XhkmvYBtCA7xjL0/IDt11szGx8DRBF0fY0CUHzIIfNNI1BSI6qyefZnJBWTp
    Q3jWvwc3iA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeCWT0u (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:26:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42511 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbeCWT0s (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 23 Mar 2018 15:26:48 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/2] usb: core: Add USB_QUIRK_DELAY_CTRL_MSG to usbcore quirks
Date: Sat, 24 Mar 2018 03:26:36 +0800
Message-Id: <20180323192636.16586-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180323192636.16586-1-kai.heng.feng@canonical.com>
References: <20180323192636.16586-1-kai.heng.feng@canonical.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's a new quirk, USB_QUIRK_DELAY_CTRL_MSG. Add it to usbcore quirks
for completeness.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 drivers/usb/core/quirks.c                       | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 61ab660f7fdc..a0b4377cb8da 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4454,7 +4454,9 @@
 					calculation);
 				m = USB_QUIRK_DISCONNECT_SUSPEND (Device needs
 					to be disconnected before suspend to
-					prevent spurious wakeup)
+					prevent spurious wakeup);
+				n = USB_QUIRK_DELAY_CTRL_MSG (Device needs a
+					pause after every control message);
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 29e5f32b38df..920f48a49a87 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -124,6 +124,9 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 			case 'm':
 				flags |= USB_QUIRK_DISCONNECT_SUSPEND;
 				break;
+			case 'n':
+				flags |= USB_QUIRK_DELAY_CTRL_MSG;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
-- 
2.15.1

