Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481655-2-2356445399656793448
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES encaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481654; b=FKlDYwLsNYrhMTsSvg909UyuCtY+X1iUpOtZAzT1TC9OFOrAIe
    23Au7bngahvtCnWx1Ge0P8MxJ3TF7l1F1LNBz1KQFCJUREaxCHBiSCilE2OkLK3O
    D/g+ASQ58SlXkldaqsArtIFRX6F/MFADW88J6nTrazVTFVTMAfe7D7MLX0WPI8N5
    VFRYs5ioNmNDKt7O7DqcC6EsTk4D3M0n9lZuY4/nYJ8znvLRl7scmnBn5V4QeNlq
    75c0aP6+lGMQuMlAtcP977MBLXJiKdKzyfG8ByYoOxTyooJCcvr2nCmjEfi1M0UW
    t5AOx3gCVBh+CXwqObjnFkJ/9gLKy3J3h7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481654; bh=KJ/sb6agxnXBXbZMYjK8Xlvxgyap9j
    c3BfXBeREPZmw=; b=TwmcBNoliglAPDhu4BqA/16psjVeT34GWFrs5eGv68p9s/
    pR2LrG/3upOk2wT1WoNJBJZ0mZScCgkC5Reva0orEeL1vwRhQzhMV4KFhEs2/M6g
    hdxa863Ts7wkB5Ebx0lNVnQA1PtoCksgOwzb0z/RH6sanDh9at9Y2g5cjX796TIW
    +gq6ehXweR1xw9xoQ6nuoKiW5WK02MHXOxN/freN23Mxtn7Scg0MNvB0XF5hSTgI
    H84E9jOW8M91CQfcFsrs9vbXIkJ/dIVALxRGjXKDUUpx9INXRW4027YL3LFvjn+8
    SICp2kg/3grLjN9Oz3DWnKjlB5VjMcvC4h8NE0og==
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
X-CM-Envelope: MS4wfGOA0+2Gih8csF6igwK5Km1wLLwIH57oPl5Ri11Sh9DCrtElgTTyfsK7jwx5bn3IqEN/KAFBEWkwmfWcd4JGsc/QSJnjBIzEz6sEIzVWhJTj0I0YV7eE
    9l6vKCjfY63Ja/05ak3FnDeoPQrWRNTl6UZ+GIe1oHJrNmdno3wYT8aD5O5NNUAZ6HBBHDuapDNMtwpI143Nx0vO2RTWjPNdKMOaGc0sWGVvZ4VQj4YDYsAb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=FOH2dFAWAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=c5uIHsn1P3uz29lLov8A:9 a=QEXdDO2ut3YA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbeDKVUh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:20:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56040 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeDKSj0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 039/121] block: fix an error code in add_partition()
Date: Wed, 11 Apr 2018 20:35:42 +0200
Message-Id: <20180411183458.790555480@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 7bd897cfce1eb373892d35d7f73201b0f9b221c4 ]

We don't set an error code on this path.  It means that we return NULL
instead of an error pointer and the caller does a NULL dereference.

Fixes: 6d1d8050b4bc ("block, partition: add partition_meta_info to hd_struct")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/partition-generic.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -309,8 +309,10 @@ struct hd_struct *add_partition(struct g
 
 	if (info) {
 		struct partition_meta_info *pinfo = alloc_part_info(disk);
-		if (!pinfo)
+		if (!pinfo) {
+			err = -ENOMEM;
 			goto out_free_stats;
+		}
 		memcpy(pinfo, info, sizeof(*info));
 		p->info = pinfo;
 	}
