Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E799ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1090420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="TXgo1WaQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mp7IB7nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1090420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbeGWHUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:20:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50141 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbeGWHUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:20:25 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D9DF21B54;
        Mon, 23 Jul 2018 02:20:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 23 Jul 2018 02:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=i6Qb57JgPBGM78B61HzYyrfg2UZZaNiwa+3MAOOa96w=; b=TXgo1WaQ
        aC3z7eQfaPCDhNfy59S8fqu4vGCt3N04kLNf/8ZcCULRmp1zgifu5SExeVlXtEZm
        9mE6cZKfA50ovAHUkfT7hS4uaY5oUL6MBRkJrD8IHSOCyBo9uYs4gQdpb0GK9xMt
        2ZlLrti9A3oThygsPLKBLekZ+OGCFhcS01VZaVW5WwZY72ATsSqcW+LW2mDY0ucR
        p/DRg2tXRZV9uAOrg1C50xyZl8ZtKtbhoLemsoysJaxXFUM1x6/Xgco2/BwylpPU
        t2o+OT70m7Uon4W6GyRuKjkMAGCShZtXpuEDYOLL7gl56hDxLRgvhnebMvlMTbi+
        dTz96PH6uxbaBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=i6Qb57JgPBGM78B61HzYyrfg2UZZa
        Niwa+3MAOOa96w=; b=mp7IB7nke11ZfMOREpGOP6X6SKINjUVBe7wuVIAwIA3h1
        nUn+6TwGERIPMihmY/JoqB4EBjwwflYgobY7e2J8c7hkvymVcwTzV/A1TtyV91L/
        UQjEuwNINdNpmNFVjOgU4DVfxZwlGU/0lIv+6Pkx1Ni1EPbMhko3FGkNHFxz8M/z
        DwNw6tIsb+Si6HP56ON1mdgla/L/1EnHpbqCSZc9EhgOpPfY8hzUqxatRsTp4r0h
        PNYaJD6VLQMAnEjHyMrCD+cWDM/0Fx2WUBfYFzw3XxNZVLhAfFJVq4YYwzKyfupZ
        ywI/kjNtmDkhMYqpSesHYW1BGwqsh6Hfeft61Av+Q==
X-ME-Proxy: <xmx:wHNVW8hldI56CBQ4xGxYZgmn9gZn0pl5Wh9kRBFP2-75coB1AyaA9A>
    <xmx:wHNVW1P8qbO51O-vfPT5lWsDxQPLhHo0_f-U60rCgWd71VcH51v9OQ>
    <xmx:wHNVW15KcfY-FavSWFHSINbwZ15GeRlJatz1iRWvK8GAYVSSSgpyQQ>
    <xmx:wHNVW72be7PH6Ncnv7RARNCaOmdxf7FEEMVe4kFS9MHX_gnNJYlIMw>
    <xmx:wHNVW-YIYY_xrcGvptdJ0fmLfLWYL9cfzeUY39wk_soRIU_v0-yjVw>
    <xmx:wXNVW4Kz5j-4S2VFQMqg1i1q0w3naJsCypdXxu0d2RbJWz6f8cqjlQ>
X-ME-Sender: <xms:wHNVW7PHW7dIA1zv605xRKicmBUqu1n4B10TmdCF4_UdZrcn0yB_dw>
Received: from localhost (lfbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1A4C41025C;
        Mon, 23 Jul 2018 02:20:48 -0400 (EDT)
Date:   Mon, 23 Jul 2018 08:20:46 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rajat Jain <rajatja@google.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 net-next tree
Message-ID: <20180723062046.GA2577@kroah.com>
References: <20180723151224.69a73892@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723151224.69a73892@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 03:12:24PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the driver-core tree got a conflict in:
> 
>   fs/sysfs/group.c
> 
> between commit:
> 
>   5f81880d5204 ("sysfs, kobject: allow creating kobject belonging to arbitrary users")
> 
> from the net-next tree and commit:
> 
>   c855cf2759d2 ("sysfs: Fix internal_create_group() for named group updates")
> 
> from the driver-core tree.
> 
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc fs/sysfs/group.c
> index c7a716c4acc9,38240410f831..000000000000
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@@ -122,15 -118,23 +122,24 @@@ static int internal_create_group(struc
>   			kobj->name, grp->name ?: "");
>   		return -EINVAL;
>   	}
>  +	kobject_get_ownership(kobj, &uid, &gid);
>   	if (grp->name) {
> - 		kn = kernfs_create_dir_ns(kobj->sd, grp->name,
> - 					  S_IRWXU | S_IRUGO | S_IXUGO,
> - 					  uid, gid, kobj, NULL);
> - 		if (IS_ERR(kn)) {
> - 			if (PTR_ERR(kn) == -EEXIST)
> - 				sysfs_warn_dup(kobj->sd, grp->name);
> - 			return PTR_ERR(kn);
> + 		if (update) {
> + 			kn = kernfs_find_and_get(kobj->sd, grp->name);
> + 			if (!kn) {
> + 				pr_warn("Can't update unknown attr grp name: %s/%s\n",
> + 					kobj->name, grp->name);
> + 				return -EINVAL;
> + 			}
> + 		} else {
>  -			kn = kernfs_create_dir(kobj->sd, grp->name,
>  -					       S_IRWXU | S_IRUGO | S_IXUGO,
>  -					       kobj);
> ++			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
> ++						  S_IRWXU | S_IRUGO | S_IXUGO,
> ++						  uid, gid, kobj, NULL);
> + 			if (IS_ERR(kn)) {
> + 				if (PTR_ERR(kn) == -EEXIST)
> + 					sysfs_warn_dup(kobj->sd, grp->name);
> + 				return PTR_ERR(kn);
> + 			}
>   		}
>   	} else
>   		kn = kobj->sd;


I think this is correct.  Rajat, can you verify it please?

thanks,

greg k-h
