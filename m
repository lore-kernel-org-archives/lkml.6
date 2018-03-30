Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeC3K1V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:27:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56966 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbeC3K1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:27:20 -0400
Date: Fri, 30 Mar 2018 12:26:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Wang <davidwang@zhaoxin.com>
Cc: tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, brucechang@via-alliance.com,
        cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com,
        lukelin@viacpu.com, timguo@zhaoxin.com
Subject: Re: [PATCH 1/2] x86/mce: new centaur CPUs support MCE broadcasting
Message-ID: <20180330102621.GA30063@pd.tnic>
References: <1522403622-31146-1-git-send-email-davidwang@zhaoxin.com>
 <1522403622-31146-2-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1522403622-31146-2-git-send-email-davidwang@zhaoxin.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 05:53:41PM +0800, David Wang wrote:
> This patch is used to tell the kernel that newer Centaur CPU support MCE
> broadcasting.
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/mcheck/mce.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index 7065846..82b25e1 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -1688,6 +1688,17 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
>  		if (c->x86 == 6 && c->x86_model == 45)
>  			quirk_no_way_out = quirk_sandybridge_ifu;
>  	}
> +
> +	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
> +		/*
> +		 * All newer centaur CPUs support MCE broadcasting. Enable
> +		 * synchronization with a one second timeout.
> +		 */
> +		if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0xf && c->x86_mask >=0xe)) &&

Are some specs or manuals available somewhere on the web for those?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
