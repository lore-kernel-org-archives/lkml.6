Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeC2Kzr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 06:55:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeC2Kzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 06:55:46 -0400
Date: Thu, 29 Mar 2018 12:54:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org, tony.luck@intel.com
Subject: Re: [PATCH v3 3/8] efi: Decode IA32/X64 Processor Error Info
 Structure
Message-ID: <20180329105448.GB29198@pd.tnic>
References: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
 <20180324184940.19762-4-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180324184940.19762-4-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 01:49:35PM -0500, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Print the fields in the IA32/X64 Processor Error Info Structure.
> 
> Based on UEFI 2.7 Table 253. IA32/X64 Processor Error Information
> Structure.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20180226193904.20532-4-Yazen.Ghannam@amd.com
> 
> v2->v3:
> * Fix table number in commit message.
> * Don't print raw validation bits.
> 
> v1->v2:
> * Add parantheses around "bits" expression in macro.
> * Fix indentation on multi-line statements.
> 
>  drivers/firmware/efi/cper-x86.c | 50 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
> index 863f0cd2a0ff..a9ab3bbf7986 100644
> --- a/drivers/firmware/efi/cper-x86.c
> +++ b/drivers/firmware/efi/cper-x86.c
> @@ -3,15 +3,28 @@
>  
>  #include <linux/cper.h>
>  
> +#define INDENT_SP	" "

There's that thing again. So it was a total waste of time discussing
this last time. So let me save my time this time:

NAKed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
