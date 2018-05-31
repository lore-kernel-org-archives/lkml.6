Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754893AbeEaMQj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:16:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:46638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754714AbeEaMQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:16:35 -0400
Date: Thu, 31 May 2018 14:16:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 1/2] printk: remove unused flag LOG_NOCONS
Message-ID: <20180531121633.acuffu2b66q24c5c@pathway.suse.cz>
References: <CGME20180531102133epcas5p2e8d47887c1708836c9b70964983093e2@epcas5p2.samsung.com>
 <20180531102133epcas5p2e8d47887c1708836c9b70964983093e2~zs4eTmEuv0380103801epcas5p2U@epcas5p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531102133epcas5p2e8d47887c1708836c9b70964983093e2~zs4eTmEuv0380103801epcas5p2U@epcas5p2.samsung.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-05-31 15:47:51, Maninder Singh wrote:
> This patch removes unused flag LOG_NOCONS for printk.
> usage of this flag is removed long back with below commit.

Make sense.

> "5c2992ee7fd8a29d04125dc0aa3522784c5fa5eb"
> printk: remove console flushing special cases for
>  partial buffered lines
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> ---
>  kernel/printk/printk.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2f4af21..ab15903 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -349,10 +349,9 @@ enum con_msg_format_flags {
>   */
>  
>  enum log_flags {
> -	LOG_NOCONS	= 1,	/* already flushed, do not print to console */
> -	LOG_NEWLINE	= 2,	/* text ended with a newline */
> -	LOG_PREFIX	= 4,	/* text started with a prefix */
> -	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
> +	LOG_NEWLINE	= 1,	/* text ended with a newline */
> +	LOG_PREFIX	= 2,	/* text started with a prefix */
> +	LOG_CONT	= 4,	/* text is a fragment of a continuation line */
>  };

Please, do not renumber the bits if there is no real need for it.
The format of the log buffer is read also by external tool like
"crash". It seems that "crash" ignores these flags but...

Best Regards,
Petr
