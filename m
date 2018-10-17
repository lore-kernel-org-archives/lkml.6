Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A08ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB0B21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20150623.gappssmtp.com header.i=@igel-co-jp.20150623.gappssmtp.com header.b="jvbrgbTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB0B21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeJQSln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:41:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33681 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeJQSln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:41:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id 78-v6so10630023pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 03:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDCIadFRSzptxJ3AJqHNtXdJLKi2HbHA5UNRHJFQ93k=;
        b=jvbrgbTtkE1B2XNRUaxvN63mWO86P9TZxovhUfFFgSXIu+2UjvJI2D7s2T08rpgXjh
         N1OK9HC0xL2ro1QIQEig8FyIhp9tTQYAnfSG28iWHY6mP53d29Tkqyl9G//oNO0I3RJy
         DnGPcEu5iO2IyMw7xE2e4bL7ohB7gchZUUmRYmKHmMDUAO8FrldrAcgk/D2DdEwRCiVh
         0Lsq7mcsC4pRc9kMbTIQ8j6YI5FXc76m3U/AkXN+QuRgImBDvjeCKm08MYn4rDd/BSWB
         MGM6MVlxEs5ba5Vcz6gBYcefhe69FZYsRrmSzh+SiOO5DEWXOl7uojb9aVlRu43TW/hZ
         ZTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDCIadFRSzptxJ3AJqHNtXdJLKi2HbHA5UNRHJFQ93k=;
        b=shB2Ag6Xyl/2czRZtKvvOV7MBEpna0/7ANtbQ+HWeCiVuj73I3QUwqFAGgVA/XtML2
         IeFU+Pzu9cB1NWpzSctq+NQjQJuZev5Az9Lijc4vTr18Gh5aExj0H2Bi9f6fRuJPrHzT
         vvzoX57PmhLe8VaJMLuWkoRFJB0nHYQrC7JjgVFGFImFqZasN2l3THH3bPPZ5u3x3x/+
         K2d8R/knlJHvh4aW0b1mQLxos2zU7u4tuSIt4wn4DxmKLOReXc4VRqD9LGxvfsWTHNes
         qPErMHjlwpl9U6bsgj8POSikNmWpUG/KHk9OrX81Zie6TSUyCqTlsPSmenmph2bsgqUN
         mATg==
X-Gm-Message-State: ABuFfoji05Z+ZW3rSIIH7HIUIIWNKp+ya5nVMNpmAdwttd8nJb5pL45X
        5Ovu0aLMD4/gIwIrHn/XbdYNGA==
X-Google-Smtp-Source: ACcGV62Z0pn+F75xv9RpVOYoaMIpgKdIQYr3bTelr5stdalHDvfRuyMk8l+yLE+6AYralIoUdWru6A==
X-Received: by 2002:a62:da1a:: with SMTP id c26-v6mr15016399pfh.52.1539773195501;
        Wed, 17 Oct 2018 03:46:35 -0700 (PDT)
Received: from ake-ubuntu.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id a14-v6sm20063247pgi.75.2018.10.17.03.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 03:46:34 -0700 (PDT)
From:   Ake Koomsin <ake@igel.co.jp>
To:     Jason Wang <jasowang@redhat.com>
Cc:     ake@igel.co.jp, "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] virtio_net: avoid using netif_tx_disable() for serializing tx routine
Date:   Wed, 17 Oct 2018 19:44:12 +0900
Message-Id: <20181017104419.13003-1-ake@igel.co.jp>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <276ac5bb-90f7-5fb6-a826-0bb05ecfa069@redhat.com>
References: <276ac5bb-90f7-5fb6-a826-0bb05ecfa069@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
introduces netif_tx_disable() after netif_device_detach() in order to
avoid use-after-free of tx queues. However, there are two issues.

1) Its operation is redundant with netif_device_detach() in case the
   interface is running.
2) In case of the interface is not running before suspending and
   resuming, the tx does not get resumed by netif_device_attach().
   This results in losing network connectivity.

It is better to use netif_tx_lock_bh()/netif_tx_unlock_bh() instead for
serializing tx routine during reset. This also preserves the symmetry
of netif_device_detach() and netif_device_attach().

Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
Signed-off-by: Ake Koomsin <ake@igel.co.jp>
---
 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3f5aa59c37b7..3e2c041d76ac 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2267,8 +2267,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 
+	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
-	netif_tx_disable(vi->dev);
+	netif_tx_unlock_bh(vi->dev);
 	cancel_delayed_work_sync(&vi->refill);
 
 	if (netif_running(vi->dev)) {
@@ -2304,7 +2305,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 		}
 	}
 
+	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
+	netif_tx_unlock_bh(vi->dev);
 	return err;
 }
 
-- 
2.19.1

