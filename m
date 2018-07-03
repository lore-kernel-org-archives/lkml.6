Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F74C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0548224F7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DnuFJ3H5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0548224F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934658AbeGCT13 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:27:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeGCT11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bnpn/Pqx4+o9HXI+clVj7407xHJqkBfieUklKp8dV7Q=; b=DnuFJ3H5B5GRblaRMkber2FVl
        8HSMB3DKGOdIm+ohFUFmhexIeg7bt5Ji867WaqWqrFtq3+760tIPmezoao2Qc0wnUfInOGITK/KGj
        3fC5NoJF+Awv8v2oPsZwQ+SKgjqP3tWgj+7iGZl7Y/yZPvBNFka0RXVwoo83tcUWLzz7nqrW0ezQW
        tUKkKBTTvXUQo92vI36q23lcq2byLwbpXUm+sRApLlVKbkN0Up3l+WSuNFbDJNumMnAT+OekG3vg5
        a1fcaXwdGQ+4D+9nDyo7j4EDpyxhJvOkKUDvUIzXXV0fRC36kcqfoGBU2edKhoyl2Jr4XCITq+ii4
        p+cyuoPdQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faQxR-00052N-NB; Tue, 03 Jul 2018 19:27:25 +0000
Subject: Re: [PATCH 05/14] swap,blkcg: issue swap io with the appropriate
 context
To:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-6-josef@toxicpanda.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <da01afa9-ee89-3c54-9e41-b10875ff0787@infradead.org>
Date:   Tue, 3 Jul 2018 12:27:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703151503.2549-6-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 08:14 AM, Josef Bacik wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> For backcharging we need to know who the page belongs to when swapping
> it out.  We don't worry about things that do ->rw_page (zram etc) at the
> moment, we're only worried about pages that actually go to a block
> device.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> cked-by: Andrew Morton <akpm@linux-foundation.org>

Checked-by:  ?  :)
copy-pasto

> ---
>  block/bio.c         | 24 ++++++++++++++++++++++++
>  include/linux/bio.h |  7 +++++++
>  mm/page_io.c        |  1 +
>  3 files changed, 32 insertions(+)


-- 
~Randy
