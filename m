Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947EDECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CD4208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vz6Z+8Qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CD4208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbeGMLn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbeGMLn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:43:58 -0400
Received: from [192.168.0.101] (unknown [121.229.225.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0553C20878;
        Fri, 13 Jul 2018 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531481382;
        bh=fNo76sbLYNMzvVdbmeu0CD50Y3oCS2Z7Zt6zzFILGrI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vz6Z+8QnAOCsUZlr3jPBYJVcsa9w7IuGWJrXcT8pS6WTZLS0VdzSP3axe/s6AFf3+
         /NEAqPdKwOWp7Q27iRS4eciYIkkrbCaVeN5d/ZYC5Rws+B9oqclcChcMA9uoIlUezQ
         aBamicrq5bVOyJCWtsHwkblVHqL31WN5otWep+Wo=
Subject: Re: [f2fs-dev v2] [PATCH 2/4] f2fs: allow wrong configure dio to
 buffered write
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-2-jaegeuk@kernel.org>
 <af7e2fa5-b9e9-3090-7659-bd76585fd3aa@kernel.org>
 <20180712175611.GA37244@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <870ee2d8-8221-4934-04a0-aef22a78480a@kernel.org>
Date:   Fri, 13 Jul 2018 19:29:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180712175611.GA37244@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/13 1:59, Jaegeuk Kim wrote:
> This fixes to support dio having unaligned buffers as buffered writes.
> 
> xfs_io -f -d -c "pwrite 0 512" $testfile
>  -> okay
> 
> xfs_io -f -d -c "pwrite 1 512" $testfile
>  -> EINVAL
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
