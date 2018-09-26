Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED9BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B5A206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B5A206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeIZGpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:45:44 -0400
Received: from fieldses.org ([173.255.197.46]:48870 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbeIZGpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:45:44 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id BA8561F67; Tue, 25 Sep 2018 20:35:35 -0400 (EDT)
Date:   Tue, 25 Sep 2018 20:35:35 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] nfsd: remove set but not used variable 'dirp'
Message-ID: <20180926003535.GC9559@fieldses.org>
References: <1537874573-182553-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537874573-182553-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applying for 4.20.--b.

On Tue, Sep 25, 2018 at 11:22:53AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> fs/nfsd/vfs.c: In function 'nfsd_create':
> fs/nfsd/vfs.c:1279:16: warning:
>  variable 'dirp' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/nfsd/vfs.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index b53e763..d74583f 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1276,7 +1276,6 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		int type, dev_t rdev, struct svc_fh *resfhp)
>  {
>  	struct dentry	*dentry, *dchild = NULL;
> -	struct inode	*dirp;
>  	__be32		err;
>  	int		host_err;
>  
> @@ -1288,7 +1287,6 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		return err;
>  
>  	dentry = fhp->fh_dentry;
> -	dirp = d_inode(dentry);
>  
>  	host_err = fh_want_write(fhp);
>  	if (host_err)
