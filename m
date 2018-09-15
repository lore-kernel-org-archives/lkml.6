Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A31CECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 09:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68F820881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 09:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kgbpNdmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68F820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIOPDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 11:03:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbeIOPDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 11:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s/1v3bsF8Z+k01SK9e+w1gtMVQ+y3u2xppW81l+ZJLY=; b=kgbpNdmqLgTIlj53tDZ4wjU+G
        rcM/6C0xCFPpHt1Pm4KCewl75IDGNe5ClgXZSyyD2QKKiVK4YxR9Iwe53CWdTrLOPWrGVzpt1eVqz
        pA2eUle8c78fiipg3/cV0/bNImznlm33qf3VaVO8OKZHlZAl53osAIHzTlrLxtZTI+KhizHyvhCgB
        v0bJ+xJrKNCMLn/FR8mauiJRcAUW+WNVmOnbnJ26V1CcvcYgzjs/PIT7cXiwnQm512FJlqHOEXRbb
        lwZQRsXw07DZyzyBeZ3ROkUT59cuHsrY7fN4ZH+Rli5/wgWey2yEju7sD6qVzHMk1NB5mSPNAwPO3
        DKgyUP08A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g178d-0006y1-Ue; Sat, 15 Sep 2018 09:45:15 +0000
Date:   Sat, 15 Sep 2018 02:45:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        kirill@shutemov.name, akpm@linux-foundation.org,
        dave.hansen@intel.com, oleg@redhat.com, srikar@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v10 PATCH 3/3] mm: unmap VM_PFNMAP mappings with optimized
 path
Message-ID: <20180915094515.GC31572@bombadil.infradead.org>
References: <1536957299-43536-1-git-send-email-yang.shi@linux.alibaba.com>
 <1536957299-43536-4-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536957299-43536-4-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 04:34:59AM +0800, Yang Shi wrote:
> When unmapping VM_PFNMAP mappings, vm flags need to be updated. Since
> the vmas have been detached, so it sounds safe to update vm flags with
> read mmap_sem.
> 
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Reviewed-by: Matthew Wilcox <willy@infradead.org>
