Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477724-2-4002916522401822534
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES fren, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477723; b=LWAZZLHwhdyD8r/IVX0I4ocbA0AQbR2EDVwZI+pJP4SvE78x2M
    Hu+n+3gExkJsZvgvmdXlroAUwUL0eseergtFHdKV7uzvFaiqjqLUJXpfUeR1uiZd
    BNSPugR3y2rUUy78ni65584amT9BlLxi0gP4q4lgiZOVCsL86kSxpMFmhpwZ5JwX
    RY0AQBQvmZFeDg/dOBJJTbKLhOyJquxPtX/39P6sPv4bn8QwInwbBgJdGD19CRyH
    RPpym66IHYwWiVLJYY6tbZHi9rvYuYeWTzw9C+ltc6en7rZ58fObBJM0nfN+VidN
    Db6QiJ7NUCdgL5x/BO+ru2TeAObboPcWHoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477723; bh=oFk84lpKx4lEpr6UZpRE2hLr3FAR7D
    G9arGlCFbX5+o=; b=LOpWCHPJi9s1Np4qG1Dqx/+53kPDT91/RYcvYh2MsaRDS3
    xP+NjFp6dplV1wEXqCtVQkT0/2o/I38HDATvKT/wMKCs1O2M4GxAR9ULlnLSge+J
    nTofSJu+5wkJZ27JdEw51AJTaP2QVyGxRGG0o/KWHJfbrOHgMvNhEyfajWuqNi3C
    QtbyBo7al+DXLEFdnTt6c7xKXvh1Repo1pnQlM53/FKxVSASChtl0w4NWeE4R8fs
    Y+PXpvpGSPm7e8+NNu0F+RzO9rjm4miPGkfth/ODLMmZT8csi6lCvQoq2Bk5NPBz
    zcgWo8qAGOyELV+FuoC5JsXoJt5R0vVHNqdFzb+Q==
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
X-CM-Envelope: MS4wfAp987gUv7ue1c4e13LlERk48oEKS8wmAV4UJcGFXJUtGbEq8lCBWC3rBQRsmbbLmm0jzUM4Gen3NzcbL65/EeG8Q3lHpJQBdMBeYg1/jDcrsLbw3wTi
    qD+n4Ii+PKNnGgruICcff7+mgVVwjpsy8IpPJ5dhFLkUz/Azsqs0LojMYihIW4n/zHuTasMURFnjpisYQ7HdzI7a4SmOUJgkNd0L+i+6kP02ltK0o5l9qcg7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=eh1Yez-EAAAA:8 a=c-n4J4-pAAAA:8
    a=iox4zFpeAAAA:8 a=ag1SF4gXAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8
    a=3HvizH4TVtXJx62AY30A:9 a=2Sayc3mZ1gRaMaqE:21 a=XgEUsmkCx6zncoXk:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=L0NDqeB7ZLmQzAogN4cw:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933257AbeDKSxX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:53:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbeDKSxV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 021/310] drivers/misc/vmw_vmci/vmci_queue_pair.c: fix a couple integer overflow tests
Date: Wed, 11 Apr 2018 20:32:40 +0200
Message-Id: <20180411183623.204492193@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 146180c052a00172f4dc08eaade836fd02f61fb5 ]

The "DIV_ROUND_UP(size, PAGE_SIZE)" operation can overflow if "size" is
more than ULLONG_MAX - PAGE_SIZE.

Link: http://lkml.kernel.org/r/20170322111950.GA11279@mwanda
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jorgen Hansen <jhansen@vmware.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -298,8 +298,11 @@ static void *qp_alloc_queue(u64 size, u3
 	size_t pas_size;
 	size_t vas_size;
 	size_t queue_size = sizeof(*queue) + sizeof(*queue->kernel_if);
-	const u64 num_pages = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
+	u64 num_pages;
 
+	if (size > SIZE_MAX - PAGE_SIZE)
+		return NULL;
+	num_pages = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
 	if (num_pages >
 		 (SIZE_MAX - queue_size) /
 		 (sizeof(*queue->kernel_if->u.g.pas) +
@@ -624,9 +627,12 @@ static struct vmci_queue *qp_host_alloc_
 {
 	struct vmci_queue *queue;
 	size_t queue_page_size;
-	const u64 num_pages = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
+	u64 num_pages;
 	const size_t queue_size = sizeof(*queue) + sizeof(*(queue->kernel_if));
 
+	if (size > SIZE_MAX - PAGE_SIZE)
+		return NULL;
+	num_pages = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
 	if (num_pages > (SIZE_MAX - queue_size) /
 		 sizeof(*queue->kernel_if->u.h.page))
 		return NULL;
