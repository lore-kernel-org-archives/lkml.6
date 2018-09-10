Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D78C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E255520855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D6hQxnLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E255520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeIKCRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:17:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeIKCRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wTbRCjyWsMDfEUK/cPz/LJvtWBIqVXeUsUioH6s4Fqo=; b=D6hQxnLTcqHREWnDg4Gd53KL9
        fhL8BU574eo660G22YPPPui0sa32Rt0dUr78CN8hyCLnCrgspOkt9uR893XCaOqVuQdIxhc2o8wfL
        Qwp7y8FnXe5QOzfEWUoc2xyHcGRSXWLjowd0cuExrFNYbLkrY+Dq8vZO32bljq8kT8HisS1PhakvW
        K73S5mb4Ym5FsWoUxENmunh3goaGQM5reiorRyHytSB+8td8PMUiFdzC20MQ8yGikHyRjnwO3pjMh
        jxEKUVLGZYsAtXNbT2A/XMz990o6ix2vaxqwSQQn7BIwE4JmrGEhL1VcrOvqUjQ/SwhPbJuUTLOQq
        hM2zj3N2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzTcP-00052Y-Hv; Mon, 10 Sep 2018 21:21:13 +0000
Date:   Mon, 10 Sep 2018 14:21:13 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        axboe@kernel.dk, nborisov@suse.com, ak@linux.intel.com,
        viro@zeniv.linux.org.uk, kemi.wang@intel.com,
        gregkh@linuxfoundation.org, ebiggers@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ext4: Convert fault handler to use vm_fault_t type
Message-ID: <20180910212113.GB21965@bombadil.infradead.org>
References: <20180910154611.GA20252@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910154611.GA20252@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 09:16:12PM +0530, Souptick Joarder wrote:
> Return type of ext4_page_mkwrite and ext4_filemap_fault are
> changed to use vm_fault_t type.
> 
> With this patch all the callers of block_page_mkwrite_return()
> are changed to handle vm_fault_t. So converting the return type
> of block_page_mkwrite_return() to vm_fault_t.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

This looks like the straight-forward conversion I was hoping to see.

Reviewed-by: Matthew Wilcox <willy@infradead.org>
