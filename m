Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E21AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0468420685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyU0OiWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0468420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395015AbeKVWl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730337AbeKVWl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:41:28 -0500
Received: from localhost (c-98-234-55-98.hsd1.ca.comcast.net [98.234.55.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3FC120663;
        Thu, 22 Nov 2018 12:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542888142;
        bh=KEEg98zg7fXg5ipC3MeUwLq+yxyuV4swZXUwoMZ+BJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyU0OiWrYGo8bO0Fxj2Y6VqUxWGZjZsf22NMp7D4yLAKThfAXwmVRBaXx4GzZI79j
         ySOMF18rnwVjPVFWFeWrADRc2x7KM+Gz5DdLPO/wbHJuIVdxV7d39cv+q22hn1F13b
         V9jMwv51+95U/ShaRYmWldgWH5MQJNUDnIoTVsXI=
Date:   Thu, 22 Nov 2018 04:02:22 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Pan Bian <bianpan2016@163.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: read page index before freeing
Message-ID: <20181122120222.GA52295@jaegeuk-macbookpro.roam.corp.google.com>
References: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
 <2cd91c95-598d-fcc1-b1d6-6fddb224efcf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd91c95-598d-fcc1-b1d6-6fddb224efcf@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22, Chao Yu wrote:
> Hi Pan,
> 
> On 2018/11/22 18:58, Pan Bian wrote:
> > The function truncate_node frees the page with f2fs_put_page. However,
> > the page index is read after that. So, the patch reads the index before
> > freeing the page.
> 
> Good catch!

+1

> 
> It will be better to add:
> 
> Fixes: bf39c00a9a7f ("f2fs: drop obsolete node page when it is truncated")
> Cc: <stable@vger.kernel.org>
> 
> > 
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Done.

> 
> Thanks,
