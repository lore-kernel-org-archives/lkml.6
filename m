Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-93447-1522980961-2-13172352158255932331
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522980960; b=EK0WuZbxseAwHjghexT9Coa4jB68tSPheejmgvlMh26KCXYiHa
    glsaA7ma4UBLKxv6XGHfzcK5nu2FTn0C0icOHApaLa2WfMb2rXFIFDyGSOhKwWft
    TJt0xr+PJXrP+xrG1C4uj0/h3OQe0ihfws3u+dzvwPPEB3W36rkmYSoERwwJpN7i
    SB4XMKxJCF5KMG3G9uRXUu+KmsVmo41FU6QNEL4E6EpHSFNcbTBNT9/NHdHuaW22
    A4Wk7OvfMKHRbc5IdQc/VA1lxBhLx7dvU//OW38AMBVhE4II+0OxZtIi8pEgx7J1
    FuXrlw5s0M2C77xsWbnTWxzaMQyTibOz4pRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522980960; bh=XFQKx+SlBp0aPJuPLl5eY/HEVHh0MS
    wodkgQWOlxlio=; b=SzxBL8h9ZIQX/EXHJFBUH3cNwYFU76zC4uQwR1mxG8Viel
    yv4iYHJsXunBBAGWZt5nCtwcrfzRTZY+AJ4yHlrmiDGqJyibnSCa+95JIksjggO2
    k3j0MyJvdxMtGocWniiZmft/kmOtiGMfVBYC866KaluK6X/FfcXrX4NjHxPOQ3cj
    UTy3qIUX8vt+PPvSxaiMjQi041OHrCPpavF2aw1OsVE90NAdk04pIUql3XvKoujO
    Uvju75JOyq3q4YiHVbYAZXEnwPlYLRBxemzQiY4SZuTpTOcpRMC4kB/7/u8eVMFu
    OFj5rdgbkPUHwOn/66ct4yODwih7mjS3VxpiH93g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFNza5zcBryVihsVCVC/NYCkNWvAXkp6hM7becb0W22AX+m9KiVcSCsOFhQsW5ZEXjx9FrtBBlP8HKKqbmFQdAfPsbUQQOfzWmQYkGmqrQ9DzNQcTEII
    28FuhevxBo6a/WxL8noOV353em4cBJUmNNguWKZQ7XxuiudMMZiFxj9vZRaIGuu3pZ9ZjC7w2sAPjAt/JaxkLJaxNVBSkEjuhJLGux/F1+OVlWjdQ1GsErCD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ITQxPpdZUBjbnp3qPPUA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeDFCP6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 22:15:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46242 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeDFCP5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Apr 2018 22:15:57 -0400
Date: Fri, 6 Apr 2018 03:15:53 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/32] aio: replace kiocb_set_cancel_fn with a
 cancel_kiocb file operation
Message-ID: <20180406021553.GS30522@ZenIV.linux.org.uk>
References: <20180330150809.28094-1-hch@lst.de>
 <20180330150809.28094-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330150809.28094-9-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 05:07:45PM +0200, Christoph Hellwig wrote:
> The current kiocb_set_cancel_fn implementation assumes the kiocb is
> embedded into an aio_kiocb, which is fundamentally unsafe as it might
> have been submitted by non-aio callers.  Instead add a cancel_kiocb
> file operation that replaced the ki_cancel function pointer set by
> kiocb_set_cancel_fn, and only adds iocbs to the active list when
> the read/write_iter methods return -EIOCBQUEUED and the file has
> a cancel_kiocb method.

> @@ -1440,6 +1423,16 @@ static inline ssize_t aio_rw_ret(struct kiocb *req, ssize_t ret)
>  {
>  	switch (ret) {
>  	case -EIOCBQUEUED:
> +		if (req->ki_filp->f_op->cancel_kiocb) {

... and by that point req might've been already freed by IO completion on
another CPU.
> +			struct aio_kiocb *iocb =
> +				container_of(req, struct aio_kiocb, rw);
> +			struct kioctx *ctx = iocb->ki_ctx;
> +			unsigned long flags;
> +
> +			spin_lock_irqsave(&ctx->ctx_lock, flags);
> +			list_add_tail(&iocb->ki_list, &ctx->active_reqs);

