Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C68C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61357214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="abkTnfAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfA1OPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:15:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfA1OPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J4RjtSiWSKweAZ3oYKdvzFuzQdIE8J3c1zqykMrcCSY=; b=abkTnfAqvvWKNyHE1Ctv3NZuD
        QcYdhd4VR9lyDAebzCjJExyPWdVMaodQgmix+rL1iz4Y9+HTq0s+Sfoy1wF4yqcopW6J8/YjOJ7Y4
        QOgj6q5AIcw9QmcNGGRGkKLjhH6b/SYc1IL93Rq5023sXZNj1CxJdALl45dVbkQnc5bTVo+QByN+Z
        XWPB4rNkqXxnipCbk9tYUfjiLwReuFn+75FClhNF5mtM9oTsXlycDcGTkFhUfmMRVrVT2qvQQ2CL2
        iW/Knif1WAqu8GqrFqqYE5pNTvtUD3lxoPi2nQpu+DHFCVQP3WDFm4I0AJ7AQ74CLmq2pwNgGWLjC
        lBhJsKNxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go7hD-0002ex-MI; Mon, 28 Jan 2019 14:15:31 +0000
Date:   Mon, 28 Jan 2019 06:15:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/11] Refactor exception entry on 40x/6xx/8xx
Message-ID: <20190128141531.GA664@infradead.org>
References: <cover.1548673552.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548673552.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:11:10AM +0000, Christophe Leroy wrote:
> This serie refactors exception entry macros for 40x, 6xx and 8xx
> 
> This serie will benefit to the implementation of CONFIG_VMAP, and also
> to Ben's serie on MSR_EE.

We don't have a CONFIG_VMAP.  Do you mean CONFIG_VMAP_STACK ?
