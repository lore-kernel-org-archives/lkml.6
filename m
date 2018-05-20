Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2412624-1526794084-2-3700274716011367369
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526794083; b=ZGbpmat96AAxEqT92yRboFJrBzPcEUjK/Hroj5kdR85eGfAXt2
    gNXcRq/3MCuvQeBuOlKZZlzeF6kSSF6yfEX7OsG6Ubr348Fj0lpjywJ8rPFHeZnl
    Pxwc+0KIIL49024P3+6rIAqnezLIqy9FbRY/lCA/gB+RxloGGtx9i9ol3Zd4piFn
    XKazg2m5e1sO2ETh6MoN/zYSrhmJvvjGHDbqnaw+CE+wXgJlALj/eIq1Iez10maS
    cK0WDiTwXkmRaMv5JTqF1t2psVP4S/CDZXvq8U2gJW3mscs4PCm0DPVDca8jIwnu
    IUgpolE6cxoVDfWjeICQ5dVrHJen/Lm9MnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526794083; bh=B1ZkEOMhtlqJcT+cCHgZ+sJAVPdRox
    Lhzbp7C/iYXaI=; b=jhXd9oXh8YBDm3HpfVSEOJ1he3/P0Ov155aA1+im75Ks3M
    E15GNxFemjRPi0S2jTvCDA64snncHe8dty2edrKfYg5s1Y90cRGPu+Aks4oy8yDn
    0HDtyvEzjiIquqxenAQ2oCmEtFg/dU9ynb5wu/JclBEFlsKTRS80bjSWoP82AERX
    46f7N8tNLd7q68jHnLt51PEAmfkKbjM3DeWMQQb575fqpj/pQqCgyzqZ2UR6/Uf3
    vmopId38NuCUVfIxDegd7z6PEILn6/+DdVNExrnjOQ52mN3jW7xuUvEYG8K1CqwQ
    Rf1B+6qME0nRmVLmcIE/KrlD18x1TEPKkSG04eKA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
    header.result=warn header_org.domain=linux.org.uk
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
      header.result=warn header_org.domain=linux.org.uk
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMc3gb/iRbgb4Ow0WM8zZdhwPXF/JsC/ZNqfa8zY1ZT5LzDqPtqKqPIQwLRqATXVhTKjA30ytGDDz+XCPkiI53FzAqofa6qrMgL5K9ZTcwOiRUwY+uvH
    4R+TOf3ypjnH9rzphv3jrLINbJlvNksUXsbT9WZmiE5HzMuS+/PwM1fq3LV+9uKSYyH/ftVdts6IVHqshvZ4kQFmIMWx0M5tesJs6ZYRW52Wyj7PkOy9szi/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=fc8I0kf6A93oNrznqK0A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbeETF2A (ORCPT <rfc822;greg@kroah.com>);
        Sun, 20 May 2018 01:28:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51590 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeETF17 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 20 May 2018 01:27:59 -0400
Date: Sun, 20 May 2018 06:27:27 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/32] aio: replace kiocb_set_cancel_fn with a
 cancel_kiocb file operation
Message-ID: <20180520052720.GY30522@ZenIV.linux.org.uk>
References: <20180515194833.6906-1-hch@lst.de>
 <20180515194833.6906-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515194833.6906-9-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 09:48:09PM +0200, Christoph Hellwig wrote:

>  	case -EIOCBQUEUED:
> +		if (req->ki_filp->f_op->cancel_kiocb) {
> +			struct aio_kiocb *iocb =
> +				container_of(req, struct aio_kiocb, rw);
> +			struct kioctx *ctx = iocb->ki_ctx;
> +			unsigned long flags;
> +
> +			spin_lock_irqsave(&ctx->ctx_lock, flags);
> +			list_add_tail(&iocb->ki_list, &ctx->active_reqs);

Use after free - that list insertion used to be done by drivers and doing
so before any ->ki_complete() calls might've happened used to be their
responsibility.  Now you've taken that to the point after ->read_iter()
(or ->write_iter()) return, so there's no way in hell to guarantee it's
not been completed (and freed) by that point.

Incidentally, none of the callers gives a damn about the difference between
0 and -EIOCBQUEUED now, so aio_rw_ret() might as well had been made void...
