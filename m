Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-218212-1518281654-2-12353991450961807145
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518281654; b=MCRGrDZFtSyKEM3kzw3focQumWrEBWYw16iFss1vXZLrMzC
    tBScf6km9eQeWh0H4+X/kwLzrkTiAPts8uQPmHXNPItQ5xmyjefSN2Tid/Xg92rU
    mBPuOTIm0roxgqIBI248RtBjXUZ6T+UIKusJaucPCU8iEkj9UC50gZpPVVlKYRSw
    JHaQ4U1cVpLqHu+bsVZALZJ50+Rp2+jlKGH0+90Mjy8v/bl+1vNM5jOxswEOjBgU
    3PIZh4vLGbyjM64V98kSgWjNpCz9lGgvTpGsJ2ECoRz/Nbo9txnw7wr4T/RArBNm
    8I1k6NSYKidjeU4GZ1rmls+UL9nO1XgBQqNOBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518281654; bh=Haitv3EQtqmHuu+uEV1p9MJzkGfrNnNnNXSaeqji5M8=; b=S
    Aq3jcXdAZN9rf4ITwHkoJmYdCvcIi5toXgv72O3WwVDVCsLWSfPT+eANpP3HtYdr
    kTD9Vz3vQ8pIXIICTBwzHcz7awR5AuJw1VNFAMCkHCsW2q3RhEVby93CROTFgOEa
    gyDbeIsETHfLzae9a8v+7egw4D05zLBLwab5ETN8HUB06lIQALBCiLOZ+LCHGL4m
    xDih5/gpuIGvU7/q3ra3pIYfLJUVvu7on2sgxqRdXJhe41ERooBUlpQxS+qFiHGJ
    aI9w6cwmWVtXLNlKt+kcmDSWC8K/cmoUhw+iRwLuKMPjpVy2gVHOKSsPZm6lklwj
    xWJuX8WiA9iIrIpGz+EsQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=HC3QcFHS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=HC3QcFHS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbeBJQyJ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 11:54:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59722 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbeBJQyJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 11:54:09 -0500
Subject: Re: [PATCH 1/2] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END
 handling
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org
References: <20180207222236.7434-1-simon@invisiblethingslab.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <b8ccff70-69a7-1fca-98f8-8828895c3c32@oracle.com>
Date: Sat, 10 Feb 2018 11:53:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207222236.7434-1-simon@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8801 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802100222
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/07/2018 05:22 PM, Simon Gaiser wrote:
> Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple
> concurrent xenstore accesses") made a subtle change to the semantic of
> xenbus_dev_request_and_reply() and xenbus_transaction_end().
> 
> Before on an error response to XS_TRANSACTION_END
> xenbus_dev_request_and_reply() would not decrement the active
> transaction counter. But xenbus_transaction_end() has always counted the
> transaction as finished regardless of the response.
> 
> The new behavior is that xenbus_dev_request_and_reply() and
> xenbus_transaction_end() will always count the transaction as finished
> regardless the response code (handled in xs_request_exit()).
> 
> But xenbus_dev_frontend tries to end a transaction on closing of the
> device if the XS_TRANSACTION_END failed before. Trying to close the
> transaction twice corrupts the reference count. So fix this by also
> considering a transaction closed if we have sent XS_TRANSACTION_END once
> regardless of the return code.
> 
> Cc: <stable@vger.kernel.org> # 4.11
> Fixes: fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

(although I'd prefer Juergen to also take a look at this)

> ---
>   drivers/xen/xenbus/xenbus_dev_frontend.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
> index f3b089b7c0b6..d2edbc79384a 100644
> --- a/drivers/xen/xenbus/xenbus_dev_frontend.c
> +++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
> @@ -365,7 +365,7 @@ void xenbus_dev_queue_reply(struct xb_req_data *req)
>   			if (WARN_ON(rc))
>   				goto out;
>   		}
> -	} else if (req->msg.type == XS_TRANSACTION_END) {
> +	} else if (req->type == XS_TRANSACTION_END) {
>   		trans = xenbus_get_transaction(u, req->msg.tx_id);
>   		if (WARN_ON(!trans))
>   			goto out;
> 
