Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2787554-1519386222-2-11874542301385513981
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES svdaen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519386221; b=DGMtuU44I3RxvkjoOJhR7HHvWVZo0xa+1Zwn8eON+XHZy4n
    2tIllefGBt00J1clIajkJ6VIoz1PY09wU3mmUWRjTJ8FqX0XUsvpYxUqRaavjbQO
    5WOS+2ICAI+fTTk2PL1/es5LpjWy48l8aKdO6CkHPe9eG984eYdVTuAsBy2yZhu1
    JRYfJjPJbU6ClPiIHi3qFjcQ8lSViMoCrq1z4PzSSJcMU8aWr6h2U5A2UwEyEQQK
    /hYLl1fb4L3FhuZaqjdMmhnEl0QGIIUnGf5Wi5K2Lv/cXSWS7p4+zSCIVRJcgRJz
    IpnyfVN3y9AtIPX2rYj2u/0yD1ijqJx2JNr6S0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519386221; bh=LLIVLDXD8YNFIqmvl2Cu1AhF29
    9D3y1jXWfdHwI2YYY=; b=XAQoO0OQ2Qh4xsGWNN1Xf5FJjA3mzNsSUSBFUVEJX4
    0cUboWyKs1kF6MjaW5JE3rWBdMBOIeAQc/VvWKFdfaBZPn8ujJC3XYkCGISFTvZz
    ScQ/BnaRXjl09zZ0mfLfu4f6dmJdbs5+BfzIOQK4Zd4pR0OQTgXlxFN+mvyrKbGa
    gB5d12Oy/88W90DDGdciqU6Fw7eCSrZJd/l7tdCsoSQq/TgoUcYYBkRDFJYaaONF
    pRktCryHdUHlH577Bjj3KyOO9zHdw47M75DbpJ4ITQmT6e6FS2/bYMyEHfHX1Jm/
    DRJCXqLYCm3gTjr0i4Px4AXBU+lQdZotDbg5YmcGbcIQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeBWLnj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 06:43:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:65239 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751089AbeBWLnj (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 06:43:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="22495077"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] virtio_ring: fix num_free handling in error case
Date: Fri, 23 Feb 2018 19:41:30 +0800
Message-Id: <20180223114130.16332-1-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.11.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The vq->vq.num_free hasn't been changed when error happens,
so it shouldn't be changed when handling the error.

Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index eb30f3e09a47..71458f493cf8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -428,8 +428,6 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 		i = virtio16_to_cpu(_vq->vdev, vq->vring.desc[i].next);
 	}
 
-	vq->vq.num_free += total_sg;
-
 	if (indirect)
 		kfree(desc);
 
-- 
2.11.0
