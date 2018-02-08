Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeBHPE4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:04:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49090 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHPEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:04:55 -0500
Date: Thu, 8 Feb 2018 16:04:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, bp@suse.de,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 1/3] x86/MCE/AMD: Redo function to get SMCA bank type
Message-ID: <20180208150433.GD7964@pd.tnic>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 12:48:11PM -0600, Yazen Ghannam wrote:
>  arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> index 0f32ad242324..4e16afc0794d 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> @@ -110,14 +110,14 @@ const char *smca_get_long_name(enum smca_bank_types t)
>  }
>  EXPORT_SYMBOL_GPL(smca_get_long_name);
>  
> -static enum smca_bank_types smca_get_bank_type(struct mce *m)
> +static enum smca_bank_types smca_get_bank_type(unsigned int bank)
>  {
>  	struct smca_bank *b;
>  
> -	if (m->bank >= N_SMCA_BANK_TYPES)
> +	if (bank >= ARRAY_SIZE(smca_banks))

MAX_NR_BANKS

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
