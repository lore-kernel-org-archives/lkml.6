Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219634-1522983594-2-3232400905209431892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522983593; b=Lv20Ma1/QVnT5j2CSHLNPwcjRj4LVwMNXcgWBSkEPOni2i/wSR
    LfHT5CYwZN0vYIvbANJnDcu1h1hH7tqV+33w2wOTRMbO+p0iihVwTM0zsn7Q8oQ2
    ROfeXuRVIqOy1fXPbp+DPkXUFYofyXx+WadhuLM0bWXDV/8fK+dXkGrTycVHk8Ig
    2EyacQufx00ptHiCoYxBKpZL89FryGVa+Lz7+n/S8k4ae6PX1cPl6Ax2bO614zXA
    Xc7I2Ts0GXWaBEAti7saBvIw3F7fpI22f69rE0yGwO8PuxWOtbBh0ELodiBHSNyC
    F45iFADH33YjgvT8HKXa4GSeky1GBFZHvzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522983593; bh=zU3XP+xPC7b8Jm7OSREZ9D4dczBoXd
    Cy50U6uGSqxsE=; b=EsP8h/TOoEj2ydmsX2AxP1BHURFYI4NJNmyCU+bDwyM2sD
    H2fMYKyMV8bhDA93MOehEsj6TJRQEMGkdw4lrYbntWZt5MDQ4xzMonJbJviFlfc+
    Yt4TL6Fnl3493krqMnCuI0zuFx8ycPnj8dkLYf6i8QzME5nUuhqGNJ6D2MkJq2sr
    bfu/j4fbQDur6s5HS+qO65VJ65H35xwFb2va044oqXYacpWBY8PUYAZRD5sD2TQ5
    RHY+sxDiYJ1RPTIxX2lZb1Yql8M+j8kZzGXM/P6xwiUwRlleMKfG/Jm3gP2BwWO9
    LkFInZGGQTOjz1hWm6JUTVSRuFLUUYC3uai5ipQA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB39a4TfgGa6AhFk8AB/3lSsXe2Aer2jcjDyL/JnmrppOJBIW+1InMij9ifasuD95ZgxmhJJjIzVixijsDh9erGbrTbqxNWzi/64V7nG3ZufS76lrmrN
    owjpLq9sC/lUEHSDaI23SCOVMsnRSOFN+5t+95wbpV2+6Zd5CXvM+4xvoasuK3wnUb3xDovI7uIPYFxs+6owBFhPYBOxOL0ddbe1YeRnKlHMGG4jNGlnC8w+
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=gDwhgaZ8aNLxu_UQeb0A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeDFC7w (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 22:59:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47050 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbeDFC7v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Apr 2018 22:59:51 -0400
Date: Fri, 6 Apr 2018 03:59:48 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] aio: implement IOCB_CMD_FSYNC and IOCB_CMD_FDSYNC
Message-ID: <20180406025948.GT30522@ZenIV.linux.org.uk>
References: <20180328072639.16885-1-hch@lst.de>
 <20180328072639.16885-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328072639.16885-6-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 09:26:38AM +0200, Christoph Hellwig wrote:
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

Really?  The only way to get there is if we got NULL ->f_op->fsync.
So this "if (unlikely(...))" is actually if (true) and I'm not
sure we want that separated anyway - simply

	if (unlikely(!req->file->f_op->fsync)) {
		fput(req->file);
		return -EINVAL;
	}

> +		fput(req->file);

> +	return ret;
> +}

