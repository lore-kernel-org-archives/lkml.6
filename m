Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0ECC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 16:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5101320865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544372731;
	bh=NKx9Rv8cfOUkSl/MPreubq4zoY+jwT9r88U2dDMg3h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hZIIl7G6+kkXzA2KxrC/jiSfcYtL9MslgcuuXx2WXkNlMK4G4TZtluAVyA8IZW0Yx
	 2yIC7nGSvgPGm7Uht8rCJs0GYdgsa8RFg1k0u3v+ih5Fh7ss6Dzp18rm3WWYHjv5GQ
	 ufTRJg/pRiSUs5KCDOCrcWfR2WtNfkGYJEk3MkiY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5101320865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeLIQUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 11:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeLIQUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 11:20:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA36E20865;
        Sun,  9 Dec 2018 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544372416;
        bh=NKx9Rv8cfOUkSl/MPreubq4zoY+jwT9r88U2dDMg3h8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QG6KDOOlN5KFEsaoHsJ2plFGBHm8AM/v905p1tf8X9DVD1oJiq4imtDB5jPCLOvSq
         DmkMb2Q58pvy5zBvTSMEGZd85T0P27c9UgtKp+uOLqIitgmJgC6UfwHJywvEBVDntw
         cIa5sWd8hhlQ4d109P+h66j7wIqtxKPlxEYxtopQ=
Date:   Sun, 9 Dec 2018 17:20:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Jespersen <laumann.thomas@gmail.com>
Cc:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: erofs: Add braces to do-while statements
Message-ID: <20181209162007.GA22432@kroah.com>
References: <20181209155900.10164-1-laumann.thomas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209155900.10164-1-laumann.thomas@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 04:59:00PM +0100, Thomas Jespersen wrote:
> This fixes warning reported by sparse (with -Wsparse-all).

Why is sparse warning about this?

> Signed-off-by: Thomas Jespersen <laumann.thomas@gmail.com>
> ---
>  drivers/staging/erofs/internal.h | 4 ++--
>  drivers/staging/erofs/utils.c    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index 57575c7f5635..bf180a803446 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -232,9 +232,9 @@ static inline bool erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
>  	/* spin if it is temporarily locked at the reclaim path */
>  	if (unlikely(o == locked)) {
>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> -		do
> +		do {
>  			cpu_relax();
> -		while (atomic_read(&grp->refcount) == locked);
> +		} while (atomic_read(&grp->refcount) == locked);

That looks like valid code to me, why change this?

greg k-h
