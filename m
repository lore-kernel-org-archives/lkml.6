Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE18C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F01A2503E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ttudi1rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F01A2503E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeGAP0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 11:26:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeGAP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 11:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vrUq7ECHxFj5AIDsXDE5vC3E+bI/VeHPJfclAyR3o28=; b=ttudi1rxFsrLK6Gx/35U/4458
        F3souxWNXp4hqlAOrpIRRu0pwJF4TGTBOPTHQWbBdfn6pTMWDjicWWGiC0erslTPfRjbiit3OsFgZ
        Wa3hQKgibmsGII6fMstLVtmfqjtPbakSAFQv95iTl2rby+aNg78veHQ8i4i+yCRYYUuedv4C3LLo8
        SXC2moWESO//q/3IXvmJBkO7ZFWTxoQtbAOrXVVm4gzwGExRhH2VJJbVFCeARuCmjOuPsgfU8ZGxc
        6fR+jadmICent2M9i4NNTB7ygF/biw5PYHZiPSR5ncKQOXIaTqmFbWqbd+giBWj7HrIbv3upGqj5n
        iQ3GSdaEw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZeFT-0001cD-Bw; Sun, 01 Jul 2018 15:26:47 +0000
Subject: Re: [PATCH v2 00/11] docs/mm: add boot time memory management docs
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6c4dbd5e-a7c9-06de-5c9f-1c311b782244@infradead.org>
Date:   Sun, 1 Jul 2018 08:26:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/18 07:54, Mike Rapoport wrote:
> Hi,
> 
> Both bootmem and memblock have pretty good documentation coverage. With
> some fixups and additions we get a nice overall description.
> 
> v2 changes:
> * address Randy's comments

For the series:
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.


> Mike Rapoport (11):
>   mm/bootmem: drop duplicated kernel-doc comments
>   docs/mm: nobootmem: fixup kernel-doc comments
>   docs/mm: bootmem: fix kernel-doc warnings
>   docs/mm: bootmem: add kernel-doc description of 'struct bootmem_data'
>   docs/mm: bootmem: add overview documentation
>   mm/memblock: add a name for memblock flags enumeration
>   docs/mm: memblock: update kernel-doc comments
>   docs/mm: memblock: add kernel-doc comments for memblock_add[_node]
>   docs/mm: memblock: add kernel-doc description for memblock types
>   docs/mm: memblock: add overview documentation
>   docs/mm: add description of boot time memory management
> 
>  Documentation/core-api/boot-time-mm.rst |  92 +++++++++++++++
>  Documentation/core-api/index.rst        |   1 +
>  include/linux/bootmem.h                 |  17 ++-
>  include/linux/memblock.h                |  76 ++++++++----
>  mm/bootmem.c                            | 159 +++++++++----------------
>  mm/memblock.c                           | 203 +++++++++++++++++++++++---------
>  mm/nobootmem.c                          |  20 +++-
>  7 files changed, 380 insertions(+), 188 deletions(-)
>  create mode 100644 Documentation/core-api/boot-time-mm.rst
> 


-- 
~Randy
