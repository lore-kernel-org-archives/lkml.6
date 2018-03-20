Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4041595-1521505218-2-6528694867377385381
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521505217; b=JKWuv6l8Ymb6XPQqxWEC3bulG15wKfBHVHxLprWV5slOuKZ
    sc47AljIM0b3KEXo95B67fExRAShrFx3kkin2MVP+gxJWv4ibZOqa3gUSsDdd8C9
    G3gdfV/rHLZ6WRZnLuY4QABJfVXEyvJfGNwqEDxhZBgn+EhtX6gaIvsEmiNUQJS0
    WGQfcCGY5nWzTYZapLC+4nPe8Sc+l3up51TomFWjKnUnkPnyih8cxzrYvmkQumol
    L83X+umX/hjKxNwySLwNd08qT4M1vIkTFAMz7YdyCJHX0Srv/JHWS+fnit0UIcSp
    iC2R5FcCy/tmXZB9ZDL6HXcP+D4EeSy1Udu3yOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521505217; bh=PVacu5lNH1snvhzD3qxS6OYvko
    S9kSv7U0B/e78bTKI=; b=L2Hqf3uKL1sxf5FLjnNjAHA8788ZyC1bXD+fhlsTmF
    9J4c+0st1lmL5UMTf3VPcCq15bRT8qMY2a3ekUPVJPoKsXXlZxaDitYqyI0Zq/Tu
    1AdGMCYTbSzbvz64/5C5MHeNUADJjLjzCDa8m6kHYzN3Qfr2ZBLbYTsFjYHi/eIQ
    CUr9ry6UFDBba/LiUJ/wb51wL+TSoc4h87+ep3zD11RRl6DiZsAM7ub7R3aPDCZE
    QCt56Yl0PrSH2YmNB3lLN0P22GcsRGEPK+6i30XZMjXdWxLOUR4fAUm/ju7/5IRA
    QliQBvNQAlD3rTBmPRXYSeZU2lN5xRoiJ5KituNJ7YKA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=OE46aiAN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddvtdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirddugeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudehtdeltdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=OE46aiAN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddvtdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirddugeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudehtdeltdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965792AbeCTATP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 20:19:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38860 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934168AbeCTATN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Mar 2018 20:19:13 -0400
Date: Mon, 19 Mar 2018 17:19:05 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/36] aio: refactor read/write iocb setup
Message-ID: <20180320001905.GA7282@magnolia>
References: <20180305212743.16664-1-hch@lst.de>
 <20180305212743.16664-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305212743.16664-4-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8836 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803190149
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 01:27:10PM -0800, Christoph Hellwig wrote:
> Don't reference the kiocb structure from the common aio code, and move
> any use of it into helper specific to the read/write path.  This is in
> preparation for aio_poll support that wants to use the space for different
> fields.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>

Looks straightforward enough to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/aio.c | 171 ++++++++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 97 insertions(+), 74 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 41fc8ce6bc7f..6295fc00f104 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -170,7 +170,9 @@ struct kioctx {
>  #define KIOCB_CANCELLED		((void *) (~0ULL))
>  
>  struct aio_kiocb {
> -	struct kiocb		common;
> +	union {
> +		struct kiocb		rw;
> +	};
>  
>  	struct kioctx		*ki_ctx;
>  	kiocb_cancel_fn		*ki_cancel;
> @@ -549,7 +551,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>  
>  void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
>  {
> -	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, common);
> +	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
>  	struct kioctx *ctx = req->ki_ctx;
>  	unsigned long flags;
>  
> @@ -582,7 +584,7 @@ static int kiocb_cancel(struct aio_kiocb *kiocb)
>  		cancel = cmpxchg(&kiocb->ki_cancel, old, KIOCB_CANCELLED);
>  	} while (cancel != old);
>  
> -	return cancel(&kiocb->common);
> +	return cancel(&kiocb->rw);
>  }
>  
>  static void free_ioctx(struct work_struct *work)
> @@ -1040,15 +1042,6 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
>  	return NULL;
>  }
>  
> -static void kiocb_free(struct aio_kiocb *req)
> -{
> -	if (req->common.ki_filp)
> -		fput(req->common.ki_filp);
> -	if (req->ki_eventfd != NULL)
> -		eventfd_ctx_put(req->ki_eventfd);
> -	kmem_cache_free(kiocb_cachep, req);
> -}
> -
>  static struct kioctx *lookup_ioctx(unsigned long ctx_id)
>  {
>  	struct aio_ring __user *ring  = (void __user *)ctx_id;
> @@ -1079,29 +1072,14 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
>  /* aio_complete
>   *	Called when the io request on the given iocb is complete.
>   */
> -static void aio_complete(struct kiocb *kiocb, long res, long res2)
> +static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
>  {
> -	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, common);
>  	struct kioctx	*ctx = iocb->ki_ctx;
>  	struct aio_ring	*ring;
>  	struct io_event	*ev_page, *event;
>  	unsigned tail, pos, head;
>  	unsigned long	flags;
>  
> -	BUG_ON(is_sync_kiocb(kiocb));
> -
> -	if (kiocb->ki_flags & IOCB_WRITE) {
> -		struct file *file = kiocb->ki_filp;
> -
> -		/*
> -		 * Tell lockdep we inherited freeze protection from submission
> -		 * thread.
> -		 */
> -		if (S_ISREG(file_inode(file)->i_mode))
> -			__sb_writers_acquired(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> -		file_end_write(file);
> -	}
> -
>  	if (iocb->ki_list.next) {
>  		unsigned long flags;
>  
> @@ -1163,11 +1141,12 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
>  	 * eventfd. The eventfd_signal() function is safe to be called
>  	 * from IRQ context.
>  	 */
> -	if (iocb->ki_eventfd != NULL)
> +	if (iocb->ki_eventfd) {
>  		eventfd_signal(iocb->ki_eventfd, 1);
> +		eventfd_ctx_put(iocb->ki_eventfd);
> +	}
>  
> -	/* everything turned out well, dispose of the aiocb. */
> -	kiocb_free(iocb);
> +	kmem_cache_free(kiocb_cachep, iocb);
>  
>  	/*
>  	 * We have to order our ring_info tail store above and test
> @@ -1430,6 +1409,47 @@ SYSCALL_DEFINE1(io_destroy, aio_context_t, ctx)
>  	return -EINVAL;
>  }
>  
> +static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
> +{
> +	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
> +
> +	WARN_ON_ONCE(is_sync_kiocb(kiocb));
> +
> +	if (kiocb->ki_flags & IOCB_WRITE) {
> +		struct inode *inode = file_inode(kiocb->ki_filp);
> +
> +		/*
> +		 * Tell lockdep we inherited freeze protection from submission
> +		 * thread.
> +		 */
> +		if (S_ISREG(inode->i_mode))
> +			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> +		file_end_write(kiocb->ki_filp);
> +	}
> +
> +	fput(kiocb->ki_filp);
> +	aio_complete(iocb, res, res2);
> +}
> +
> +static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
> +{
> +	int ret;
> +
> +	req->ki_filp = fget(iocb->aio_fildes);
> +	if (unlikely(!req->ki_filp))
> +		return -EBADF;
> +	req->ki_complete = aio_complete_rw;
> +	req->ki_pos = iocb->aio_offset;
> +	req->ki_flags = iocb_flags(req->ki_filp);
> +	if (iocb->aio_flags & IOCB_FLAG_RESFD)
> +		req->ki_flags |= IOCB_EVENTFD;
> +	req->ki_hint = file_write_hint(req->ki_filp);
> +	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
> +	if (unlikely(ret))
> +		fput(req->ki_filp);
> +	return ret;
> +}
> +
>  static int aio_setup_rw(int rw, struct iocb *iocb, struct iovec **iovec,
>  		bool vectored, bool compat, struct iov_iter *iter)
>  {
> @@ -1449,7 +1469,7 @@ static int aio_setup_rw(int rw, struct iocb *iocb, struct iovec **iovec,
>  	return import_iovec(rw, buf, len, UIO_FASTIOV, iovec, iter);
>  }
>  
> -static inline ssize_t aio_ret(struct kiocb *req, ssize_t ret)
> +static inline ssize_t aio_rw_ret(struct kiocb *req, ssize_t ret)
>  {
>  	switch (ret) {
>  	case -EIOCBQUEUED:
> @@ -1465,7 +1485,7 @@ static inline ssize_t aio_ret(struct kiocb *req, ssize_t ret)
>  		ret = -EINTR;
>  		/*FALLTHRU*/
>  	default:
> -		aio_complete(req, ret, 0);
> +		aio_complete_rw(req, ret, 0);
>  		return 0;
>  	}
>  }
> @@ -1473,56 +1493,78 @@ static inline ssize_t aio_ret(struct kiocb *req, ssize_t ret)
>  static ssize_t aio_read(struct kiocb *req, struct iocb *iocb, bool vectored,
>  		bool compat)
>  {
> -	struct file *file = req->ki_filp;
>  	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
>  	struct iov_iter iter;
> +	struct file *file;
>  	ssize_t ret;
>  
> +	ret = aio_prep_rw(req, iocb);
> +	if (ret)
> +		return ret;
> +	file = req->ki_filp;
> +
> +	ret = -EBADF;
>  	if (unlikely(!(file->f_mode & FMODE_READ)))
> -		return -EBADF;
> +		goto out_fput;
> +	ret = -EINVAL;
>  	if (unlikely(!file->f_op->read_iter))
> -		return -EINVAL;
> +		goto out_fput;
>  
>  	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
>  	if (ret)
> -		return ret;
> +		goto out_fput;
>  	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
>  	if (!ret)
> -		ret = aio_ret(req, call_read_iter(file, req, &iter));
> +		ret = aio_rw_ret(req, call_read_iter(file, req, &iter));
>  	kfree(iovec);
> +out_fput:
> +	if (unlikely(ret && ret != -EIOCBQUEUED))
> +		fput(file);
>  	return ret;
>  }
>  
>  static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
>  		bool compat)
>  {
> -	struct file *file = req->ki_filp;
>  	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
>  	struct iov_iter iter;
> +	struct file *file;
>  	ssize_t ret;
>  
> +	ret = aio_prep_rw(req, iocb);
> +	if (ret)
> +		return ret;
> +	file = req->ki_filp;
> +
> +	ret = -EBADF;
>  	if (unlikely(!(file->f_mode & FMODE_WRITE)))
> -		return -EBADF;
> +		goto out_fput;
> +	ret = -EINVAL;
>  	if (unlikely(!file->f_op->write_iter))
> -		return -EINVAL;
> +		goto out_fput;
>  
>  	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
>  	if (ret)
> -		return ret;
> +		goto out_fput;
>  	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
>  	if (!ret) {
> +		struct inode *inode = file_inode(file);
> +
>  		req->ki_flags |= IOCB_WRITE;
>  		file_start_write(file);
> -		ret = aio_ret(req, call_write_iter(file, req, &iter));
> +		ret = aio_rw_ret(req, call_write_iter(file, req, &iter));
>  		/*
> -		 * We release freeze protection in aio_complete().  Fool lockdep
> -		 * by telling it the lock got released so that it doesn't
> -		 * complain about held lock when we return to userspace.
> +		 * We release freeze protection in aio_complete_rw().  Fool
> +		 * lockdep by telling it the lock got released so that it
> +		 * doesn't complain about held lock when we return to userspace.
>  		 */
> -		if (S_ISREG(file_inode(file)->i_mode))
> -			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> +		if (S_ISREG(inode->i_mode))
> +			__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
>  	}
>  	kfree(iovec);
> +out_fput:
> +	if (unlikely(ret && ret != -EIOCBQUEUED))
> +		fput(file);
>  	return ret;
>  }
>  
> @@ -1530,7 +1572,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  			 struct iocb *iocb, bool compat)
>  {
>  	struct aio_kiocb *req;
> -	struct file *file;
>  	ssize_t ret;
>  
>  	/* enforce forwards compatibility on users */
> @@ -1553,16 +1594,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  	if (unlikely(!req))
>  		return -EAGAIN;
>  
> -	req->common.ki_filp = file = fget(iocb->aio_fildes);
> -	if (unlikely(!req->common.ki_filp)) {
> -		ret = -EBADF;
> -		goto out_put_req;
> -	}
> -	req->common.ki_pos = iocb->aio_offset;
> -	req->common.ki_complete = aio_complete;
> -	req->common.ki_flags = iocb_flags(req->common.ki_filp);
> -	req->common.ki_hint = file_write_hint(file);
> -
>  	if (iocb->aio_flags & IOCB_FLAG_RESFD) {
>  		/*
>  		 * If the IOCB_FLAG_RESFD flag of aio_flags is set, get an
> @@ -1576,14 +1607,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  			req->ki_eventfd = NULL;
>  			goto out_put_req;
>  		}
> -
> -		req->common.ki_flags |= IOCB_EVENTFD;
> -	}
> -
> -	ret = kiocb_set_rw_flags(&req->common, iocb->aio_rw_flags);
> -	if (unlikely(ret)) {
> -		pr_debug("EINVAL: aio_rw_flags\n");
> -		goto out_put_req;
>  	}
>  
>  	ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
> @@ -1595,26 +1618,24 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  	req->ki_user_iocb = user_iocb;
>  	req->ki_user_data = iocb->aio_data;
>  
> -	get_file(file);
>  	switch (iocb->aio_lio_opcode) {
>  	case IOCB_CMD_PREAD:
> -		ret = aio_read(&req->common, iocb, false, compat);
> +		ret = aio_read(&req->rw, iocb, false, compat);
>  		break;
>  	case IOCB_CMD_PWRITE:
> -		ret = aio_write(&req->common, iocb, false, compat);
> +		ret = aio_write(&req->rw, iocb, false, compat);
>  		break;
>  	case IOCB_CMD_PREADV:
> -		ret = aio_read(&req->common, iocb, true, compat);
> +		ret = aio_read(&req->rw, iocb, true, compat);
>  		break;
>  	case IOCB_CMD_PWRITEV:
> -		ret = aio_write(&req->common, iocb, true, compat);
> +		ret = aio_write(&req->rw, iocb, true, compat);
>  		break;
>  	default:
>  		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);
>  		ret = -EINVAL;
>  		break;
>  	}
> -	fput(file);
>  
>  	if (ret && ret != -EIOCBQUEUED)
>  		goto out_put_req;
> @@ -1622,7 +1643,9 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  out_put_req:
>  	put_reqs_available(ctx, 1);
>  	percpu_ref_put(&ctx->reqs);
> -	kiocb_free(req);
> +	if (req->ki_eventfd)
> +		eventfd_ctx_put(req->ki_eventfd);
> +	kmem_cache_free(kiocb_cachep, req);
>  	return ret;
>  }
>  
> -- 
> 2.14.2
> 
