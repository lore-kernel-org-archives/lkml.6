Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EB4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFE320672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1zxeRf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeLQHiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:38:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38793 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeLQHiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:38:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so8683796lfg.5;
        Sun, 16 Dec 2018 23:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ee9i0Pf5EL3wAgyVdNMbOnVA/LU9ZoEU3jWh4MH/pzM=;
        b=V1zxeRf19ANFZMqxqf5l6CueidMjz+boTLTZzevyKpRwCmwrJsNT72b9LVXfI5hHGk
         l5SNewACKVHmQ151grYDU6Onl25SNziaNBdVLyjW9M+u0MBwbTHVjM07WiTd3+3ezGB0
         F/m1dewxxmDQNMf8uSaxD/EQ1bXslNeOXHcqyTHZ8J+vEU3BmJc8no7hq8R28dxGpOT6
         MSY36Pk0hipZ5B/f4IoNEp0v9CpISPzEU7JPMXPG1gI+gRvbgexcXk4RUWCE08vf1e2t
         JUwzintB9Nr7B19vvtCeYu8+n2h3iVGdOAympKGJaKz/6P9SwczyElFgs5CkmmZJF+0F
         8Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ee9i0Pf5EL3wAgyVdNMbOnVA/LU9ZoEU3jWh4MH/pzM=;
        b=NDAAgM0dFbTckQ8eH+QWG75wtOy0OC6TZ/uCB5+sM7tU8t8OQYoX+/MPQgMXKLBWU0
         uZgiAG37AmBwwKsOqXwW42DzgUXeE+6XA/ED35RT/A0BL54aWe2JgdAaDbyw7CrVLltB
         zYQuDKfOUJN2KXR5yP4FOl2X+rlQuw58eXPaorJWw0qcTRMckXin8NkuldFPSqENmgmr
         pQPrOJ9CO1TMIp8uEyfpzzMzVlE1b37UnY3c/KesRyVSnyZuBhNMW9HKkIR9/YIXCrnE
         h2rLceiUPHLJnS66LgGjYcVJp4ujK0To4nFJVqR2ukBj78XA+PKHwAtbfYOqNi4N5ABv
         xt1Q==
X-Gm-Message-State: AA+aEWaItm5qx7ffELfg2BmiDG+ImWRVNuOY89TtiMcUzrzRnq85Fgi3
        OREG8W0459NhdnPVaI4krdI=
X-Google-Smtp-Source: AFSGD/VbjHy5dVfDVDlnjf4fnSvfHu1g+9sU6LnBhAgSUDijIicBV9AAkvvoA3gnwwdvixasZ3KQpw==
X-Received: by 2002:a19:739d:: with SMTP id h29mr7172834lfk.85.1545032278644;
        Sun, 16 Dec 2018 23:37:58 -0800 (PST)
Received: from [192.168.0.21] (87-50-154-159-cable.dk.customer.tdc.net. [87.50.154.159])
        by smtp.gmail.com with ESMTPSA id s3-v6sm2412237lje.73.2018.12.16.23.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 23:37:58 -0800 (PST)
Subject: Re: [PATCH 1/3] 9p/net: implement asynchronous rpc
To:     Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dmitry Vyukov <dvyukov@google.com>
References: <1544532108-21689-1-git-send-email-asmadeus@codewreck.org>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0da7d896-0d67-46f6-83f9-b346eba991a9@gmail.com>
Date:   Mon, 17 Dec 2018 08:37:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1544532108-21689-1-git-send-email-asmadeus@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dominique,

sorry for the delay, I've been quite busy these days.

The patches looks good to me and should indeed speed up the code a bit.
I quickly tested them against Syzkaller tuned for the 9p subsystem and
everything seems fine.

And by the way, which refcount races?

Cheers,
Tomas

On 12/11/18 1:41 PM, Dominique Martinet wrote:
> From: Dominique Martinet <dominique.martinet@cea.fr>
> 
> Add p9_client_async_rpc that will let us send an rpc without waiting
> for the reply, as well as an async handler hook.
> 
> The work done in the hook could mostly be done in the client callback,
> but I prefered not to for a couple of reasons:
>  - the callback can be called in an IRQ for some transports, and the
> handler needs to call p9_tag_remove which takes the client lock that has
> recently been reworked to not be irq-compatible (as it was never taken
> in IRQs until now)
>  - the handled replies can be handled anytime, there is nothing the
> userspace would care about and want to be notified of quickly
>  - the async request list and this function would be needed anyway for
> when we disconnect the client, in order to not leak async requests that
> haven't been replied to
> 
> Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
> Cc: Eric Van Hensbergen <ericvh@gmail.com>
> Cc: Latchesar Ionkov <lucho@ionkov.net>
> Cc: Tomas Bortoli <tomasbortoli@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
> 
> I've been sitting on these patches for almost a month now because I
> wanted to fix the cancel race, but I think it's what the most recent
> syzbot email is about so if it could find it without this it probably
> won't hurt to at least get some reviews for these three patches first.
> 
> I won't submit these for next cycle, so will only put them into -next
> after 4.20 is released; hopefully I'll have time to look at the two
> pending refcount races around that time.

> Until then, comments please!
> 
> 
>  include/net/9p/client.h |  9 +++++-
>  net/9p/client.c         | 64 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index 947a570307a6..a4ded7666c73 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -89,7 +89,8 @@ enum p9_req_status_t {
>   * @tc: the request fcall structure
>   * @rc: the response fcall structure
>   * @aux: transport specific data (provided for trans_fd migration)
> - * @req_list: link for higher level objects to chain requests
> + * @req_list: link used by trans_fd
> + * @async_list: link used to check on async requests
>   */
>  struct p9_req_t {
>  	int status;
> @@ -100,6 +101,7 @@ struct p9_req_t {
>  	struct p9_fcall rc;
>  	void *aux;
>  	struct list_head req_list;
> +	struct list_head async_list;
>  };
>  
>  /**
> @@ -110,6 +112,9 @@ struct p9_req_t {
>   * @trans_mod: module API instantiated with this client
>   * @status: connection state
>   * @trans: tranport instance state and API
> + * @fcall_cache: kmem cache for client request data (msize-specific)
> + * @async_req_lock: protects @async_req_list
> + * @async_req_list: list of requests waiting a reply
>   * @fids: All active FID handles
>   * @reqs: All active requests.
>   * @name: node name used as client id
> @@ -125,6 +130,8 @@ struct p9_client {
>  	enum p9_trans_status status;
>  	void *trans;
>  	struct kmem_cache *fcall_cache;
> +	spinlock_t async_req_lock;
> +	struct list_head async_req_list;
>  
>  	union {
>  		struct {
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 357214a51f13..0a67c3ccd4fd 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -729,6 +729,62 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
>  	return ERR_PTR(err);
>  }
>  
> +static struct p9_req_t *
> +p9_client_async_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
> +{
> +	va_list ap;
> +	int err;
> +	struct p9_req_t *req;
> +
> +	va_start(ap, fmt);
> +	req = p9_client_prepare_req(c, type, c->msize, fmt, ap);
> +	va_end(ap);
> +	if (IS_ERR(req))
> +		return req;
> +
> +	err = c->trans_mod->request(c, req);
> +	if (err < 0) {
> +		/* bail out without flushing... */
> +		p9_req_put(req);
> +		p9_tag_remove(c, req);
> +		if (err != -ERESTARTSYS && err != -EFAULT)
> +			c->status = Disconnected;
> +		return ERR_PTR(safe_errno(err));
> +	}
> +
> +	return req;
> +}
> +
> +static void p9_client_handle_async(struct p9_client *c, bool free_all)
> +{
> +	struct p9_req_t *req, *nreq;
> +
> +	/* it's ok to miss some async replies here, do a quick check without
> +	 * lock first unless called with free_all
> +	 */
> +	if (!free_all && list_empty(&c->async_req_list))
> +		return;
> +
> +	spin_lock_irq(&c->async_req_lock);
> +	list_for_each_entry_safe(req, nreq, &c->async_req_list, async_list) {
> +		if (free_all && req->status < REQ_STATUS_RCVD) {
> +			p9_debug(P9_DEBUG_ERROR,
> +				 "final async handler found req tag %d type %d status %d\n",
> +				 req->tc.tag, req->tc.id, req->status);
> +			if (c->trans_mod->cancelled)
> +				c->trans_mod->cancelled(c, req);
> +			/* won't receive reply now */
> +			p9_req_put(req);
> +		}
> +		if (free_all || req->status >= REQ_STATUS_RCVD) {
> +			/* Put old refs whatever reqs actually returned */
> +			list_del(&req->async_list);
> +			p9_tag_remove(c, req);
> +		}
> +	}
> +	spin_unlock_irq(&c->async_req_lock);
> +}
> +
>  /**
>   * p9_client_rpc - issue a request and wait for a response
>   * @c: client session
> @@ -746,6 +802,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>  	unsigned long flags;
>  	struct p9_req_t *req;
>  
> +	p9_client_handle_async(c, 0);
> +
>  	va_start(ap, fmt);
>  	req = p9_client_prepare_req(c, type, c->msize, fmt, ap);
>  	va_end(ap);
> @@ -841,6 +899,8 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>  	unsigned long flags;
>  	struct p9_req_t *req;
>  
> +	p9_client_handle_async(c, 0);
> +
>  	va_start(ap, fmt);
>  	/*
>  	 * We allocate a inline protocol data of only 4k bytes.
> @@ -1030,6 +1090,8 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  	memcpy(clnt->name, client_id, strlen(client_id) + 1);
>  
>  	spin_lock_init(&clnt->lock);
> +	spin_lock_init(&clnt->async_req_lock);
> +	INIT_LIST_HEAD(&clnt->async_req_list);
>  	idr_init(&clnt->fids);
>  	idr_init(&clnt->reqs);
>  
> @@ -1101,6 +1163,8 @@ void p9_client_destroy(struct p9_client *clnt)
>  
>  	v9fs_put_trans(clnt->trans_mod);
>  
> +	p9_client_handle_async(clnt, 1);
> +
>  	idr_for_each_entry(&clnt->fids, fid, id) {
>  		pr_info("Found fid %d not clunked\n", fid->fid);
>  		p9_fid_destroy(fid);
> 

