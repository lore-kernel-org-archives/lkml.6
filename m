Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523399463-2-13381922907163490810
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
    1523399462; b=C+Dxa4eH+gASjIIBlJb+b0mOeoGSPaiSwJV5Nn6t+NXKPHto4M
    PHoMP9Bw/+8yPRwc+f6K3ECgK/vksF9ahj5v2vl2uJv7ql3RKfBtLrJpvUACpayK
    709ltldinFnSBBY2g3jHvVS4pzpTHjwqG6bAPnM7XOrw/sjYApKKQ92mrWOurx/x
    vkE5pZcSf+kGhlHZ/EezZyj4IKzSX5rUDF2A8TuXxcMZIEwGeKJ4FsTj03SzbnE+
    CRvxhZ+r3wQMCbEbITbmnV5+eCD+mP9LnpuCC0r7dMwsHqK53WEX3G1TgxPtIG6M
    vFsLDY5vELcYv3gNlJMwoLekM26xRdbZeTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399462; bh=mpBI5Am+kqg/bKyEgRHzsTqX9ecmo0
    rrH6wEFJk8uGs=; b=ClmPGq+x5BDJkJMdpwTj8s830pnOzfn/oQMq8CYHij7ENL
    dQNS9mn88mw0CJL4uB1Oa67Kbg0ujyR6mo/+jVjo8WXGRhtCT2j1Fiifv74w+KDi
    Up3kLnszPTV7/QY/y/OsrwCgbaQYcdZThHrtbZGHjPRp2UKqjzRW3oRdcdrw8FBJ
    kHVAtNZGAHbLZzdvGG5DwoI4U8SzrpOuG18lwCfQscVfRd5RxJYQ6AFzJALFiNxL
    b9/UlOF2mrh1RYox65BxHZlezK66YIaNB45M4r3JybA7KdY1dNOT5fQnIJ5V62MN
    fMPqT/xzcxerS+WlS3th7Jpcup8ptvXuJIok/sKw==
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
X-CM-Envelope: MS4wfC3r1hxdZz/9kHqPtos+vqOITKww1b64YHyDN+gIaL8xXrQzzy8LJRjM0T3Y8Rvbqr63NdK2rlvgOwRTtzt4eYz5Az9KLvCEoSuAz/92kuNZwgZvJU8f
    6xsYTELQHe9/nHJy3eQ631Dkw16InbSzg7h+nAK671QqO7LcydEbs2ITghcIVBkGLD7D2fI1TcndJKFT+3HlC6dI9y1cZkETXTld9jaizSvNtPkMBFKeOdaq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=4q1Si5jR-L8UMUJKs8cA:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754709AbeDJWa7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:30:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40206 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbeDJWa4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:30:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 096/168] RDMA/cma: Fix rdma_cm path querying for RoCE
Date: Wed, 11 Apr 2018 00:23:58 +0200
Message-Id: <20180410212804.335965237@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>


[ Upstream commit 89838118a515847d3e5c904d2e022779a7173bec ]

The 'if' logic in ucma_query_path was broken with OPA was introduced
and started to treat RoCE paths as as OPA paths. Invert the logic
of the 'if' so only OPA paths are treated as OPA paths.

Otherwise the path records returned to rdma_cma users are mangled
when in RoCE mode.

Fixes: 57520751445b ("IB/SA: Add OPA path record type")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/ucma.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -914,13 +914,14 @@ static ssize_t ucma_query_path(struct uc
 
 		resp->path_data[i].flags = IB_PATH_GMP | IB_PATH_PRIMARY |
 					   IB_PATH_BIDIRECTIONAL;
-		if (rec->rec_type == SA_PATH_REC_TYPE_IB) {
-			ib_sa_pack_path(rec, &resp->path_data[i].path_rec);
-		} else {
+		if (rec->rec_type == SA_PATH_REC_TYPE_OPA) {
 			struct sa_path_rec ib;
 
 			sa_convert_path_opa_to_ib(&ib, rec);
 			ib_sa_pack_path(&ib, &resp->path_data[i].path_rec);
+
+		} else {
+			ib_sa_pack_path(rec, &resp->path_data[i].path_rec);
 		}
 	}
 
