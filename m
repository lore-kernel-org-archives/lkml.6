Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2707851-1524408567-2-8123429195060516181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524408566; b=bHuLpf2awHImhoyJ7KLWZhn7gJvA7X2kY5I7smk7YD4OT+4TY+
    wDIE3JwiyIfTy2ZIyHnpULP5gRrRFXih8+nrwfrC+syWi/o28vbuSljKjssTHptj
    Rkx3AROYG6bYWhX7rhs4DQUfMsM3+w7kGYjjEOJGnA41aDxgiNwVTqJOOihSowJO
    joSqg2LKaYXYZueR8LcCJEPRs3W0kJWcbxieVMCRzUIYfex34cwbN5j1X1vIyOWv
    NJNlJKs6ILXZygx5p24mPG3CDtL9ymAv6Up+hP4R15E+MoQJSt/1XtGo9m9ayO84
    fIV/g3PMMv4MDlMiZZb+BKcAUuHEYRK6BcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524408566; bh=iUNr/JLEc8wB7SJbtakl2Sh3i338ko
    dDQMiBIqressM=; b=ZklhlWwmNIwzQL7rFZoGd8MWNEp5bM7weAsATdL2Rwl6DG
    8Fsy56Gn5t2gjobFQynmzMkIubi2aUf/GFxv96OnUm9YT9QM+9netYY9huclU1Xw
    Q4Uysez/gNuLr0ooqR6yr+Rrdo7aQOPuXaUB8PQL/NjicLUadqHmWaTDDQetrw/V
    fLtThMa0pDiQ2Dqo6ktNKYko6CkFKfM7fy9GaK8r+WwOq8uYa0FElvKKZdL8j2wU
    hJMQvv3vJIccrntD62CM73YGH9fPsISUI8lwpELRedDoeyXsGfHyNYl8DHVfYyHI
    R+Sd1DFVW9iy1UX+AYVcdSLVVWJg6KJofOgO9fcA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOU+AJfXCK2fXFvHmQheFRF13PCku0DP2TqH5Uy3C6/5Ar6Krnqdxof1mrJdY/y35k+hXF/jXcJM9cYJ9gVccItk7eYR/1j/q2hYrz6vt18tCrKBUuDo
    Zg+Kb6zp4P3WyIS+Y8kNIZ/Mi+2qktvov4yfsJqMRJWBcM/2NYzia+vUo5kThteh14nYIu1fb0KVdsPPznExzntpkmMqPSyo8qECYTU5YWHqKoqKTLZLgdyn
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=fk1lIlRQAAAA:8 a=VwQbUJbxAAAA:8 a=LpQP-O61AAAA:8 a=ag1SF4gXAAAA:8
    a=dvAl-2Suf6oiNL_zVn0A:9 a=QEXdDO2ut3YA:10 a=U75ogvRika4pmaD_UPO0:22
    a=AjGcO6oz07-iQ99wixmX:22 a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeDVOPr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:15:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756709AbeDVOPl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:15:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sudhir Sreedharan <ssreedharan@mvista.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 14/97] rtl8187: Fix NULL pointer dereference in priv->conf_mutex
Date: Sun, 22 Apr 2018 15:52:52 +0200
Message-Id: <20180422135305.425164589@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudhir Sreedharan <ssreedharan@mvista.com>

commit 7972326a26b5bf8dc2adac575c4e03ee7e9d193a upstream.

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
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1454,6 +1454,7 @@ static int rtl8187_probe(struct usb_inte
 		goto err_free_dev;
 	}
 	mutex_init(&priv->io_mutex);
+	mutex_init(&priv->conf_mutex);
 
 	SET_IEEE80211_DEV(dev, &intf->dev);
 	usb_set_intfdata(intf, dev);
@@ -1627,7 +1628,6 @@ static int rtl8187_probe(struct usb_inte
 		printk(KERN_ERR "rtl8187: Cannot register device\n");
 		goto err_free_dmabuf;
 	}
-	mutex_init(&priv->conf_mutex);
 	skb_queue_head_init(&priv->b_tx_status.queue);
 
 	wiphy_info(dev->wiphy, "hwaddr %pM, %s V%d + %s, rfkill mask %d\n",
