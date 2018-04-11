Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479659-2-3124371067950472800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479658; b=Wcy67cOFfE2hx5K46GblgioJgS4ENDUPsvBiL89N5nlXhNdo9M
    qMMP0Ox6cB/yvLSpW+wd5jHwqfzq1YW7Qb9UxBwDFROzzrI8dkf6RX+/qRFr/V5W
    KqO8Ar6BtCifqqnJpHVzeWz3CZVRUFLFfW4mWDQG+nyLsaU/PqCKXJYkIwUg5mVF
    /Jw82SMAveBDoG4ofS8K8w2SCeniN1Efo+h6vL3VmQlfASixkQNpuTvv3m1Xc79D
    lm3MYJCtuHKKtEtVxWozrUfbl5IMB/Qdnr3TmD6pTcihEPHCIM66d6WNCQI5CYr+
    Fcg6/wTei1EdniGH9FjUzFKSNSQ8HAMjXWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479658; bh=BJRbwy5GM+S5vGVqWp2GulZVJp5YgD
    jC7pJjB/jXjBM=; b=SGN+q/FpqlXU3AgZwwYbPp+FzWt1710JkVUPQaM4qZqFr/
    t7NaEBulpRByx6y4xoNQIbrjyz/ryAss2mr7+sZ6fFn/qudKaYsVt1WsqFH25QBF
    suUWWkIqJSwzPW4EOWqRDMDNY711+ViX/kDO+2i+f+axufzHcRk9U+KZYjv+S0bU
    cAdCoZJku5h6h0tuDUG9Kqj0RltYbrb+OGXUSRTGhUWxC9BXZjJAoEEJcZXvJhoF
    6Q2+c5Voyig7QBG0jxDm2ss6pZsAJXCrZCFveTaD4kK/Sf/cwZmCMA1Wn0CgelMp
    M8e3bNbyFjex4GnKl4rEqTs5tFfG73psbb0jdqFA==
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
X-CM-Envelope: MS4wfJo8y83JymVqTA9CgxfnORcjzSnzYsFAVQ8ePD2Qmrqz+wtFNNm72VEzKVdlev3pXUzHhXkAVe5l2pq5RGfzJ652Xe61/jgp+zGG3bwdWcIy+xW+i9by
    5KcglOQ11s/c7FJ1J5EkMaXBBP1Qz/CGz6+x/6JzyqL3iF7MX/7R3Mo484TuooV/8E1wsOsZlFHcfx0ImJw+dHJfG+X5zIQXtH7n7g2BrWC511Ue3gcgsN7s
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=whL-I8Ncu8VTbA793AgA:9 a=QEXdDO2ut3YA:10 a=vzdIw8kzLcqZOxdJCU6L:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756209AbeDKUrY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:47:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932349AbeDKSq2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 070/190] pNFS/flexfiles: missing error code in ff_layout_alloc_lseg()
Date: Wed, 11 Apr 2018 20:35:16 +0200
Message-Id: <20180411183554.400079524@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 662f9a105b4322b8559d448f86110e6ec24b8738 ]

If xdr_inline_decode() fails then we end up returning ERR_PTR(0).  The
caller treats NULL returns as -ENOMEM so it doesn't really hurt runtime,
but obviously we intended to set an error code here.

Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -461,6 +461,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_
 			goto out_err_free;
 
 		/* fh */
+		rc = -EIO;
 		p = xdr_inline_decode(&stream, 4);
 		if (!p)
 			goto out_err_free;
