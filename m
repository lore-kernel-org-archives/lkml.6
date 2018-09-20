Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F34ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC3E21534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL8aQxsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC3E21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbeITUCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730955AbeITUCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:02:43 -0400
Received: from [192.168.0.101] (unknown [117.62.222.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB71321532;
        Thu, 20 Sep 2018 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537453141;
        bh=OTpHNOvWTsvkCHBAmiZ/bR9jpMMPRm5Cr1yg6MIW9u0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=gL8aQxsvxr0GNERL72ExqL/fCJGD89mEc2hld5CkjkW2kyWMxWXVCuZWdrNhlc45v
         bnxRlJbCtVwiOMBC6PiwAG5W5ijut31HklX5270keg1svcIZfuva43JZR7kRh9xyOA
         woKTrX8+tKZ0dcy2VRvzxfeCMsvZ3bULjHfoGtgI=
Subject: Re: [PATCH] jfs: remove redundant dquot_initialize() in
 jfs_evict_inode()
To:     Chao Yu <yuchao0@huawei.com>, Dave Kleikamp <shaggy@kernel.org>,
        "open list:JFS FILESYSTEM" <jfs-discussion@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>,
        dave.kleikamp@oracle.com
References: <20180917071221.13187-1-yuchao0@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <be3a41fb-9a83-19a8-b3da-ca91500471fc@kernel.org>
Date:   Thu, 20 Sep 2018 22:18:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917071221.13187-1-yuchao0@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,

Any comments?

On 2018/9/17 15:12, Chao Yu wrote:
> We don't need to call dquot_initialize() twice in jfs_evict_inode(),
> remove one of them for cleanup.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/jfs/inode.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index 054cc761b426..805ae9e8944a 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -166,7 +166,6 @@ void jfs_evict_inode(struct inode *inode)
>  			/*
>  			 * Free the inode from the quota allocation.
>  			 */
> -			dquot_initialize(inode);
>  			dquot_free_inode(inode);
>  		}
>  	} else {
> 
