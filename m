Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-143482-1521512034-2-4353975051532802225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521512033; b=DcA1DD8UOubIwrrfBGc0HEn83RDm5GBRsuPQfK3YZicLIuL
    TwNSC7wN/KYtroheftdeBfqt0q7xonyBR5yE1OmeJSfBM/uHG9Py3iefIn6+9Y3r
    fOGo7MyT6olxqErJF4KRmojreeAI6tBd/uqmUV01NZUzNkTfa9uTlZpV+qmphd6E
    0NRHewt+3OnvPeN7lnGSUo2rkwCKS0u5d0xP6xP9wPp1cDrW0tb2cWvbrLKTNwVQ
    HxfkaK80MuKgYrKIHlcy6GUTOGTXxqoqyvP88dfK+FSrukasK1J3t9iQH4exYgoa
    k/2yR+CDFMnNpELqWGgWKOn5Z9hdIPUv92R5Vkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521512033; bh=DO9u8c4ztynX1IQSkGl7X486S/
    oOeasTbWHCAT6mPuw=; b=g7apcMcqKsMQczjTI8l+Pnrhp5D3G71x/j5nQLPfRE
    Qytf5yr1eODrXYF/V9JSE970mP7KKMY/ZJceHzYgvZS+CG2GkiHDEmotbYEEncQ6
    uN8/iMF3RIFBVo01tddlcxNrxWKZp1pBJ84nwy31mqBl4r1p5iCRjI/8Z2EiOIqg
    NcObVAld8FbbDp1+EB/SCakLMkEZBjVQLXzv67rxT0WJi2DtZ8Ocy+pzd8bG97Me
    EMQwFc8rQVAiVvYHxmE8URnhCI0kSkT2rQQHUabKvB4VGiEh16oHJwF62W7150yL
    gSqywQHAZS8d74vP/lbeBon0d25HxkeWntN439Sl6DyQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Zzr28gm6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdduvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfephedvudelnecuvehluhhsthgvrhfuihiivgepud
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Zzr28gm6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdduvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfephedvudelnecuvehluhhsthgvrhfuihiivgepud
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751018AbeCTCNc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 22:13:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55356 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeCTCNV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Mar 2018 22:13:21 -0400
Date: Mon, 19 Mar 2018 19:13:14 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/36] fs: unexport poll_schedule_timeout
Message-ID: <20180320021314.GF7282@magnolia>
References: <20180305212743.16664-1-hch@lst.de>
 <20180305212743.16664-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305212743.16664-10-hch@lst.de>
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

On Mon, Mar 05, 2018 at 01:27:16PM -0800, Christoph Hellwig wrote:
> No users outside of select.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/select.c          | 3 +--
>  include/linux/poll.h | 2 --
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index b6c36254028a..686de7b3a1db 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -233,7 +233,7 @@ static void __pollwait(struct file *filp, wait_queue_head_t *wait_address,
>  	add_wait_queue(wait_address, &entry->wait);
>  }
>  
> -int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
> +static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
>  			  ktime_t *expires, unsigned long slack)
>  {
>  	int rc = -EINTR;
> @@ -258,7 +258,6 @@ int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
>  
>  	return rc;
>  }
> -EXPORT_SYMBOL(poll_schedule_timeout);
>  
>  /**
>   * poll_select_set_timeout - helper function to setup the timeout value
> diff --git a/include/linux/poll.h b/include/linux/poll.h
> index f45ebd017eaa..a3576da63377 100644
> --- a/include/linux/poll.h
> +++ b/include/linux/poll.h
> @@ -96,8 +96,6 @@ struct poll_wqueues {
>  
>  extern void poll_initwait(struct poll_wqueues *pwq);
>  extern void poll_freewait(struct poll_wqueues *pwq);
> -extern int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
> -				 ktime_t *expires, unsigned long slack);
>  extern u64 select_estimate_accuracy(struct timespec64 *tv);
>  
>  #define MAX_INT64_SECONDS (((s64)(~((u64)0)>>1)/HZ)-1)
> -- 
> 2.14.2
> 
