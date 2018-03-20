Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-143482-1521512395-2-4291613804107309576
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
    t=1521512395; b=J9tJ9hVJxiXcj8XCEyExgQSwDB6Dzrfg1/nqxSZA2mvNETi
    DZDW+aIzXY98jNs7b/fxgBqqmsbbV2ZMqJUgRtRU46AU0COaokoPoV+dnsvykxKF
    Nle7XnT8qslUiHzya5K5sKNanFfYVWDPG0ytjB/XEC5lIKCq6/KciTs426PLKYMf
    lE83toHkSE+4aHPC+7AfR4h6cCHlkCNiIa/lTA8M99NJ5aCI12Xgpl9GZp1UkEDJ
    i44AztdrfQzhvzgoeKLSzUJ9dxEL/enI8S5sxGje22LdzuMx6+Yf1y/pNVU7aHvz
    TXJBMkF+AjhC6iOuA530/wTro3P9MpKR02bbqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521512395; bh=G+ZzAwwKkNvubpyCcVIFd9RVgO
    iZRnF9Q+y8TVzONyU=; b=AluBmImSQM+F8qd0qbsPWCQi4YNqY4tQtBPqnBDsxe
    /yLB3erPFbREtWaHAooBivJ9EZgJTvrgE3ayZ4DKDJPrIY9wu7dj6EWNnQ1LyU42
    uXWzqmo4NcPuSyCeasnsT/pP5bJ02e5lREp1CaTUflKq5WixxtpLI7BL+k7mhyfc
    WhBWfrEbkTJnPh4rYYnjZqI8LCgpWfUKnz99HxV5ZfOkQb+x4LvUkZ32ONYinuAq
    RWjDDz8cwbI2ru1JDeymVMv39Yvv2SOlMsIV4SLmT6ydpOQbp1139vpQILSJVcke
    UDJZ6J7nEvEqwBLboVKa1FFT2MQZYirZSdNh1s4Hmrjg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=l9/Sxasu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdduudenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheegkedtnecuvehluhhsthgvrhfuihiivgeptd
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=l9/Sxasu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpedfffgrrhhrihgtkhculfdrucghohhnghdfuceouggrrhhrihgtkhdrfihonhhgsehorhgrtghlvgdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddugedurddugeeirdduudeirdduudenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheegkedtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbeCTCTo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 22:19:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58092 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeCTCTn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Mar 2018 22:19:43 -0400
Date: Mon, 19 Mar 2018 19:19:35 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/36] fs: update documentation for __poll_t
Message-ID: <20180320021935.GH7282@magnolia>
References: <20180305212743.16664-1-hch@lst.de>
 <20180305212743.16664-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305212743.16664-12-hch@lst.de>
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

On Mon, Mar 05, 2018 at 01:27:18PM -0800, Christoph Hellwig wrote:

No commit message... "Update documentation to match the headers"?

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/filesystems/Locking | 2 +-
>  Documentation/filesystems/vfs.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
> index 75d2d57e2c44..220bba28f72b 100644
> --- a/Documentation/filesystems/Locking
> +++ b/Documentation/filesystems/Locking
> @@ -439,7 +439,7 @@ prototypes:
>  	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
>  	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
>  	int (*iterate) (struct file *, struct dir_context *);
> -	unsigned int (*poll) (struct file *, struct poll_table_struct *);
> +	__poll_t (*poll) (struct file *, struct poll_table_struct *);
>  	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
>  	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
>  	int (*mmap) (struct file *, struct vm_area_struct *);
> diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
> index 5fd325df59e2..f608180ad59d 100644
> --- a/Documentation/filesystems/vfs.txt
> +++ b/Documentation/filesystems/vfs.txt
> @@ -856,7 +856,7 @@ struct file_operations {
>  	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
>  	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
>  	int (*iterate) (struct file *, struct dir_context *);
> -	unsigned int (*poll) (struct file *, struct poll_table_struct *);
> +	__poll_t (*poll) (struct file *, struct poll_table_struct *);
>  	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
>  	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
>  	int (*mmap) (struct file *, struct vm_area_struct *);
> -- 
> 2.14.2
> 
