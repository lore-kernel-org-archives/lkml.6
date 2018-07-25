Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF801C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713C320890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lnBJ4XiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713C320890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbeGYNQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:16:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbeGYNQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JpAqOlVL78rZe9usniS/4U3mVHa/jLMk0ZsJc+geDZM=; b=lnBJ4XiWG/I4sC8lbnrSqtlUs
        i93JKHj2IlfmRhWmgIlhXnYvWy/6nBXMqh4xdWqJufEQLg7bTiHAsaogq8INXYB+A5Uwdi7q39T0i
        oh/W+o/2vUA6ADdSe1DXZ0TzOms48Ly/emF3m0aAQAsIli8rCK+yimehOfBVabus8PDygS3NR6yzj
        flcVJ3XEaYX1RYnZ29UjXgrepx2LRGrP0n1DoYB++UhFBg6uMiBkqNXJAlDNBcp7JMcQZ6yNJ7H4u
        KmOpSYVOMFo8Q6BfEs4gDm+0tdR5IXXQiYsf4ffBSNsVFT7xgdgd70pfjYEaoed0ZlvRGL8HLwkSj
        FSpZN6HBA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiIXM-0001jl-9r; Wed, 25 Jul 2018 12:05:00 +0000
Date:   Wed, 25 Jul 2018 05:05:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] docs/core-api: split memory management API to a
 separate file
Message-ID: <20180725120500.GA9352@bombadil.infradead.org>
References: <1532517970-16409-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1532517970-16409-6-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532517970-16409-6-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 02:26:08PM +0300, Mike Rapoport wrote:
> +User Space Memory Access
> +========================
> +
> +.. kernel-doc:: arch/x86/include/asm/uaccess.h
> +   :internal:
> +
> +.. kernel-doc:: arch/x86/lib/usercopy_32.c
> +   :export:
> +
> +The Slab Cache
> +==============
> +
> +.. kernel-doc:: include/linux/slab.h
> +   :internal:
> +
> +.. kernel-doc:: mm/slab.c
> +   :export:
> +
> +.. kernel-doc:: mm/util.c
> +   :functions: kfree_const kvmalloc_node kvfree get_user_pages_fast

get_user_pages_fast would fit better in the previous 'User Space Memory
Access' section.

