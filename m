Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeDHBcO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 21:32:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeDHBcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 21:32:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7DA1602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date: Sat, 7 Apr 2018 20:32:10 -0500
From: Richard Kuo <rkuo@codeaurora.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hexagon: export csum_partial_copy_nocheck
Message-ID: <20180408013210.GD3036@codeaurora.org>
References: <20180406142832.2243021-1-arnd@arndb.de>
 <20180406142832.2243021-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406142832.2243021-3-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 04:28:23PM +0200, Arnd Bergmann wrote:
> This is needed to link ipv6 as a loadable module, which in turn happens
> in allmodconfig.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/hexagon/lib/checksum.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/hexagon/lib/checksum.c b/arch/hexagon/lib/checksum.c
> index 617506d1a559..7cd0a2259269 100644
> --- a/arch/hexagon/lib/checksum.c
> +++ b/arch/hexagon/lib/checksum.c
> @@ -199,3 +199,4 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
>  	memcpy(dst, src, len);
>  	return csum_partial(dst, len, sum);
>  }
> +EXPORT_SYMBOL(csum_partial_copy_nocheck);

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
