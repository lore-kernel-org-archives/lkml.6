Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3621199-1521624499-2-16689887004991569066
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521624498; b=wz2ahl4JRXpSzKOjy2nlQBpUafpugSteNQKK4BS/iSQulkB
    CohDsYFvTEtWb6jAnPjU9N5JZ4ZBNvR+knAFvPV7Duxzy77HVCrgZg0jUsqUF0xu
    MANjPgzY4X5T2Q3QpSZABdTEBb8HYnCP5sEoAPVFJ7LIH/9KhrNttQ7TTBUgssM6
    EJaTuQgNLQFW/CInBPTrJbyxp+jvm9VMWV/Q6OMjNaSwUQc6SnRfwj7NWJD9bhet
    ZQISJvilAaOmqXLd72NVof7mP5G1MmG5mGYwM/aLqIi9Y2EJFqP89QHi7Jghu1P/
    ZehvSsvtI0mPlvJ1hlMWOu2KgdEdEbcEt04JXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521624498; bh=EaVGhGh8EYqOfXtq7eXKXYR2gt
    1i/H0TVID+kPOSDlg=; b=Wl5975zOMLXu0EU8wcpb5CKcb5rnySy3wunTPVjrbo
    X5f8yDBQoKFg99e25q3Uf8HPDp11IVx08i/hzOmzujglW61THOGKpwGUCKqDrNrv
    Xv4CDKYG9x6D9j9iOTlUdbxEicERwQ32TCdJ1AjNYWdx52iOCGwGgvKyjqqQfvaq
    +zZ25ltDwz70ZdkocGa5aaQ3DDIOZh+PEtV3RExTMra4dOlLYteEsD5cbT0JEPPs
    rk0ySOlp+qsqSMnqLjHDON31+RHXP+uPtqkAFVfPBLffAlfuPzj6p8W6OM26gN86
    44yNf7YYDN5mD3nxLCwKZsmQtbkdwLJxRGTQREWKqCiw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeCUJ1R (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:27:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeCUJ1Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:27:16 -0400
Date: Wed, 21 Mar 2018 10:27:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] aio: implement IOCB_CMD_FSYNC and IOCB_CMD_FDSYNC
Message-ID: <20180321092713.GR14085@kroah.com>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-10-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:32AM +0100, Christoph Hellwig wrote:
> Simple workqueue offload for now, but prepared for adding a real aio_fsync
> method if the need arises.  Based on an earlier patch from Dave Chinner.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/aio.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index da87cbf7c67a..79d3eb3d2dd9 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -156,9 +156,16 @@ struct kioctx {
>  	unsigned		id;
>  };
>  
> +struct fsync_iocb {
> +	struct work_struct	work;
> +	struct file		*file;
> +	bool			datasync;
> +};
> +
>  struct aio_kiocb {
>  	union {
>  		struct kiocb		rw;
> +		struct fsync_iocb	fsync;
>  	};
>  
>  	struct kioctx		*ki_ctx;
> @@ -1565,6 +1572,43 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
>  	return ret;
>  }
>  
> +static void aio_fsync_work(struct work_struct *work)
> +{
> +	struct fsync_iocb *req = container_of(work, struct fsync_iocb, work);
> +	int ret;
> +
> +	ret = vfs_fsync(req->file, req->datasync);
> +	fput(req->file);
> +	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
> +}
> +
> +static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)

I hate the "bool" arguments to functions as you always need to go back
and look them up.  A "wrapper" of "aio_fsync_datasync()" and
"aio_fsync_nodatasync()" around this maybe?

Anyway, very tiny nit, not a big deal, it's your code, you can maintain
it as-is :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
