Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8AFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A668214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549996453;
	bh=+qQSxXleqR6YUtPP08TdpBONjqXTvc9GgGmMifSjOYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VRSiwDuog1Bn0ZGbgu+VLXaEBROWiy6nrISr1o+o3btH5iE15rQjNwLw3BrUmOOlh
	 tTXxZY2/sOEg8TAQ0GaU/ET0RKIh9INy3s2HT3QFAK+5mVhxGdxFwdj82nfjO03K5X
	 VX01DApnSWfq1HVFpVPGJwDnR302gI041ckNwAWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbfBLSeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfBLSeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:34:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB9320842;
        Tue, 12 Feb 2019 18:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549996451;
        bh=+qQSxXleqR6YUtPP08TdpBONjqXTvc9GgGmMifSjOYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+B21HlQXzPe1vj2AWgdcfGm2rob9dT/1LWzmcyYHlFcZxdKiHvDewwCyGGoaBUDK
         X7XXAsiKo4Dy8z1lG28L3sl36oX6W9jLUfTaZEGBa2iGVi9qcpiZYB0EWHeipMh/as
         Mf/ffXdolixd3SC+ry5r8v6lOP8ooRfBGEAoxt2s=
Date:   Tue, 12 Feb 2019 19:34:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiang Xiao <xiaoxiang781216@gmail.com>
Cc:     alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] lib/string: add memrchr function
Message-ID: <20190212183408.GA14892@kroah.com>
References: <1549994809-27479-1-git-send-email-xiaoxiang@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549994809-27479-1-git-send-email-xiaoxiang@xiaomi.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:06:49AM +0800, Xiang Xiao wrote:
> Here is the detailed description for memrchr:
> https://linux.die.net/man/3/memrchr

Please put it in the changelog, as web pages move and go away :(

> 
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> ---
>  include/linux/string.h |  1 +
>  lib/string.c           | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 7927b87..f380f4b 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -167,6 +167,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
>  	memcpy(dst, src, cnt);
>  }
>  #endif
> +void *memrchr(const void *s, int c, size_t n);

Who is going to use this?

thanks,

greg k-h
