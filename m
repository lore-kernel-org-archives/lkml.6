Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FF5ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DF62146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DF62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeIRQwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:52:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:52:04 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CD803C03;
        Tue, 18 Sep 2018 11:19:55 +0000 (UTC)
Date:   Tue, 18 Sep 2018 13:19:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 0/8] staging: erofs: error handing and more tracepoints
Message-ID: <20180918111953.GA3585@kroah.com>
References: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:40:22PM +0800, Gao Xiang wrote:
> In order to avoid conflicts with cleanup patches, Chao and I think
> it is better to send reviewed preview patches in the erofs mailing list
> to the community in time.
> 
> So here is reviewed & tested patches right now, which clean up and
> enhance the error handing and add some tracepoints for decompression.
> 
> Note that in this patchset, bare use of 'unsigned' and NULL comparison are
> also fixed compared with the preview patches according to the previous
> discussion in the staging mailing list.

I applied this, but I need to go delete it as this patch series adds a
build warning to the system:

In file included from drivers/staging/erofs/unzip_vle.h:16:0,
                 from drivers/staging/erofs/unzip_vle.c:13:
drivers/staging/erofs/unzip_vle.c: In function ‘z_erofs_map_blocks_iter’:
drivers/staging/erofs/internal.h:303:34: warning: ‘pblk’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 #define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
                                  ^
drivers/staging/erofs/unzip_vle.c:1574:20: note: ‘pblk’ was declared here
  erofs_blk_t mblk, pblk;
                    ^~~~

Please fix that up and resend.

thanks,

greg k-h
