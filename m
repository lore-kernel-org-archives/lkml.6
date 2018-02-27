Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbeB0Kre (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:47:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:41521 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752674AbeB0Krc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:47:32 -0500
Date: Tue, 27 Feb 2018 11:47:08 +0100
From: Borislav Petkov <bp@suse.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org
Subject: Re: [PATCH v2 1/8] efi: Fix IA32/X64 Processor Error Record
 definition
Message-ID: <20180227104708.GC26382@pd.tnic>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226193904.20532-2-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 01:38:57PM -0600, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Based on UEFI 2.7 Table 255. Processor Error Record, the "Local APIC_ID"

My pdf says this is table 252.

> field is 8 bytes but Linux defines this field as 1 byte.
> 
> Fix this in the struct cper_sec_proc_ia definition.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20180223200333.6410-2-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * No changes.
> 
>  include/linux/cper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index d14ef4e77c8a..4b5f8459b403 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -381,7 +381,7 @@ struct cper_sec_proc_generic {
>  /* IA32/X64 Processor Error Section */
>  struct cper_sec_proc_ia {
>  	__u64	validation_bits;
> -	__u8	lapic_id;
> +	__u64	lapic_id;
>  	__u8	cpuid[48];

Ok, that processor error record has a variable length structure at byte
offset 64 and we don't have it in this struct.

I guess I'll see it in the following patches but right now it looks
like that "Processor Error Info" thing is simply situated after that
Processor Error Record so we are supposed to simply find the info at
offset 64...

/me continues reading...

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
