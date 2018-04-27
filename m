Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524838310-2-12136344276230404339
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524838309; b=Xlm81ucXFXCtifcOlvOPj5Z+z7jzenNxRNDNEaD2dPGQOIa6+n
    gjQbuPFw7sLANiUKjqSXPAcv6AEJfnCwNHxLgmLttpcux2vY6aYUneZqTYKBjzPt
    bPnTSccwRD5x5JSYStn7cbu9PzgqKDytq+tTivk0tpxe0GOWEndAnad8AZKzysps
    V6fUH/RBIgA23vlgD5pamsyefvvL50mybsABCDS2d123u9LaXYYdQtopqjygzYPG
    S116e7kLljSbx9EGHVYNrZqp2QVMaIdrsQVMQDvrbe8gIo9G1nNvxhwLGL9PWCE4
    Sw+37RTv8Bsqj8MiiE0cERp4XTd4jwxRdlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838309; bh=1ablwz0uUQBs35rspVMYaLhOP3Nmni
    58OEpmelRf8Y8=; b=W1hIZtJHNcHNCq1rvYHY1+cuqYONEnDWBuyKNIDrgJFu1a
    EYi4TlM3uDC+aKVhmymMz+qbcrQul9ZTZZiA4/u9RCd07cvDCOzcz7fUoQzYNxU3
    ZUSW81xZsAE0VMikgMjcJ1O1OKANYl1MWtVicIxNESlGt67IqhaLLWovEdb6K4Pi
    pxo1Qa+giEfwz5JVTjHki7eh+S/DVJ300cMM4uoOWVglsqEbIZBPe399H7JGJzXx
    knsbWj17g9QdrEnPYvnkstZ5kyN+PJYEFWplXqydG3b9CCpyQFmqYdT8oFx9+Zcw
    6JoRk1h5R/ykskuB819vGXNRTKDLg86nWVd97C2w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNZvAdXz8Q6PLDVHFySd9D8cJpYjFiNhhPoKqCDsfE+ju4XF8cQ+Obht8Tkq+c8k7EtqPxj73gLE/rykZDJJ+R/Qhn+a8UYDzRdyrqlmf/37hdeMf3QK
    a4LIJz1FaRTjBe1n+ei+tM/5oOnpXKnNUOpIF1r7xZPUAuEMI0M9EmNXGRD6EFzxt1rGlZrePjwy84Rj8BrNfJSFGaSxtvx2heJF/oXf0VImqGCcm7URgQ2I
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=hWMQpYRtAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=0pm2IfRHqH4KOsd3xggA:9 a=O7wS3sNDcQHtxC9h:21 a=08H95I4FNwZwT5KQ:21
    a=QEXdDO2ut3YA:10 a=KCsI-UfzjElwHeZNREa_:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935071AbeD0OLo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934628AbeD0OLj (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:11:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D0721895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kimitoshi Takahashi <ktaka@nii.ac.jp>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 53/81] virtio-net: add missing virtqueue kick when flushing packets
Date: Fri, 27 Apr 2018 15:58:55 +0200
Message-Id: <20180427135746.321343844@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit 9267c430c6b6f4c0120e3c6bb847313d633f02a6 ]

We tends to batch submitting packets during XDP_TX. This requires to
kick virtqueue after a batch, we tried to do it through
xdp_do_flush_map() which only makes sense for devmap not XDP_TX. So
explicitly kick the virtqueue in this case.

Reported-by: Kimitoshi Takahashi <ktaka@nii.ac.jp>
Tested-by: Kimitoshi Takahashi <ktaka@nii.ac.jp>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Fixes: 186b3c998c50 ("virtio-net: support XDP_REDIRECT")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1269,7 +1269,9 @@ static int virtnet_poll(struct napi_stru
 {
 	struct receive_queue *rq =
 		container_of(napi, struct receive_queue, napi);
-	unsigned int received;
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	struct send_queue *sq;
+	unsigned int received, qp;
 	bool xdp_xmit = false;
 
 	virtnet_poll_cleantx(rq);
@@ -1280,8 +1282,13 @@ static int virtnet_poll(struct napi_stru
 	if (received < budget)
 		virtqueue_napi_complete(napi, rq->vq, received);
 
-	if (xdp_xmit)
+	if (xdp_xmit) {
+		qp = vi->curr_queue_pairs - vi->xdp_queue_pairs +
+		     smp_processor_id();
+		sq = &vi->sq[qp];
+		virtqueue_kick(sq->vq);
 		xdp_do_flush_map();
+	}
 
 	return received;
 }
