Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523400083-2-7306140077890362171
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
    1523400082; b=pEJdL5/CeUg3ymqeUwsgTKNUAL9T2cZkWEJnKFwQSrF7QRWNxu
    +h+aH1SXjgYvyOe1BNBfKXm6BAuOS5nW4SWlHAqBG0edkid9ctInUR0IK3aJs5m3
    NaKEJqwlw06j1uB2QFGgvJbMWApsLMGLuZ6ttQfzHGFPqFpNz+yESGNK13LVI1oZ
    QqeF/tYiKIZlS9jd7PBd7PQL9WcQ/rjC9dcEHQKkquFfmZs6eRhutd15LDj2tGu+
    qWo0hJIo303D16MbWsiFDtXYBWZexllBNT3E5iV8tlS8addrnj1UlW54kkwfvTGW
    yunxFZuSIJPsVWIPD7ZWH3kXxji03iK/Lqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400082; bh=woi7oeHj2QGaPmtXXDKkjhuy1hn7OX
    coRMzNq86jIRg=; b=TNhcUGYcOsxpaJlwEIxobHiU5sV8liXwG0q2haTmbIX0Gy
    U2n/Woo3RV7UYxSRGqAGZygz57YBDJPwuc0Rz6PrxcM07j4VgflqdX12b894g67G
    xBknNq7Q1g5gqDZb28NUBOqP62/K69n3MDDKNrTFqZjtZG8fA4D+Dp/N2porMZDs
    /G+JVOMYaknltDcX7+lnx+5HBRanmXa+AOInAPH+Dl204NxZ/0DwOu0QgDvsU3Rk
    x7a26gH1dBt6YNOiQy15sHtkGHktW7zdXV4IQA/fKfGB3WazNJbefD4YL2xCxVZz
    kxC4iEl+W5RybIHnrmD1+dvxXWQSGh9jvEloWbOQ==
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
X-CM-Envelope: MS4wfNRBc1TFvgbw+TkT9X7Dr1h7xU0sCkKIhBh4/J7iKGZHCsITzd+KwUn5kEN+FAKL9O4CeP0jx0nBnQVTJPuLyIPl3Ymon9nQfnbEWHzRL7hhZfdNL+8G
    DBYFoL+N0y2db3dQQrIifZ4648NNeSGuJI5lanA3NPjdkwlXUEYAqcuvK4W5Rhgp0qXQDLLpLC1TMCeSkaxtkWhrxe/V5pnNdwqYUyt6dUC3Dch7ICjmFFN4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=pLoruLiFDANQYzNcO30A:9 a=1p09Xky88IM9OuM4:21 a=6VQx6ZM_NQrM1O5F:21
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbeDJWkX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:40:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46734 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932736AbeDJWkV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:40:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 134/138] vhost: validate log when IOTLB is enabled
Date: Wed, 11 Apr 2018 00:25:24 +0200
Message-Id: <20180410212917.818627954@linuxfoundation.org>
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


[ Upstream commit d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ]

Vq log_base is the userspace address of bitmap which has nothing to do
with IOTLB. So it needs to be validated unconditionally otherwise we
may try use 0 as log_base which may lead to pin pages that will lead
unexpected result (e.g trigger BUG_ON() in set_bit_to_user()).

Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1252,14 +1252,12 @@ static int vq_log_access_ok(struct vhost
 /* Caller should have vq mutex and device mutex */
 int vhost_vq_access_ok(struct vhost_virtqueue *vq)
 {
-	if (vq->iotlb) {
-		/* When device IOTLB was used, the access validation
-		 * will be validated during prefetching.
-		 */
-		return 1;
-	}
-	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used) &&
-		vq_log_access_ok(vq, vq->log_base);
+	int ret = vq_log_access_ok(vq, vq->log_base);
+
+	if (ret || vq->iotlb)
+		return ret;
+
+	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
 }
 EXPORT_SYMBOL_GPL(vhost_vq_access_ok);
 
