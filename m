Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BE4C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068F82089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068F82089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeI3RnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:43:24 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45326 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728220AbeI3RnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:43:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09676321|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03291;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.Cxqz6Xt_1538305836;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cxqz6Xt_1538305836)
          by smtp.aliyun-inc.com(10.147.42.241);
          Sun, 30 Sep 2018 19:10:37 +0800
Date:   Sun, 30 Sep 2018 19:10:36 +0800
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
Subject: Re: [PATCH V6 20/33] csky/dma: fix up dma_mapping error
Message-ID: <20180930111036.GA5395@guoren>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <378d4064bf29863785f4cc637999e07507e2e926.1538058840.git.ren_guo@c-sky.com>
 <20180928162116.GF19827@infradead.org>
 <20180929150840.GA9311@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929150840.GA9311@guoren-Inspiron-7460>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 11:08:41PM +0800, Guo Ren wrote:
> On Fri, Sep 28, 2018 at 09:21:16AM -0700, Christoph Hellwig wrote:
> > On Fri, Sep 28, 2018 at 08:51:17AM +0800, Guo Ren wrote:
> > > The arch_sync_dma_for_cpu()/arch_sync_dma_for_device() implementation is
> > > broken for some combinations that end up in a BUG() instead of performing
> > > the necessary flushes.
> > 
> > This should be folded into the original patch adding this code.
> Ok, I'll rebase it.
Sorry, my git-tree has been included in linux-next. I really don't want to rebase
it.
