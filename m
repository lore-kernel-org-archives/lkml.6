Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAB4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C9520660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BkqR4ZCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfAHSaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:30:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbfAHSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nlfj27VUloOq8RjKt9xLwgFPnK/hHgjvHVmhDJLArlg=; b=BkqR4ZCEMnnWZ/vhRFhAoDqQ/
        UeyPnm5DK6LH2MmGvBAGBUJdsbaPlDR7qFn/hqmsYqo8U/ZQt95C4Cs98Lx0mHk7nCjPXCH4iayij
        E2FC0EDi1nKVZGo/18Ih6tYn1A6q7c5zLAm8ui6sPGeLVIUV42PBUtberNI/ost5fV7mHwgzHIIQ5
        pNo3iH398yiNvOETN9Fv+ldGfLi11gSI56iEzk1CqsiY7o9x5l5NQQx/AvtQ3OXstxTauKvc5G324
        aVnPqLRUnOFSo0cJ3SWUpnAHsikuCEqnxxOvqgGzAURzCC35rOp15ySKDqaqCXa7VfHlVm2aypis8
        TI3SHZSrw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggw8V-00080t-EG; Tue, 08 Jan 2019 18:29:59 +0000
Date:   Tue, 8 Jan 2019 10:29:59 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, rppt@linux.ibm.com, mhocko@suse.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, riel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, william.kucharski@oracle.com
Subject: Re: [PATCH v4] mm: Create the new vm_fault_t type
Message-ID: <20190108182959.GD6310@bombadil.infradead.org>
References: <20190108183041.GA12137@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108183041.GA12137@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:00:41AM +0530, Souptick Joarder wrote:
> Page fault handlers are supposed to return VM_FAULT codes,
> but some drivers/file systems mistakenly return error
> numbers. Now that all drivers/file systems have been converted
> to use the vm_fault_t return type, change the type definition
> to no longer be compatible with 'int'. By making it an unsigned
> int, the function prototype becomes incompatible with a function
> which returns int. Sparse will detect any attempts to return a
> value which is not a VM_FAULT code.
> 
> VM_FAULT_SET_HINDEX and VM_FAULT_GET_HINDEX values are changed
> to avoid conflict with other VM_FAULT codes.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
