Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCDEC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A873820020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KCEdLaND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A873820020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935495AbeFRRZ3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:25:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934963AbeFRRZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M87h/tftk1QAZelX0jtKbsPMx6CqKhWupzXoNkS25R0=; b=KCEdLaNDKGyh1TSxPJ5LIveRo
        Je0C3PjRLavv+AyCSpfjOlMUUAW4GWcHaFHpur2CPqaDJUOYhnyL3f/50bK6BQCcwGlkU4eAst+Fv
        1jObsA955/KnR5Yu0RXW7rVSFQ8VKIHsImzTVvlrmibrZPDG8iyrX6nPX9FYaLUbtyHs7jy5CQYki
        txfPFZJbi3UNrjU3ARIgSkPN+/qjftAlWdCTtb7SYTd/E4eIRno5gm4eRDZa0iPInhMwSkjBPtzQU
        PJV0lI2BAruAdpPq3dcJdNfylyVkuMNrVFZLIR2ASKhSEfThDrWmXkGNcMUexRgqKXnpDmtz7vbgb
        snOoLiHhg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUxuB-00045s-Jn; Mon, 18 Jun 2018 17:25:27 +0000
Subject: Re: [PATCH 04/11] docs/mm: bootmem: add kernel-doc description of
 'struct bootmem_data'
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <1529341199-17682-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1529341199-17682-5-git-send-email-rppt@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f276789a-f6c0-6a98-5e21-3c3c15112e80@infradead.org>
Date:   Mon, 18 Jun 2018 10:25:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529341199-17682-5-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 09:59 AM, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  include/linux/bootmem.h | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
> index 7942a96..1526ba1 100644
> --- a/include/linux/bootmem.h
> +++ b/include/linux/bootmem.h
> @@ -27,9 +27,20 @@ extern unsigned long max_pfn;
>  extern unsigned long long max_possible_pfn;
>  
>  #ifndef CONFIG_NO_BOOTMEM
> -/*
> - * node_bootmem_map is a map pointer - the bits represent all physical 
> - * memory pages (including holes) on the node.
> +/**
> + * struct bootmem_data - per-node information used by the bootmem allocator
> + * @node_min_pfn: the starting physical address of the node's memory
> + * @node_low_pfn: the end physical address of the directly addressable memory
> + * @node_bootmem_map: is a bitmap pointer - the bits represent all physical
> + *		     memory pages (including holes) on the node.
> + * @last_end_off: the offset within the page of the end of the last allocation;
> + *                if 0, the page used is full
> + * @hint_idx: the the PFN of the page used with the last allocation;

            drop one "the" above.

> + *	       together with using this with the @last_end_offset field,
> + *	       a test can be made to see if allocations can be merged
> + *	       with the page used for the last allocation rather than
> + *	       using up a full new page.
> + * @list: list entry in the linked list ordered by the memory addresses
>   */
>  typedef struct bootmem_data {
>  	unsigned long node_min_pfn;
> 


-- 
~Randy
