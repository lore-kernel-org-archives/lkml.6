Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2222763-1524248319-2-16201566909038499174
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524248318; b=f73qPp2Xe7ERb0kSg4HLG4S4x6G9887UkxbCD2zEp8nyBad2Pq
    zrsz8ROka57TgBg7QpVVSzlwb+zaZOAh3Mk+q1KRyCxNT0bWKlH8WdEUWP9kRlXd
    n48uNI/z5IGDoQMGbrCEoMHVGlEVb6+22JLFfASUxZHMMsXHsraeloFZrnlUNpMk
    FRW3lE5Cq8fj9Ut/rsK9OX0iU/hpaepDjomIQrrOVVuPUlSTLPR6JNTlwR4P8sh0
    +tl44E7ZciSYZph39GGVJ/cCUoUiGvsy7AY5qv/uXoyB4JZYTcxBCljUHPT2Lrm0
    Q2Zgk2rrneTm7OkxAa4KhdQFYxWjA4WRmbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524248318; bh=MxsH4c5diKRNF/YZQYFPgPwmdNDbQb
    JLXCGlj75UcgQ=; b=r4/UW2zcer0UqhK1zCSr/lZ7T2WLv/qBHIOrkqv/G244Ym
    ySplBfdZUxnISmeXU/xZL0qIqQH37c2gy///h9nUqdp/z88uSh3i+quNckF5j4kS
    E2hAPITnIzh0qpWTS5tPzyam8HkV2bGELmrkpfbqdT0C04zhoY0GAPhU+mi3lBZH
    mLYn0QSGnFDUGQqBDcdejiNMhQCEOc9dSho7dJ3T2AZtxtHwjaG7uO3QdokloXe4
    Cu7vq6O79nM/iKxQwdcAu9fhaPVDVlsOgrfTCQOi9dNbh89qi3pSWwMSPxkxinx7
    OgeoRR7gIe80VoXxQMyzxsMgpPMBIBpkIzMQ4XZg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfJIn1/aDaUEVdMVkWEl//YbJ8EZW92quLA3AMRgqysVVhyvm1Fjayp57zYy9DbnQUyM6PGbrp8UtKZU+rNG+VZejCiIwsYx/618BhBbvfM/ALRHdkgwp
    PV4i+RTnu/bxQaxTx0eEJZMb/sfaqSSY0FoKw5jqflWAR/3pKeNfRh/tCIIUIBLfutjUH0cBbuNOC5k93MNNUmRf0SE/r6OAefEA+pyexR/3jtggdj96t2ge
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=-BF7RMpBGUrKxb8xwUoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbeDTSSJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 14:18:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753706AbeDTSSG (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 14:18:06 -0400
Date: Fri, 20 Apr 2018 21:18:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 5/6] virtio_console: move removal code
Message-ID: <1524248223-393618-6-git-send-email-mst@redhat.com>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524248223-393618-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Will make it reusable for error handling.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 72 +++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2d87ce5..e8480fe 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1988,6 +1988,42 @@ static void remove_vqs(struct ports_device *portdev)
 	kfree(portdev->out_vqs);
 }
 
+static void virtcons_remove(struct virtio_device *vdev)
+{
+	struct ports_device *portdev;
+	struct port *port, *port2;
+
+	portdev = vdev->priv;
+
+	spin_lock_irq(&pdrvdata_lock);
+	list_del(&portdev->list);
+	spin_unlock_irq(&pdrvdata_lock);
+
+	/* Disable interrupts for vqs */
+	vdev->config->reset(vdev);
+	/* Finish up work that's lined up */
+	if (use_multiport(portdev))
+		cancel_work_sync(&portdev->control_work);
+	else
+		cancel_work_sync(&portdev->config_work);
+
+	list_for_each_entry_safe(port, port2, &portdev->ports, list)
+		unplug_port(port);
+
+	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
+
+	/*
+	 * When yanking out a device, we immediately lose the
+	 * (device-side) queues.  So there's no point in keeping the
+	 * guest side around till we drop our final reference.  This
+	 * also means that any ports which are in an open state will
+	 * have to just stop using the port, as the vqs are going
+	 * away.
+	 */
+	remove_vqs(portdev);
+	kfree(portdev);
+}
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -2116,42 +2152,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 	return err;
 }
 
-static void virtcons_remove(struct virtio_device *vdev)
-{
-	struct ports_device *portdev;
-	struct port *port, *port2;
-
-	portdev = vdev->priv;
-
-	spin_lock_irq(&pdrvdata_lock);
-	list_del(&portdev->list);
-	spin_unlock_irq(&pdrvdata_lock);
-
-	/* Disable interrupts for vqs */
-	vdev->config->reset(vdev);
-	/* Finish up work that's lined up */
-	if (use_multiport(portdev))
-		cancel_work_sync(&portdev->control_work);
-	else
-		cancel_work_sync(&portdev->config_work);
-
-	list_for_each_entry_safe(port, port2, &portdev->ports, list)
-		unplug_port(port);
-
-	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
-
-	/*
-	 * When yanking out a device, we immediately lose the
-	 * (device-side) queues.  So there's no point in keeping the
-	 * guest side around till we drop our final reference.  This
-	 * also means that any ports which are in an open state will
-	 * have to just stop using the port, as the vqs are going
-	 * away.
-	 */
-	remove_vqs(portdev);
-	kfree(portdev);
-}
-
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
 	{ 0 },
-- 
MST
