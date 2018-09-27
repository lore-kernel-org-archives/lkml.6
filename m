Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61245C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB41215EC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRqrigPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB41215EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeI0S2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeI0S2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:28:03 -0400
Received: from [192.168.0.101] (unknown [49.77.227.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA92206B2;
        Thu, 27 Sep 2018 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538050204;
        bh=zVwmsdGaZQdR4v4KYzjmALtL8ngkjwkwzv3FPxgRQ08=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=RRqrigPOpymayyeCHfFIGFLY5YFVLvoAYVHb1Xu/e10DKKD0dz5VSWv69TCBvZuIB
         X+6AprT0HVY1HBLLC+3+AagdK9Q/FlrBO9YfqQG1BXxdjv4qY9ikZBcuf0HU6Uw4JN
         gVILgeriD0V3MkwwURb2DKc7TzkvLrNXYfIptXWc=
Subject: Re: [f2fs-dev] [PATCH 2/2 v3] f2fs: avoid f2fs_bug_on if
 f2fs_get_meta_page_nofail got EIO
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <20180918021805.85032-2-jaegeuk@kernel.org>
 <20180918175648.GE91945@jaegeuk-macbookpro.roam.corp.google.com>
 <20180920214804.GF35918@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <0c036757-5200-e952-e814-d07aa50af90f@kernel.org>
Date:   Thu, 27 Sep 2018 20:09:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920214804.GF35918@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-9-21 5:48, Jaegeuk Kim wrote:
> This patch avoids BUG_ON when f2fs_get_meta_page_nofail got EIO during
> xfstests/generic/475.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
