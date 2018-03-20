Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-143482-1521512077-2-9824820934760955357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521512076; b=RSRpfFSahPBs5ARwjsVc1Jy75yqHaSL/3OkDh4zrj2zUUYW
    GjDaORYeJ2OtsBjGM2iCN04M8N1oelrAv/gu5Ip3SIN38IMmC3XqJ2BKjjq0hMr2
    Ie2+TIIlouBWZlq4EmNSbxXf7p3Si0QfHqcylIswpJDFv56HKrfybtGWj73aAmDo
    Gp4zGPUHf/V2aZnnXhb15jHCLXe9uB9fl1AoQGjv65rXLpe8P69ZWn6do0Qu2hwx
    LMH8YxfluzSyxxelYzEdzIX4iOO63pj7hd4DKP6ywusB8Tc2Av1z7G51BGqjE1zI
    NDyxDaquwE438atBND+nc+GXUIbGvbOce34UosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521512076; bh=Eauh8iqDK3UmtIgLN0J4FcV2OR
    Ttin30d6LrOoPav0s=; b=Xf/7i+fAtHUAlzz8zsopWH9UwZZ3Wu6OACGKBD/8Mg
    zm7BSnxENbOj7w85nnaXu0I45M2g4EvfNc1OEhvsEBjvC04F9UZvDtwKOlir6wW4
    FNqjKN9fjnnDFCyq29B4dBui6sgqlGLggxlQ8aHoEwspeRQffsiAKdMjX/61SU2k
    soMpn5RlKkhNVo63lILasMB0ZWFbeeEl3Xy7o3R3dQpbN5ltUPS8qtLcs1RkCU2s
    POvUbKNB1l+4zAi3yMCwO9yhBEcvF0GjTCaeoi99B5gFmmXh45rYJCd2vDHlUXsM
    9ZqwV2G9C5x6n7j7P237kfgmNcpNJNSWG73gk004l1/w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=dRHYP9s7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdduheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheeivdegnecuvehluhhsthgvrhfuihiivgeptd
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=dRHYP9s7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdduheenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheeivdegnecuvehluhhsthgvrhfuihiivgeptd
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeCTCOf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 22:14:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43040 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeCTCOe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Mar 2018 22:14:34 -0400
Date: Mon, 19 Mar 2018 19:14:27 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/36] fs: cleanup do_pollfd
Message-ID: <20180320021427.GG7282@magnolia>
References: <20180305212743.16664-1-hch@lst.de>
 <20180305212743.16664-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305212743.16664-11-hch@lst.de>
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

On Mon, Mar 05, 2018 at 01:27:17PM -0800, Christoph Hellwig wrote:
> Use straigline code with failure handling gotos instead of a lot
> of nested conditionals.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/select.c | 48 +++++++++++++++++++++++-------------------------
>  1 file changed, 23 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 686de7b3a1db..c6c504a814f9 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -806,34 +806,32 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
>  				     bool *can_busy_poll,
>  				     __poll_t busy_flag)
>  {
> -	__poll_t mask;
> -	int fd;
> -
> -	mask = 0;
> -	fd = pollfd->fd;
> -	if (fd >= 0) {
> -		struct fd f = fdget(fd);
> -		mask = EPOLLNVAL;
> -		if (f.file) {
> -			/* userland u16 ->events contains POLL... bitmap */
> -			__poll_t filter = demangle_poll(pollfd->events) |
> -						EPOLLERR | EPOLLHUP;
> -			mask = DEFAULT_POLLMASK;
> -			if (f.file->f_op->poll) {
> -				pwait->_key = filter;
> -				pwait->_key |= busy_flag;
> -				mask = f.file->f_op->poll(f.file, pwait);
> -				if (mask & busy_flag)
> -					*can_busy_poll = true;
> -			}
> -			/* Mask out unneeded events. */
> -			mask &= filter;
> -			fdput(f);
> -		}
> +	int fd = pollfd->fd;
> +	__poll_t mask = 0, filter;
> +	struct fd f;
> +
> +	if (fd < 0)
> +		goto out;
> +	mask = EPOLLNVAL;
> +	f = fdget(fd);
> +	if (!f.file)
> +		goto out;
> +
> +	/* userland u16 ->events contains POLL... bitmap */
> +	filter = demangle_poll(pollfd->events) | EPOLLERR | EPOLLHUP;
> +	mask = DEFAULT_POLLMASK;
> +	if (f.file->f_op->poll) {
> +		pwait->_key = filter | busy_flag;
> +		mask = f.file->f_op->poll(f.file, pwait);
> +		if (mask & busy_flag)
> +			*can_busy_poll = true;
>  	}
> +	mask &= filter;		/* Mask out unneeded events. */
> +	fdput(f);
> +
> +out:
>  	/* ... and so does ->revents */
>  	pollfd->revents = mangle_poll(mask);
> -
>  	return mask;
>  }
>  
> -- 
> 2.14.2
> 
