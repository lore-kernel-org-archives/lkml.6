Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAA4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401242150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401242150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbeHBP0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:26:00 -0400
Received: from fieldses.org ([173.255.197.46]:35914 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387574AbeHBPZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:25:59 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 3E6851E29; Thu,  2 Aug 2018 09:34:45 -0400 (EDT)
Date:   Thu, 2 Aug 2018 09:34:45 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: use true and false for boolean values
Message-ID: <20180802133445.GB30706@fieldses.org>
References: <20180802004405.GA23995@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802004405.GA23995@embeddedor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, applied for for-4.19, thanks.--b.

On Wed, Aug 01, 2018 at 07:44:05PM -0500, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  fs/nfsd/nfsfh.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index a008e76..b319080 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -451,7 +451,7 @@ static bool fsid_type_ok_for_exp(u8 fsid_type, struct svc_export *exp)
>  	switch (fsid_type) {
>  	case FSID_DEV:
>  		if (!old_valid_dev(exp_sb(exp)->s_dev))
> -			return 0;
> +			return false;
>  		/* FALL THROUGH */
>  	case FSID_MAJOR_MINOR:
>  	case FSID_ENCODE_DEV:
> @@ -461,13 +461,13 @@ static bool fsid_type_ok_for_exp(u8 fsid_type, struct svc_export *exp)
>  	case FSID_UUID8:
>  	case FSID_UUID16:
>  		if (!is_root_export(exp))
> -			return 0;
> +			return false;
>  		/* fall through */
>  	case FSID_UUID4_INUM:
>  	case FSID_UUID16_INUM:
>  		return exp->ex_uuid != NULL;
>  	}
> -	return 1;
> +	return true;
>  }
>  
>  
> -- 
> 2.7.4
