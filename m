Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B91C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967C92183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550658033;
	bh=CF/764IXha6H4xVi6cFlLBrEeOovahreeqOw5Mw3GX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lnnNvaSkhUKAnyiS5RwkywNsUw6U+c/M2lpkvWNH6twu0jqDxoN/QaLg93/CyayGH
	 PHf8lTxeQgayGBqe9JAg3IqD+sBOAfpgt7iReS3hEHZYQczSLjUOLLTbriNAh9/C5S
	 VLljtuIKjFSZ/eDEK4hZgtJ6ABb/VXZyE6alooMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfBTKUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:20:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbfBTKUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:20:31 -0500
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEDFA2147C;
        Wed, 20 Feb 2019 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550658031;
        bh=CF/764IXha6H4xVi6cFlLBrEeOovahreeqOw5Mw3GX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2JO+A8Qn9jMOGIMMlYhOfoTZ2JsBAMD7endZUj4aZxmwt3EDX3ws8hPRZMu316/TN
         5BtWZCUbvADH38GVYAp1oXG/tAJBVS0sO4C7Hp2E6+RVmWummq4xw0xY/ByRlsz5/X
         Q8Z8cJ+22X6TWPRpR60XyUqfj9YD7t/YP1OL7Sig=
Date:   Wed, 20 Feb 2019 11:20:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>, Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH] staging: erofs: remove rcu_read_lock() in
 erofs_try_to_free_cached_page
Message-ID: <20190220102026.GA32312@kroah.com>
References: <20190216084650.33841-1-gaoxiang25@huawei.com>
 <fc058e45-a645-c680-2ce0-19de83fffc2e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc058e45-a645-c680-2ce0-19de83fffc2e@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:38:53AM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> Could you consider take some time on these two patches for linux-5.1-rc1?
>  1) staging: erofs: fix race of initializing xattrs of a inode at the same time
>  2) staging: erofs: remove rcu_read_lock() in erofs_try_to_free_cached_page
> 
> It will be of great help, especially patch 1 (it could cause potential memleak
> in the race condition without it).

Ok, I'll queue them up now, I was waiting for reviewed-by tags from
others to show up :)

greg k-h
