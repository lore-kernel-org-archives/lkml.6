Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223322-1521650252-2-11054976454647635807
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
    t=1521650251; b=C8+0V5EypuT5XILh3TmBPh+SHCtN3u2i+whQ2duPPqkXl2k
    GDE1p3SNrdtBxdpJCxug5X3YWsFKCXu+NsiIpNvz4CUKfb7I7JN+8sQzmaspLw2O
    YuCQh8lamtdLQOKnRTLNe5PNSjdvMML5KbYzgze2VMhGJ2nKA12gDbUcZAfjtkfF
    X+oFX/VCJYnqEidmJ0jN4Yk17bW6e/RPfllKgJPwSqI7RQpcYXcULeFLA0cCvIRS
    1EqctWf6RvWu5DtvkW1NnOh11dSOrGGTDeVowVyPyhoY4oQe4QWjz/m/pYgbhmTa
    5k/jZnDPfNieogKmZfzLPGyoqD3iJDdMbYClJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521650251; bh=H+OFbN4dHHO+wLtZ5UkBXgdqtM
    dMHzrEQ48UNQBgTg0=; b=A5suzKfJsTp4PUETUp+edfRUfPGYO/nGmmgnqPgLns
    5Wg9PIO1HVRLilHZb5mGbdiOWk42ZsfwmWVrIScCWZgw6OA0ctUOHO+ZNI4K611w
    3DD5kQm4yuCTBECr/7DOXLXMRXnGmwFCqkiP4PHl6j/htRDZ+GYNY0gKUI/I1Bfu
    OL6bt8DFz4Zi5Me8mI1d68fSyMWA2/y6I4dAk+KySBNs5TqKNcvmPkS+JBstCI0I
    UV6/oVu+UUfWRO5NPIx26ZWBdGzT9B45wGxhnODePIE1YxSmsfYodVXTQk9D9G+p
    FaRb75jDCQwythg3GMsfZg8vrzgi1UWLteb+wsrzvl/w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=dnQtcA+4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=dnQtcA+4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeCUQh3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 12:37:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33154 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCUQh2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 12:37:28 -0400
Date: Wed, 21 Mar 2018 09:23:25 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] aio: delete iocbs from the active_reqs list in
 kiocb_cancel
Message-ID: <20180321162325.GB4807@magnolia>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-7-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:29AM +0100, Christoph Hellwig wrote:
> One we cancel an iocb there is no reason to keep it on the active_reqs
> list, given that the list is only used to look for cancelation candidates.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/aio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 2d40cf5dd4ec..0b6394b4e528 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -561,6 +561,8 @@ static int kiocb_cancel(struct aio_kiocb *kiocb)
>  {
>  	kiocb_cancel_fn *cancel = kiocb->ki_cancel;
>  
> +	list_del_init(&kiocb->ki_list);
> +
>  	if (!cancel)
>  		return -EINVAL;
>  	kiocb->ki_cancel = NULL;
> @@ -607,8 +609,6 @@ static void free_ioctx_users(struct percpu_ref *ref)
>  	while (!list_empty(&ctx->active_reqs)) {
>  		req = list_first_entry(&ctx->active_reqs,
>  				       struct aio_kiocb, ki_list);
> -
> -		list_del_init(&req->ki_list);
>  		kiocb_cancel(req);
>  	}
>  
> -- 
> 2.14.2
> 
