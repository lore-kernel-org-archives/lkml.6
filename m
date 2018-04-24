Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3668839-1524605299-2-17494141448779968232
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524605299; b=C4nVuqoIUkm3eKKgWpbLPapNosSFyW1DiHFM2sVRL2VVkOanBi
    Y8v2v7evy/IuaT2mKEmxKzyJWTZSgvxNq6C/S5V/2OU6CKa7GUyTDAS2KNsJQAQd
    f4hu+gqBGQuNO7qRloqIYQFeJmMuNAHfQjQQ3qbZnH50Twzzvrxw2FuT3XQajDrW
    Q2TlhEIrYzdOV4BbsKCaXSyEaNZfMlb0ZqT66EHo78R1HICM/deZDc/a64H8owrT
    ZxpOFlG2jGaiLWd4Rp59AAsA2dywf712StNFCZL+U15RKBCYNaiWyOlV8LRrC5BF
    rIiHv41YSR6csdt/LTysB8MBAp4g+N2kKm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524605299; bh=8TguHmsYVMox6HEsnlC+cC6HSLk1FG
    ATuXdMI9XF51I=; b=wp0uaZ/Bm2ab7qSLwSsHqI1+bFMVZGgHNSnljIFdfZC5Lb
    0NhRFrF4L5ISMtkDLvX7N57C8nc99Du/gzmZaMS0IEpNPef2HcKispjpzVikTn5E
    qQ+HRmUa25rCYdHbNwDGoAuQNEVN7hO3vqr/NlfiUpcfHwAUYbR29hQZyO5QVxrK
    vbZfEzPmn2+hVrDSGTTQ3C28qF2xgTfIJHLqfa+M4UGTR9wc4+n3dogoVzes9ULt
    wDYOilqcwUXXUYcK1BvgSKL85QV/IlW+jVQ6xYQBhj25MOg4lvfLXukp7sSPN0GL
    F4v9gWGQ8WV8H3OaAMZnOmS1YEyy9X6DuicNtkkg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=slHfghN2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=slHfghN2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAixcbEQ8EyNC9nG8WbmpCNbxJX19VOhY123m703FWkAJGlB3CYtAitFdGidQ8gHUIYrz2+Nu5hk4yVP+ysuGRvbOOzV2X81D48fVy0XULFfLEQVZ6b/
    olNlttatdbrjaq/JjQGnkND6MGotDl0ywxCTsFh86xCgr+RcA7LLjAmE0xHbHf2ORlUUeKAlydPoNe2kln4w1WbnPPUuZGFfKfROos4EDZOatPWTNFhJjIG9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=aX38WVO_Nfzbc2vW1K4A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbeDXV2G (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 17:28:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51988 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDXV2F (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Apr 2018 17:28:05 -0400
Date: Tue, 24 Apr 2018 14:27:57 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] aio: remove an outdated BUG_ON and comment in
 aio_complete
Message-ID: <20180424212757.GA26258@magnolia>
References: <20180415150108.1341-1-hch@lst.de>
 <20180415150108.1341-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415150108.1341-3-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8873 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=803
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240203
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 15, 2018 at 05:01:03PM +0200, Christoph Hellwig wrote:
> These days we don't treat sync iocbs special in the aio completion code as
> they never use it.  Remove the old comment and BUG_ON given that the
> current definition of is_sync_kiocb makes it impossible to hit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/aio.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index add46b06be86..7c1855afd723 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1107,15 +1107,6 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
>  		file_end_write(file);
>  	}
>  
> -	/*
> -	 * Special case handling for sync iocbs:
> -	 *  - events go directly into the iocb for fast handling
> -	 *  - the sync task with the iocb in its stack holds the single iocb
> -	 *    ref, no other paths have a way to get another ref
> -	 *  - the sync task helpfully left a reference to itself in the iocb
> -	 */
> -	BUG_ON(is_sync_kiocb(kiocb));
> -
>  	if (iocb->ki_list.next) {
>  		unsigned long flags;
>  
> -- 
> 2.17.0
> 
