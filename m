Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98AFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A8820869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="qe/aYiIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbeL1JRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 04:17:35 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:50651 "EHLO owa.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbeL1JRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 04:17:34 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1545988648; h=from:subject:to:date:message-id;
        bh=bXPWMB1a1xv0OU1FHVN4kt0o4N8eWzBIjlSHmha7iBI=;
        b=qe/aYiImnHL5EX4sIlsI1R7c2llB/Kk7VioFQ7AmcWa4sYFeDXL1wWae4yjrLmaDhGXlieEH6o5
        d+a4J/7RvaqGegCaZxBXMFATQlAs8EvACfQGWPkdlZeHHQ8cRmRXKOK6H8FLh3h6vKvZglvBfbrNy
        ElwqJjcGo1C5lOJkrbo=
Received: from hsj-Precision-5520 (10.101.1.99) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Fri, 28 Dec 2018 17:17:28 +0800
Date:   Fri, 28 Dec 2018 17:17:26 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Christoph Hellwig <hch@lst.de>
CC:     <akpm@linux-foundation.org>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <sfr@canb.auug.org.au>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <shijie8@gmail.com>
Subject: Re: [PATCH] lib/genalloc.c: rename addr_in_gen_pool to
 gen_pool_has_addr
Message-ID: <20181228091726.GA22551@hsj-Precision-5520>
References: <20181228083950.20398-1-sjhuang@iluvatar.ai>
 <20181228084834.GA8658@lst.de>
MIME-Version: 1.0
In-Reply-To: <20181228084834.GA8658@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.101.1.99]
X-ClientProxiedBy: S-10-101-1-105.iluvatar.local (10.101.1.105) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 09:48:34AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 28, 2018 at 04:39:50PM +0800, Huang Shijie wrote:
> > Follow the kernel conventions, rename addr_in_gen_pool to
> > gen_pool_has_addr.
> 
> Which convention?  The old name certainly looks more sensible to me.
I submitted a patch to export the symbol, addr_in_gen_pool.
But most the exported symbols are named like gen_pool_*.

What about I add a macro in the header genalloc.h, such as:

#define addr_in_gen_pool 	gen_pool_has_addr

> 
> If we really want to change anything about this function I'd suggest
> to drop the size argument, as the address itself should describe the
> region good enough.

Maybe others need the @size argument. I am not sure if it is right to remove
the size argument...

Thanks
Huang Shijie
