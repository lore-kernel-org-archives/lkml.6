Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45578C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E036120841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpnQiPOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E036120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeIBMLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 08:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbeIBMLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 08:11:05 -0400
Received: from [192.168.0.101] (unknown [49.77.178.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C563220837;
        Sun,  2 Sep 2018 07:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535874972;
        bh=vQ/Ipz/UsVKab4OkoXpElVZMlrbFmrgaDXwuz3mJvT4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qpnQiPOvimEfjnwcZqY1/kojEz5IY0YVmInwwZpEkh4jssblzJYCfdvCayLmyXO/K
         i5e/gCWwTjBR2OcvAtUYCUvxEbKyYi7DVNWksJaG5Rg134cAlkALLmbHcIl7FSlXCt
         dZ5k4EqILm9p9owy9BKieJRcDbkujuus5YTEaUxs=
Subject: Re: [f2fs-dev] [PATCH v2 3/5] f2fs: cache NULL when both default_acl
 and acl are NULL
To:     Chengguang Xu <cgxu519@gmx.com>, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        shaggy@kernel.org, hubcap@omnibond.com, martin@omnibond.com
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        devel@lists.orangefs.org
References: <20180831143352.22970-1-cgxu519@gmx.com>
 <20180831143352.22970-3-cgxu519@gmx.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <900e5d34-f95a-279d-2d1b-bd8333be7f55@kernel.org>
Date:   Sun, 2 Sep 2018 15:55:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831143352.22970-3-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/31 22:33, Chengguang Xu wrote:
> default_acl and acl of newly created inode will be initiated
> as ACL_NOT_CACHED in vfs function inode_init_always() and later
> will be updated by calling xxx_init_acl() in specific filesystems.
> Howerver, when default_acl and acl are NULL then they keep the value
> of ACL_NOT_CACHED, this patch tries to cache NULL for acl/default_acl
> in this case.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,
