Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4CB20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZVbtH1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4CB20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbeGWEiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:38:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44178 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeGWEiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:38:04 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so7634807pls.11;
        Sun, 22 Jul 2018 20:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eZiQqkTFFg41WoFSCsN8KawQ8i2v1RPfiGDsWopGuAE=;
        b=fZVbtH1O55IKbQJVTgn29DYK/BY5fxpfvrh2BThf4o1RzJWZuFDdWCWWMjdvLngr1I
         jSEDPT4/DjdBYdMLuNesjqQq+7AwvmN7NXLJOgppRXxvbFjj1krW1GYgAJTtu9ebyAmZ
         fRgGbDX8k41Fbg2BA472IsqTdwpljov/cc5X7N9OiHM/DqXAXzrMOULdfIUtIQ3xr1RK
         UxwO608+7gTJPMEDlbTe7gwDigvywwVVJ8MdD5aSTVqZQd98WfvsF4NMqQPMxtyKAe1b
         LeBQQLXdwU/oS4pchOAo1NY36TBd1vkLyXWCWAy0NKxTfs4sEDmJd6fA7VUI+QNvo6LN
         /OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eZiQqkTFFg41WoFSCsN8KawQ8i2v1RPfiGDsWopGuAE=;
        b=Y6mM61xRNoVxvs3s6Bz8F1UXsL0I0C3ASK3ZIMEvDsrs7kN9nGoTWMz7pBRN3gYBbk
         wffQ5HUHEcE7hORoPguYFxbvMeftiv1DLtdDo8WCgumFv8wdWy9Lv8wkseACAl6+amqF
         v46GNMTWz/Ly3orBcFZQ8MxHpCo38cumhhIpfTPHGqMPsFDVjaqT90/s2owe1ds5oLcn
         mczVm2Lak0n4hMh3nCfeehcHwA+gy+jzVERDcyEZazPeXd9kQG8BntlVbUNQHb2RDON+
         jz7LJUD6llxaLt7SvwhIlbwO50Gc2Umq2JuYCKG59OYTta5AcBwTpHyL1UhiMqeOQdty
         Oljg==
X-Gm-Message-State: AOUpUlEG4AwTjU1EaIbuMslpeTrfpZRx+riAY5Vgp3hwWQVYgx0F1CMR
        6/b4k1ZaeSUE6TsKiECc5gE=
X-Google-Smtp-Source: AAOMgpd5sR/muSutJ6XR1QrYg2iTYYEKWHIcKrlqoFkjmxxpHuT51pPuIQ0iNHetIzIUm20d9dOy8A==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11-v6mr11299275plq.228.1532317138661;
        Sun, 22 Jul 2018 20:38:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:c122:f95a:1d53:1f82])
        by smtp.gmail.com with ESMTPSA id y3-v6sm4986153pfi.24.2018.07.22.20.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:38:58 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: btusb: Replace GFP_ATOMIC with GFP_KERNEL in inject_cmd_complete()
Date:   Mon, 23 Jul 2018 11:38:51 +0800
Message-Id: <20180723033851.8141-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inject_cmd_complete() is only called by btusb_send_frame_intel(), 
which is set to hdev->send, and hdev->send() is never 
called in atomic context.

inject_cmd_complete() calls bt_skb_alloc() with GFP_ATOMIC, 
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c8c8b0b8d333..1586c54a01f1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1870,7 +1870,7 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 	struct hci_event_hdr *hdr;
 	struct hci_ev_cmd_complete *evt;
 
-	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_ATOMIC);
+	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
-- 
2.17.0

