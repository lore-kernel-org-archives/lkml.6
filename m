Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521623678-4-12806175924613841542
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
    t=1521623678; b=kLnKcU5eP62Rss+4u4WX3NOtE51IPk1szKDTalq09wEwgbj
    dkOjMkHxlrcT8k0jUtoWBuSRUQ1MlVPR/67VChVtgEv/lAAK8GEV9dD90i+VMUo2
    VwznbnErLM2tILH5EHUHYhAEtS6Ht4sYEefO0wtMcjMw7+QyM8L0eMZEFSvp58Tq
    c4Nzp1AQN2g1Z6+T9/k3ih1g9C9XRXBfNkk1siYKFpxmVh1PJN+c3R2bqNWQp1QL
    eg8D/GLL7QOLEq3J/Fdr7+THI6khnNeZUs1lETS6Y8XNKxe+HV6SheKtvN1brX6V
    dFS18PPq1oYkIJ0d6BwkXvWHv2msm0BUvIrl0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521623678; bh=MzptSGWEdHB6yHaA9iMK5UhJjD
    axbTdPSgABrRdIOAo=; b=liLi80AUr2m8k+dIK1SMzOM2GlFs8fA7eAJ0Y24Eju
    2EsYusIGHud74PhwQTjpUqVimDt/JcdvpImsjsKSTGCERX/KzeEzZbQ2/KOmM1Hl
    +ZhOnkGwyuCDUYVsNWH9znnwsE85R7tsNOCgUVXAFCCMs5YyTTwyIRV+loM1+wdP
    ak+V0qAuacgLjeo+0h+EStcQZ7uqq14SftiR93QU4Dqhdy1+0WvNkYEVSSSIDA2A
    LClQuPg6rBSzW/1yQVXMpDtMAVQfoh61Ufs10+ugQVcd1iIG9E26u7Y5Jz5ORKiW
    vrUSGs31ug0TqvD8pyBLMzerOK4veyDz0fzGUXsNSDCQ==
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
        id S1751615AbeCUJOY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:14:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeCUJOX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 05:14:23 -0400
Date: Wed, 21 Mar 2018 10:14:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] aio: remove an outdated comment in aio_complete
Message-ID: <20180321091420.GJ14085@kroah.com>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-3-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:25AM +0100, Christoph Hellwig wrote:
> These days we don't treat sync iocbs special in the aio completion code as
> they never use it.  Remove the old comment, and move the BUG_ON for a sync
> iocb to the top of the function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Moyer <jmoyer@redhat.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/aio.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 03d59593912d..41fc8ce6bc7f 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1088,6 +1088,8 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
>  	unsigned tail, pos, head;
>  	unsigned long	flags;
>  
> +	BUG_ON(is_sync_kiocb(kiocb));

Is this BUG_ON even needed anymore?  Does it ever trip in any "regular"
use, or is it only there for when a developer does something dumb?  If
"dumb", then we should keep it, otherwise we might be able to just drop
it.

Either way, this patch is fine:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
