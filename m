Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D745CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D922064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D922064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeJAQ2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:28:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728826AbeJAQ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:28:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB11FB041;
        Mon,  1 Oct 2018 09:51:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 528021E356C; Mon,  1 Oct 2018 11:51:19 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:51:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
        mgorman@techsingularity.net, ak@linux.intel.com,
        jlayton@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap.c: Use vmf_error()
Message-ID: <20181001095119.GE3913@quack2.suse.cz>
References: <20180927171411.GA23331@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927171411.GA23331@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-09-18 22:44:12, Souptick Joarder wrote:
> These codes can be replaced with new inline vmf_error().
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 52517f2..7d04d7c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2581,9 +2581,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	 * system is low on memory, or a problem occurs while trying
>  	 * to schedule I/O.
>  	 */
> -	if (error == -ENOMEM)
> -		return VM_FAULT_OOM;
> -	return VM_FAULT_SIGBUS;
> +	return vmf_error(error);
>  
>  page_not_uptodate:
>  	/*
> -- 
> 1.9.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
