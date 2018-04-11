Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3150701-1523473798-2-8349424266446496669
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
    1523473797; b=U0Uv7dePcSdXpLTbil1TudxcfacbkzEdSx2ilJGh++MqqdCSgO
    h3Fcrr/jfE078LbCiQNsTcE1tB8Rpuj1se2nb7K4uvJUe97UvhqrCHfPLVi7Tlwf
    iBSMkewmRQpcNoLjD4kK8OFmq42GpGUeYo1rKhmnGUEHDoKxHI09ArqaiNg2FDKN
    xvN/dnT+OqTysWW/6MJ2IzIb74sjjPVKVsLTsUKEA7DlH75u9bM5EFNvV5KvuW4a
    KafPtXQltRY7LC9bFkoW2UJL5x305R6Nz0f0ZS5elOQBop8TWoQooJKvPCN1iU3R
    9TXv+rsVVOVkY58owTpqXGj2ASO0RAikiA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473797; bh=clXL8o0fnO27S19yR5Me9t4NE9ocjs
    2qJ1oZEXD1Kdo=; b=Hxxt0/bKp6EeMWpdntkoGSZMwcDSaiQmPGxhZUfuxvh9V5
    VQCTn32DAbHhMx1tEiVG55Aki0JC7SEG/1kx93r/i7QVBJaCgkeUiGSh9JxB7KC3
    W1ADVxGPDDOHbPJkB/g8Lqg1Js1IJjQwmsHtK4dT4FmITdR8rSM6evse99jaeJre
    N4c5GZHMEa5BXmzYEF9/TLk+4zgi4crgZbTnPZcL4pwqcXwjtWhXS62C9heZWRPX
    TK8jsh595pE5y85dmas/vAjMddSDPrgeGzw+YqgSKTxxuzkMPAvBYSUYhKQ8Rz26
    SPlZdY8oVYG6Fnt9SAH/Vzu1ariTcj1Z6O4+LiJQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfD/AkKJGzpocDVi4JU2+OKdBjhz1mT2b2L9BQ1/gqMam3MOSXXNYCqQ88/NV0idHfXZjEXiTwRtrCjchKsHiyL2QzpKJdsmmMJ8Dmw/9X1sJYwdLmeE+
    KEy5y7af00ufs5NnYndsrMjWzcexeTRqpWhbisjdFdjSXELcQO+d97+vATb8SDVFlt3RXTAVjAeHsg7lGEZuNytToEqKHD3bLOiS4hDkYd5LgICS5pXSieoW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=1pB0iXOITbQmDCDZV7sA:9 a=7Ku7ZD0yW4bsnk2K:21 a=nwQ16E7mQNhVHWJ4:21
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935263AbeDKTGj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:06:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935257AbeDKTGj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7f073540b1384a614e09@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 306/310] vhost_net: add missing lock nesting notation
Date: Wed, 11 Apr 2018 20:37:25 +0200
Message-Id: <20180411183635.706806905@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -524,7 +524,7 @@ static int vhost_net_rx_peek_head_len(st
 
 	if (!len && vq->busyloop_timeout) {
 		/* Both tx vq and rx socket were polled here */
-		mutex_lock(&vq->mutex);
+		mutex_lock_nested(&vq->mutex, 1);
 		vhost_disable_notify(&net->dev, vq);
 
 		preempt_disable();
@@ -657,7 +657,7 @@ static void handle_rx(struct vhost_net *
 	struct iov_iter fixup;
 	__virtio16 num_buffers;
 
-	mutex_lock(&vq->mutex);
+	mutex_lock_nested(&vq->mutex, 0);
 	sock = vq->private_data;
 	if (!sock)
 		goto out;
