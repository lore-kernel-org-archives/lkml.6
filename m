Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA0C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CFC20879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CFC20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeI2Xi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:38:58 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47163 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728364AbeI2Xi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:38:58 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1847406|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03275;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.CxVtNp2_1538240951;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CxVtNp2_1538240951)
          by smtp.aliyun-inc.com(10.147.41.121);
          Sun, 30 Sep 2018 01:09:11 +0800
Date:   Sun, 30 Sep 2018 01:09:10 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com
Subject: Re: [PATCH V6 03/33] csky: Kernel booting
Message-ID: <20180929170909.GG27796@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <d46b38db96f8b39c38d40170e1842a0dc5ba0671.1538058840.git.ren_guo@c-sky.com>
 <20180928161305.GB19827@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928161305.GB19827@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 09:13:05AM -0700, Christoph Hellwig wrote:
> > +phys_addr_t __init_memblock memblock_end_of_REG0(void)
> > +{
> > +	return (memblock.memory.regions[0].base + memblock.memory.regions[0].size);
> > +}
> 
> No need for the braces.
Ok.

> > +	if (memblock.memory.cnt > 1) {
> > +		zone_size[ZONE_NORMAL]  = PFN_DOWN(memblock_start_of_REG1())
								- min_low_pfn;
> > +		zhole_size[ZONE_NORMAL] = PFN_DOWN(memblock_start_of_REG1())
								- max_low_pfn;
> 
> Please brake lines after 80 characters.
Ok.
> 
> > +	pr_info("C-SKY: https://github.com/c-sky/csky-linux\n");
> 
> I don't think this belongs into the kernel log.
Ok, remove it.

Best Regards
 Guo Ren
