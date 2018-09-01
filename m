Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560FBC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98AD2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uo0/85gU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98AD2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeIAODc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 10:03:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34443 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 10:03:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so6611973pfi.1;
        Sat, 01 Sep 2018 02:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Raofxx57efFth3r6wwJuAFO+Ffnzbkls5dR0luoXJCI=;
        b=uo0/85gUWkSJ4ioIKGDVwjHwJIfjbwqbi0woBd1rKHwjJhCVsWfDvvrCg3F66d8PNP
         BcmvJMoI58y2rNZTGHGHq08dnrBJgBRdB7FEpySb8rU5n+pwRy4z/8uqMa+ujaEtGrB4
         ykeqc3m2n8DX8215mASnCgWJaaIp0U477nzVOCU2QNih9+5fBJOKb5wVlBEluePilQf7
         Maz2Bmddgr2U7CryPjG/o9WuRfGlP2Hr3DgYu8Yqw2kEdQeQTz/aXOGOjE6WiIoUEWbJ
         lo+nZTGp91FPr6IZa9WLfAc4wTcivRtEaBKRv+4qoIuSl42QXVIPe9Nt+vok/Q/XqKCS
         aW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Raofxx57efFth3r6wwJuAFO+Ffnzbkls5dR0luoXJCI=;
        b=STFbq9fibPVfWVM1CuoEgTE2ptVSMW5hqqswo3LmJEX0auD26/jB/h9yG6zb+EHMA7
         ZAa+xneZZD70uok51Ys+4yN0OOd9JTIdwQOZ0xqmG2SmYPd/x8cWjV+x/bD5Dec5gGWo
         mX/YdI7DMrRpAW4XYgwUsF8boo8ajaNEE3GcJYUteRobOUnnxHQPrCioOhXpifX3LX49
         jspl2DoZ5yM5ysavhNwYrtz1KBal/ghAJxcuz7bZENVsALjrbbg0Nc04g+ltQ4N5KhO2
         3NTO5WwDxFgAP956mzgfs/4rPqUje7NDkTwiqmWA394y1WqAg/gG5Q/pbzy1ZK21fB/O
         Wu9A==
X-Gm-Message-State: APzg51DzMi+DiWG8PU4UNmPrImtFNnLWaWimJ3rWw9rxfBKIgSJEqEi+
        IiVm5FLTL0qpKWqem01HhRQ=
X-Google-Smtp-Source: ANB0VdaSALSqtcs9VfWiUuf4jOm43OGXda7bqNxhcx12QnEuY/3ke1yKJFpeN0agBHUnaAwhyoieQQ==
X-Received: by 2002:a63:4c07:: with SMTP id z7-v6mr18401589pga.312.1535795525590;
        Sat, 01 Sep 2018 02:52:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id u184-v6sm18261473pgd.46.2018.09.01.02.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 02:52:04 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     sameo@linux.intel.com, davem@davemloft.net, viro@zeniv.linux.org.uk
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: nfc: nci: Fix a sleep-in-atomic-context bug in nci_uart_default_recv_buf()
Date:   Sat,  1 Sep 2018 17:51:46 +0800
Message-Id: <20180901095146.15627-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel module may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] nci_skb_alloc(GFP_KERNEL)
net/nfc/nci/uart.c, 349: 
	nci_skb_alloc in nci_uart_default_recv_buf
net/nfc/nci/uart.c, 255: 
	[FUNC_PTR]nci_uart_default_recv_buf in nci_uart_tty_receive
net/nfc/nci/uart.c, 254: 
	spin_lock in nci_uart_tty_receive

Note that [FUNC_PTR] means a function pointer call is used.

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 net/nfc/nci/uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index a66f102c6c01..040576dd73bb 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -348,7 +348,7 @@ static int nci_uart_default_recv_buf(struct nci_uart *nu, const u8 *data,
 			nu->rx_packet_len = -1;
 			nu->rx_skb = nci_skb_alloc(nu->ndev,
 						   NCI_MAX_PACKET_SIZE,
-						   GFP_KERNEL);
+						   GFP_ATOMIC);
 			if (!nu->rx_skb)
 				return -ENOMEM;
 		}
-- 
2.17.0

