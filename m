Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1250620-1517927355-2-4057929392043842852
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517927355; b=eNWtzPMZtmAM9lwJ+jQ73Oo4iPJysX3Na0geUrHUrCi3wBs
    U+0kOZy1b53B8LOChnM4FPXOOW+afSXdg2i2PG7jKteIwk8cjzZtx5XkyOBx7TaK
    sSOWSS4Dq265YI/iXxWmF9no+6T4+YwFeRxD4HDsYkBiuD12wxLK6TDpl1ZvDttn
    lm/jcAz7PYLVhQJZt2iKHB4hqGVdskyDJ+ZSKmoYjAjwR90XfLIDWKyrMuhAI28C
    kx79/KxBTtNiu90b7a3rv3MGU2iBbcOIt274nqJQyG5G8sPeK35+GJvH0Ud8cCzK
    x05A/BZe3jxxYDQvs0VQn93j79gLcSa0LyuOsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517927355; bh=iOxnFhU4wi529Rg31X0IERW8CGZQgfFIZf7G7pJaylY=; b=D
    CRlh2ecwuW0basMFi+lTSRXNsQSEx9k4He47ocEnrfLki5bq/Vic34J/a1/UywoI
    lSoeHYobAJU91Q/9Mf4sE1PH37Sfezf0+f9kBezrBV1eebOwaUZVOK14YlYg6vDM
    f/8nHPQI2HNNZm1p3HQOqwtnW7flAACOeZtntW8uJSNP9RKicYojDA5HAfXSAooU
    Ym8WZJQ6OrnQOxUoHEzuFq65yq0ZT5hnskyeFNllAXYNo5nKMqc00kElrlc5lGqn
    SqxEfNLuJ8zdoG1/eCXe35mpkQqxoKoXcYCngSN8kjz+DKdVAmkq5D+d8zW5dQbd
    qS1AZQ58kFkT6K5o8hNIQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeBFO3N (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 09:29:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:53081 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbeBFO3M (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 09:29:12 -0500
Subject: Re: [PATCH v2] xenbus: track caller request id
To: Joao Martins <joao.m.martins@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        stable@vger.kernel.org
References: <20180202174233.27341-1-joao.m.martins@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <99d14fe8-2f7a-6133-ced7-0ecec732d135@suse.com>
Date: Tue, 6 Feb 2018 15:29:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180202174233.27341-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/18 18:42, Joao Martins wrote:
> Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent
> xenstore accesses") optimized xenbus concurrent accesses but in doing so
> broke UABI of /dev/xen/xenbus. Through /dev/xen/xenbus applications are in
> charge of xenbus message exchange with the correct header and body. Now,
> after the mentioned commit the replies received by application will no
> longer have the header req_id echoed back as it was on request (see
> specification below for reference), because that particular field is being
> overwritten by kernel.
> 
> struct xsd_sockmsg
> {
>   uint32_t type;  /* XS_??? */
>   uint32_t req_id;/* Request identifier, echoed in daemon's response.  */
>   uint32_t tx_id; /* Transaction id (0 if not related to a transaction). */
>   uint32_t len;   /* Length of data following this. */
> 
>   /* Generally followed by nul-terminated string(s). */
> };
> 
> Before there was only one request at a time so req_id could simply be
> forwarded back and forth. To allow simultaneous requests we need a
> different req_id for each message thus kernel keeps a monotonic increasing
> counter for this field and is written on every request irrespective of
> userspace value.
> 
> Forwarding again the req_id on userspace requests is not a solution because
> we would open the possibility of userspace-generated req_id colliding with
> kernel ones. So this patch instead takes another route which is to
> artificially keep user req_id while keeping the xenbus logic as is. We do
> that by saving the original req_id before xs_send(), use the private kernel
> counter as req_id and then once reply comes and was validated, we restore
> back the original req_id.
> 
> Cc: <stable@vger.kernel.org> # 4.11
> Fixes: fd8aa9095a ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
> Reported-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

> ---
> Here's a link to a unit test (https://pastebin.com/2q51j2sR) where req_id of
> reply and response are being asserted each request. Without this patch
> the assert will fail (e.g. try it with `./xswire_reqid_test name`). But
> on <= v4.10 or >= v4.11 with the fix above, it will print domain name 10
> times.
> 
> Changes since v1:
>  * Adjust commit message
>  (Comments from Juergen on IRC)
>  * Unilateraly save/restore req_id and remove xs_request_is_user()
>  * Initialize req_id for kernel callers
> ---
>  drivers/xen/xenbus/xenbus.h       | 1 +
>  drivers/xen/xenbus/xenbus_comms.c | 1 +
>  drivers/xen/xenbus/xenbus_xs.c    | 3 +++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/xen/xenbus/xenbus.h b/drivers/xen/xenbus/xenbus.h
> index 149c5e7efc89..092981171df1 100644
> --- a/drivers/xen/xenbus/xenbus.h
> +++ b/drivers/xen/xenbus/xenbus.h
> @@ -76,6 +76,7 @@ struct xb_req_data {
>  	struct list_head list;
>  	wait_queue_head_t wq;
>  	struct xsd_sockmsg msg;
> +	uint32_t caller_req_id;
>  	enum xsd_sockmsg_type type;
>  	char *body;
>  	const struct kvec *vec;
> diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
> index 5b081a01779d..d239fc3c5e3d 100644
> --- a/drivers/xen/xenbus/xenbus_comms.c
> +++ b/drivers/xen/xenbus/xenbus_comms.c
> @@ -309,6 +309,7 @@ static int process_msg(void)
>  			goto out;
>  
>  		if (req->state == xb_req_state_wait_reply) {
> +			req->msg.req_id = req->caller_req_id;
>  			req->msg.type = state.msg.type;
>  			req->msg.len = state.msg.len;
>  			req->body = state.body;
> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> index 3e59590c7254..3f3b29398ab8 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -227,6 +227,8 @@ static void xs_send(struct xb_req_data *req, struct xsd_sockmsg *msg)
>  	req->state = xb_req_state_queued;
>  	init_waitqueue_head(&req->wq);
>  
> +	/* Save the caller req_id and restore it later in the reply */
> +	req->caller_req_id = req->msg.req_id;
>  	req->msg.req_id = xs_request_enter(req);
>  
>  	mutex_lock(&xb_write_mutex);
> @@ -310,6 +312,7 @@ static void *xs_talkv(struct xenbus_transaction t,
>  	req->num_vecs = num_vecs;
>  	req->cb = xs_wake_up;
>  
> +	msg.req_id = 0;
>  	msg.tx_id = t.id;
>  	msg.type = type;
>  	msg.len = 0;
> 
