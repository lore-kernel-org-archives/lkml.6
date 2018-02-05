Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeBEJ0x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:26:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751705AbeBEJ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:26:46 -0500
Date: Mon, 5 Feb 2018 10:26:44 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Jia Zhang <zhang.jia@linux.alibaba.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mm/64: Add vsyscall page to /proc/kcore
 conditionally
Message-ID: <20180205092644.GA23191@krava>
References: <1517294579-117473-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1517294579-117473-2-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517294579-117473-2-git-send-email-zhang.jia@linux.alibaba.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 02:42:59PM +0800, Jia Zhang wrote:
> The vsyscall page should be visible only if
> vsyscall=emulate/native when dumping /proc/kcore.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> ---
>  arch/x86/mm/init_64.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index dab78f6..3d4cf33 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1186,8 +1186,9 @@ void __init mem_init(void)
>  	register_page_bootmem_info();
>  
>  	/* Register memory areas for /proc/kcore */
> -	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
> -		   PAGE_SIZE, KCORE_USER);
> +	if (get_gate_vma(&init_mm))
> +		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
> +			   PAGE_SIZE, KCORE_USER);

nit, we use { } when there's more than 1 line code 

anyway the approach looks ok to me

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
