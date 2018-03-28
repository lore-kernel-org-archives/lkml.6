Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2742536-1522254950-2-5616250499176879445
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522254949; b=UAfWY4oXvpLT5kxpt6lk7pvzHOPXCL0NfRyXjLltVuOYK+y
    x73iH2aM45bNUYf/BErsdKUuim/0kX5ahKU1pOvAbZhREHwkNwoDmiPQK5FAmhUh
    Wzp0Eou+xLqzEyI7Rsv9405pIjYezVVSAJJAVpQ4grmEM/aiPNT3KmoAwxDwiAcj
    3eWmlCTc4FxfG1d7qJlO+AZ03RMASFTVzyuFMYq+F5jOtRnkCwsIQA/mvxF8Lmpb
    DmCSg0PvogKEsjqRffRds1gR8H08cIrWL0/Q85xqyxvnokCZeo6oaOgCcf2HPHRw
    AltJLqU1fai3peSjjcOvogKA2u8UL+CMfZ6JRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522254949; bh=CPVcEjUQ9oXRi0nAMO79g903Fd
    DTvWL9JnKu5zfsk0Q=; b=pmPPcnRpq7xm9ogcyFiej0Jpd7e4dsFHZ+ozhI7x7X
    yf/e0xCNtu1u7AJKmKdDWhxDadLHwqA30H+/75SiJ1O33RWpeSxTWYMfUL12WNuT
    vxefjEnRtuzwXPY4EMSYtEfjsEyA+h8LlqRhgYYz2L1Zccxf2I+JRKJZ1X8Z7PUS
    YN7WMLhmUreiH6XELSkS2dtiyggVjK2qw1Q8gbibuRgdeguNPV6ov02SLWHsnTgA
    PkwfUhTdhYfM2bJeQjbpqLAIXsLq52FB+5djv7Mob/CmSllKaEV6NCXrr3NHVCSD
    dt7cH/Ss56z8NlD2c7eziF04F4FylPXSXR242faDXUqg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfFGunoIKKQlAq03SC5rdo0qNPQVJi/xHas756H6qAo99bPOgLEVr6FCKYClH3/Mm2aiblIIliu6t0rR9BrtEBJR89IXbsqKdvQZ9bJV99zjVuoaOULsH
    9mQWk88Ip7hJ9gNJgFLp2xDhKRtiG2YTK90flLFQig6icLW6VnqP8dvaqZ+2H5VF9re62p7f4uBWve9qwCGb9Ux6HxHowH7BB+f9Stc8RKJSUqgjZukIXfqz
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=zgRTvXXBjWuRq7UJpGAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeC1Qfa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 12:35:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36130 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752670AbeC1Qf2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 12:35:28 -0400
Date: Wed, 28 Mar 2018 17:35:26 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/30] aio: add delayed cancel support
Message-ID: <20180328163526.GV30522@ZenIV.linux.org.uk>
References: <20180328072926.17131-1-hch@lst.de>
 <20180328072926.17131-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328072926.17131-8-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 09:29:03AM +0200, Christoph Hellwig wrote:
>  static void aio_fsync_work(struct work_struct *work)
>  {
>  	struct fsync_iocb *req = container_of(work, struct fsync_iocb, work);
> +	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, fsync);
> +	struct file *file = req->file;
>  	int ret;
>  
>  	ret = vfs_fsync(req->file, req->datasync);
> -	fput(req->file);
> -	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
> +	if (aio_complete(iocb, ret, 0, 0))
> +		fput(file);

IDGI.
	1) can aio_complete() ever return false here?
	2) do we ever have aio_kiocb that would not have an associated
struct file * that needs to be dropped on successful aio_complete()?  AFAICS,
rw, fsync and poll variants all have one, and I'm not sure what kind of
async IO *could* be done without an opened file.
