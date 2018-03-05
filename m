Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2684081-1520286723-2-14679007493169052238
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520286722; b=l9zxiEX/PFrQ2w85tLY1Mr8dz13yZ0YmxNv8VCtp4zGUUFp
    kGBZC46Ei+XbzEzZfNTzhMHMIN2reXi/3yFvlnLf9BBGUMutPuTyeFqoA6wvftsp
    VKDdbc42+k9HVDqtnCBUp4KCM0mPyeb9sHluIzxwJXMfJ3aPqp5ANzJFjufgIgkQ
    aibX6IYjZFMClPet1ni1zZZzkhlIj2zjYlwN8vNLt9C7rsmiVFmpZfVV77WaJ04u
    Gn9ZcOnNZcideV/lKHAwdc/hB3sohud3VLPz+zOQMDJUkGx3IKETKjpYAhd4FzIN
    nKQTpSpUs6bcAQ1mlucbFfI/n4TLgNyVogIxvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=arctest; t=1520286722; bh=xCnlr67l8CLyX0QPpn2Rfuzx4P
    ntAiSgod9C/pwk0m0=; b=OkLn0fspILYfWQuCgeFyImkz6ROWDQwNMwPyTidhv/
    sBAHMdUD4XrrviSMt0L5/ky+LMWTsRAAe8ez29Crp38yM//RY1PTTZYZAE6QuSkg
    CfXph08dUCTWyDxjJzSBBqPELvsdukJuJiRfQhuIn+Z0vEDLHrHWOpL2COxYKuMR
    Cwd7K04eABNJp+6w5s3oT8oyfx5hDGIx3ggUXwQgW6CsMp6GQMh6GtvVdBASTM9K
    cAnGCVicRdUtQloXbVUe7RmPKWD+BZ1a+OaU+Q+ZUiiWIBd26k3cTiyiqp9wCzQr
    y9POvNHu5nKnwSoO82JvP0CTJr5NmOTKYXP2LbMJGA0Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeCEVwA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:52:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753137AbeCEVv7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 5 Mar 2018 16:51:59 -0500
From: Jeff Moyer <jmoyer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/36] aio: implement IOCB_CMD_POLL
References: <20180305212743.16664-1-hch@lst.de>
        <20180305212743.16664-15-hch@lst.de>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Mon, 05 Mar 2018 16:51:57 -0500
In-Reply-To: <20180305212743.16664-15-hch@lst.de> (Christoph Hellwig's message
        of "Mon, 5 Mar 2018 13:27:21 -0800")
Message-ID: <x49bmg29on6.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

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

Also acked this one in the last posting.

Acked-by: Jeff Moyer <jmoyer@redhat.com>


> ---
>  fs/aio.c                     | 102 +++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/aio_abi.h |   6 +--
>  2 files changed, 104 insertions(+), 4 deletions(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index da87cbf7c67a..0bafc4975d51 100644
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
> @@ -156,9 +157,17 @@ struct kioctx {
>  	unsigned		id;
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
> +		struct poll_iocb	poll;
>  	};
>  
>  	struct kioctx		*ki_ctx;
> @@ -1565,6 +1574,96 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
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
> @@ -1628,6 +1727,9 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  	case IOCB_CMD_PWRITEV:
>  		ret = aio_write(&req->rw, iocb, true, compat);
>  		break;
> +	case IOCB_CMD_POLL:
> +		ret = aio_poll(req, iocb);
> +		break;
>  	default:
>  		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);
>  		ret = -EINVAL;
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
