Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC6C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9312073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9312073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeI2X3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:29:35 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38903 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728394AbeI2X3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:29:35 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08073233|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07408;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.CxVflgQ_1538240412;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CxVflgQ_1538240412)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sun, 30 Sep 2018 01:00:12 +0800
Date:   Sun, 30 Sep 2018 01:00:11 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Christoph Hellwig <hch@infradead.org>
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
Message-ID: <20180929170011.GA27796@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <2418a9d77fb92ff7606c08e209d8994e4f21e7ff.1538058840.git.ren_guo@c-sky.com>
 <20180928162030.GE19827@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928162030.GE19827@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 09:20:30AM -0700, Christoph Hellwig wrote:
> > +unsigned long long notrace __bswapdi2(unsigned long long u)
> > +{
> > +	return (((u) & 0xff00000000000000ull) >> 56) |
> > +	       (((u) & 0x00ff000000000000ull) >> 40) |
> > +	       (((u) & 0x0000ff0000000000ull) >> 24) |
> > +	       (((u) & 0x000000ff00000000ull) >>  8) |
> > +	       (((u) & 0x00000000ff000000ull) <<  8) |
> > +	       (((u) & 0x0000000000ff0000ull) << 24) |
> > +	       (((u) & 0x000000000000ff00ull) << 40) |
> > +	       (((u) & 0x00000000000000ffull) << 56);
> > +}
> 
> How is this any better than using the generic byteswap helpers?
OK.
#include <uapi/linux/swab.h>

unsigned long long notrace __bswapdi2(unsigned long long u)
{
	return ___constant_swab64(u);


> 
> > +unsigned int notrace __bswapsi2(unsigned int u)
> > +{
> > +	return (((u) & 0xff000000) >> 24) |
> > +	       (((u) & 0x00ff0000) >>  8) |
> > +	       (((u) & 0x0000ff00) <<  8) |
> > +	       (((u) & 0x000000ff) << 24);
> > +}
> 
> Same here.
OK.
#include <uapi/linux/swab.h>

unsigned int notrace __bswapsi2(unsigned int u)
{
	return ___constant_swab32(u);
}

Thx
 Guo Ren
