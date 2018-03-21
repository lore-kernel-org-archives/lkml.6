Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223322-1521649974-2-10880747196124762765
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
    t=1521649973; b=lUGmZHYupnE3+KNBBi7IR3USQCWhC0S/vSjIZrFJYm/htgx
    QNzriHX3sQa9kg0wPl+JJkvmvzrhKKeXHQCcJLM8hC/UIsD8VQP4eMEWaSIdeY3S
    Dyh7pSOq0EkYyGGYaj4/SWkbGcPDJznsBm1+hnu6iO3KNuhqJcrXWrPqI1cJ7qjC
    VvdGhO8A91mwz2riivrHdV7pWSMcxf9km/aNu/PQCP0oiVs740FO+dTMx3Dtvqe9
    93j59ohgcJH+MAF8oTvvBFPkqUMCCFFR9kToa5ljEZGc6UwBO/sEhVgMI0U7rqrx
    98lBpNVWC+3I8FoO9BsD8Xh6T5K9F1wKbzo/X6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521649973; bh=y0nWhF7VLOS0pEdG/42oLxm8bY
    qN1bio71usdqXemJQ=; b=JaevqdfDIIXzlFBt+N6ksxPM7PSTwqAsIB6Es644xX
    fpG4D4f3VArrGOcptdRmUErzGr3TPFKOAGYsSxMXXCnP/s3n11l9jHPotW+Krf7e
    LsZUislmVimowNN5B7EH4bKR+lS4qTpbwt50SuI997UXuJ6qqGKmjmYgP7DU9jhI
    j6/NCaoGJY7wFwcoiboQ0Jw1Qcs0q91O4IWeTQYda7jU4beHKxSOg24AdTF9cU/4
    HZrH3FtcSscSCzEEkiK/2obAXBUNOF66Jhq+wZrrGB9myG5yUHTe421sFdjYqwV9
    J40FSObg+kR1O9nDcsBm5nsQJrX/0U0nhYyKq8e5p46w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Xinn6JLf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Xinn6JLf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbeCUQcu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 12:32:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53036 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752956AbeCUQcp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 12:32:45 -0400
Date: Wed, 21 Mar 2018 09:28:42 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/28] fs: update documentation to mention __poll_t
Message-ID: <20180321162842.GF4807@magnolia>
References: <20180321074032.14211-1-hch@lst.de>
 <20180321074032.14211-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321074032.14211-4-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:40:07AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

It still would be nice to have a commit message to note that we're
merely updating the documentation to reflect what's currently in the C
headers (as opposed to a mangled patch that updated the docs but dropped
the actual code update)...

...so with that fixed,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

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
