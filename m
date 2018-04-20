Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2222762-1524248361-2-11054660430332740133
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524248360; b=OI8fSO7K1yXtk9VHAev0Um+5qV+kWYUfO6HZgT8cXfv0I3KS/2
    k7JjWvj17SUb/N3ZUBthpnT0xEVfvHD4c4nI7ML5DWa+UdYP1ZfQYMd5gy4oxCXF
    42iYhfVXbqbNPpG+h1DQ+0c3fh55EpfaJs1wQQvPzOTquVH9QtWSJrkpV2/xyz4w
    yOl+Z/BnGs08VX5gt9hN+vuW42Q5VKoJfdEYZsMEUFF/UDUpOrAzckJwO6XeYplB
    JRS9h9o4SZSmRFpHGWF57lRPGUfEDY/4TTxkug3p0oekN2xvjRHzeV4k5DiINvW7
    TT2fewdRMZHfQlfP87JLuohqrm9JpEM+3Hcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524248360; bh=OGnm0nlLcag
    feiUapHxzKF1VdD3WA24I5pfGYzUCua0=; b=VEZ8/6vBFsCWU7ctzW7sd49MSeQ
    dLKjvTTCpwayPRMPNvI9jNxFzJMW69CNQOVtkX3q2+oIMGdoHU1dQE7uXOczI31m
    lBB0ug/Z7j4Comc5egRiVCN64LS4TxE0W2/6V8n7o366x9saJ2gIfaGtSrRw+3Lm
    GnkUA59NyiGQGI9HXhbat2Hc22J7wA/OPXUZNxLZ85ZdsU+/zEEUszN4e7dMhFSa
    0if+BlL9VF0/vhSftbqoPvSxnLgf+fR1bsxoymCd8kTiIQ06RpT8hbvy4D7Ysa7o
    Wbb/GIiBJ9g/HFiklKwxU8DQ3SDyD7BiZMrLFmzHeP2aNiZpowhTUGyzDWA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGinTdEm4gdNudvAJK6Q3BR5LngftqZgaIlOpyslsvgpnJ4lYA9jjhuKnpFBk+h8757GfwwJrk4ruT500oqEK/R06zRQURDvDtwow+H8tG4tNTlmt6wZ
    y91yuJPxcV15ei+zpuhyWPdP4GJPnpVJ8OjIRb+XK0HvgNO1rW9IcPkayeYGUptM37K3NNYsAHRoTRdpxc2Nnm48mNAD1V5IOPoIlPTszfiHXhsgzPRhhHTx
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=GggQS1mPNjHnj7bSnTEA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753782AbeDTSTA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 14:19:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753514AbeDTSSE (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 14:18:04 -0400
Date: Fri, 20 Apr 2018 21:18:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>, stable@kernel.org
Subject: [PATCH 3/6] virtio_console: free buffers after reset
Message-ID: <1524248223-393618-4-git-send-email-mst@redhat.com>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524248223-393618-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Console driver is out of spec. The spec says:
	A driver MUST NOT decrement the available idx on a live
	virtqueue (ie. there is no way to “unexpose” buffers).
and it does exactly that by trying to detach unused buffers
without doing a device reset first.

Defer detaching the buffers until device unplug.

Of course this means we might get an interrupt for
a vq without an attached port now. Handle that by
discarding the consumed buffer.

Reported-by: Tiwei Bie <tiwei.bie@intel.com>
Fixes: b3258ff1d6 ("virtio: Decrement avail idx on buffer detach")
CC: stable@kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 49 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 3e56f32..26a66ff 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1402,7 +1402,6 @@ static int add_port(struct ports_device *portdev, u32 id)
 {
 	char debugfs_name[16];
 	struct port *port;
-	struct port_buffer *buf;
 	dev_t devt;
 	unsigned int nr_added_bufs;
 	int err;
@@ -1513,8 +1512,6 @@ static int add_port(struct ports_device *portdev, u32 id)
 	return 0;
 
 free_inbufs:
-	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
-		free_buf(buf, true);
 free_device:
 	device_destroy(pdrvdata.class, port->dev->devt);
 free_cdev:
@@ -1539,34 +1536,14 @@ static void remove_port(struct kref *kref)
 
 static void remove_port_data(struct port *port)
 {
-	struct port_buffer *buf;
-
 	spin_lock_irq(&port->inbuf_lock);
 	/* Remove unused data this port might have received. */
 	discard_port_data(port);
 	spin_unlock_irq(&port->inbuf_lock);
 
-	/* Remove buffers we queued up for the Host to send us data in. */
-	do {
-		spin_lock_irq(&port->inbuf_lock);
-		buf = virtqueue_detach_unused_buf(port->in_vq);
-		spin_unlock_irq(&port->inbuf_lock);
-		if (buf)
-			free_buf(buf, true);
-	} while (buf);
-
 	spin_lock_irq(&port->outvq_lock);
 	reclaim_consumed_buffers(port);
 	spin_unlock_irq(&port->outvq_lock);
-
-	/* Free pending buffers from the out-queue. */
-	do {
-		spin_lock_irq(&port->outvq_lock);
-		buf = virtqueue_detach_unused_buf(port->out_vq);
-		spin_unlock_irq(&port->outvq_lock);
-		if (buf)
-			free_buf(buf, true);
-	} while (buf);
 }
 
 /*
@@ -1791,13 +1768,24 @@ static void control_work_handler(struct work_struct *work)
 	spin_unlock(&portdev->c_ivq_lock);
 }
 
+static void flush_bufs(struct virtqueue *vq, bool can_sleep)
+{
+	struct port_buffer *buf;
+	unsigned int len;
+
+	while ((buf = virtqueue_get_buf(vq, &len)))
+		free_buf(buf, can_sleep);
+}
+
 static void out_intr(struct virtqueue *vq)
 {
 	struct port *port;
 
 	port = find_port_by_vq(vq->vdev->priv, vq);
-	if (!port)
+	if (!port) {
+		flush_bufs(vq, false);
 		return;
+	}
 
 	wake_up_interruptible(&port->waitqueue);
 }
@@ -1808,8 +1796,10 @@ static void in_intr(struct virtqueue *vq)
 	unsigned long flags;
 
 	port = find_port_by_vq(vq->vdev->priv, vq);
-	if (!port)
+	if (!port) {
+		flush_bufs(vq, false);
 		return;
+	}
 
 	spin_lock_irqsave(&port->inbuf_lock, flags);
 	port->inbuf = get_inbuf(port);
@@ -1984,6 +1974,15 @@ static const struct file_operations portdev_fops = {
 
 static void remove_vqs(struct ports_device *portdev)
 {
+	struct virtqueue *vq;
+
+	virtio_device_for_each_vq(portdev->vdev, vq) {
+		struct port_buffer *buf;
+
+		flush_bufs(vq, true);
+		while ((buf = virtqueue_detach_unused_buf(vq)))
+			free_buf(buf, true);
+	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
 	kfree(portdev->in_vqs);
 	kfree(portdev->out_vqs);
-- 
MST
