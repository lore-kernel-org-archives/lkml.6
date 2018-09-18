Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81ADC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4B5214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4B5214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbeIRTac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:30:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44498 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbeIRTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:30:32 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A8EFCFD;
        Tue, 18 Sep 2018 13:57:47 +0000 (UTC)
Date:   Tue, 18 Sep 2018 15:57:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: erofs: initialize `pblk' with 0 first in
 `z_erofs_map_blocks_iter'
Message-ID: <20180918135745.GA25679@kroah.com>
References: <20180918130911.GA16187@kroah.com>
 <1537278276-110982-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1537278276-110982-1-git-send-email-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 09:44:36PM +0800, Gao Xiang wrote:
> This commit message helps to understand why `pblk' is assigned with 0 here.
> 
> [ Greg reported a warning raised by gcc. ]
> In file included from drivers/staging/erofs/unzip_vle.h:16:0,
>                  from drivers/staging/erofs/unzip_vle.c:13:
> drivers/staging/erofs/unzip_vle.c: In function ‘z_erofs_map_blocks_iter’:
> drivers/staging/erofs/internal.h:303:34: warning: ‘pblk’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>  #define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
>                                   ^
> drivers/staging/erofs/unzip_vle.c:1574:20: note: ‘pblk’ was declared here
>   erofs_blk_t mblk, pblk;
>                     ^~~~
> 
> Actually, it is a false-positive warning when looking into that. [1]
> Just initialize the variable to keep gcc from printing foolish warnings.
> 
> [1] https://lists.ozlabs.org/pipermail/linux-erofs/2018-September/000637.html
> 
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Thanks-to: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/unzip_vle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please roll this into the original patch.  I have dropped that whole
series from my tree, it is no longer present and needs to be resent in
order for me to be able to accept any of these.

thanks,

greg k-h
