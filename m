Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA88C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2401C2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensourcefoundries-com.20150623.gappssmtp.com header.i=@opensourcefoundries-com.20150623.gappssmtp.com header.b="AAEjP0oE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2401C2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opensourcefoundries.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbeFSXpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:45:44 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32786 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeFSXpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:45:34 -0400
Received: by mail-oi0-f68.google.com with SMTP id c6-v6so1408819oiy.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opensourcefoundries-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Pw36kANzBzVFCceN2ShrfOSf6hSA5sBqGzJvCDRzaKY=;
        b=AAEjP0oEmUfluG+DMWeAha0+wW1fKc45bVO9Pooy5XmN9/6Awo5UCj+El301XpDNHV
         6zupIpZyuV9nzbuMT5nXhD21V7RaTbsHZxKsobJtTBkeUfSHuHomT45EuVOWx5I23s/s
         jjfXofxhkONpY2Q3//fjtFG42hGtB0HaTkZflukOqtkv8zZ2WwOfZKuYksKO48gJ2zSQ
         4ermjzp1K+kil5OXn3tHYcZ83QTu7SBwSliuhmthgMtkpwK2AbxyXiSXkA1XjOVFhAeW
         NOpY0yNo4NmcISymUJHMZ1/0lRS3iYYNHxtDpUoC5sV/UDOCQoI0pxQfXKx50O0rIGl2
         GFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pw36kANzBzVFCceN2ShrfOSf6hSA5sBqGzJvCDRzaKY=;
        b=Cuj+UyzOun7Tit/8JEb2UbTJKLyqynhIA4Ia39s8eX1n7n7t9JSzi+1dsdDp9chuxM
         eWu8SZZ6yRpS16+8nAWGAge4sBvaiFYa8atTPDeBYI0sUmVhcVKZ/hFEDWqalgi9uRzc
         7Yz8xXfGhxrylFesmpMRwcEnv/ChMMsVM4a+jKhcBKQ3mU5VfCyMjyo91jjIxmP42Q15
         njJ1D+D74CoXaEnE85fphQe4iWM/SQ0fGVYRK04kZtbKbGJj6DZbuIMvHxUw5PmXPM73
         LZFQKNWAsKiXrVx1XSElDl4kPqlV7bJoVi7LTbz6UJsy6zqWW6DFCJNkLgElifKtBBzE
         Vx7A==
X-Gm-Message-State: APt69E3mWAYPfJVhMPHpSLuoJy4nhRDwE7aW3R63+Sem/KFX1j3mXNVP
        pMwFFQAswS8Cr5HFdYMU00HaHA==
X-Google-Smtp-Source: ADUXVKKDVjrw3bPM0TL7RSUp5lZZW0kvrDKENc4C/g54FK5TgbcgDxhnZUn2fSj56GDwGj6HR8N5Sg==
X-Received: by 2002:aca:a9c8:: with SMTP id s191-v6mr10143491oie.314.1529451933700;
        Tue, 19 Jun 2018 16:45:33 -0700 (PDT)
Received: from localhost.localdomain (107-198-5-8.lightspeed.irvnca.sbcglobal.net. [107.198.5.8])
        by smtp.googlemail.com with ESMTPSA id u35-v6sm575420otc.27.2018.06.19.16.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 16:45:33 -0700 (PDT)
From:   Michael Scott <michael@opensourcefoundries.com>
Cc:     Michael Scott <michael@opensourcefoundries.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 6lowpan: iphc: reset mac_header after decompress to fix panic
Date:   Tue, 19 Jun 2018 16:44:06 -0700
Message-Id: <20180619234406.8217-1-michael@opensourcefoundries.com>
X-Mailer: git-send-email 2.17.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After decompression of 6lowpan socket data, an IPv6 header is inserted
before the existing socket payload.  After this, we reset the
network_header value of the skb to account for the difference in payload
size from prior to decompression + the addition of the IPv6 header.

However, we fail to reset the mac_header value.

Leaving the mac_header value untouched here, can cause a calculation
error in net/packet/af_packet.c packet_rcv() function when an
AF_PACKET socket is opened in SOCK_RAW mode for use on a 6lowpan
interface.

On line 2088, the data pointer is moved backward by the value returned
from skb_mac_header().  If skb->data is adjusted so that it is before
the skb->head pointer (which can happen when an old value of mac_header
is left in place) the kernel generates a panic in net/core/skbuff.c
line 1717.

This panic can be generated by BLE 6lowpan interfaces (such as bt0) and
802.15.4 interfaces (such as lowpan0) as they both use the same 6lowpan
sources for compression and decompression.

Signed-off-by: Michael Scott <michael@opensourcefoundries.com>
---
 net/6lowpan/iphc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 6b1042e21656..52fad5dad9f7 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -770,6 +770,7 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
 		hdr.hop_limit, &hdr.daddr);
 
 	skb_push(skb, sizeof(hdr));
+	skb_reset_mac_header(skb);
 	skb_reset_network_header(skb);
 	skb_copy_to_linear_data(skb, &hdr, sizeof(hdr));
 
-- 
2.17.0

