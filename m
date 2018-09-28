Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F32C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A112083A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dS5Equ8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A112083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbeI1WpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:45:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1WpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LmaH5ZUI3rnWbCHZ/o2sYuAVE5EZKis2D9MExUpomio=; b=dS5Equ8OFiJjzh8eoyfr3z3qt
        Djd9Crs/Ohzn1d6FtPLDRJrjsBZNiVU03od0ooFP1mBeSYGUniR4WXkDC9pBPgC6mQY36IjTKw2UX
        5OZ2y7ImO8S56C8wNXhdW3tHbw/tvPWc2PKrDfOWCRQjLkfPzpWN18cM83uvSDePxWqTIs2OO6UCF
        oqrFeZbmwXTnumkGUlhJfjLLckILg1M1GpHqMU6lqI2YwLdLXsxpcgYNKNj6xFVLXH+084g4Cxi0d
        4MlSav1LYsPmoyZjD6D/AMUetKN/7KkLhkIY+7sedGelD+YEanrkZdQ7IAuvq2V8qBj19I+P8UepM
        A2lR0n1Dg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5vVG-0002bK-HE; Fri, 28 Sep 2018 16:20:30 +0000
Date:   Fri, 28 Sep 2018 09:20:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com,
        Chen Linfei <linfei_chen@c-sky.com>,
        Mao Han <han_mao@c-sky.com>
Subject: Re: [PATCH V6 13/33] csky: Library functions
Message-ID: <20180928162030.GE19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <2418a9d77fb92ff7606c08e209d8994e4f21e7ff.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2418a9d77fb92ff7606c08e209d8994e4f21e7ff.1538058840.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +unsigned long long notrace __bswapdi2(unsigned long long u)
> +{
> +	return (((u) & 0xff00000000000000ull) >> 56) |
> +	       (((u) & 0x00ff000000000000ull) >> 40) |
> +	       (((u) & 0x0000ff0000000000ull) >> 24) |
> +	       (((u) & 0x000000ff00000000ull) >>  8) |
> +	       (((u) & 0x00000000ff000000ull) <<  8) |
> +	       (((u) & 0x0000000000ff0000ull) << 24) |
> +	       (((u) & 0x000000000000ff00ull) << 40) |
> +	       (((u) & 0x00000000000000ffull) << 56);
> +}

How is this any better than using the generic byteswap helpers?

> +unsigned int notrace __bswapsi2(unsigned int u)
> +{
> +	return (((u) & 0xff000000) >> 24) |
> +	       (((u) & 0x00ff0000) >>  8) |
> +	       (((u) & 0x0000ff00) <<  8) |
> +	       (((u) & 0x000000ff) << 24);
> +}

Same here.

