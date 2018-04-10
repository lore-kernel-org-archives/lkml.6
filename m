Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523400150-2-15544599289869588051
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
    1523400150; b=JTrIx7ROkI2BALVVbdmyADwHdnqYzOZNJcC0E6xPHqSvQnxUuG
    1zv53jVHgE3cjvEU2cvuGRSXc8Ltrcv7NMqlG0RcRpH+as5zSJXXp45R7oFyCtHX
    61cS3ip7/e3NoP5b1/GOxc1TuUuNBtaCafZtonkoUngRI8CakT0sigBG2PhGi/Ak
    Hw8bTg9QasQTRrroNTgiMJCIN4KMPnbWNPVLVES9sjT6+NYp4WEA0hN8xTPwiP+I
    1pIEdO/3hdtF5PWtQjuxzr3oggwZJ8LwNMXMxO8ebjiMn91S6kD1mDCU2OErxPBg
    ywp33cct/9DZq8LsNONc9euv8Lv7EJJfGOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400150; bh=KyHYRUXmWQcZJFN9pyOhIH8KhlE6xu
    1xTw3IerqCYuI=; b=A76X+v5FUuPOM9kZpUTN5IHOWXGNHYd3tWjOP9xduXECDn
    lV5SxbQakYNAzvm3BgblpskEZOfTcwy5DSsGRH2OF/K240o2bDWgNUNQF6hwYOd8
    BYNmpmr9ws8PHAEcrPqiYKVqAYdYFvtWBAYgb0e10mHHcnkxFO0DyfdPoy1sKwVx
    UnyAnsROJvWrr1btUoMdVBRbQl1RqeXBsC955ty12D6+qf2WmMjiPXcdtYSRM1Yc
    bHW/HIW0dUrrYWxXkSky327vY3tnVrm2EqZJEupWGP1M3XkoMCCMeTOxRvIGEWXk
    0t1nq8/AikhThY8gH5kEPTREOxhFMj0ZGUsghnvw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfObw3B2ydKJ/0vdCyQ4T6Uk5OWtaNnXinJQxy0E98eX0MsfQ6nR+bxD7K7B4u08+4tpqpaSrXm2jUmH4JCOY2/RkhJ+gTbrvljfljfLKWjuvf7PCmamp
    TQTqJypzGbZCKG+gMn53uuMcbtIsWMZhcgNR4T/xDgTZvu+4i8YfXOyCgpoTxg9eyuPif6MPf+9/EShFAt07veNIbEVVUQEcZ93ZNuNK923xNvNjpC4ZV7Qc
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=1pB0iXOITbQmDCDZV7sA:9 a=mVkuK23AttXBeS0K:21 a=nwQ16E7mQNhVHWJ4:21
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754563AbeDJWkD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:40:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932680AbeDJWkB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:40:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7f073540b1384a614e09@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 137/138] vhost_net: add missing lock nesting notation
Date: Wed, 11 Apr 2018 00:25:27 +0200
Message-Id: <20180410212918.165552577@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit aaa3149bbee9ba9b4e6f0bd6e3e7d191edeae942 ]

We try to hold TX virtqueue mutex in vhost_net_rx_peek_head_len()
after RX virtqueue mutex is held in handle_rx(). This requires an
appropriate lock nesting notation to calm down deadlock detector.

Fixes: 0308813724606 ("vhost_net: basic polling support")
Reported-by: syzbot+7f073540b1384a614e09@syzkaller.appspotmail.com
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/net.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -622,7 +622,7 @@ static int vhost_net_rx_peek_head_len(st
 
 	if (!len && vq->busyloop_timeout) {
 		/* Both tx vq and rx socket were polled here */
-		mutex_lock(&vq->mutex);
+		mutex_lock_nested(&vq->mutex, 1);
 		vhost_disable_notify(&net->dev, vq);
 
 		preempt_disable();
@@ -755,7 +755,7 @@ static void handle_rx(struct vhost_net *
 	struct iov_iter fixup;
 	__virtio16 num_buffers;
 
-	mutex_lock(&vq->mutex);
+	mutex_lock_nested(&vq->mutex, 0);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
