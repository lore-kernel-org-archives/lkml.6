Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216147-1523476396-2-16502093137699237968
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
    1523476396; b=OaWDAHGX2DjN01qkcKQUcktkq7Gue3Dh+JxdSFZrrAO7rXQDHj
    5yXKqkFucp09vioWqd4TZmk4YjUY8rgc266TxRbsx/RX6KNo9D0uDJg0SUTJ8b3t
    OSlsPxcxh8OhB4F7nEiBmXx/KRv1QrEuzYR5B6TiALNazKv6IbUk8gbfAyc4pSpN
    7xHkNNU6cRDlv30lNI7eWiBmHHwQkjRk3sGTYZleNQYxoUPoIEJjMptD6r14jxt6
    H2mGPCZ9in0G53CUBGsJvvIOq4G+EV7yE0f3gvjBImgnSfE22reB+e31WeFyuSP5
    4c6lqFLVAKUKSqymS+6+1pmeUhKxUjcXtP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476396; bh=1XIQ+OUCVxVFD2x38gQg+IjNbw+Buw
    LyeyDGBl2vUBQ=; b=S6Zt+q2KGqGfdZKCXW2UMgLLOB+Zw0Kj5xs7J73ry6Lsj2
    1IVWlHEL/wBcwQ6VFYVo6rzGr/Yy/oCTKhl7DKXtBrfJb4PexY8vxMYu6Ti5Jid2
    sHmAVE8S+2ClD3/6Wxy2lRpMyvFKLsv3GH/NRrLn2XLhq/MIygEf8dR0Rjy3Vv3E
    CrYE14AcJIDsbTHFEchevfJ2IbBjBZZg+tNPtEyLjVoZzT+D5xpjEuyhaoRVYfJF
    9egropgv84qv9p8M/PmJyac+6w2Vy/YoQfpTK3P1pAnmEHsNkZ4WPDGtbaxkaWI+
    0Nt2WXHnKm2jZ7DSuuZQPWwo9BV9QFHTYF2lNdvQ==
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
X-CM-Envelope: MS4wfBF09BTqVyLADD9a5vRK6Bj916GgnaIuatt9/vZ9m+TP8sPyOAl3zjPL+ZLe4LNDYm2EJdVd9J9Uqn3Bkg0fG+6AUNVCcTmaJtWa+sZdtu85YdRzq4I8
    5ZnLRSnvZ/FfPPx4M4tN33uHmk4HNLSquJTgsbjLUEAA8pruaFpWPDQ6hIafSuyUV1QsVRN9SEHerESx06pa9GLQgm8q8cmV0NUqRvwsswwjEjg/Ji4jO6Pm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VZJtwKKvAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=whL-I8Ncu8VTbA793AgA:9 a=QEXdDO2ut3YA:10 a=vzdIw8kzLcqZOxdJCU6L:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755136AbeDKS55 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:57:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754213AbeDKS5z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:57:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 103/310] pNFS/flexfiles: missing error code in ff_layout_alloc_lseg()
Date: Wed, 11 Apr 2018 20:34:02 +0200
Message-Id: <20180411183626.650941949@linuxfoundation.org>
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
@@ -475,6 +475,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_
 			goto out_err_free;
 
 		/* fh */
+		rc = -EIO;
 		p = xdr_inline_decode(&stream, 4);
 		if (!p)
 			goto out_err_free;
