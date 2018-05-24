Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163227-2-11700187735179613043
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163226; b=LyrKLU9sJ00Hj2LDBrca7cgfF8R1IBomZ63RMUQucvvXr4X7P6
    wsdPT5Qhksoqk9R6XI9u3vuCP2CM3Av5lAG8D1TMcf0pSa7dICR8x+JuGcTpZMJ3
    GS/YoXBuEGTY0UI5jO6nNdHs0tHyhRCF/7OU6Js3/rHpVYwkRpQFN/nk5efhRHGk
    uf8CWfARvOhhpOxdta29boULjk6O6DsyD0XWmpu5wq8oD4T1ulKqKYf+tzlzCeTt
    ghOpfjQjP8ruKyx4iTtTVOm43wpbESYcJ0U8Ly1Y9ipjTcc3mdD2LVXz0L2dywTV
    XESaU6Xbk7j4aU73sydqfzfnwj+8e5Enu7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163226; bh=ccGZlLFwAEZtGgdRKncP3JU7eAB2p3
    tszQsrUB7u+2Q=; b=Zj9qio0fULqTN7JDeRwb7U+zTuJmmY4Zvn0y5jiGpmZDhW
    CME9dwX2ywPK4I8dKy3jvviLOyqS1TTb52tVCUZyO8aCU43e8JNaDDE5ODxMU8RS
    qmnh+IHO9YC0ps6bpcqpiVtNglgHW0Ta7lOQlmaGT4A8C7KXHEtfAMd0zcHHiMXi
    ClbNclQ9Khsqvt1AUySQ8CRdQQt4GdscCz6DqsFlqU4nlphFZ706+0+achHECWyT
    0PLx4jiMb0e7IqelVJqkZVdPhbVfn6AZ4vjZphkfLpv5vYgBxsC5pkJ+499HBi4j
    0KA/JKfF4vveoIV20bVG5jXVIW1ddjU3+RApS+kA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=nAGz/hA1 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=nAGz/hA1 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfESqzpQo7KJTxrusRjQbohmJ0nLSpYcXsT8zzDY2PXqUjIKcJrKWL4QtG9XRZwNh2d2qQfOuLzP717UNqj8kLPLx3Gl/CxDKxficBM8WFcHmVgt54d/0
    D9N/ZlJ6rQEzlJbP8OAkka5f+1avpdqnXmJmWjuYkIRZBKrGOW+21w7XLovpIajUAuD8MUTqZDV+ZAKxxi6/Hp5UZpCR/0xOJI+aExGhuo1t8l3iL2EQspFv
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=qjy3gpqsaOfp75Jk0UoA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966792AbeEXMAL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966462AbeEXJpH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 58/92] s390/qdio: fix access to uninitialized qdio_q fields
Date: Thu, 24 May 2018 11:38:35 +0200
Message-Id: <20180524093204.893790544@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

commit e521813468f786271a87e78e8644243bead48fad upstream.

Ever since CQ/QAOB support was added, calling qdio_free() straight after
qdio_alloc() results in qdio_release_memory() accessing uninitialized
memory (ie. q->u.out.use_cq and q->u.out.aobs). Followed by a
kmem_cache_free() on the random AOB addresses.

For older kernels that don't have 6e30c549f6ca, the same applies if
qdio_establish() fails in the DEV_STATE_ONLINE check.

While initializing q->u.out.use_cq would be enough to fix this
particular bug, the more future-proof change is to just zero-alloc the
whole struct.

Fixes: 104ea556ee7f ("qdio: support asynchronous delivery of storage blocks")
Cc: <stable@vger.kernel.org> #v3.2+
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/qdio_setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -140,7 +140,7 @@ static int __qdio_allocate_qs(struct qdi
 	int i;
 
 	for (i = 0; i < nr_queues; i++) {
-		q = kmem_cache_alloc(qdio_q_cache, GFP_KERNEL);
+		q = kmem_cache_zalloc(qdio_q_cache, GFP_KERNEL);
 		if (!q)
 			return -ENOMEM;
 
