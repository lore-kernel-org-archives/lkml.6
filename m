Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AEDFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28FC20840
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28FC20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeG3Kwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:52:55 -0400
Received: from verein.lst.de ([213.95.11.211]:51340 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbeG3Kwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:52:55 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B533D68D52; Mon, 30 Jul 2018 11:23:06 +0200 (CEST)
Date:   Mon, 30 Jul 2018 11:23:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Fugang Duan <fugang.duan@nxp.com>
Subject: Re: [BUG BISECT] Ethernet fail on VF50 (OF: Don't set default
        coherent DMA mask)
Message-ID: <20180730092306.GA18701@lst.de>
References: <CAJKOXPeaguNxRr7pCArJ5Db4tS6Kr5BDheCxskY+vd0dUN+0GQ@mail.gmail.com> <CAJKOXPfageiBVXddtdJRBS+092O3QfD0yoS_Mk+PoX7+qNYNUA@mail.gmail.com> <20180727140448.GA29001@lst.de> <20180728165820.GA5731@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180728165820.GA5731@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 09:58:20AM -0700, Guenter Roeck wrote:
> I would call it a serious regression. Also, no longer setting a default
> coherent DMA mask is a quite substantial behavioral change, especially
> if and since the code worked just fine up to now.
> 
> Crash when booting sam460ex attached below, as is a bisect log.

Things should be ok again with:

commit a5516219b10218a87abb3352c82248ce3088e94a
Author: Robin Murphy <robin.murphy@arm.com>
Date:   Fri Jul 27 15:14:15 2018 +0100

    of/platform: Initialise default DMA masks

from the lastest dma-mapping tree as of Friday.  It isn't in the
latest linux-next tree yet but be in the next one.
