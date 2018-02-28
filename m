Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835841-2-14591796464607582412
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835840; b=jlmBPqY3K6C4HGw9hB1s2BdsdQVlw5jDdYQUBsbGl6cXV9V
    tZSDOHuk2iMWQBRkz8dxshA/h5+MgraWdnD1Lk+XYyU0WnOXRPbzAymmiw9/SXXe
    C/4emquWg8bJDYJppq6RkTKgsqkb2kxPxuIqDVgt5JDguf1tvf7czh8S9LelOdQK
    b1kbW8Z/Kwwq0cXe+XANVcBYQcU0evrS7KXnMvG4/g5qxDtx5oSoYmWCUKT00hKD
    CEdL/2vceGDnUuMWGwWUdvibijxfosOvAfIn6fnuKFGOkNeXZJf6e/16ldB46Zv6
    LZeWQ7PD/ND0RbBCNoEVdttKWW0mKwCn7K6w6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835840; bh=M168I81I2hakrIuHHoN
    LYQAaXzk9JajDZsWWn8380d8=; b=WRRq4UkAZV4Rz9qGi1UE+EMYP72lGtObEZI
    Uo16cEMaIoE6mIR60AhGPELqiWsgXaxer2Yzy6qJFFbnt0EV/Bs3CTzuSzloiF50
    J6I/9SzJJL7hyddHJz/fA9fJ4M3y/JD9bAe6JM9aI9uB4cwYd75NHGf0BhzgcNDM
    uJ+7FDEggzPUOrkzaIh0edAOvkdfbjbM2G1s6eLPTrxNLGcxCKNSeQ5UDFdesvQH
    hPpaEWYMYoSVEa//wm9Y0cTuejy3Ybp1p/YVaeY9V1Bn1Fr0SLvcBLRdNw9Yyy9d
    7SDQHn0+rmOz/eYmhMYaWTkheY3iXC55Hw0xx+YIAjlDaLgpH1g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934396AbeB1QEh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:04:37 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34833 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932767AbeB1QEe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:34 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "weiping zhang" <zwp10758@gmail.com>,
        "weiping zhang" <zhangweiping@didichuxing.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Cornelia Huck" <cohuck@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.307464691@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 045/254] virtio: release virtio index when fail to
 device_register
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: weiping zhang <zwp10758@gmail.com>

commit e60ea67bb60459b95a50a156296041a13e0e380e upstream.

index can be reused by other virtio device.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/virtio/virtio.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -223,6 +223,8 @@ int register_virtio_device(struct virtio
 	/* device_register() causes the bus infrastructure to look for a
 	 * matching driver. */
 	err = device_register(&dev->dev);
+	if (err)
+		ida_simple_remove(&virtio_index_ida, dev->index);
 out:
 	if (err)
 		add_status(dev, VIRTIO_CONFIG_S_FAILED);
