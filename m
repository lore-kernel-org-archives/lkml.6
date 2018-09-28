Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB94C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848AE20666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eH5FFgNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848AE20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeI1Whk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:37:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbeI1Whk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8fo/iWbl2vAeVQlPNp9/eo8WmURP6snScnT2BfqgI1g=; b=eH5FFgNi9dT1MMo1/X3Q4Nx5r
        EjBbuQimA4yh6vez0oIZOuBc38LKK7VRgxxZTuUyohRHdcZT/EddjJ1ba3w97EITtACxeWL6hOQSr
        vjsXrP7KI/dK4CAO0Yz29PdPmYklc+QU9hy9kZWJ8tuQHTX3kON4d4rQAQ4clmRRr09s9VKQSRqKk
        pZ981rnYgfOxIlnkB2sTC8e0k7TMwVP8q2YFBoY/xPLHMUpRaN4bh30uMX5xNKz+6OfHfAXC4VJi6
        bKgA7pZ1wwHntETIMpI+1BBL/UoGmnTU/L+IqY21nlTnHICW2dNE2Tur/Jae6WH+wUhw5J876/usG
        wtu7Fg2xw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5vO5-0006sJ-Py; Fri, 28 Sep 2018 16:13:05 +0000
Date:   Fri, 28 Sep 2018 09:13:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com
Subject: Re: [PATCH V6 03/33] csky: Kernel booting
Message-ID: <20180928161305.GB19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <d46b38db96f8b39c38d40170e1842a0dc5ba0671.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d46b38db96f8b39c38d40170e1842a0dc5ba0671.1538058840.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +phys_addr_t __init_memblock memblock_end_of_REG0(void)
> +{
> +	return (memblock.memory.regions[0].base + memblock.memory.regions[0].size);
> +}

No need for the braces.

> +	if (memblock.memory.cnt > 1) {
> +		zone_size[ZONE_NORMAL]  = PFN_DOWN(memblock_start_of_REG1()) - min_low_pfn;
> +		zhole_size[ZONE_NORMAL] = PFN_DOWN(memblock_start_of_REG1()) - max_low_pfn;

Please brake lines after 80 characters.

> +	pr_info("C-SKY: https://github.com/c-sky/csky-linux\n");

I don't think this belongs into the kernel log.
