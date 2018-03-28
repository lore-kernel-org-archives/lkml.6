Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2629663-1522253484-2-6034996343962398618
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
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
    t=1522253483; b=KeL7PLKKs3NQ5GdqWJzGSffE3CA74H0g/xB7mQF0huuKp3+
    yQKRwJkIOjoga+bCrTojyqzgF75vDtZ2cf8uXl3EHTKOrES7El4l5TdcfVDHVfFj
    F8sWMvtPrZuYOHrdzpE1bbSwWSoDX7Gmhdxa9ATzNygdeUpCBMe+ezaF/SR27uR3
    R56fd/f1JQLC4WECvizE+cAlFIv7P39EUfVikJJvMr88yHhNTOmYc7iMZ0lyivw/
    1kMkbbkRGmLuwrm6cC/uUpCoAxMW4qmgcmHmjEmb4LvUdzwibo3rmrZ2WlTvHaqa
    YHEAAqomseq4/Te7NYuqE92KPYuyLeH7EpKxyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522253483; bh=3YnN5Qlm9eFczQYBlPK3FiiLli
    PHIzLYvy0WDCrubsA=; b=JysjZOyxnICflFcBjM3rjyVMS7wZbGQiALoz5ufn5c
    lPhvTK1jyImpva9/E374gZ90CaZCS1yYE+Zo2tqeAls/hGhtRFnB86qg5WZZy+rF
    k5/gcdnvjMDx08K7krF0upj7WA1nBzMCfL4a7b0daIN7cSJ1jytW0hs1Bzy1QEN9
    Nle33QTHl6D81rHCJnLfzAbDWo6ie9E1LR66E0rZz+eYddwf6F5pLzYgjbCxwGwK
    XKTa38nULzcFcqlQC58A4igdH6khAWlju95rwdPoZucx6WgTy+j0MFgjz78rOuUI
    MRGvNdmkQEBvTtBYyXhwxJYDhArwn/CTQNwypQmFG7lA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=GL7HMz6p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=GL7HMz6p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOLbuExJym3PLD3dvvTT44VXYLQfYQ8oAWFC44uwZlgfoe1RIxmXDZhyK34c87DLhOkuXVP/gA5zEVIX6sRRljqvBfX6x+Ejz9d+hgGObzsveosZVnhL
    eDz3s+c08Z8fo02e3m58i1JEMuZBhZrJz3caObF50oTYHioyH8FRJG8a9tTYWLSZeQwZ+CAr1xjHQT/sdbL4u7gRfbW01BXJ1gvJ6amTfCmixXuykOx/nr2t
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=aX38WVO_Nfzbc2vW1K4A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeC1QLJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 12:11:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46234 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeC1QLH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 12:11:07 -0400
Date: Wed, 28 Mar 2018 09:05:58 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] aio: remove an outdated comment in aio_complete
Message-ID: <20180328160558.GB11581@magnolia>
References: <20180328072639.16885-1-hch@lst.de>
 <20180328072639.16885-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328072639.16885-3-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=747
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280168
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 09:26:35AM +0200, Christoph Hellwig wrote:
> These days we don't treat sync iocbs special in the aio completion code as
> they never use it.  Remove the old comment and BUG_ON given that the
> current definition of is_sync_kiocb makes it impossible to hit.
> iocb to the top of the function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yeah that looks fairly impossible now...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/aio.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 03d59593912d..f536b0f249d4 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1100,15 +1100,6 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
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
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-api" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
