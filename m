Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2412624-1526794424-2-14976412880538388546
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
    1526794420; b=Gg8GhHym1182ffwp9OgUrnVNp/J0IGbePVaoEF9aCAUwz8Aggj
    eXIX3ZcLeSMXIHA34F7n40PZiZir22fNwp8w6bEpVosfYOmsi7jU1fOxJUpGLtTl
    bPvD5lwQhBQMju6hZO2ekpYwUCweiIPQw2RXfhGA64PJgyXH1mhR8Syu0Cy+7/ny
    CU23dfvkOevHTxZg3nBwVaVXbObXlkdXwWvthHxP+TGdOqeBmcXKriv6v2GSKxaD
    A2z1nde0MM9raYUadQm3/k4SvWrQ1qvyBJ/nd8J3aDjljt4sbqcFnfpBdV0VtHGD
    7CYgeD2mbIy34rEjKh5EjbX9XAYaATMSyuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526794420; bh=J5V2zKYmQGBEHKreMCH0vXrW2ewNUG
    aUWTolDtcWN50=; b=GPEOdwLUeD88RnuGKzDT/EuzsCxfkT0hmqQn2WFRHDMtgQ
    XbELDJf9fCjEq5D6ujm3SXiFuUrlVpt31YNZ8P36QQjLisODYer96rMbgHfYKKjD
    8Z2/GG/caDDAGgbdsj3yikh7XuRZlZT8xBGHcsVSgi4Pe4ELyrrOAb4iFCJ3i8B+
    xNKeNmYlQUfRRjm8p6NriEVzT3jsRzpCGonwHFmt7CA4Phn/h5oPoFqY5kEQzzLh
    eTT7ewhOp0G30pqMGDj3rd8xK3RkfJz6ZqNxeenSCi/3fQSb2gpDL/wRFu6l6Kwd
    NEnEStLx4ffwiQ9OkjGJ+Ge5gMBYi/P4/qyiuMxg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfPUIx4sH2GAbsIiWp1BaDrxvpI6GZCBGuFcj25lH9XnG/71b0mAuL6I4SDDH28mPOXo8ZJp7ax4KgXHyeOT0JfekBkAqAvwryDadpR9Nzyq4LrOCBn/O
    5t9rMGsfr/awn4VCjWDxWSaQJuI9wmftRVUjyICDfWww5vfBKpuRet+jFC+EJHAyLnKPoFf04hNRCj1okJjebeLv73pb5bnUQd9GpvlZYr9cEssl6XTpv4MB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=W-zAx6Qnem87JT1tI20A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeETFdU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 20 May 2018 01:33:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51690 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeETFdT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 20 May 2018 01:33:19 -0400
Date: Sun, 20 May 2018 06:32:25 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/32] aio: implement IOCB_CMD_POLL
Message-ID: <20180520053219.GZ30522@ZenIV.linux.org.uk>
References: <20180515194833.6906-1-hch@lst.de>
 <20180515194833.6906-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515194833.6906-11-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 09:48:11PM +0200, Christoph Hellwig wrote:
> +static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
> +{
> +	struct kioctx *ctx = aiocb->ki_ctx;
> +	struct poll_iocb *req = &aiocb->poll;
> +	unsigned long flags;
> +	__poll_t mask;
> +
> +	/* reject any unknown events outside the normal event mask. */
> +	if ((u16)iocb->aio_buf != iocb->aio_buf)
> +		return -EINVAL;
> +	/* reject fields that are not defined for poll */
> +	if (iocb->aio_offset || iocb->aio_nbytes || iocb->aio_rw_flags)
> +		return -EINVAL;
> +
> +	req->events = demangle_poll(iocb->aio_buf) | POLLERR | POLLHUP;
> +	req->file = fget(iocb->aio_fildes);
> +	if (unlikely(!req->file))
> +		return -EBADF;
> +	if (!file_has_poll_mask(req->file))
> +		goto out_fail;
> +
> +	req->head = req->file->f_op->get_poll_head(req->file, req->events);
> +	if (!req->head)
> +		goto out_fail;
> +	if (IS_ERR(req->head)) {
> +		mask = EPOLLERR;
> +		goto done;
> +	}
> +
> +	init_waitqueue_func_entry(&req->wait, aio_poll_wake);
> +	aiocb->ki_cancel = aio_poll_cancel;
> +
> +	spin_lock_irqsave(&ctx->ctx_lock, flags);
> +	list_add_tail(&aiocb->ki_list, &ctx->delayed_cancel_reqs);
> +	spin_unlock(&ctx->ctx_lock);

... and io_cancel(2) comes, finds it and inhume^Wcompletes it, leaving us to...

> +	spin_lock(&req->head->lock);

... get buggered on attempt to dereference a pointer fetched from freed and
reused object.
