Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473881-2-17015594681064001447
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
    1523473881; b=Z+iAyrpK0wmIwVfiS93IHj1ABMCKwSqUzkhVPl5kjatHRRt7Fu
    xVXvdPgU7Uv6Rz5NVhZt9aIDHKRsX26gnS+Mk8plPPQSnhi+XLR2YU++g9fqVUjv
    nzpSKEC6Pz4obRXZMXBx2G2w3ho6uOhDIaBZU+7hsWA+jDhzpx7XiEGhEF+SJ73T
    Iae2tJFpubrkOLc4PemhxQdPLmkN0vCevLiq4LgXezeyD/p8BhKY7eVUTL4vXrva
    GsZFR/1BZ2TmbQmvaA7CKAKxQ6bzd0KQiI8ZKUcOwhA4VOKjVb91tAS2ij+ogOsv
    V8hIgAsLybf7kBel3YIgDJ6lJmjivSWz9X8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473881; bh=1RXtb6ZQgju75o4EBzr+mc49op10ab
    JFysDeWWVWLko=; b=copUJCVwdBsN9j64ItiWuRjCdzUTYMQeeh9JD64l/u/hVH
    vbi0oJa7n9DTCqddTcUjhuGHAmWNtZCfMZIu4vqsMUEFKUbaBy+ba3H/WSAEqxks
    q5FyfWevxefKyFBG8SZR6qix+xhhVx5oqnLTbFqmMGZbwK4g59OYKYLMhJsl8zOo
    jm4trXAXVDf0qRSgq8UuOP+oDNAyN2+4SYjb9wiPlsu3OGRETcZbOXofRR1pW4R5
    0iF+qnIrhxp1XMkFgutcmMNfDq/5j/VXYrEbxc+0jHEHoHzx3XimA0YzXZiCc2Fy
    nyh4nlAuawsQthAn6q/eWtobTuW+oJq4U6NzPg/A==
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
X-CM-Envelope: MS4wfLtaLlta4ppPPcwva/MOqDgNK/qX9IKctZBRzYEjQzsOf+mm02Wx3TZkGxUUGPnp1s4VT+rwPUn2Fd+/K6gSi1zj5q4aQ/F/XNUc1/O0JgHw6C5ek2E/
    leBbxA6Anh3oTZ7Ww59uUiC8HYvc81mVGV6aONuRlkTt5p1WvhOcxIsg9HCNryWk6h2Xl8dLAZ1ZADKZhIcDfaWVHZSOeDhu0b3HqTKz0myLgb0FyYo214iH
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=BfUTh4rD5ENHjmf4174A:9 a=i1_wZxKdJhItxwgI:21 a=6VQx6ZM_NQrM1O5F:21
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeDKTKN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:10:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40836 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935232AbeDKTGb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 303/310] vhost: validate log when IOTLB is enabled
Date: Wed, 11 Apr 2018 20:37:22 +0200
Message-Id: <20180411183635.587286856@linuxfoundation.org>
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
@@ -1175,14 +1175,12 @@ static int vq_log_access_ok(struct vhost
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
 
