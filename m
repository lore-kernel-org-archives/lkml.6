Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58872C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DA320857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUPbWPAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DA320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbeG0Dci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:32:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43333 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbeG0Dci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:32:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id v13-v6so2274473pgr.10;
        Thu, 26 Jul 2018 19:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nVAkD3uKYDtdsLDY4zEptBxny+D9QKC8Gw+NBOVmUEs=;
        b=FUPbWPALh1VywiThhmtNnzWlNCCzMTb95oh0gzHNd38vYnQXSCrqTW1VegcM/sNVOQ
         Volob6mgUcjOhdMkjAEKpKh+zCdT6L/gOSiBK200KtKJlSm6fbB/nqw/qZh5+20JIOSG
         sTT+Bytn6mjx8yp67Wez+gQ3RZoX/N9kScHGJ6KuEribPpEPWFQYcEX868SsVxOQx3sX
         7eAmLK8N1B13eRsovsGjEQaBVAdTF95rw5F9oPuCIg2ieOrJe4dIpGocVUQ57YKf0LRR
         d3M0zmJ5opJcf8+kyRYqalSOEXzTouXEBRWnjqfZlYTcILzqxcrjli6KELc7QPlK3VeV
         8ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nVAkD3uKYDtdsLDY4zEptBxny+D9QKC8Gw+NBOVmUEs=;
        b=DyWxgbmFoHsNNOGgV6Z3IKuTdFHb0kE07cWkzjW/3XRiAGN7GErsO6LQ51pOih+TFS
         dZZ/vZblz/IglezFPOV02+rp3g162nWpxQjFXsQCa5gynBQjJ9Ia/0IhzZ4m9+9rMORx
         L8MX+9dDB7jl2D3dgTS3Fn0iZeY8kVN78m7qUTUXVpDTUqquuIGiQPXNPS/VEWLU4XM+
         vRPo2CtSDQVXRj6CSj0GFKvFTLYo6p2DM0ub41jKjPnR+7D0HE5g1CziWGzcj9tEkL7l
         h0706C9zdiApMa3iOOj33Oc9IATaM+sLm9niOQ4Jdoqop3j9D22MelH2cVMKEwhuJut5
         R/RA==
X-Gm-Message-State: AOUpUlEObw9e8zevnrQ4BCCkFhRXTj2LhyetsR/nckliSR+Tjq65v4KR
        7Tqu07f7bIj2EQNxVZ8Sq2DIPTJw
X-Google-Smtp-Source: AAOMgpflbjRRR0sYFULjhDheTyxy2VKFU5C904Qn5a0z9VATGOYNHPyFyTL3yB7671/3rWcKtikE3g==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr4205137pgt.164.1532657585675;
        Thu, 26 Jul 2018 19:13:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id f5-v6sm3565406pga.58.2018.07.26.19.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:13:05 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     dmitry.torokhov@gmail.com, arvind.yadav.cs@gmail.com,
        gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] input: misc: keyspan_remote: Replace GFP_ATOMIC with GFP_KERNEL in keyspan_probe()
Date:   Fri, 27 Jul 2018 10:12:58 +0800
Message-Id: <20180727021258.29675-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

keyspan_probe() is never called in atomic context.
It calls usb_alloc_coherent() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replace with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/input/misc/keyspan_remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
index 67482b248b2d..a8937ceac66a 100644
--- a/drivers/input/misc/keyspan_remote.c
+++ b/drivers/input/misc/keyspan_remote.c
@@ -466,7 +466,7 @@ static int keyspan_probe(struct usb_interface *interface, const struct usb_devic
 	remote->in_endpoint = endpoint;
 	remote->toggle = -1;	/* Set to -1 so we will always not match the toggle from the first remote message. */
 
-	remote->in_buffer = usb_alloc_coherent(udev, RECV_SIZE, GFP_ATOMIC, &remote->in_dma);
+	remote->in_buffer = usb_alloc_coherent(udev, RECV_SIZE, GFP_KERNEL, &remote->in_dma);
 	if (!remote->in_buffer) {
 		error = -ENOMEM;
 		goto fail1;
-- 
2.17.0

