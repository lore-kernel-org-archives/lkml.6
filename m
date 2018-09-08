Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B25C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67FA204EC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S789HJQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67FA204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeIHQDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 12:03:41 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:42386 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeIHQDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 12:03:41 -0400
Received: by mail-pg1-f172.google.com with SMTP id y4-v6so8208463pgp.9;
        Sat, 08 Sep 2018 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GnsE7WC6IihF8i1sYNQ5eRL+PXvsEtGvbgLJrwJ8I2Q=;
        b=S789HJQxc0SwoZYc/dRYweQ3n0L77N7a+G8Nd8BbBs45T6QyxA2S0BfNQHAHu8ZOo0
         h3PUjS9L47924TT7WB8CwKsKSTElCwvNM1Q4+GWGFZe1/eSLDQ3zl72GryxIuajSRYo+
         4nb/ZFCrHyh4uQIwlMREL1S8X6xGhwnJC6ceSqUT1ItRClErWRPAfpL12eXkklsNUt+T
         xOFqkQSiEUgvX6sgtSlBWLjV4GOJOXyBO2c2o9B5UizwIgrYUqHokQ+1j/VNb0aR9+kB
         akJMF/kAYFpmidSdhEgOB359hP1ZY0SsxaP127J8dgG40MzS2bgM4JVYnq+eRPXGCBKX
         Foww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GnsE7WC6IihF8i1sYNQ5eRL+PXvsEtGvbgLJrwJ8I2Q=;
        b=WjZMigHLb1dawheA1Ffp03vycmuE5kmkc5ws6N6KjDxn5vCi9VpBSETnfRwVH07QHY
         7QNSU1+rtVRBZe0IaoshoyzueYas8vuvhyomsv1sLcUbpXLOwpY5r2uET4Exj9y0IqJV
         zPD2fkNmE5brIM8AjA1cmUZtidNmdVU8qEE0Rvf3MaKt3xbBI20JXUzmiC+EFqBA/9Zx
         UV5X5qG6tfGvjehLGX2qy3Mfl9s3UOWKDDebz2OwdMgdhQhb7RMPYiV7Pi3Nwn63NVBf
         IMUmMzBaKnVn0bp9FhXPZEQYn4grFyD92IFgaIn8kdzXRwpvdjmupj0OnckxPX9HPGfF
         C0EQ==
X-Gm-Message-State: APzg51Bk2j2PCkCiWMXNgkLjxLqAd/GOfJJrOnYO3hOA0kUbWW/dpJCH
        1xwVbOtfhLRcfNMKV/CERtc=
X-Google-Smtp-Source: ANB0VdZIj1HkhLMVkyOuw80kDWNVYKoxydrqGkMWLcJh2LqZenLXnuJbFsmIi1vE+GVSpzQkOWkD3Q==
X-Received: by 2002:a63:380d:: with SMTP id f13-v6mr12958660pga.124.1536405495142;
        Sat, 08 Sep 2018 04:18:15 -0700 (PDT)
Received: from ubuntu ([103.224.155.47])
        by smtp.gmail.com with ESMTPSA id z5-v6sm13756816pfh.83.2018.09.08.04.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 04:18:14 -0700 (PDT)
Date:   Sat, 8 Sep 2018 04:18:07 -0700
From:   jagadish tirumala <t.jag587@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: PATCH fixed error space required before the open parenthesis 
Message-ID: <20180908111807.GA1931@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi , I have fixed error space required before the open parenthesis in drivers/bluetooth/hci_serdev.c

--MGYHOYXEY6WxJCY8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-fixed-error-space-required-before-the-open-parenthes.patch"

From 084feec211eb99e6658d9ad11152406348716ced Mon Sep 17 00:00:00 2001
From: Jagdish Tirumala <t.jag587@gmail.com>
Date: Sat, 8 Sep 2018 03:36:34 -0700
Subject: [PATCH] fixed error space required before the open parenthesis

Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
---
 drivers/bluetooth/hci_serdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index aa2543b3c286..d41c520e8970 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -94,7 +94,7 @@ static void hci_uart_write_work(struct work_struct *work)
 			hci_uart_tx_complete(hu, hci_skb_pkt_type(skb));
 			kfree_skb(skb);
 		}
-	} while(test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
+	} while (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
 
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 }
-- 
2.17.1


--MGYHOYXEY6WxJCY8--
