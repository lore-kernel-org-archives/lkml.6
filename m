Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeFEIyF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:54:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50656 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeFEIyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:54:03 -0400
Date: Tue, 5 Jun 2018 10:54:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] x86/microcode/AMD: Add microcode container data
 checking functions
Message-ID: <20180605085403.GA1617@zn.tnic>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
 <28d0439f64e03e3c8192e1f5280f01a5729698fc.1526767245.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28d0439f64e03e3c8192e1f5280f01a5729698fc.1526767245.git.mail@maciej.szmigiero.name>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 12:07:16AM +0200, Maciej S. Szmigiero wrote:
> Add verify_container(), verify_equivalence_table(), verify_patch_section()
> and verify_patch() functions to the AMD microcode update driver.
> 
> These functions check whether a passed buffer contains the relevant
> structure, whether it isn't truncated and (for actual microcode patches)
> whether the size of a patch is not too large for a particular CPU family.
> By adding these checks as separate functions the actual microcode loading
> code won't get interspersed with a lot of checks and so will be more
> readable.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 148 +++++++++++++++++++++++++++-
>  1 file changed, 145 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index dc8ea9a9d962..f9485ff7183c 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -73,6 +73,150 @@ static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
>  	return 0;
>  }
>  
> +/*
> + * Checks whether there is a valid microcode container file at the beginning

"Check whether... " imperative tone. Ditto for the rest.

> + * of a passed buffer @buf of size @size.

@buf_size

Also, fix the other comments too.

> + * If @early is set this function does not print errors which makes it
> + * usable by the early microcode loader.
> + */
> +static bool verify_container(const u8 *buf, size_t buf_size, bool early)

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
