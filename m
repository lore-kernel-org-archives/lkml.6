Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A977CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671112174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLL+l3Ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671112174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeH0MIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:08:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33133 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeH0MIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:08:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so11620842ljj.0;
        Mon, 27 Aug 2018 01:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j9TEfnBOgeJPhtnrYYF91KbGFTGsSDrgCHOAcfWP4Mw=;
        b=sLL+l3Ef7vuu98F2P2T9G3v9ADJLAmn98w8OEIxxEYESoYFK5cdNGA9DogEGtSz3Xq
         +CFyPZUw8zefxNxcJzNg0VF4B1zRPZ39A/TJQIIWb+aDSbSvblxMWqRMYmNnQv2SxV4q
         8veoQkdQwpbdI6jE8jmEx37qWmdrEaZvw/F50yugVCN4vgumsh13txKY8kgD8o3g2AEv
         LkWWJlxQSp6XOuSjJUf54l0C9xNx5WREzC5KR9+3aVuax8fwyhzx5qJVk5IfAc1Os2eT
         XpkLirc5Pivx85B+HYkKYOO1f1U82eV9azJxH6ioRVz+csr4aWKMa8lx9vnzgBVsGu3L
         5+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=j9TEfnBOgeJPhtnrYYF91KbGFTGsSDrgCHOAcfWP4Mw=;
        b=GveSClsfch34NhRLXqc0d0N8fIMJ6jjKd07ifhi+onqGXMkS2l12U0JTzGFDEiBk0K
         2ngTwLbpOw6hinZU65EGfNgY+ti1MTqd3Ubf72ghtpum0thrjDDtx10YNYAgFwJqfJUL
         /feC7dO8ESHpBZdjKlcJOccYID7tJ7StIrAF9+ZPkwbBP16/6VxIqZztEF6KB3nqkKJs
         sIajEClYdUJnxu6u0s0ljqs5XdEw3D+gAgiygMOePrAsWz50LNJhu0bACIwmNgjntAfg
         whc+e65KXRdxjGDMd0z+Avy0UmlVT4dAZBPBDwS2FM19nVHhepcy9yAyoqPic1bOLIcP
         98vQ==
X-Gm-Message-State: APzg51CWW0joFxG+Q7G0xbeAY9qrdRJGhbLd2vhDQfOT6zg96WQQn5KK
        fF/aI0dwU26pBMFoL0FC3lFH5/mA
X-Google-Smtp-Source: ANB0VdbYSiT8wrUTbV5RHR41HVfH4gnGNwgbuQsVlHYHEAJlSqnKk1hQS5iLmXclyLQFeeWv0OgdKw==
X-Received: by 2002:a2e:3005:: with SMTP id w5-v6mr7559328ljw.20.1535358153014;
        Mon, 27 Aug 2018 01:22:33 -0700 (PDT)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f9-v6sm2649837ljf.9.2018.08.27.01.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:22:31 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fuCn7-0005t1-83; Mon, 27 Aug 2018 10:22:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Vincent Cuissard <cuissard@marvell.com>,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH v2 8/9] NFC: nfcmrvl_uart: fix OF child-node lookup
Date:   Mon, 27 Aug 2018 10:21:52 +0200
Message-Id: <20180827082153.22537-9-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827082153.22537-1-johan@kernel.org>
References: <20180827082153.22537-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the nfc child
node instead of using of_find_compatible_node(), which searches the
entire tree from a given start node and thus can return an unrelated
(i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the parent node).

Fixes: e097dc624f78 ("NFC: nfcmrvl: add UART driver")
Fixes: d8e018c0b321 ("NFC: nfcmrvl: update device tree bindings for Marvell NFC")
Cc: stable <stable@vger.kernel.org>     # 4.2
Cc: Vincent Cuissard <cuissard@marvell.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/nfc/nfcmrvl/uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 91162f8e0366..9a22056e8d9e 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -73,10 +73,9 @@ static int nfcmrvl_uart_parse_dt(struct device_node *node,
 	struct device_node *matched_node;
 	int ret;
 
-	matched_node = of_find_compatible_node(node, NULL, "marvell,nfc-uart");
+	matched_node = of_get_compatible_child(node, "marvell,nfc-uart");
 	if (!matched_node) {
-		matched_node = of_find_compatible_node(node, NULL,
-						       "mrvl,nfc-uart");
+		matched_node = of_get_compatible_child(node, "mrvl,nfc-uart");
 		if (!matched_node)
 			return -ENODEV;
 	}
-- 
2.18.0

