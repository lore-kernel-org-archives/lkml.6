Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E4167C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6632208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6632208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965164AbeFNXvE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:51:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:50491 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965001AbeFNXvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:51:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5ENotVY007904;
        Thu, 14 Jun 2018 18:50:56 -0500
Message-ID: <3312487e2b61b8c2f265d210d14bbed8681a9ecc.camel@kernel.crashing.org>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 15 Jun 2018 09:50:54 +1000
In-Reply-To: <CAMuHMdVixknUDYZUHafCqNY02z=T-WC2s+Qh6GkpejmoJU0fuQ@mail.gmail.com>
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
         <CAMuHMdVixknUDYZUHafCqNY02z=T-WC2s+Qh6GkpejmoJU0fuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-14 at 10:27 +0200, Geert Uytterhoeven wrote:
> > --- a/include/linux/of_address.h
> > +++ b/include/linux/of_address.h
> > @@ -40,6 +40,11 @@ extern void __iomem *of_iomap(struct device_node *device, int index);
> >   void __iomem *of_io_request_and_map(struct device_node *device,
> >                                      int index, const char *name);
> > 
> > +/* Request and map, wrapper on devm_ioremap_resource */
> > +extern void __iomem *devm_of_iomap(struct device *dev,
> > +                                  struct device_node *node, int index,
> > +                                  resource_size_t *size);
> > +
> >   /* Extract an address from a device, returns the region size and
> >    * the address space flags too. The PCI version uses a BAR number
> >    * instead of an absolute index
> 
> Do you need a dummy for !CONFIG_OF_ADDRESS, to aid compile-testing?

I didn't think so, as of_address_to_resource() already has a dummy, so
it should build fine.

Cheers,
Ben.

