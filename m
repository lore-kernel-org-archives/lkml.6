Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E278C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFB9218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548937932;
	bh=2cJOY3/4x2f1iwU6c1/wbHc/6tNO/YCRrnlCbF9ziXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wtH702qtt7NAoXynRlCwXJvVNywBsTpjukSFFgSOPDAO/SpIBrNL1PspPo/XZ3N1x
	 tByd51vE4iq37ruzqQqxgMmKmkCGwuqiJiXdGIzFl0hzKSOuwyYiCkeHaeRo3Qn27W
	 jwSWbMnU805pXT8k8Jj6Kbb2PjLen9Rgw7BBHU18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbfAaMcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732871AbfAaMcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:32:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A3C218FC;
        Thu, 31 Jan 2019 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548937928;
        bh=2cJOY3/4x2f1iwU6c1/wbHc/6tNO/YCRrnlCbF9ziXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4JzAuE2+ketXbvOHD5A6Gxvd+I5EUUOX9Ce/kwzrYGPQWr7CFRw0YCYlbbOuFs0O
         oXDrQWbbfYJsiGQuFeLN6xX3AOGO4ZKnZmChhqfDSq6T2qKBA613RbhO7ltubYiA5o
         awhldaVE7OCQZPFYen3orqSlqru56OtRX3twaOho=
Date:   Thu, 31 Jan 2019 13:32:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ayush Mittal <ayush.m@samsung.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 1/1] kernfs: Allocating memory for kernfs_iattrs with
 kmem_cache.
Message-ID: <20190131123205.GA20404@kroah.com>
References: <CGME20190131095437epcas5p1501775cdfb469235c6ab9f6f9ab67898@epcas5p1.samsung.com>
 <1548927785-40397-1-git-send-email-ayush.m@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548927785-40397-1-git-send-email-ayush.m@samsung.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 03:13:05PM +0530, Ayush Mittal wrote:
> @@ -414,4 +414,9 @@ void __init kernfs_init(void)
>  					      0,
>  					      SLAB_PANIC | SLAB_TYPESAFE_BY_RCU,
>  					      NULL);
> +	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
> +					      sizeof(struct kernfs_iattrs),
> +					      0,
> +					      SLAB_PANIC | SLAB_TYPESAFE_BY_RCU,
> +					      NULL);
>  }

Are you sure the comment above this holds true for this new cache as
well?  Please document it as well as the other one was, and remove the
SLAB_ flags as needed.

thanks,

greg k-h
