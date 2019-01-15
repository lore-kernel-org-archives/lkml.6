Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F6EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2250320868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KxQ9SHRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfAOPbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:31:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfAOPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QciLo+wsg0uZeXWr5zAF7r512Gi3FOpmFxN/2k9BQPQ=; b=KxQ9SHRw5S/vqoyv3cI+bd0WE
        S6N5IlbHR9347Wh2JGe9k7BjJmZ0VluGXDlueZzJqPNSvBBQAeMm4mCGDDGbmV4+sqSBrkOCaxfUt
        42dL8Mk1qjvWsnyaaJGVh2KGUeD0lggQW7nm+FtPrs/Q5phVi9GgJAyTiTh7yV72H0aLAtq8POvic
        CaGPgs6gBngjMmKK6/ckxoY8gYcK2Ck8sPcZaL7R7RIJAMqmd1Fmi0In7UQJKwkT/JVdQebNGrMEL
        Px3ee/tEG7l2duBqjrb9LjmUizOTNVzBFxtvCwmnxMhUlmaeAbt9NTG89uSkNOJwyrf9fsLU7Q2Ow
        xrc7N3Wug==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjQga-00022e-Lk; Tue, 15 Jan 2019 15:31:28 +0000
Date:   Tue, 15 Jan 2019 07:31:28 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Joel Nider <joeln@il.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] docs-rst: userspace: update verbs API details
Message-ID: <20190115153128.GA6310@bombadil.infradead.org>
References: <1547547991-5314-1-git-send-email-joeln@il.ibm.com>
 <1547547991-5314-3-git-send-email-joeln@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547547991-5314-3-git-send-email-joeln@il.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 12:26:31PM +0200, Joel Nider wrote:
> It is important to understand the existing framework when implementing
> a new verb. The majority of existing API functions are implemented using
> the write syscall, but this has been superceded by the ioctl syscall
> for new commands. This patch updates the documentation regarding how
> to go about implementing a new verb, focusing on the new ioctl
> interface.
> 
> The documentation is far from complete, but this is a good step in the
> right direction. Future patches can add more detail according to need.
> Also, the interface is still undergoing substantial changes so an
> effort was made to document only the stable parts so as to avoid
> incorrect information since documentation changes tend to lag behind
> code changes.

I think this is a horrible direction to take.  The current document is
clearly for _users_.  All this documentation you've added is for kernel
hackers.  It needs to go in a different file, or not be added at all.

