Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeCNMjb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:39:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50684 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751615AbeCNMj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:39:29 -0400
Date: Wed, 14 Mar 2018 13:38:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] x86/microcode/AMD: subtract SECTION_HDR_SIZE from
 file leftover length
Message-ID: <20180314123851.GB16605@pd.tnic>
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <27607e8b-68bc-13f2-a2e6-8f77c8381f48@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27607e8b-68bc-13f2-a2e6-8f77c8381f48@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 10:06:10PM +0100, Maciej S. Szmigiero wrote:
> verify_patch_size() function verifies whether the microcode container file
> remaining size is large enough to contain a patch of the indicated size.
> 
> However, the section header length is not included in this indicated size
> but it is present in the leftover file length so it should be subtracted
> from the leftover file length before passing this value to
> verify_patch_size().
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index a998e1a7d46f..ffe0d0ce57fc 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -613,7 +613,8 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
>  		return crnt_size;
>  	}
>  
> -	ret = verify_patch_size(family, patch_size, leftover);
> +	ret = verify_patch_size(family, patch_size,
> +				leftover - SECTION_HDR_SIZE);

Pls add a sentence or two as a comment above it explaining why the
section header size needs to be subtracted and do not break the line
even if it is > 80 cols.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
