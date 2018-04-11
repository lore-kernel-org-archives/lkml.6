Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039319-1523472149-2-12148083336314117361
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
    1523472148; b=URvyQke0o6u7faECgbK7mUXZ1OGwuou0gsw/beYE8nnFO2YwzF
    Qn/ykrTKo2tGH4sFatua7/56aPFppRNzfUjyHb4vsGVfddZ6oyLG7vOcFYlVRXyT
    NXw8HXYWqnMwmNW+mVN+S+sG9X+6p5DSv+QT0OVZVRmYmcbNr936PSYlCE/f6bPs
    JUfp0OE2teJS/i60cP1pECpHjKPKjhJ9Z0FsHuL/quFWU1xKG3X5DJQ/pq9VKNGt
    H5n+MLpIWLvoaK8P1eOx6j+LuGsIeLn6fqoZyS/GLly2HqYadMCNDeAmB/BhZ20K
    QhFsIsxzX/O9+eWTfpcdsJqLisYJZKBneKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472148; bh=aMN6TVBM2To5xIV9dkb1O/j8yzciQJ
    vk/Je3A9IjEE8=; b=uwZrscYe8J111wSqX0vLpIEuWVafk65lGP7+OQnvxZ2sal
    9a8QifDg4dhmcwBG6pUmHEj3gOXnV52KjWD74OWbP4AyZjPNhKfcflbcXBhnChjZ
    gBJkoTBDlIBhCsmqHgPg9AijQ40BkqmV7hynhg1qrwym9GGFxkrZ4ZOvEZxKMd4I
    EujaW4I7qEIQEujYKjleeebTK8CDs4U+k6qzVSMkJc/QbKkqJ+7hufzEYkXVaeW8
    fn6yCtKBHUHSd24V7bC5zpN3Cf+zbJkr/po6Y4CWJhGr/T22F9aEwJ25kO6OQ/B9
    DfcNZhzTw5JcXUKnsRdyiICoEgjkrdfmS7GawKkA==
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
X-CM-Envelope: MS4wfPy0SI15QErpZl+JzrbG6bZJ6GAJPWoaER87nVyBb/ZtUvldr95DOsJDe8XfqvfdgYtAOaO0ByFvpDgZSKCDmcFiPM8exErZbJo+F9zmMT5JzfiX+r3n
    G3p2WUnMDEuotyFfVgypCLl9+h5/9abGSfhdAhImiBjI45S1SRitJoy09zUl5YmKvIL2//skANAyAO2+c9OGC8JW+UrJsrWJ+T/idHtIoqAQxq/TzmNzsQWA
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=UGG5zPGqAAAA:8 a=AMTvMMonAAAA:8 a=20KFwNOVAAAA:8
    a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=tm7yTRqP0MyoP90mQagA:9 a=QEXdDO2ut3YA:10
    a=17ibUXfGiVyGqR_YBevW:22 a=p5oU-coMHzOM5oT1KbOf:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeDKSmU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:42:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57114 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755019AbeDKSmP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:42:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 3.18 100/121] virtio_net: check return value of skb_to_sgvec in one more location
Date: Wed, 11 Apr 2018 20:36:43 +0200
Message-Id: <20180411183502.877953714@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <natechancellor@gmail.com>

Kernels that do not have f6b10209b90d ("virtio-net: switch to use
build_skb() for small buffer") will have an extra call to skb_to_sgvec
that is not handled by e2fcad58fd23 ("virtio_net: check return value of
skb_to_sgvec always"). Since the former does not appear to be stable
material, just fix the call up directly.

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/virtio_net.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -551,7 +551,12 @@ static int add_recvbuf_small(struct rece
 	hdr = skb_vnet_hdr(skb);
 	sg_init_table(rq->sg, MAX_SKB_FRAGS + 2);
 	sg_set_buf(rq->sg, &hdr->hdr, sizeof hdr->hdr);
-	skb_to_sgvec(skb, rq->sg + 1, 0, skb->len);
+
+	err = skb_to_sgvec(skb, rq->sg + 1, 0, skb->len);
+	if (unlikely(err < 0)) {
+		dev_kfree_skb(skb);
+		return err;
+	}
 
 	err = virtqueue_add_inbuf(rq->vq, rq->sg, 2, skb, gfp);
 	if (err < 0)
