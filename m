Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-143482-1521512919-2-11288462642989177943
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
    t=1521512918; b=ublkDVuTcwagva8libmrhBw4hGHmvNgf2HFJpZZpAqbsOFE
    dcBLtQwK0JhRblts4CleXVKvHiOLhUpuJ638x3a6zLnU3/kdGgHxEJaYg3Qaf1+g
    iPf3wXROGzgo8DTa1zutoEAGWeE8FmHm+gShE7lC4VTtVyE39yzrZQiSlx1BjWko
    zbUenz8QVxkPyA6zsZdHNMa2q4Th6/Mk2CNIgfq2a8zFu2LiNEZznEnvBbh57Ap5
    doSRfxuVPazAIVQpGYNZt3lM2F90dVj8BseAL5cpDTxD/FpC8spmJFe5OILR8pf5
    u88heCZbaX2v9JxarZzXVL4IOSuPBYgPs/AWSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521512918; bh=IBsKB2Il8bOoqSXzONkCX8Wldv
    FEYJ9Ex/MOqIxT9Dg=; b=oe9VD4o7yXfsawCxJPlczMC8sSQK+yWxuUOI1UidFY
    VV1iu/gBBj/L+9tOhSQFbicfgDychNYCmFyECSMGG1lidPUa59rgmz/9sMigUejn
    JPpZdK/ogvjglDIR79CD7EKcP+hMHy8CCI8w+IVfVaKPNo4n70BjMs9nRqClzlue
    +bfRIB3O150CZ16wJjhWgk8p50KcLI7EXF5vjFHTa201LTukrOfdfYkZoB63oyLC
    m1tcPjc96EQr6DYXPtPcMqC226Y/qH0czUrwME1o803puKRofufBsV/OgjQPbbPC
    OB8Ssln2fRn0DQUm8Ka+b8pTByaAbS9bkbfYViN3yAtg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Ew1liyWK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdeknecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdgrphhiqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudehjeelnecuvehluhhsthgvrhfuihiivgeptd
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Ew1liyWK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdeknecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdgrphhiqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudehjeelnecuvehluhhsthgvrhfuihiivgeptd
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbeCTC1m (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 22:27:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48842 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeCTC1l (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Mar 2018 22:27:41 -0400
Date: Mon, 19 Mar 2018 19:27:34 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/36] fs: add new vfs_poll and file_can_poll helpers
Message-ID: <20180320022734.GI7282@magnolia>
References: <20180305212743.16664-1-hch@lst.de>
 <20180305212743.16664-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305212743.16664-13-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8837 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200006
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 01:27:19PM -0800, Christoph Hellwig wrote:
> These abstract out calls to the poll method in preparation for changes
> in how we poll.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/staging/comedi/drivers/serial2002.c |  4 ++--
>  drivers/vfio/virqfd.c                       |  2 +-
>  drivers/vhost/vhost.c                       |  2 +-
>  fs/eventpoll.c                              |  5 ++---
>  fs/select.c                                 | 23 ++++++++---------------
>  include/linux/poll.h                        | 12 ++++++++++++
>  mm/memcontrol.c                             |  2 +-

For the fs/include/mm changes,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

The other conversions look fine to me too but I've never looked at them
before. :)

--D

>  net/9p/trans_fd.c                           | 18 ++++--------------
>  virt/kvm/eventfd.c                          |  2 +-
>  9 files changed, 32 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/serial2002.c b/drivers/staging/comedi/drivers/serial2002.c
> index b3f3b4a201af..5471b2212a62 100644
> --- a/drivers/staging/comedi/drivers/serial2002.c
> +++ b/drivers/staging/comedi/drivers/serial2002.c
> @@ -113,7 +113,7 @@ static void serial2002_tty_read_poll_wait(struct file *f, int timeout)
>  		long elapsed;
>  		__poll_t mask;
>  
> -		mask = f->f_op->poll(f, &table.pt);
> +		mask = vfs_poll(f, &table.pt);
>  		if (mask & (EPOLLRDNORM | EPOLLRDBAND | EPOLLIN |
>  			    EPOLLHUP | EPOLLERR)) {
>  			break;
> @@ -136,7 +136,7 @@ static int serial2002_tty_read(struct file *f, int timeout)
>  
>  	result = -1;
>  	if (!IS_ERR(f)) {
> -		if (f->f_op->poll) {
> +		if (file_can_poll(f)) {
>  			serial2002_tty_read_poll_wait(f, timeout);
>  
>  			if (kernel_read(f, &ch, 1, &pos) == 1)
> diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
> index 085700f1be10..2a1be859ee71 100644
> --- a/drivers/vfio/virqfd.c
> +++ b/drivers/vfio/virqfd.c
> @@ -166,7 +166,7 @@ int vfio_virqfd_enable(void *opaque,
>  	init_waitqueue_func_entry(&virqfd->wait, virqfd_wakeup);
>  	init_poll_funcptr(&virqfd->pt, virqfd_ptable_queue_proc);
>  
> -	events = irqfd.file->f_op->poll(irqfd.file, &virqfd->pt);
> +	events = vfs_poll(irqfd.file, &virqfd->pt);
>  
>  	/*
>  	 * Check if there was an event already pending on the eventfd
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 1b3e8d2d5c8b..4d27e288bb1d 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -208,7 +208,7 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file)
>  	if (poll->wqh)
>  		return 0;
>  
> -	mask = file->f_op->poll(file, &poll->table);
> +	mask = vfs_poll(file, &poll->table);
>  	if (mask)
>  		vhost_poll_wakeup(&poll->wait, 0, 0, poll_to_key(mask));
>  	if (mask & EPOLLERR) {
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 0f3494ed3ed0..2bebae5a38cf 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -884,8 +884,7 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
>  
>  	pt->_key = epi->event.events;
>  	if (!is_file_epoll(epi->ffd.file))
> -		return epi->ffd.file->f_op->poll(epi->ffd.file, pt) &
> -		       epi->event.events;
> +		return vfs_poll(epi->ffd.file, pt) & epi->event.events;
>  
>  	ep = epi->ffd.file->private_data;
>  	poll_wait(epi->ffd.file, &ep->poll_wait, pt);
> @@ -2020,7 +2019,7 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
>  
>  	/* The target file descriptor must support poll */
>  	error = -EPERM;
> -	if (!tf.file->f_op->poll)
> +	if (!file_can_poll(tf.file))
>  		goto error_tgt_fput;
>  
>  	/* Check if EPOLLWAKEUP is allowed */
> diff --git a/fs/select.c b/fs/select.c
> index c6c504a814f9..ba91103707ea 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -502,14 +502,10 @@ static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
>  					continue;
>  				f = fdget(i);
>  				if (f.file) {
> -					const struct file_operations *f_op;
> -					f_op = f.file->f_op;
> -					mask = DEFAULT_POLLMASK;
> -					if (f_op->poll) {
> -						wait_key_set(wait, in, out,
> -							     bit, busy_flag);
> -						mask = (*f_op->poll)(f.file, wait);
> -					}
> +					wait_key_set(wait, in, out, bit,
> +						     busy_flag);
> +					mask = vfs_poll(f.file, wait);
> +
>  					fdput(f);
>  					if ((mask & POLLIN_SET) && (in & bit)) {
>  						res_in |= bit;
> @@ -819,13 +815,10 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
>  
>  	/* userland u16 ->events contains POLL... bitmap */
>  	filter = demangle_poll(pollfd->events) | EPOLLERR | EPOLLHUP;
> -	mask = DEFAULT_POLLMASK;
> -	if (f.file->f_op->poll) {
> -		pwait->_key = filter | busy_flag;
> -		mask = f.file->f_op->poll(f.file, pwait);
> -		if (mask & busy_flag)
> -			*can_busy_poll = true;
> -	}
> +	pwait->_key = filter | busy_flag;
> +	mask = vfs_poll(f.file, pwait);
> +	if (mask & busy_flag)
> +		*can_busy_poll = true;
>  	mask &= filter;		/* Mask out unneeded events. */
>  	fdput(f);
>  
> diff --git a/include/linux/poll.h b/include/linux/poll.h
> index a3576da63377..7e0fdcf905d2 100644
> --- a/include/linux/poll.h
> +++ b/include/linux/poll.h
> @@ -74,6 +74,18 @@ static inline void init_poll_funcptr(poll_table *pt, poll_queue_proc qproc)
>  	pt->_key   = ~(__poll_t)0; /* all events enabled */
>  }
>  
> +static inline bool file_can_poll(struct file *file)
> +{
> +	return file->f_op->poll;
> +}
> +
> +static inline __poll_t vfs_poll(struct file *file, struct poll_table_struct *pt)
> +{
> +	if (unlikely(!file->f_op->poll))
> +		return DEFAULT_POLLMASK;
> +	return file->f_op->poll(file, pt);
> +}
> +
>  struct poll_table_entry {
>  	struct file *filp;
>  	__poll_t key;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 670e99b68aa6..8774ece5c3c3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3849,7 +3849,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	if (ret)
>  		goto out_put_css;
>  
> -	efile.file->f_op->poll(efile.file, &event->pt);
> +	vfs_poll(efile.file, &event->pt);
>  
>  	spin_lock(&memcg->event_list_lock);
>  	list_add(&event->list, &memcg->event_list);
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 0cfba919d167..3811775692d0 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -231,7 +231,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>  static __poll_t
>  p9_fd_poll(struct p9_client *client, struct poll_table_struct *pt, int *err)
>  {
> -	__poll_t ret, n;
> +	__poll_t ret;
>  	struct p9_trans_fd *ts = NULL;
>  
>  	if (client && client->status == Connected)
> @@ -243,19 +243,9 @@ p9_fd_poll(struct p9_client *client, struct poll_table_struct *pt, int *err)
>  		return EPOLLERR;
>  	}
>  
> -	if (!ts->rd->f_op->poll)
> -		ret = DEFAULT_POLLMASK;
> -	else
> -		ret = ts->rd->f_op->poll(ts->rd, pt);
> -
> -	if (ts->rd != ts->wr) {
> -		if (!ts->wr->f_op->poll)
> -			n = DEFAULT_POLLMASK;
> -		else
> -			n = ts->wr->f_op->poll(ts->wr, pt);
> -		ret = (ret & ~EPOLLOUT) | (n & ~EPOLLIN);
> -	}
> -
> +	ret = vfs_poll(ts->rd, pt);
> +	if (ts->rd != ts->wr)
> +		ret = (ret & ~EPOLLOUT) | (vfs_poll(ts->wr, pt) & ~EPOLLIN);
>  	return ret;
>  }
>  
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index 6e865e8b5b10..90d30fbe95ae 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -397,7 +397,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  	 * Check if there was an event already pending on the eventfd
>  	 * before we registered, and trigger it as if we didn't miss it.
>  	 */
> -	events = f.file->f_op->poll(f.file, &irqfd->pt);
> +	events = vfs_poll(f.file, &irqfd->pt);
>  
>  	if (events & EPOLLIN)
>  		schedule_work(&irqfd->inject);
> -- 
> 2.14.2
> 
