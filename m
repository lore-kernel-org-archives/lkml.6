Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223322-1521650030-2-14473240438733979690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521650029; b=jGNKdXkQc+j+mq03sK6KyMX0ovXowxctLpO74XpUsIUxMLN
    VTWzia828A8Kvs0xVYx3OJ0osw1eS787f0APIRZ3mQlvMDcfUUDKrZAJOj5PScl6
    y3T7YeYHEw9vcN5D98WBROHv9iGGLS0SwEw+zRn8kmFK/17jJR3FUc7KYFFf+8jh
    eg/Ijel0mRfT2IrjRDzx/11wbBnLiCkgf+Axn05U3GJiZWCliwtCJ9PWWMgPBhSD
    w+pCagtrvV2JgBGYiKUCoTsLGnN+pRxG5an5rSJWo1+mE8Ghy1BICa2+hitVcm0T
    9qN4iY8OLvMVuFGvhrUJtJI6/NK27yq7upx5OVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521650029; bh=4E5mJBJh2OgugxWwSHvniLCWau
    ozmnlfDmN4c5FJByA=; b=pYm6UZX6dv4CFYhxZeAWe6pg5jFnJwfApVE6IbZ63S
    mxJe4ZJ8c7NICuZcJrSkHoMTqX4LzEKIRfzJfXFI2ksqT0lyHuPbkCX23/kZfKQd
    rLFBI0LG/wHn9Na57btDtrXQr7vIC5PU4Fa1Pkqp6WkZ7a1qLjsiCSnjKV1Fu1Fu
    29hoYB2BPauw6GDB8171Vf1Hkr1y7eg69KrfOu7jpRby6ybreWs0ftPnFrv9FMA7
    vClDwzruV6yqVidUgM4/tuCzsXzSA/fLGgB4zJvrkHE2ieONLBcM0JhZY/NYTLRR
    dZNGFgwEhDQ3xq4hvVGvu16+MLn3Q5PlrKZYO7Jv3uPA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=L9/HDzfe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=L9/HDzfe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeCUQdj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 12:33:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57550 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753084AbeCUQde (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 12:33:34 -0400
Date: Wed, 21 Mar 2018 09:31:00 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/28] aio: implement IOCB_CMD_POLL
Message-ID: <20180321163100.GH4807@magnolia>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-7-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:10AM +0100, Christoph Hellwig wrote:
> Simple one-shot poll through the io_submit() interface.  To poll for
> a file descriptor the application should submit an iocb of type
> IOCB_CMD_POLL.  It will poll the fd for the events specified in the
> the first 32 bits of the aio_buf field of the iocb.
> 
> Unlike poll or epoll without EPOLLONESHOT this interface always works
> in one shot mode, that is once the iocb is completed, it will have to be
> resubmitted.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

After this point in the series my familiarity with network code and
sockets drops way off, so please don't be too surprised if I don't get
any further.

--D

> ---
>  fs/aio.c                     | 102 ++++++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/aio_abi.h |   6 +--
>  2 files changed, 103 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 79d3eb3d2dd9..38b408129697 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -5,6 +5,7 @@
>   *	Implements an efficient asynchronous io interface.
>   *
>   *	Copyright 2000, 2001, 2002 Red Hat, Inc.  All Rights Reserved.
> + *	Copyright 2018 Christoph Hellwig.
>   *
>   *	See ../COPYING for licensing terms.
>   */
> @@ -162,10 +163,18 @@ struct fsync_iocb {
>  	bool			datasync;
>  };
>  
> +struct poll_iocb {
> +	struct file		*file;
> +	__poll_t		events;
> +	struct wait_queue_head	*head;
> +	struct wait_queue_entry	wait;
> +};
> +
>  struct aio_kiocb {
>  	union {
>  		struct kiocb		rw;
>  		struct fsync_iocb	fsync;
> +		struct poll_iocb	poll;
>  	};
>  
>  	struct kioctx		*ki_ctx;
> @@ -1590,7 +1599,6 @@ static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
>  		return -EINVAL;
>  	if (iocb->aio_offset || iocb->aio_nbytes || iocb->aio_rw_flags)
>  		return -EINVAL;
> -
>  	req->file = fget(iocb->aio_fildes);
>  	if (unlikely(!req->file))
>  		return -EBADF;
> @@ -1609,6 +1617,96 @@ static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
>  	return ret;
>  }
>  
> +static void __aio_complete_poll(struct poll_iocb *req, __poll_t mask)
> +{
> +	fput(req->file);
> +	aio_complete(container_of(req, struct aio_kiocb, poll),
> +			mangle_poll(mask), 0);
> +}
> +
> +static void aio_complete_poll(struct poll_iocb *req, __poll_t mask)
> +{
> +	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
> +
> +	if (!(iocb->flags & AIO_IOCB_CANCELLED))
> +		__aio_complete_poll(req, mask);
> +}
> +
> +static int aio_poll_cancel(struct kiocb *rw)
> +{
> +	struct aio_kiocb *iocb = container_of(rw, struct aio_kiocb, rw);
> +
> +	remove_wait_queue(iocb->poll.head, &iocb->poll.wait);
> +	__aio_complete_poll(&iocb->poll, 0); /* no events to report */
> +	return 0;
> +}
> +
> +static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
> +		void *key)
> +{
> +	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
> +	struct file *file = req->file;
> +	__poll_t mask = key_to_poll(key);
> +
> +	assert_spin_locked(&req->head->lock);
> +
> +	/* for instances that support it check for an event match first: */
> +	if (mask && !(mask & req->events))
> +		return 0;
> +
> +	mask = vfs_poll_mask(file, req->events);
> +	if (!mask)
> +		return 0;
> +
> +	__remove_wait_queue(req->head, &req->wait);
> +	aio_complete_poll(req, mask);
> +	return 1;
> +}
> +
> +static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
> +{
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
> +
> +	req->head = vfs_get_poll_head(req->file, req->events);
> +	if (!req->head) {
> +		fput(req->file);
> +		return -EINVAL; /* same as no support for IOCB_CMD_POLL */
> +	}
> +	if (IS_ERR(req->head)) {
> +		mask = PTR_TO_POLL(req->head);
> +		goto done;
> +	}
> +
> +	init_waitqueue_func_entry(&req->wait, aio_poll_wake);
> +
> +	spin_lock_irqsave(&req->head->lock, flags);
> +	mask = vfs_poll_mask(req->file, req->events);
> +	if (!mask) {
> +		__kiocb_set_cancel_fn(aiocb, aio_poll_cancel,
> +				AIO_IOCB_DELAYED_CANCEL);
> +		__add_wait_queue(req->head, &req->wait);
> +	}
> +	spin_unlock_irqrestore(&req->head->lock, flags);
> +done:
> +	if (mask)
> +		aio_complete_poll(req, mask);
> +	return -EIOCBQUEUED;
> +}
> +
>  static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  			 struct iocb *iocb, bool compat)
>  {
> @@ -1677,6 +1775,8 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  		break;
>  	case IOCB_CMD_FDSYNC:
>  		ret = aio_fsync(&req->fsync, iocb, true);
> +	case IOCB_CMD_POLL:
> +		ret = aio_poll(req, iocb);
>  		break;
>  	default:
>  		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);
> diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
> index 2c0a3415beee..ed0185945bb2 100644
> --- a/include/uapi/linux/aio_abi.h
> +++ b/include/uapi/linux/aio_abi.h
> @@ -39,10 +39,8 @@ enum {
>  	IOCB_CMD_PWRITE = 1,
>  	IOCB_CMD_FSYNC = 2,
>  	IOCB_CMD_FDSYNC = 3,
> -	/* These two are experimental.
> -	 * IOCB_CMD_PREADX = 4,
> -	 * IOCB_CMD_POLL = 5,
> -	 */
> +	/* 4 was the experimental IOCB_CMD_PREADX */
> +	IOCB_CMD_POLL = 5,
>  	IOCB_CMD_NOOP = 6,
>  	IOCB_CMD_PREADV = 7,
>  	IOCB_CMD_PWRITEV = 8,
> -- 
> 2.14.2
> 
