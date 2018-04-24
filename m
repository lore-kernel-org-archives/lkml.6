Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeDXPzL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:55:11 -0400
Received: from foss.arm.com ([217.140.101.70]:55886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbeDXPzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:55:09 -0400
Date: Tue, 24 Apr 2018 16:55:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kmemleak: Report if we need to tune
 KMEMLEAK_EARLY_LOG_SIZE
Message-ID: <20180424155504.frbxmzq4dw3veudu@armageddon.cambridge.arm.com>
References: <288b0afc-bcc3-a2aa-2791-707e625d1da7@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288b0afc-bcc3-a2aa-2791-707e625d1da7@siemens.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 05:51:15PM +0200, Jan Kiszka wrote:
> ...rather than just mysteriously disabling it.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  mm/kmemleak.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 9a085d525bbc..156c0c69cc5c 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -863,6 +863,7 @@ static void __init log_early(int op_type, const void *ptr, size_t size,
>  
>  	if (crt_early_log >= ARRAY_SIZE(early_log)) {
>  		crt_early_log++;
> +		pr_warn("Too many early logs\n");

That's already printed, though later where we have an idea of how big the early
log needs to be:

	if (crt_early_log > ARRAY_SIZE(early_log))
		pr_warn("Early log buffer exceeded (%d), please increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE\n",
			crt_early_log);

-- 
Catalin
