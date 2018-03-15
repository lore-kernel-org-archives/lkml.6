Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeCOQcG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:32:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50668 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbeCOQcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:32:05 -0400
Date: Thu, 15 Mar 2018 17:31:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] x86/microcode/AMD: verify patch section type for
 every such section
Message-ID: <20180315163125.GG27816@pd.tnic>
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <c22d8453-e72a-4708-7aa1-3c19256881b1@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c22d8453-e72a-4708-7aa1-3c19256881b1@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 10:07:01PM +0100, Maciej S. Szmigiero wrote:
> We should check whether the patch section currently being processed is
> actually a patch section for each of them (not just the first one) in the
> late loader verify_and_add_patch() function, just like the early loader
> already does in parse_container() function.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 0f78200f2f6c..3ad23e72c2b0 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -627,6 +627,11 @@ static int verify_and_add_patch(u8 family, u8 *fw, size_t leftover)
>  	if (leftover < SECTION_HDR_SIZE + sizeof(*mc_hdr))
>  		return leftover;
>  
> +	if (*(u32 *)fw != UCODE_UCODE_TYPE) {

Store that in a local var patch_type for better readability, while
you're touching that.

Also, for all your patch subject names for your next submission, start
the patch subject sentence with a capital letter:

Subject: [PATCH v3 6/9] x86/microcode/AMD: Verify patch section type for every such section

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
