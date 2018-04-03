Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182135-1522749551-2-329305167658190214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522749550; b=DSZKx/7RrpuhUPppYPXuW96SO7vCla6IXwXi5uQ6Pex03IEITv
    Fq+tl5LIfW6YWgwwtU+VldENbFATk+5HPhLQO4EnFk69X1kJy5DFXdNHxreHo211
    Iv88Fyu6oONSj8whgC7b/PBs2XwbdxZ+fOTzxJ+koKA2K/mtIeMO1j0uG/WRPWxy
    bR+xzw92KipIrLjgbWIuItuV6SoRorA2h7vWdMKskbsEqvOINktH0pOkekM8dr4u
    39GwHZxrIyWNhoX8bsHFhUCySBoV6V9DocHNSJHGFMY+E38OEyMMQJKdSqKsj81d
    sS6Y/uY+7uWd5ui7Qf7UxThZvukRyUErD3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522749550; bh=JSNGuHSm+7MSGqXIWI4cqEvDsRnq6e
    3QO8ZrxDfR22E=; b=VhXb3xnYLQu1CMxU+G3x+d2d5oHpeuTkwe092qNosBSpT0
    GO+31mMLhUT2+J2hMUKgVCiBDFdFCqQWh8IonJ30YBJOWk+vUZ6l4k4MRkVQh8KJ
    tvSogkMIqDIeCmmxN/sJc8R5p94JvernehEHVeWJuITFKFHOcJq/xa05vUcme1kl
    S31k+DYAEiEow8ttIOu4CPbNhpMg18naYyNbCF6B2Pi7j2U+x7EqAWOvh3Ps7xWK
    lLTzK66a869unPHmCeqDnpSVxek6MQmDqt/Z1a81BAbPr8iuTcc2ylzXBWz5Jz1D
    pyD4wyYODS0cCcKDpfRgbshVxVifCkX6RU/1dxMA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfPXAr59khCANiFFpzCYQtIguiZzvWlj+4wI91ylBgYlDXui8WibEtLkzPVBcTloVZqnsLEWEoEl4F4ym768WgCA+9u4LuFrSqpHAcDC9fqL0w2qwhQpO
    v6mtkPFFXEkrw+2ETeUHD8Kgrk34T7GFBugwp1tfYUTxQZcLbwVt5iSz2kadVVcJz+9WDUREk+xQNzRCM8GjPtSOqaRf8h+RYNPg4NUnP22MDwYdllmIx1yf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=ePdMqToNAAAA:8 a=20KFwNOVAAAA:8 a=VIXy6wiYodPrrMOquqIA:9
    a=hbKeS-eqEzA8Ata3:21 a=exkvX2FUgcdUgVQY:21 a=AjGcO6oz07-iQ99wixmX:22
    a=fq9aknvlO0Q50tsIl6NS:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754931AbeDCJ7I (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 05:59:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754910AbeDCJ7H (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 3 Apr 2018 05:59:07 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: amagloire@blackberry.com, Gerd Hoffmann <kraxel@redhat.com>,
        stable@vger.kernel.org, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: fix vq wait_event condition
Date: Tue,  3 Apr 2018 11:59:04 +0200
Message-Id: <20180403095904.11152-1-kraxel@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Wait until we have enough space in the virt queue to actually queue up
our request.  Avoids the guest spinning in case we have a non-zero
amount of free entries but not enough for the request.

Cc: stable@vger.kernel.org
Reported-by: Alain Magloire <amagloire@blackberry.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 48e4f1df6e..020070d483 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -293,7 +293,7 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->ctrlq.qlock);
-		wait_event(vgdev->ctrlq.ack_queue, vq->num_free);
+		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= outcnt + incnt);
 		spin_lock(&vgdev->ctrlq.qlock);
 		goto retry;
 	} else {
@@ -368,7 +368,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->cursorq.qlock);
-		wait_event(vgdev->cursorq.ack_queue, vq->num_free);
+		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
 		spin_lock(&vgdev->cursorq.qlock);
 		goto retry;
 	} else {
-- 
2.9.3
