Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59CFC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AB220881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJzm3jiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AB220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeILBM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeILBM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:12:59 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EBC1206B7;
        Tue, 11 Sep 2018 20:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536696724;
        bh=EUs8lD/67dpo1txkYIVAT2/oB0543BP0sQ+9p/sqahc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJzm3jiZcj2vt9cv1STrR+pLALSYZl0zXehaSd1yNo/w/+vVsbettkiupUOBuSuwI
         sVS/5Mgeyr//437f0dGJz/Tfy3Dw+SLN1exJQ7g2SggZel3GH6f+hSdc1MB6jdfwRT
         WarUz72xREcyKXvfyiL0w2xYe+hV91M/INkEfxCs=
Date:   Tue, 11 Sep 2018 13:12:03 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chengguang Xu <cgxu519@gmx.com>, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        devel@lists.orangefs.org
Subject: Re: [f2fs-dev] [PATCH v2 3/5] f2fs: cache NULL when both default_acl
 and acl are NULL
Message-ID: <20180911201203.GA55456@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180831143352.22970-1-cgxu519@gmx.com>
 <20180831143352.22970-3-cgxu519@gmx.com>
 <900e5d34-f95a-279d-2d1b-bd8333be7f55@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900e5d34-f95a-279d-2d1b-bd8333be7f55@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Let me queue this patch in my -next.

Thanks,

On 09/02, Chao Yu wrote:
> On 2018/8/31 22:33, Chengguang Xu wrote:
> > default_acl and acl of newly created inode will be initiated
> > as ACL_NOT_CACHED in vfs function inode_init_always() and later
> > will be updated by calling xxx_init_acl() in specific filesystems.
> > Howerver, when default_acl and acl are NULL then they keep the value
> > of ACL_NOT_CACHED, this patch tries to cache NULL for acl/default_acl
> > in this case.
> > 
> > Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> 
> Acked-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
