Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4219EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC652184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q/0ICl2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfBAI1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:27:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBAI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4jYfF0RHgLDGZP1baxdkWWJzvYzFpk+IlDtTVjcA6to=; b=q/0ICl2ECWYXf4faDCHKG/vG3
        0jGoLmOaGN2Z/QiscmXAzzpHo/etyxL+rJs20aO26olhx7LqD4nmc4MSdaTZMSgdbVw+miU06mc+u
        BQshuIlYHVbbFG2hvlp7obY4ycitRsl5+HKQVD6vimY2lKdIrFvyNmAfMEBk2oW14YEiXPvtZsrvn
        EGl5117fh8nXuaFL6Zflborv92esLOUfkCmQDca8RxypKl0wrqxIjMJ/c3aRZGsaCijwxvg/ZPSzB
        7YAhvcBwf+R96XmpckT0tqNszL2GFxNVbRCXU0MB+RMjchP0UX6P3xACNiWjGq6Rkr/IirubUVUYe
        DSQ3nb6lg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUAI-0003vB-Uz; Fri, 01 Feb 2019 08:27:10 +0000
Date:   Fri, 1 Feb 2019 00:27:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>
Subject: Re: [Xen-devel] xen/mem-reservation API and out-of-tree kernel
 modules
Message-ID: <20190201082710.GA7437@infradead.org>
References: <f3ca533d-7f51-c59e-6a96-4e1fba687c8f@epam.com>
 <alpine.DEB.2.10.1901311343370.22962@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1901311343370.22962@sstabellini-ThinkPad-X260>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 01:44:15PM -0800, Stefano Stabellini wrote:
> The alternative would be to turn xenmem_reservation_scrub_page into a
> regular function (not a static inline)?

All that is a moot point until said currently out of tree module gets
submitted for inclusion anyway.
