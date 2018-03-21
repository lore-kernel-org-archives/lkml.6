Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223322-1521649985-2-3909545826783602410
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
    t=1521649984; b=olNYl/+u/t2JYhuq8pvMlNGMPgX0GlDIOd7ivuzPcmeOVDv
    XRMSQhpjkXLswfcJXTR8NjoEOWJIExmaVzdz3MGH7jisaIzap1d1f5ehGZqYtwRg
    c5FVFPKmw/FTQ/KXjkGVKNrI/O3T2xN1fI4uddvZotfVGxjU9ted97o5IkGDieIe
    20gdAtpW16s8vRUx1uEzElFWU/gpL8PQ59myVESniAeMtVZaYCEckYVeB6bcQEvx
    peNCrSZcK8YGj770yjCOSHlayICBRDHIF2OJLY3zyVKwV35H7MGL01MKhHPuRInn
    tAp9iUvQbUG57eCi1A38c9GIocZH+3M5IXIsB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521649984; bh=HCQAtUlliXmrDcXuk5DMOW9TMz
    dDiF4chbIqOL7UiII=; b=KKu2yREQ22rPV8A8tNDcqyhPxuFhu6L3MY1FVCa3Na
    RWF1VHe6gGvqh5RIyYB6sAIsU1XDRhsIcydAmafc5CZ0cU5rK+lNGCufZEbDkiFJ
    fgXkpaZ/Vx2V+cgWXwHb0rdpZqvBVKrh6qsj+PkealvZRsnTLgrq4SXkymHUUi7x
    c/mfslkmzA8r/NbCh0CjEksBppaLYCz5FvcoF00vnVnSyDlP4/Tg6E0hNaB/1JBc
    0F+qoKJJIHt2bS02vpMu63v04i2edgIG+1UR0PdH2SS3Elob2c61qDkOqBzRsVVF
    T7oFVlYdRbahqWeSFTIiSR3HzA2tOo7OAMMEOdY+0weA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=mT+l0/9B x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=mT+l0/9B x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeCUQdD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 12:33:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55282 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbeCUQc7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 12:32:59 -0400
Date: Wed, 21 Mar 2018 09:26:23 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] aio: implement IOCB_CMD_FSYNC and IOCB_CMD_FDSYNC
Message-ID: <20180321162623.GD4807@magnolia>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-10-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=924
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
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

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

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
> +{
> +	int ret;
> +
> +	if (iocb->aio_buf)
> +		return -EINVAL;
> +	if (iocb->aio_offset || iocb->aio_nbytes || iocb->aio_rw_flags)
> +		return -EINVAL;
> +
> +	req->file = fget(iocb->aio_fildes);
> +	if (unlikely(!req->file))
> +		return -EBADF;
> +
> +	ret = -EINVAL;
> +	if (!req->file->f_op->fsync)
> +		goto out_fput;
> +
> +	req->datasync = datasync;
> +	INIT_WORK(&req->work, aio_fsync_work);
> +	schedule_work(&req->work);
> +	return -EIOCBQUEUED;
> +out_fput:
> +	if (unlikely(ret && ret != -EIOCBQUEUED))
> +		fput(req->file);
> +	return ret;
> +}
> +
>  static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  			 struct iocb *iocb, bool compat)
>  {
> @@ -1628,6 +1672,12 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
>  	case IOCB_CMD_PWRITEV:
>  		ret = aio_write(&req->rw, iocb, true, compat);
>  		break;
> +	case IOCB_CMD_FSYNC:
> +		ret = aio_fsync(&req->fsync, iocb, false);
> +		break;
> +	case IOCB_CMD_FDSYNC:
> +		ret = aio_fsync(&req->fsync, iocb, true);
> +		break;
>  	default:
>  		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);
>  		ret = -EINVAL;
> -- 
> 2.14.2
> 
