Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10155C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F0B213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F0B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeJDHhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:37:05 -0400
Received: from fieldses.org ([173.255.197.46]:58174 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeJDHhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:37:05 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id AB5B122BE; Wed,  3 Oct 2018 20:46:19 -0400 (EDT)
Date:   Wed, 3 Oct 2018 20:46:19 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix fall-through annotations
Message-ID: <20181004004619.GL17517@fieldses.org>
References: <20181002100848.GA31166@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002100848.GA31166@embeddedor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applying.--b.

On Tue, Oct 02, 2018 at 12:08:48PM +0200, Gustavo A. R. Silva wrote:
> Replace "fallthru" with a proper "fall through" annotation.
> 
> Also, add an annotation were it is expected to fall through.
> 
> These fixes are part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  fs/nfsd/vfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index d74583f..2751976 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1407,6 +1407,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  					*created = 1;
>  				break;
>  			}
> +			/* fall through */
>  		case NFS4_CREATE_EXCLUSIVE4_1:
>  			if (   d_inode(dchild)->i_mtime.tv_sec == v_mtime
>  			    && d_inode(dchild)->i_atime.tv_sec == v_atime
> @@ -1415,7 +1416,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  					*created = 1;
>  				goto set_attr;
>  			}
> -			 /* fallthru */
> +			/* fall through */
>  		case NFS3_CREATE_GUARDED:
>  			err = nfserr_exist;
>  		}
> -- 
> 2.7.4
