Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F34FC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E682A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E682A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbeIKW4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:56:23 -0400
Received: from ms.lwn.net ([45.79.88.28]:51544 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbeIKW4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:56:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4306772A;
        Tue, 11 Sep 2018 17:55:57 +0000 (UTC)
Date:   Tue, 11 Sep 2018 11:55:55 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] docs: core-api: add memory allocation guide
Message-ID: <20180911115555.5fce5631@lwn.net>
In-Reply-To: <1534517236-16762-4-git-send-email-rppt@linux.vnet.ibm.com>
References: <1534517236-16762-1-git-send-email-rppt@linux.vnet.ibm.com>
        <1534517236-16762-4-git-send-email-rppt@linux.vnet.ibm.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for being so slow to get to this...it fell into a dark crack in my
rickety email folder hierarchy.  I do have one question...

On Fri, 17 Aug 2018 17:47:16 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> +    ``GFP_HIGHUSER_MOVABLE`` does not require that allocated memory
> +    will be directly accessible by the kernel or the hardware and
> +    implies that the data is movable.
> +
> +    ``GFP_HIGHUSER`` means that the allocated memory is not movable,
> +    but it is not required to be directly accessible by the kernel or
> +    the hardware. An example may be a hardware allocation that maps
> +    data directly into userspace but has no addressing limitations.
> +
> +    ``GFP_USER`` means that the allocated memory is not movable and it
> +    must be directly accessible by the kernel or the hardware. It is
> +    typically used by hardware for buffers that are mapped to
> +    userspace (e.g. graphics) that hardware still must DMA to.

I realize that this is copied from elsewhere, but still...as I understand
it, the "HIGH" part means that the allocation can be satisfied from high
memory, nothing more.  So...it's irrelevant on 64-bit machines to start
with, right?  And it has nothing to do with DMA, I would think.  That would
be handled by the DMA infrastructure and, perhaps, the DMA* zones.  Right?

I ask because high memory is an artifact of how things are laid out on
32-bit systems; hardware can often DMA quite easily into memory that the
kernel sees as "high".  So, to me, this description seems kind of
confusing; I wouldn't mention hardware at all.  But maybe I'm missing
something?

Thanks,

jon
