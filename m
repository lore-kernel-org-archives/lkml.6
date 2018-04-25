Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4146373-1524627875-5-11091258550898897754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524627875; b=womZnW0NoEMZXUT3ZiVof7hcveJtRHWuUVmM209n6TQBRk+6h3
    VLRx2e+CD9MD6+hnCgiw7sDTKrbKa9asT6b30GlplOI19rNZ5cJBr0DuGIjw9ql6
    jjEgBoY87QnID52+se01GnkJQqiL2jPnTA7ddbtNdln7Lv6JPNEMYEigrmrpAcFL
    Osq3wq6Igyv5J+R7G1GluoDQp90AGXImAyMKjgPFrBukLWrZPwJ6bjyisr2LxOjp
    Q3Wbx2iq3KUL3eO4A/BC2xFj8ObaCcAX5NyLEhGFfE2rKPH4ssU1uU6tZjxQpqH2
    hJXSZ74zEQvXVQpgTUR9Afe8wPrgpjHV3KOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524627875; bh=wneIV
    dAH4tnJ5clzlQU5ksK767RTTS5/HDbQhIoogDA=; b=J1oXOMI/VC6l7FJR5MtZ0
    tA4Yk3kzpeoTKd9ZfJaDF7+hH0R9s6wwYGhxW4IdUKMoOp0W4AJuX3z/Bp1o5L/Y
    ffPMbLeT93r0afIpOPM/HPeNM1naDFK+6J7pWDrtxRVv/iPWCOdG63OGUbrnDyZ3
    eMqVQBnkZXMZeR3aEQQd7qVQQyBY3HnHGpwviyNmTYaT4O/dltR1JcZxHrGnTyTj
    ngIjPgA+SBH87EVuVNQf7o+wT++aXTbZMzA/v2XzxpYhKpTFRa0YOYe6CDK+tGU/
    KPoIga55yQkDdvD4Aye2ZNiu1t0S+SUJkv38IVgXxU9SeMuFtHNEyVOwSvVqHedT
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=O8XCtg53 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=O8XCtg53 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=O8XCtg53 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=O8XCtg53 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMKp35l6jVPGFN1H8JVaplk7rriWhHMvXL1YpjFA88otb1h/b7q/tp5dKSZVjWwtSOoGSVGRd93OE+5fPzxfVdsrLAgm8xliQ35FTOTJiJ6lO+VfyVQK
    hHb1UaJ1QrOIIGT72GzkpQXjncM1C+lafEy43Ru2uZzWocU/7szw52doffBUyybslEs2kdB402wY4kNIIg2wv6KORFwJIVFYsW2VxfYI+U8s+81xWzfMKeEP
    aNHDVeF3L9ccnrUiSXrNfg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=LpQP-O61AAAA:8 a=DDOyTI_5AAAA:8
    a=nlBReJhuOfJfO7ktIx8A:9 a=CjuIK1q_8ugA:10 a=pioyyrs4ZptJ924tMmac:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B92F6071A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=vjitta@codeaurora.org
From: vjitta@codeaurora.org
To: labbott@redhat.com,
	sumit.semwal@linaro.org
Subject: [PATCH] ion: Consider ion pool pages as indirectly reclaimable
Date: Wed, 25 Apr 2018 09:13:50 +0530
Message-Id: <1524627830-17187-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, tkjos@android.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, arve@android.com,
 Vijayanand Jitta <vjitta@codeaurora.org>, maco@android.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vijayanand Jitta <vjitta@codeaurora.org>

An issue is observed where mallocs are failing due to overcommit failure.
The failure happens when there is high ION page pool since ION page
pool is not considered reclaimable by the overcommit calculation code.
This change considers ion pool pages as indirectly reclaimable and thus
accounted as available memory in the overcommit calculation.

Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 drivers/staging/android/ion/ion_page_pool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index db8f614..9bc56eb 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -32,6 +32,9 @@ static void ion_page_pool_add(struct ion_page_pool *pool, struct page *page)
 		list_add_tail(&page->lru, &pool->low_items);
 		pool->low_count++;
 	}
+
+	mod_node_page_state(page_pgdat(page), NR_INDIRECTLY_RECLAIMABLE_BYTES,
+			    (1 << (PAGE_SHIFT + pool->order)));
 	mutex_unlock(&pool->mutex);
 }
 
@@ -50,6 +53,8 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
 	}
 
 	list_del(&page->lru);
+	mod_node_page_state(page_pgdat(page), NR_INDIRECTLY_RECLAIMABLE_BYTES,
+			    -(1 << (PAGE_SHIFT + pool->order)));
 	return page;
 }
 
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
