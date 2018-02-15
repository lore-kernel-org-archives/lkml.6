Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-853991-1518679394-2-8242552563571174205
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_BL_SPAMCOP_NET 2, RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518679393; b=NDmjDdYHobJRRZPDCpNqR130PxVCB3ylwjeWul//0cohlIg
    TgCCK4mGObKW+LNkT1Xkv3hwA0edzXTxTaUwsR0eE+5gyrIm8jpH9JUpZwGN7JnT
    oH2Um2ABCr/OXs+wjFxPuzkjsfKfuPTzjl/xX6DkmdlvEYI0uBCvs7XC0CLVYMsb
    B12NUOvpRi0Qdk1LmVFKuXEGf1KziEf+GSC8MPbeekCZMw/FRWI00HoktfL8OOA7
    kZSP35BBS6ki3VtUh7o1RN2V3EdHMuw5M3kxzNnBnt2xqrPcXDYBt1vNwipVFUAz
    1DHAtMzN7Dq8ZYxQ92Iz60O92a+Q8pqgCmBsJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518679393; bh=lk2smMaUA6Xk9Sfo9qvH3lTwAd
    aLg+WfqYhmEVzJPf8=; b=vX0L7LjYJQCJPL3yPjRuzOS5jygX+IgTGREv0tx1Ie
    xpnZLVVb3ylPe9ctw4dl9E/QveDWc+VqrTmfIhdcxnVQlylDWTFsx1t6DNrSnfBb
    q3m2Hc9Nq+HokTIcGFy93q4I01IN6ooK4yY9yqnoMbH1rcEiRCIi0pWKLnjN7aeA
    MxlzoUe0a2G6o4r6cUNcv4Rey8Nx50C/KI7zn2qSuR4Ruw2lbjgCziRTHWjJ3ea8
    QF5WOLFzlrukDnbHBE/KHTCDqfIeJhsqfkd6sl7YrAWrf1oXLCTvp5orXjrOx6tk
    vK0mYzeQ3EdjfM28YLuabSbyuMeFctrChHuiHiFfDOOg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b=tP1Gslzj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mvista.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jIFpHsnR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mvista.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b=tP1Gslzj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mvista.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jIFpHsnR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mvista.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754824AbeBOHXK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 02:23:10 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46306 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754800AbeBOHXJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 02:23:09 -0500
X-Google-Smtp-Source: AH8x227b7N81xrZzXzfgC7YyBnysfsfaii1If/qgfFf2BwUfMPWbdLmEl5i2QyVx51DwAYxpwrkBVg==
From: Sudhir Sreedharan <ssreedharan@mvista.com>
To: herton@canonical.com, htl10@users.sourceforge.net,
        Larry.Finger@lwfinger.net
Cc: kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudhir Sreedharan <ssreedharan@mvista.com>,
        stable@vger.kernel.org
Subject: [PATCH] rtl8187: Fix NULL pointer dereference in priv->conf_mutex
Date: Thu, 15 Feb 2018 12:52:45 +0530
Message-Id: <1518679365-15697-1-git-send-email-ssreedharan@mvista.com>
X-Mailer: git-send-email 2.6.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This can be reproduced by bind/unbind the driver multiple times
in AM3517 board.

Analysis revealed that rtl8187_start() was invoked before probe
finishes(ie. before the mutex is initialized).

 INFO: trying to register non-static key.
 the code is fine but needs lockdep annotation.
 turning off the locking correctness validator.
 CPU: 0 PID: 821 Comm: wpa_supplicant Not tainted 4.9.80-dirty #250
 Hardware name: Generic AM3517 (Flattened Device Tree)
 [<c010e0d8>] (unwind_backtrace) from [<c010beac>] (show_stack+0x10/0x14)
 [<c010beac>] (show_stack) from [<c017401c>] (register_lock_class+0x4f4/0x55c)
 [<c017401c>] (register_lock_class) from [<c0176fe0>] (__lock_acquire+0x74/0x1938)
 [<c0176fe0>] (__lock_acquire) from [<c0178cfc>] (lock_acquire+0xfc/0x23c)
 [<c0178cfc>] (lock_acquire) from [<c08aa2f8>] (mutex_lock_nested+0x50/0x3b0)
 [<c08aa2f8>] (mutex_lock_nested) from [<c05f5bf8>] (rtl8187_start+0x2c/0xd54)
 [<c05f5bf8>] (rtl8187_start) from [<c082dea0>] (drv_start+0xa8/0x320)
 [<c082dea0>] (drv_start) from [<c084d1d4>] (ieee80211_do_open+0x2bc/0x8e4)
 [<c084d1d4>] (ieee80211_do_open) from [<c069be94>] (__dev_open+0xb8/0x120)
 [<c069be94>] (__dev_open) from [<c069c11c>] (__dev_change_flags+0x88/0x14c)
 [<c069c11c>] (__dev_change_flags) from [<c069c1f8>] (dev_change_flags+0x18/0x48)
 [<c069c1f8>] (dev_change_flags) from [<c0710b08>] (devinet_ioctl+0x738/0x840)
 [<c0710b08>] (devinet_ioctl) from [<c067925c>] (sock_ioctl+0x164/0x2f4)
 [<c067925c>] (sock_ioctl) from [<c02883f8>] (do_vfs_ioctl+0x8c/0x9d0)
 [<c02883f8>] (do_vfs_ioctl) from [<c0288da8>] (SyS_ioctl+0x6c/0x7c)
 [<c0288da8>] (SyS_ioctl) from [<c0107760>] (ret_fast_syscall+0x0/0x1c)
 Unable to handle kernel NULL pointer dereference at virtual address 00000000
 pgd = cd1ec000
 [00000000] *pgd=8d1de831, *pte=00000000, *ppte=00000000
 Internal error: Oops: 817 [#1] PREEMPT ARM
 Modules linked in:
 CPU: 0 PID: 821 Comm: wpa_supplicant Not tainted 4.9.80-dirty #250
 Hardware name: Generic AM3517 (Flattened Device Tree)
 task: ce73eec0 task.stack: cd1ea000
 PC is at mutex_lock_nested+0xe8/0x3b0
 LR is at mutex_lock_nested+0xd0/0x3b0

Cc: stable@vger.kernel.org
Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>
---
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 121b94f..9a1d15b 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1450,6 +1450,7 @@ static int rtl8187_probe(struct usb_interface *intf,
 		goto err_free_dev;
 	}
 	mutex_init(&priv->io_mutex);
+	mutex_init(&priv->conf_mutex);
 
 	SET_IEEE80211_DEV(dev, &intf->dev);
 	usb_set_intfdata(intf, dev);
@@ -1625,7 +1626,6 @@ static int rtl8187_probe(struct usb_interface *intf,
 		printk(KERN_ERR "rtl8187: Cannot register device\n");
 		goto err_free_dmabuf;
 	}
-	mutex_init(&priv->conf_mutex);
 	skb_queue_head_init(&priv->b_tx_status.queue);
 
 	wiphy_info(dev->wiphy, "hwaddr %pM, %s V%d + %s, rfkill mask %d\n",
-- 
2.6.4
