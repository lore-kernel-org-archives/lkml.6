Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3468281-1526428699-2-14358894506004320883
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526428698; b=Nc0gb/wOHW384wEodRLsuw9VXmXEZzcsvHSEpLUsR5YbH6IzBr
    nsmn/hznnUGHT/2+4FodmrRliWZXx5I/+qI3e4mzpx4B5+5mG0rISFS9V0IxRneW
    MnqVH1W74EErcAUJk/NdEXrYqGKkNMONGO0loGT4WIKJ6cO+3wZlHQTtKGQE3y09
    FE2KK5ndmW9QPspI4AXoiWsKvYXrAhFpbmsSRgbg16XqCFw3soZoKsTgI1d7Yx14
    2NKhSLge/3xgGw4Tpumhxg9w5P6DJP6HZC4OxaFnNtRpM69l/N91EUnN5lgpH7aN
    FAkLdfiSM2sYqT8SrZuhtyDRoGppgJJkXRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526428698; bh=rjkZIjvXQQaFaUUD451DNSJmnfV/lf
    QpBkAdFf4Hagc=; b=KoYCtaGPFzlZcMDKzFa/74B0GQJ0qNQ1+m6MsOOnpVKu6S
    UFwBfOTjZJbK4+UN5pfa4yrjuIJV6mbaJYnCd1inFSZwiEg4P+qyvn0Fl098GaW6
    tEUHPspTSdE+msTeSk6dSDRm4gpo35bB6MpGupXVNURkuQ5y6y+StZW0QT2la4TJ
    ZkRcF8qsEmLAY0pknuy5YromMcSYfLOUKEGBeXJ9/jecMcMbrcy5h+jarki+kPQc
    MYjwbsv4VrRCu+6y6UIekmUG3z213dSGcGqT8IQXK4HN7ijQcEC8aOzI8Wk6CjaL
    7FmeOxlm3yMj/P16/QujSWhbv5G7wtk3gtjN9uJA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOKg2y4eQL+vi0WDUrNo/zQpU08VhtqqRd0CBpxhHG4leRnYadxEs7/1n2F91gACbdoPyexc2TxKUNFbD/SHM1trb4iSZJEz0uBQGJU4I/4TlM2QMwnV
    sWQWN+SLvRU5rUTd4732thNMHUFA903ZeqI1EyD2AXh4ZWwR/IPmWrotM6oOClxu2MELnAL8NNTHFpprmyoqj0VRUOUOsvMu58lvJBG1pTsnzSmDRX1epyVO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=qTCTqAxlTHOC2uTrnRkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeEOX5y (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 19:57:54 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:55294 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeEOX5v (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 19:57:51 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: usbip_host: fix bad unlock balance during stub_probe()
Date: Tue, 15 May 2018 17:57:23 -0600
Message-Id: <20180515235723.30845-1-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stub_probe() calls put_busid_priv() in an error path when device isn't
found in the busid_table. Fix it by making put_busid_priv() safe to be
called with null struct bus_id_priv pointer.

This problem happens when "usbip bind" is run without loading usbip_host
driver and then running modprobe. The first failed bind attempt unbinds
the device from the original driver and when usbip_host is modprobed,
stub_probe() runs and doesn't find the device in its busid table and calls
put_busid_priv(0 with null bus_id_priv pointer.

usbip-host 3-10.2: 3-10.2 is not in match_busid table...  skip!

[  367.359679] =====================================
[  367.359681] WARNING: bad unlock balance detected!
[  367.359683] 4.17.0-rc4+ #5 Not tainted
[  367.359685] -------------------------------------
[  367.359688] modprobe/2768 is trying to release lock (
[  367.359689]
==================================================================
[  367.359696] BUG: KASAN: null-ptr-deref in print_unlock_imbalance_bug+0x99/0x110
[  367.359699] Read of size 8 at addr 0000000000000058 by task modprobe/2768

[  367.359705] CPU: 4 PID: 2768 Comm: modprobe Not tainted 4.17.0-rc4+ #5

Fixes: 22076557b07c ("usbip: usbip_host: fix NULL-ptr deref and use-after-free errors") in usb-linus
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: stable <stable@kernel.org>
---

 drivers/usb/usbip/stub_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index 41c7b9de2a92..bf8a5feb0ee9 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -82,7 +82,8 @@ struct bus_id_priv *get_busid_priv(const char *busid)
 
 void put_busid_priv(struct bus_id_priv *bid)
 {
-	spin_unlock(&bid->busid_lock);
+	if (bid)
+		spin_unlock(&bid->busid_lock);
 }
 
 static int add_match_busid(char *busid)
-- 
2.14.1

