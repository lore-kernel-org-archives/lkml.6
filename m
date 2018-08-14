Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEC5C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311C52150F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5KooL97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311C52150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390856AbeHNUdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:33:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46993 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388100AbeHNUdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:33:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id l16-v6so14379490lfc.13;
        Tue, 14 Aug 2018 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2RzCE4VMrhY/fre5vyqN9xxwVA4XQ3fIrcngAHfCqDM=;
        b=m5KooL976stRrekw5YWazjqTJPNWfjqk4uQ6aDVXvc0p9nSrqx63GJKvXPLVaI+k2A
         Gs2TsCI5DV5V3muBK/toDxf+9vK6nCEFEbZJnQJj8zpyrf/lsvtKzXQbCQD4Ebth7uQP
         OjDqX4L0edjrm55GksdNgYn3rgcSNo08vmDR3hGrTZH9i38u+t4KkBpZtjm/gYGJM4LN
         Z1mlqC6sRSdq0Th8pb1zs4cl4Z+Q28f+z6ZDjkPgDPZkQqXCa73sHQznND2JxjmJQ9Px
         TpVLohmHPp8Kdor+pQ80x2Wr0Mq5lTjjWc+S0LBcWc9p9/NYuWHxbdCIrgoJMR/ysuhO
         MBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2RzCE4VMrhY/fre5vyqN9xxwVA4XQ3fIrcngAHfCqDM=;
        b=QVPdTUf/Lplqdv40vqSLnabR3nGpECnJZWpu9rW1VoqLDrgKz9mkmTWtk8caTW2neb
         05cMkRE0EfcjETZNT8Rv4Z+/ZyiBaecQaQUL/OKV5+xHnkuVnRhIW861oUmkEQHzcrJJ
         N6gGdTH1UKkgZByl9SV3oApKCjOEAx5OtPnbqrlBzE8EkuQWzrK8PQWZPAlZC9J6zLoA
         8IcTyR2164YbmzBf2/u5+cakulGF8eOvAqWlo92e437piRuhGxULm3wnwr/TYzP7I3xb
         eKTmPmFiI/Eq6llzSW3TYaA1FE4RObVPdYmvZNh0FWtezLWzmTApFiM8H3zrcOFVEao2
         34Mg==
X-Gm-Message-State: AOUpUlF3qPcJatUEJKd3y0L7ubsdQhd/YHFYq64glHycymQNrhrptaNF
        7DgjACAqMMQ3kRR73YKxpcU=
X-Google-Smtp-Source: AA+uWPy7KzMboxcdxweYC42eiO4v9/q9uv9WF7c8gyMTOcpVPIHYgheLwBXziEYuClcWEQUlJodgNQ==
X-Received: by 2002:a19:7d84:: with SMTP id y126-v6mr15152618lfc.94.1534268698887;
        Tue, 14 Aug 2018 10:44:58 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id j140-v6sm3996382lfg.16.2018.08.14.10.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 10:44:58 -0700 (PDT)
Subject: Re: [V9fs-developer] [PATCH 2/2] 9p: Add refcount to p9_req_t
To:     piaojun <piaojun@huawei.com>, asmadeus@codewreck.org,
        ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, v9fs-developer@lists.sourceforge.net,
        davem@davemloft.net
References: <20180811144254.23665-1-tomasbortoli@gmail.com>
 <20180811144254.23665-2-tomasbortoli@gmail.com> <5B72329F.80902@huawei.com>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2e535e20-ddd7-4d4e-8c3c-51e09a651863@gmail.com>
Date:   Tue, 14 Aug 2018 19:44:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5B72329F.80902@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 03:38 AM, piaojun wrote:
> Hi Tomas & Dominique,
> 
> On 2018/8/11 22:42, Tomas Bortoli wrote:
>> To avoid use-after-free(s), use a refcount to keep track of the
>> usable references to any instantiated struct p9_req_t.
>>
>> This commit adds p9_req_put(), p9_req_get() and p9_req_try_get() as
>> wrappers to kref_put(), kref_get() and kref_get_unless_zero().
>> These are used by the client and the transports to keep track of
>> valid requests' references.
>>
>> p9_free_req() is added back and used as callback by kref_put().
>>
>> Add SLAB_TYPESAFE_BY_RCU as it ensures that the memory freed by
>> kmem_cache_free() will not be reused for another type until the rcu
>> synchronisation period is over, so an address gotten under rcu read
>> lock is safe to inc_ref() without corrupting random memory while
>> the lock is held.
>>
>> Co-developed-by: Dominique Martinet <dominique.martinet@cea.fr>
>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com
>> Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
>> ---
>>  include/net/9p/client.h | 14 +++++++++++++
>>  net/9p/client.c         | 54 +++++++++++++++++++++++++++++++++++++++++++------
>>  net/9p/trans_fd.c       | 11 +++++++++-
>>  net/9p/trans_rdma.c     |  1 +
>>  4 files changed, 73 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
>> index 735f3979d559..947a570307a6 100644
>> --- a/include/net/9p/client.h
>> +++ b/include/net/9p/client.h
>> @@ -94,6 +94,7 @@ enum p9_req_status_t {
>>  struct p9_req_t {
>>  	int status;
>>  	int t_err;
>> +	struct kref refcount;
>>  	wait_queue_head_t wq;
>>  	struct p9_fcall tc;
>>  	struct p9_fcall rc;
>> @@ -233,6 +234,19 @@ int p9_client_lock_dotl(struct p9_fid *fid, struct p9_flock *flock, u8 *status);
>>  int p9_client_getlock_dotl(struct p9_fid *fid, struct p9_getlock *fl);
>>  void p9_fcall_fini(struct p9_fcall *fc);
>>  struct p9_req_t *p9_tag_lookup(struct p9_client *, u16);
>> +
>> +static inline void p9_req_get(struct p9_req_t *r)
>> +{
>> +	kref_get(&r->refcount);
>> +}
>> +
>> +static inline int p9_req_try_get(struct p9_req_t *r)
>> +{
>> +	return kref_get_unless_zero(&r->refcount);
>> +}
>> +
>> +int p9_req_put(struct p9_req_t *r);
>> +
>>  void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status);
>>  
>>  int p9_parse_header(struct p9_fcall *, int32_t *, int8_t *, int16_t *, int);
>> diff --git a/net/9p/client.c b/net/9p/client.c
>> index 7942c0bfcc5b..83f2f0aadc14 100644
>> --- a/net/9p/client.c
>> +++ b/net/9p/client.c
>> @@ -310,6 +310,18 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>>  	if (tag < 0)
>>  		goto free;
>>  
>> +	/*	Init ref to two because in the general case there is one ref
>> +	 *	that is put asynchronously by a writer thread, one ref
>> +	 *	temporarily given by p9_tag_lookup and put by p9_client_cb
>> +	 *	in the recv thread, and one ref put by p9_remove_tag in the
> 
> There is a spell mistake, p9_remove_tag->p9_tag_remove, and sorry for not
> pointing this in last comment.
> 
> Thanks,
> Jun
> 
>> +	 *	main thread. The only exception is virtio that does not use
>> +	 *	p9_tag_lookup but does not have a writer thread either
>> +	 *	(the write happens synchronously in the request/zc_request
>> +	 *	callback), so p9_client_cb eats the second ref there
>> +	 *	as the pointer is duplicated directly by virtqueue_add_sgs()
>> +	 */
>> +	refcount_set(&req->refcount.refcount, 2);
>> +
>>  	return req;
>>  
>>  free:
>> @@ -333,10 +345,21 @@ struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag)
>>  	struct p9_req_t *req;
>>  
>>  	rcu_read_lock();
>> +again:
>>  	req = idr_find(&c->reqs, tag);
>> -	/* There's no refcount on the req; a malicious server could cause
>> -	 * us to dereference a NULL pointer
>> -	 */
>> +	if (req) {
>> +		/* We have to be careful with the req found under rcu_read_lock
>> +		 * Thanks to SLAB_TYPESAFE_BY_RCU we can safely try to get the
>> +		 * ref again without corrupting other data, then check again
>> +		 * that the tag matches once we have the ref
>> +		 */
>> +		if (!p9_req_try_get(req))
>> +			goto again;
>> +		if (req->tc.tag != tag) {
>> +			p9_req_put(req);
>> +			goto again;
>> +		}
>> +	}
>>  	rcu_read_unlock();
>>  
>>  	return req;
>> @@ -350,7 +373,7 @@ EXPORT_SYMBOL(p9_tag_lookup);
>>   *
>>   * Context: Any context.
>>   */
>> -static void p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
>> +static int p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
>>  {
>>  	unsigned long flags;
>>  	u16 tag = r->tc.tag;
>> @@ -359,11 +382,23 @@ static void p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
>>  	spin_lock_irqsave(&c->lock, flags);
>>  	idr_remove(&c->reqs, tag);
>>  	spin_unlock_irqrestore(&c->lock, flags);
>> +	return p9_req_put(r);
>> +}
>> +
>> +static void p9_req_free(struct kref *ref)
>> +{
>> +	struct p9_req_t *r = container_of(ref, struct p9_req_t, refcount);
>>  	p9_fcall_fini(&r->tc);
>>  	p9_fcall_fini(&r->rc);
>>  	kmem_cache_free(p9_req_cache, r);
>>  }
>>  
>> +int p9_req_put(struct p9_req_t *r)
>> +{
>> +	return kref_put(&r->refcount, p9_req_free);
>> +}
>> +EXPORT_SYMBOL(p9_req_put);
>> +
>>  /**
>>   * p9_tag_cleanup - cleans up tags structure and reclaims resources
>>   * @c:  v9fs client struct
>> @@ -379,7 +414,9 @@ static void p9_tag_cleanup(struct p9_client *c)
>>  	rcu_read_lock();
>>  	idr_for_each_entry(&c->reqs, req, id) {
>>  		pr_info("Tag %d still in use\n", id);
>> -		p9_tag_remove(c, req);
>> +		if (p9_tag_remove(c, req) == 0)
>> +			pr_warn("Packet with tag %d has still references",
>> +				req->tc.tag);
>>  	}
>>  	rcu_read_unlock();
>>  }
>> @@ -403,6 +440,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
>>  
>>  	wake_up(&req->wq);
>>  	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc.tag);
>> +	p9_req_put(req);
>>  }
>>  EXPORT_SYMBOL(p9_client_cb);
>>  
>> @@ -682,6 +720,8 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
>>  	return req;
>>  reterr:
>>  	p9_tag_remove(c, req);
>> +	/* We have to put also the 2nd reference as it won't be used */
>> +	p9_req_put(req);
>>  	return ERR_PTR(err);
>>  }
>>  
>> @@ -716,6 +756,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>>  
>>  	err = c->trans_mod->request(c, req);
>>  	if (err < 0) {
>> +		/* write won't happen */
>> +		p9_req_put(req);
>>  		if (err != -ERESTARTSYS && err != -EFAULT)
>>  			c->status = Disconnected;
>>  		goto recalc_sigpending;
>> @@ -2241,7 +2283,7 @@ EXPORT_SYMBOL(p9_client_readlink);
>>  
>>  int __init p9_client_init(void)
>>  {
>> -	p9_req_cache = KMEM_CACHE(p9_req_t, 0);
>> +	p9_req_cache = KMEM_CACHE(p9_req_t, SLAB_TYPESAFE_BY_RCU);
>>  	return p9_req_cache ? 0 : -ENOMEM;
>>  }
>>  
>> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
>> index 20f46f13fe83..686e24e355d0 100644
>> --- a/net/9p/trans_fd.c
>> +++ b/net/9p/trans_fd.c
>> @@ -132,6 +132,7 @@ struct p9_conn {
>>  	struct list_head req_list;
>>  	struct list_head unsent_req_list;
>>  	struct p9_req_t *req;
>> +	struct p9_req_t *wreq;
>>  	char tmp_buf[7];
>>  	struct p9_fcall rc;
>>  	int wpos;
>> @@ -383,6 +384,7 @@ static void p9_read_work(struct work_struct *work)
>>  		m->rc.sdata = NULL;
>>  		m->rc.offset = 0;
>>  		m->rc.capacity = 0;
>> +		p9_req_put(m->req);
>>  		m->req = NULL;
>>  	}
>>  
>> @@ -472,6 +474,8 @@ static void p9_write_work(struct work_struct *work)
>>  		m->wbuf = req->tc.sdata;
>>  		m->wsize = req->tc.size;
>>  		m->wpos = 0;
>> +		p9_req_get(req);
>> +		m->wreq = req;
>>  		spin_unlock(&m->client->lock);
>>  	}
>>  
>> @@ -492,8 +496,11 @@ static void p9_write_work(struct work_struct *work)
>>  	}
>>  
>>  	m->wpos += err;
>> -	if (m->wpos == m->wsize)
>> +	if (m->wpos == m->wsize) {
>>  		m->wpos = m->wsize = 0;
>> +		p9_req_put(m->wreq);
>> +		m->wreq = NULL;
>> +	}
>>  
>>  end_clear:
>>  	clear_bit(Wworksched, &m->wsched);
>> @@ -694,6 +701,7 @@ static int p9_fd_cancel(struct p9_client *client, struct p9_req_t *req)
>>  	if (req->status == REQ_STATUS_UNSENT) {
>>  		list_del(&req->req_list);
>>  		req->status = REQ_STATUS_FLSHD;
>> +		p9_req_put(req);
>>  		ret = 0;
>>  	}
>>  	spin_unlock(&client->lock);
>> @@ -711,6 +719,7 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
>>  	spin_lock(&client->lock);
>>  	list_del(&req->req_list);
>>  	spin_unlock(&client->lock);
>> +	p9_req_put(req);
>>  
>>  	return 0;
>>  }
>> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
>> index c60655c90c9e..8cff368a11e3 100644
>> --- a/net/9p/trans_rdma.c
>> +++ b/net/9p/trans_rdma.c
>> @@ -365,6 +365,7 @@ send_done(struct ib_cq *cq, struct ib_wc *wc)
>>  			    c->busa, c->req->tc.size,
>>  			    DMA_TO_DEVICE);
>>  	up(&rdma->sq_sem);
>> +	p9_req_put(c->req);
>>  	kfree(c);
>>  }
>>  
>>
> 

Spell fixed

Tomas
