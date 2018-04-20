Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2222763-1524248338-2-4648350861609404068
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enfr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524248337; b=R0XV01Z5OCJ2DnNi3pQl4NR7eraEK9tGcCKzngRiBIMw193Kmi
    FgyXVkmF8U/VDknf7HK8fP+vuxIw+pTkFgUY88gti2tvWDgBDtoSMQ1T3iSpuvEx
    /FyQkTa/x58CDXhejIfXNV5Jdoc2YNLXhHA7yOnrFG/aKEeqXZPG2Jikip+rs1CZ
    q+2PxFtjfcsvVtDXVIWYhTh+CFfjFKs5IXjOYzQ20L3SKc+HYi6xy5uZvpgC0Rom
    MlYulqJzkMn2lXmBYNlYwl+hoMhOAR9XS7gtv6qI128k0rVkdQpVJeIG8HPs2taG
    Z+qro232iG8gZ0y1o658uO/RfsVNg+PJNDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524248337; bh=neGm39E+LVV1kF8+Z+5evcg+Ray9NL
    nxK1DR+X9mUtE=; b=ZNtEy3AJIf3ImL3pqIAmHWF7lVp7uUYn8aZiQ7iODrmO/g
    FCpSFaSAKnQl0Q7OENAJWVBchJPAYvRDcAdCmvsYzv5bZ2e0AnoudyIorQUxh7ii
    Nw477x1ptpmJS3sL33nqkiptZX55FEle7qGtMewb6iCXZGLW4A8LFKOMO30wH8kn
    YbgfcYgt6cIetc9VRVKt1DnTH53S+ebUja4+dskelskAfVdLjLAgnLGletz/DKYQ
    mmMx4GxU4BwQxC2k7wZ4Hx9cJ6LtDguw128hM+mP6vLsFD8UPlSpoOp4MLkNDkyU
    qubPIW5/kARL4Alo65ASFGaZnKg5ogMnDMcw0hWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfPR8SfJnaMp2BVE7FR2LpmUo3jzvCfb769yZqpOZJngI13e1xfadW8x9wmAkKmt13kzK27V4IGISRz3cpF9QxkofoY3tYb31GbC/2E0JtGgqj8CVLqC1
    6wCMZq7vWr7LqKlVlxZN64EMUKi7YLtCGSyf6LkTqRWLhj0WvJ9R4BX68u18bTN8UPdhj4gFZRI5ghQ9gcYJmv5BUbIh9fy7UrJooN5f9XHwVbEi14amj2v2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=_ym-k62AjudfxA0QQeYA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbeDTSSm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 14:18:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753782AbeDTSSF (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 14:18:05 -0400
Date: Fri, 20 Apr 2018 21:18:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 4/6] virtio_console: drop custom control queue cleanup
Message-ID: <1524248223-393618-5-git-send-email-mst@redhat.com>
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

We now cleanup all VQs on device removal - no need
to handle the control VQ specially.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 26a66ff..2d87ce5 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1988,21 +1988,6 @@ static void remove_vqs(struct ports_device *portdev)
 	kfree(portdev->out_vqs);
 }
 
-static void remove_controlq_data(struct ports_device *portdev)
-{
-	struct port_buffer *buf;
-	unsigned int len;
-
-	if (!use_multiport(portdev))
-		return;
-
-	while ((buf = virtqueue_get_buf(portdev->c_ivq, &len)))
-		free_buf(buf, true);
-
-	while ((buf = virtqueue_detach_unused_buf(portdev->c_ivq)))
-		free_buf(buf, true);
-}
-
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -2163,7 +2148,6 @@ static void virtcons_remove(struct virtio_device *vdev)
 	 * have to just stop using the port, as the vqs are going
 	 * away.
 	 */
-	remove_controlq_data(portdev);
 	remove_vqs(portdev);
 	kfree(portdev);
 }
@@ -2208,7 +2192,6 @@ static int virtcons_freeze(struct virtio_device *vdev)
 	 */
 	if (use_multiport(portdev))
 		virtqueue_disable_cb(portdev->c_ivq);
-	remove_controlq_data(portdev);
 
 	list_for_each_entry(port, &portdev->ports, list) {
 		virtqueue_disable_cb(port->in_vq);
-- 
MST
