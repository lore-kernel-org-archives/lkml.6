Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836280-2-7331748437481613057
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836279; b=wTCUFLdLMpIlqczXYPhhGjqWGER67ERKWih86ekHHv4ZNAM
    ak0SiJM59EwMMmqDCA8jsa0FShurTL3B6QA4CP8b46+N1rjigtvsadNM5DwxDBvc
    AuU5eRTzlT7yNv3siKwJlxEPvKA0Vgk9PhwuHwwWhJrVDtFbBiUYbHs0kJYopwV/
    tOYNmRFTjqEi0uZAY2dnXumo7QjEyaAcsFCDyg/JYzh9Zo/q7YRFqpi53ewpBeGc
    uAwkO49kulADQE8gLyAZJhO0I/mhjdEpExl3KL4/W4YnCHZHVdTCRWsIDH4eGxRG
    zvuySTZ1tmaWTDXgML5/VjxYNDRH93f96gAGbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836279; bh=TBZVkS9G05Uc15L1j+g
    r7zLmcglftkEbgOEBZdzwawI=; b=DgzhrdyXNW/t9p2f6cTs24F1A67okWiw7Wl
    NODzYP/V6YOPpl+1bPf0G42CZud9a5QbxXCWbkp0ARu9BPHOzHlqUU6/IjHVis7F
    tQdCfcIPohsOffoSr1zwNFYMp2IYtTf9dAOWp2dGgN7fqELHxGZTe4q5FW7orbQA
    n8sI+bK2/rIop3iBQY0LOEq8vtSNXPt+XrnEgc/8HimLwfpjxKUo8MLOiQdHWBMC
    7i7Xyu8ES/akWaCNuHuqndr9K1AILFxkbePCrHgtquDNAievmLZhk71YUfLlIuhi
    ZfIiDqd1zA3NXkAaffJCorCQnek2rm8Gbf8A/N8SBg+4gh08eUg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932088AbeB1QAl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:00:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34676 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932458AbeB1QAj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:00:39 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.680359656@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 025/254] usb: quirks: Add no-lpm quirk for KY-688 USB
 3.1 Type-C Hub
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit e43a12f1793ae1fe006e26fe9327a8840a92233c upstream.

KY-688 USB 3.1 Type-C Hub internally uses a Genesys Logic hub to connect
to Realtek r8153.

Similar to commit ("7496cfe5431f2 usb: quirks: Add no-lpm quirk for Moshi
USB to Ethernet Adapter"), no-lpm can make r8153 ethernet work.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -148,6 +148,9 @@ static const struct usb_device_id usb_qu
 	/* appletouch */
 	{ USB_DEVICE(0x05ac, 0x021a), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Genesys Logic hub, internally used by KY-688 USB 3.1 Type-C Hub */
+	{ USB_DEVICE(0x05e3, 0x0612), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Genesys Logic hub, internally used by Moshi USB to Ethernet Adapter */
 	{ USB_DEVICE(0x05e3, 0x0616), .driver_info = USB_QUIRK_NO_LPM },
 
