Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763A3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307082075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GK8Uf/W/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307082075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbeGRWf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:35:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeGRWf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n9sdRV5huwsPMZaAHNKAnlfR/vAMLilVVM7UUWnj6NA=; b=GK8Uf/W/9LqBbLirlagnfPBmu
        FbRqzWKza0uyoM2xBEw/ivc0lPc5M6OvBkbjIiAEA+fLz8i8ZfCWx6POGljQFwu8/e/6JZPwzz/Of
        aYp9Dlrff8z/DN0XLhopRd6KID2pefQwvUQ1QHn+dxuukBK8IcdIVo+Qpc+vqlUy5oQ+QA0eEPHMI
        QMoBfaDPLEh46zMaOKDGWwrOt4ueKOczCvIfGjJzytQrc6lycRW6WUP30vbXfUjlILOr0Om6cYWdm
        EanFkk3CzPlvyW0SFVf05yWSwag1+TlsOUqlJrE+a85lTlGHTvdFb2d7/LE6RWOfzR9vVacCi3vF7
        kjG/QrJkQ==;
Received: from 50-233-148-155-static.hfc.comcastbusiness.net ([50.233.148.155] helo=[10.18.6.178])
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffuQS-0000T1-Cc; Wed, 18 Jul 2018 21:56:00 +0000
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
To:     Fredrik Noring <noring@nocrew.org>, Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        JuergenUrban@gmx.de
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
 <20180705193613.GA28905@lst.de> <20180715122826.GB2342@localhost.localdomain>
 <20180717145725.GA22109@lst.de> <20180717163330.GE2342@localhost.localdomain>
From:   Geoff Levand <geoff@infradead.org>
Message-ID: <ac14e13b-82fb-c623-6dcb-4c944120eb24@infradead.org>
Date:   Wed, 18 Jul 2018 14:55:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717163330.GE2342@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/17/2018 09:33 AM, Fredrik Noring wrote:
>>> Here are three other regressions related to the coherent mask WARN_ON_ONCE:
>>
>> They are a pretty strong indication that yes, you should really set
>> the coherent mask if you ever do coherent allocations..
> 
> I'm unfortunately unfamiliar with the USB drivers for the PS3. Geoff, what
> do you think about setting a coherent mask?

I guess we need to add a dma_set_coherent_mask() call in the driver
probe routines.  I'll send out a patch.

-Geoff


