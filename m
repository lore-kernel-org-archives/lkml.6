Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EB4C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 00:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA4220870
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 00:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwE3jSJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfBCA4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 19:56:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38874 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfBCA4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 19:56:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so5109784pfi.5;
        Sat, 02 Feb 2019 16:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZGcVYn3pyoZQburOYIXpkDXd89ixvABOYmn0RFue96Q=;
        b=WwE3jSJ9cRc3a+DuR8QJpVLuJbFK8CVHgotiDfWmnIZRqOMLmP8QJBgrlbIcGVUlKg
         w6gz4XQkqu0V+4nQuQvbANVGHF0SME1d25m06hltmzD1Md2MMkVfkmC+oym4nJfxd5cP
         BvQV3ZpAxP3f/+rlzxY6yS69NRrrm36DfQ0MRQd3NqTx1KGWYGjlFrgv/TU0mYw5M4rL
         y/KUY1OLYBMKV9JsUJO8gQX/vj5I7R3cs5yu7vuYKUd19HsUOfttFQMOib0y8D6+kqWd
         E88P5vnTOLGwhu8AOxf/WNjgRwiA5MiUnyg2lhGkq6wsRZOScxbKAaeFA9HtsfIngxCC
         CaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZGcVYn3pyoZQburOYIXpkDXd89ixvABOYmn0RFue96Q=;
        b=ue89l5afjMW1VO1wB2DdZoaURC9xZZriiwuI4xWjsVtruYzUFAM613cFEXi1iHDN9y
         jay7YGXCczc4hOhc+3idoYAUH8QEEsOYafhX9pFW1taAEFfS2c9ewiR9FM8F73q3oNq6
         L7QOmbVnHg8XWiKo7ZjkNsQICto8J4IUAc9Tm+dVdrGoBfIdRt69Hod2n72ccHktYBwC
         h45y7dAHvihib0F+D+G+qqrS25cOLkKbn/NA2ZUphVxZhmjgb+FHkQq84/8NLhgTif17
         VG1WIIWynGBqmMJt0KtYPCvYs/u03PPfGbehxUdh6vV/vchZlZ0xj43xOy7fMXgsEjDQ
         QyZA==
X-Gm-Message-State: AHQUAuZteIp9xyRSdnI/AHnSp3KNJm7ZHLHTbfdfxS5Z9/AuRQJe/Jad
        zinyp6LAevEl7b0066uGUKE4MPxp/W0=
X-Google-Smtp-Source: AHgI3Ib93bQ6fDj8FuLfnM32V9L1kcDDu182B8sLRdrauCSlhM0a/ynOcSOIB3pCPSlG6n1aZh4xnQ==
X-Received: by 2002:a63:1a5f:: with SMTP id a31mr4650129pgm.335.1549155399587;
        Sat, 02 Feb 2019 16:56:39 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id h64sm18341455pfc.142.2019.02.02.16.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 16:56:39 -0800 (PST)
Date:   Sat, 2 Feb 2019 16:56:36 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix decrementing reference count twice in
 releasing socket
Message-ID: <20190203005634.GA19908@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When releasing socket, it is possible to enter hci_sock_release() and
hci_sock_dev_event(HCI_DEV_UNREG) at the same time in different thread.
The reference count of hdev should be decremented only once from one of
them but if storing hdev to local variable in hci_sock_release() before
detached from socket and setting to NULL in hci_sock_dev_event(),
hci_dev_put(hdev) is unexpectedly called twice. This is resolved by
referencing hdev from socket after bt_sock_unlink() in
hci_sock_release().

Reported-by: syzbot+fdc00003f4efff43bc5b@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 net/bluetooth/hci_sock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1506e1632394..d4e2a166ae17 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -831,8 +831,6 @@ static int hci_sock_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
-	hdev = hci_pi(sk)->hdev;
-
 	switch (hci_pi(sk)->channel) {
 	case HCI_CHANNEL_MONITOR:
 		atomic_dec(&monitor_promisc);
@@ -854,6 +852,7 @@ static int hci_sock_release(struct socket *sock)
 
 	bt_sock_unlink(&hci_sk_list, sk);
 
+	hdev = hci_pi(sk)->hdev;
 	if (hdev) {
 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
 			/* When releasing a user channel exclusive access,
-- 
2.17.1

