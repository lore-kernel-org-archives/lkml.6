Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB20C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B68420658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EATIPzK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B68420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeHaCYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:24:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41782 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeHaCYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:24:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id l26-v6so8444108lfc.8;
        Thu, 30 Aug 2018 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9+hyDGhb2K6Rx9yef7p92y38x5ULnXkXLYQWG0o+sM0=;
        b=EATIPzK+/96cpTICvfYCeJp+2R152sUsm3b7A4EldbNBBYqH3QxqRB7NUM/8p6dkRr
         YXiwRhWKAXOgsyruGfz/mp5AJgLjSStF2qI0YsJ9PJk6gA+x0ItfgKll3xXQxwUYYpiX
         TLMuTzwfzLofSVyOkvS13HCjJ0qNAPms9nGITgwEjVKZL/mYTMubwfiJauOfiDz2xpIS
         FDXA0pnP4n5NbrBHqgqkfyQ66yX90oktAkOJ7sT3FTGafNK9GzcoLAPfCQP+prYtNj3o
         p5OZYDYBwJWGcwdS0HSkes0hgJekUIayd1160Vsv37+ybxwd+LCnl2I/NEONYj+CKBQO
         np+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9+hyDGhb2K6Rx9yef7p92y38x5ULnXkXLYQWG0o+sM0=;
        b=J3yRaIXYEcsuLDpncu4/AxSdMYJCbiW/k2alydCt4IHb+48wn1uEP7xt2aLOj4CBoH
         7CgNsNTn8PpZQPZSRGwcvN8MzkBa61Tntx5V+jmaGuu6LgwjmHk3VRrd/IDKH0Mq0Kez
         nOEVuWWQFKgJFyYeNobutYPI8PDhnSo8LWehaA40mYrrlG/0YVm4NeXXVHPacmE6ewqZ
         4LJBihmeBkajIW+n99Wo2+Rh2ILT56prYwIfAdSCzwkAZUtWuH+/EOna5GOMzIz8xrBm
         JyRxVqtej92Krxmm7krbWo1AnhVRQeKUWsqsVe6tHI9NgfoE3NCjqBB4zQEWST84D2Ex
         TQ6A==
X-Gm-Message-State: APzg51AK5gb+jI9bdSEXMM5oImooIT92b/fUfqeuUgNKkRbhOW6xsDUo
        QYPp7ekK3sY7sZjc7Rp7NKw=
X-Google-Smtp-Source: ANB0Vdaybxmn4o5yTI+g/E1s+ZHJBtZa+x9HgTaZOBNoileiPQddy8thh6s/B0hLfjBfYHqOVU4bTA==
X-Received: by 2002:a19:c38b:: with SMTP id t133-v6mr9028092lff.7.1535667623692;
        Thu, 30 Aug 2018 15:20:23 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id t15-v6sm430942lft.41.2018.08.30.15.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:20:22 -0700 (PDT)
Subject: Re: [PATCH v4] 9p: Add refcount to p9_req_t
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Cc:     v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Dominique Martinet <dominique.martinet@cea.fr>
References: <1535518779-28551-1-git-send-email-asmadeus@codewreck.org>
 <1535626341-20693-1-git-send-email-asmadeus@codewreck.org>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <96b44210-3c4d-b5c9-0806-ad4b53fe911f@gmail.com>
Date:   Fri, 31 Aug 2018 00:20:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535626341-20693-1-git-send-email-asmadeus@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 12:52 PM, Dominique Martinet wrote:
> From: Tomas Bortoli <tomasbortoli@gmail.com>
> 
> To avoid use-after-free(s), use a refcount to keep track of the
> usable references to any instantiated struct p9_req_t.
> 
> This commit adds p9_req_put(), p9_req_get() and p9_req_try_get() as
> wrappers to kref_put(), kref_get() and kref_get_unless_zero().
> These are used by the client and the transports to keep track of
> valid requests' references.
> 
> p9_free_req() is added back and used as callback by kref_put().
> 
> Add SLAB_TYPESAFE_BY_RCU as it ensures that the memory freed by
> kmem_cache_free() will not be reused for another type until the rcu
> synchronisation period is over, so an address gotten under rcu read
> lock is safe to inc_ref() without corrupting random memory while
> the lock is held.
> 
> Co-developed-by: Dominique Martinet <dominique.martinet@cea.fr>
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com
> Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
> ---
> v3:
>  - add req put if virtio zc request fails
>  - add req put if cancelled callback is not defined for virtio
>  - (incorrectly) add req put in rdma cancelled callback
> 
> v4:
>  - removed rdma's cancelled callback put again
>  - changed the else if no cancelled callback into actually giving virtio
> a callback, xen does not need to call put in that case either because
> both function rely on tag_lookup to find the request. trans_fd only
> needs to put in cancelled because it also keeps the req in a list around
> for cancel.
>  - add req put for trans xen's request(), I'm not sure why that one was
> missing either..
> 
> And with that I believe I am done testing all four transports.
> I'll do a second round of tests next week just to make sure, but it
> should be good enough™
> Sorry for the multiple iterations.
> 
>  include/net/9p/client.h | 14 ++++++++++
>  net/9p/client.c         | 57 ++++++++++++++++++++++++++++++++++++-----
>  net/9p/trans_fd.c       | 11 +++++++-
>  net/9p/trans_rdma.c     |  1 +
>  net/9p/trans_virtio.c   | 26 ++++++++++++++++---
>  net/9p/trans_xen.c      |  1 +
>  6 files changed, 98 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index 735f3979d559..947a570307a6 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -94,6 +94,7 @@ enum p9_req_status_t {
>  struct p9_req_t {
>  	int status;
>  	int t_err;
> +	struct kref refcount;
>  	wait_queue_head_t wq;
>  	struct p9_fcall tc;
>  	struct p9_fcall rc;
> @@ -233,6 +234,19 @@ int p9_client_lock_dotl(struct p9_fid *fid, struct p9_flock *flock, u8 *status);
>  int p9_client_getlock_dotl(struct p9_fid *fid, struct p9_getlock *fl);
>  void p9_fcall_fini(struct p9_fcall *fc);
>  struct p9_req_t *p9_tag_lookup(struct p9_client *, u16);
> +
> +static inline void p9_req_get(struct p9_req_t *r)
> +{
> +	kref_get(&r->refcount);
> +}
> +
> +static inline int p9_req_try_get(struct p9_req_t *r)
> +{
> +	return kref_get_unless_zero(&r->refcount);
> +}
> +
> +int p9_req_put(struct p9_req_t *r);
> +
>  void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status);
>  
>  int p9_parse_header(struct p9_fcall *, int32_t *, int8_t *, int16_t *, int);
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 7942c0bfcc5b..aeeb6d8515d4 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -310,6 +310,18 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  	if (tag < 0)
>  		goto free;
>  
> +	/* Init ref to two because in the general case there is one ref
> +	 * that is put asynchronously by a writer thread, one ref
> +	 * temporarily given by p9_tag_lookup and put by p9_client_cb
> +	 * in the recv thread, and one ref put by p9_tag_remove in the
> +	 * main thread. The only exception is virtio that does not use
> +	 * p9_tag_lookup but does not have a writer thread either
> +	 * (the write happens synchronously in the request/zc_request
> +	 * callback), so p9_client_cb eats the second ref there
> +	 * as the pointer is duplicated directly by virtqueue_add_sgs()
> +	 */
> +	refcount_set(&req->refcount.refcount, 2);
> +
>  	return req;
>  
>  free:
> @@ -333,10 +345,21 @@ struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag)
>  	struct p9_req_t *req;
>  
>  	rcu_read_lock();
> +again:
>  	req = idr_find(&c->reqs, tag);
> -	/* There's no refcount on the req; a malicious server could cause
> -	 * us to dereference a NULL pointer
> -	 */
> +	if (req) {
> +		/* We have to be careful with the req found under rcu_read_lock
> +		 * Thanks to SLAB_TYPESAFE_BY_RCU we can safely try to get the
> +		 * ref again without corrupting other data, then check again
> +		 * that the tag matches once we have the ref
> +		 */
> +		if (!p9_req_try_get(req))
> +			goto again;
> +		if (req->tc.tag != tag) {
> +			p9_req_put(req);
> +			goto again;
> +		}
> +	}
>  	rcu_read_unlock();
>  
>  	return req;
> @@ -350,7 +373,7 @@ EXPORT_SYMBOL(p9_tag_lookup);
>   *
>   * Context: Any context.
>   */
> -static void p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
> +static int p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
>  {
>  	unsigned long flags;
>  	u16 tag = r->tc.tag;
> @@ -359,11 +382,23 @@ static void p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
>  	spin_lock_irqsave(&c->lock, flags);
>  	idr_remove(&c->reqs, tag);
>  	spin_unlock_irqrestore(&c->lock, flags);
> +	return p9_req_put(r);
> +}
> +
> +static void p9_req_free(struct kref *ref)
> +{
> +	struct p9_req_t *r = container_of(ref, struct p9_req_t, refcount);
>  	p9_fcall_fini(&r->tc);
>  	p9_fcall_fini(&r->rc);
>  	kmem_cache_free(p9_req_cache, r);
>  }
>  
> +int p9_req_put(struct p9_req_t *r)
> +{
> +	return kref_put(&r->refcount, p9_req_free);
> +}
> +EXPORT_SYMBOL(p9_req_put);
> +
>  /**
>   * p9_tag_cleanup - cleans up tags structure and reclaims resources
>   * @c:  v9fs client struct
> @@ -379,7 +414,9 @@ static void p9_tag_cleanup(struct p9_client *c)
>  	rcu_read_lock();
>  	idr_for_each_entry(&c->reqs, req, id) {
>  		pr_info("Tag %d still in use\n", id);
> -		p9_tag_remove(c, req);
> +		if (p9_tag_remove(c, req) == 0)
> +			pr_warn("Packet with tag %d has still references",
> +				req->tc.tag);
>  	}
>  	rcu_read_unlock();
>  }
> @@ -403,6 +440,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
>  
>  	wake_up(&req->wq);
>  	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc.tag);
> +	p9_req_put(req);
>  }
>  EXPORT_SYMBOL(p9_client_cb);
>  
> @@ -643,9 +681,10 @@ static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
>  	 * if we haven't received a response for oldreq,
>  	 * remove it from the list
>  	 */
> -	if (oldreq->status == REQ_STATUS_SENT)
> +	if (oldreq->status == REQ_STATUS_SENT) {
>  		if (c->trans_mod->cancelled)
>  			c->trans_mod->cancelled(c, oldreq);
> +	}
>  
>  	p9_tag_remove(c, req);
>  	return 0;
> @@ -682,6 +721,8 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
>  	return req;
>  reterr:
>  	p9_tag_remove(c, req);
> +	/* We have to put also the 2nd reference as it won't be used */
> +	p9_req_put(req);
>  	return ERR_PTR(err);
>  }
>  
> @@ -716,6 +757,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>  
>  	err = c->trans_mod->request(c, req);
>  	if (err < 0) {
> +		/* write won't happen */
> +		p9_req_put(req);
>  		if (err != -ERESTARTSYS && err != -EFAULT)
>  			c->status = Disconnected;
>  		goto recalc_sigpending;
> @@ -2241,7 +2284,7 @@ EXPORT_SYMBOL(p9_client_readlink);
>  
>  int __init p9_client_init(void)
>  {
> -	p9_req_cache = KMEM_CACHE(p9_req_t, 0);
> +	p9_req_cache = KMEM_CACHE(p9_req_t, SLAB_TYPESAFE_BY_RCU);
>  	return p9_req_cache ? 0 : -ENOMEM;
>  }
>  
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 20f46f13fe83..686e24e355d0 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -132,6 +132,7 @@ struct p9_conn {
>  	struct list_head req_list;
>  	struct list_head unsent_req_list;
>  	struct p9_req_t *req;
> +	struct p9_req_t *wreq;
>  	char tmp_buf[7];
>  	struct p9_fcall rc;
>  	int wpos;
> @@ -383,6 +384,7 @@ static void p9_read_work(struct work_struct *work)
>  		m->rc.sdata = NULL;
>  		m->rc.offset = 0;
>  		m->rc.capacity = 0;
> +		p9_req_put(m->req);
>  		m->req = NULL;
>  	}
>  
> @@ -472,6 +474,8 @@ static void p9_write_work(struct work_struct *work)
>  		m->wbuf = req->tc.sdata;
>  		m->wsize = req->tc.size;
>  		m->wpos = 0;
> +		p9_req_get(req);
> +		m->wreq = req;
>  		spin_unlock(&m->client->lock);
>  	}
>  
> @@ -492,8 +496,11 @@ static void p9_write_work(struct work_struct *work)
>  	}
>  
>  	m->wpos += err;
> -	if (m->wpos == m->wsize)
> +	if (m->wpos == m->wsize) {
>  		m->wpos = m->wsize = 0;
> +		p9_req_put(m->wreq);
> +		m->wreq = NULL;
> +	}
>  
>  end_clear:
>  	clear_bit(Wworksched, &m->wsched);
> @@ -694,6 +701,7 @@ static int p9_fd_cancel(struct p9_client *client, struct p9_req_t *req)
>  	if (req->status == REQ_STATUS_UNSENT) {
>  		list_del(&req->req_list);
>  		req->status = REQ_STATUS_FLSHD;
> +		p9_req_put(req);
>  		ret = 0;
>  	}
>  	spin_unlock(&client->lock);
> @@ -711,6 +719,7 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
>  	spin_lock(&client->lock);
>  	list_del(&req->req_list);
>  	spin_unlock(&client->lock);
> +	p9_req_put(req);
>  
>  	return 0;
>  }
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index 5b0cda1aaa7a..9cc9b3a19ee7 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -365,6 +365,7 @@ send_done(struct ib_cq *cq, struct ib_wc *wc)
>  			    c->busa, c->req->tc.size,
>  			    DMA_TO_DEVICE);
>  	up(&rdma->sq_sem);
> +	p9_req_put(c->req);
>  	kfree(c);
>  }
>  
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 3dd6ce1c0f2d..eb596c2ed546 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -207,6 +207,13 @@ static int p9_virtio_cancel(struct p9_client *client, struct p9_req_t *req)
>  	return 1;
>  }
>  
> +/* Reply won't come, so drop req ref */
> +static int p9_virtio_cancelled(struct p9_client *client, struct p9_req_t *req)
> +{
> +	p9_req_put(req);
> +	return 0;
> +}
> +
>  /**
>   * pack_sg_list_p - Just like pack_sg_list. Instead of taking a buffer,
>   * this takes a list of pages.
> @@ -404,6 +411,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  	struct scatterlist *sgs[4];
>  	size_t offs;
>  	int need_drop = 0;
> +	int kicked = 0;
>  
>  	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
>  
> @@ -411,8 +419,10 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  		__le32 sz;
>  		int n = p9_get_mapped_pages(chan, &out_pages, uodata,
>  					    outlen, &offs, &need_drop);
> -		if (n < 0)
> -			return n;
> +		if (n < 0) {
> +			err = n;
> +			goto err_out;
> +		}
>  		out_nr_pages = DIV_ROUND_UP(n + offs, PAGE_SIZE);
>  		if (n != outlen) {
>  			__le32 v = cpu_to_le32(n);
> @@ -428,8 +438,10 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  	} else if (uidata) {
>  		int n = p9_get_mapped_pages(chan, &in_pages, uidata,
>  					    inlen, &offs, &need_drop);
> -		if (n < 0)
> -			return n;
> +		if (n < 0) {
> +			err = n;
> +			goto err_out;
> +		}
>  		in_nr_pages = DIV_ROUND_UP(n + offs, PAGE_SIZE);
>  		if (n != inlen) {
>  			__le32 v = cpu_to_le32(n);
> @@ -498,6 +510,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  	}
>  	virtqueue_kick(chan->vq);
>  	spin_unlock_irqrestore(&chan->lock, flags);
> +	kicked = 1;
>  	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
>  	err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);
>  	/*
> @@ -518,6 +531,10 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  	}
>  	kvfree(in_pages);
>  	kvfree(out_pages);
> +	if (!kicked) {
> +		/* reply won't come */
> +		p9_req_put(req);
> +	}
>  	return err;
>  }
>  
> @@ -750,6 +767,7 @@ static struct p9_trans_module p9_virtio_trans = {
>  	.request = p9_virtio_request,
>  	.zc_request = p9_virtio_zc_request,
>  	.cancel = p9_virtio_cancel,
> +	.cancelled = p9_virtio_cancelled,
>  	/*
>  	 * We leave one entry for input and one entry for response
>  	 * headers. We also skip one more entry to accomodate, address
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index 782a07f2ad0c..e2fbf3677b9b 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -185,6 +185,7 @@ static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
>  	ring->intf->out_prod = prod;
>  	spin_unlock_irqrestore(&ring->lock, flags);
>  	notify_remote_via_irq(ring->irq);
> +	p9_req_put(p9_req);
>  
>  	return 0;
>  }
> 

LGTM, thanks Dominique!

Tomas
