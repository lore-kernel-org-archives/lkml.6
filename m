Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15299C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE10620644
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="HnfyWpv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE10620644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeJSFsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:48:19 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34512 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:48:19 -0400
Received: by mail-yb1-f193.google.com with SMTP id 184-v6so12484549ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cKO6C4CuFmlcQMHod2k6MX0M8iJXUgxmWJyTyPMmdH0=;
        b=HnfyWpv6P/ai9KVTY/w8rHoTFouxeKSrPlJtTFlB+lGN/YR3dfMyedG8I3NhM9OUtM
         kcxcpzBUVfKMazA1cRvRUSX0K6vR4bFrA10adWv0PLABT/QYe8HQLtuIX2GC1pknLRER
         /utDiGFztGnOPqX+wqFSj5w4TasZFC0+Df1Bi+/dDvOMVEJJBKQMH84QsPrhHBpJ1deY
         IgtcEoPBM/kixs/R4r8NT/0qL2UGALHB6ha2q+sTMo/vyy+omisg6/CdE0FIQ6uPh0/D
         UvrMetVPlNsKjzSuG1PVy7eCtNmj+UVINa/qBpCm1MLSStdo3F7BB/CGrHBacsdQuzX+
         g9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cKO6C4CuFmlcQMHod2k6MX0M8iJXUgxmWJyTyPMmdH0=;
        b=marXTr8lHnzyWVWAJcVqf8WPNBNrGQX3Ss7GaPxxbanv0766jb7WFvSwsXuB/k8xWh
         lp/JaKFwTIMLjwjsx7GA57SNvX6fsz04f7FFCd1AfkQlNs1JNJhWkg6HNrobhuDoEdCl
         0qhITHTvdAYFA2AV/sNZKzQgAC8f2Q3+qvgFFHR0rpPzvDuGeualv3dQDCKKHqFVTZbQ
         lbmTUVcUX1olaNMpsfw0+O+s4Nm041l5foo77tM47HSiFbelKbTFrLqDUWDJw7+yytOl
         wKOvDj5Xv54lUk9MSPp2QLSiV5K9yKFK39qZ/3d/twTS+WofklQdUqJNZ5Z7H2lOOeYt
         nROw==
X-Gm-Message-State: ABuFfoh02xItQSgOoaaRqu8UShQ2vv/hrXMi+xly/eQTkE+3g8CbxOBz
        HUAli/reCdXBOrMZRvVNGygtfg==
X-Google-Smtp-Source: ACcGV62xAAwkvc27TDbWs0TnX0mm5BP1xzu7iIHfIvEYiqkRQaFhfYtaoRET/EHjwgNBR7mrvpI77w==
X-Received: by 2002:a25:67d6:: with SMTP id b205-v6mr3049621ybc.521.1539899121109;
        Thu, 18 Oct 2018 14:45:21 -0700 (PDT)
Received: from t480s.mkb.name (47-49-164-163.static.spbg.sc.charter.com. [47.49.164.163])
        by smtp.gmail.com with ESMTPSA id x64-v6sm5978439ywx.103.2018.10.18.14.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 14:45:19 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:45:17 -0400
From:   martin@omnibond.com
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mike Marshall <hubcap@omnibond.com>
Subject: Re: [PATCH 1/3] orangefs: fix request_mask misuse
Message-ID: <20181018214517.GA44581@t480s.mkb.name>
References: <20181018131125.6303-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018131125.6303-1-mszeredi@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 03:11:23PM +0200, Miklos Szeredi wrote:
> Orangefs only handles STATX_BASIC_STATS in its getattr implementation, so
> mask off all other flags.  Not doing so results in statx(2) forcing a
> refresh of cached attributes on any other requested flag (i.e. STATX_BTIME
> currently) due to the following test in orangefs_inode_getattr():
> 
>   (request_mask & orangefs_inode->getattr_mask) == request_mask
> 
> Also clean up gratuitous uses of STATX_ALL.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Mike Marshall <hubcap@omnibond.com>
> Cc: Martin Brandenburg <martin@omnibond.com>

Reviewed-by: Martin Brandenburg <martin@omnibond.com>

> ---
>  fs/orangefs/inode.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 31932879b716..bd7f15a831dc 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -256,7 +256,8 @@ int orangefs_getattr(const struct path *path, struct kstat *stat,
>  		     "orangefs_getattr: called on %pd\n",
>  		     path->dentry);
>  
> -	ret = orangefs_inode_getattr(inode, 0, 0, request_mask);
> +	ret = orangefs_inode_getattr(inode, 0, 0,
> +				     request_mask & STATX_BASIC_STATS);
>  	if (ret == 0) {
>  		generic_fillattr(inode, stat);
>  
> @@ -408,7 +409,7 @@ struct inode *orangefs_iget(struct super_block *sb,
>  	if (!inode || !(inode->i_state & I_NEW))
>  		return inode;
>  
> -	error = orangefs_inode_getattr(inode, 1, 1, STATX_ALL);
> +	error = orangefs_inode_getattr(inode, 1, 1, STATX_BASIC_STATS);
>  	if (error) {
>  		iget_failed(inode);
>  		return ERR_PTR(error);
> @@ -453,7 +454,7 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
>  	orangefs_set_inode(inode, ref);
>  	inode->i_ino = hash;	/* needed for stat etc */
>  
> -	error = orangefs_inode_getattr(inode, 1, 1, STATX_ALL);
> +	error = orangefs_inode_getattr(inode, 1, 1, STATX_BASIC_STATS);
>  	if (error)
>  		goto out_iput;
>  
> -- 
> 2.14.3
> 
