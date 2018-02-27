Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbeB0Oap (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:30:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:33462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753280AbeB0Oan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:30:43 -0500
Date: Tue, 27 Feb 2018 15:30:20 +0100
From: Borislav Petkov <bp@suse.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org
Subject: Re: [PATCH v2 4/8] efi: Decode UEFI-defined IA32/X64 Error Structure
 GUIDs
Message-ID: <20180227143020.GG26382@pd.tnic>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180226193904.20532-5-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226193904.20532-5-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 01:39:00PM -0600, Yazen Ghannam wrote:
> @@ -45,6 +81,11 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
>  		printk("%sError Structure Type: %pUl\n", newpfx,
>  		       &err_info->err_type);
>  
> +		err_type = cper_get_err_type(&err_info->err_type);
> +		printk("%sError Structure Type: %s\n", newpfx,
> +		       err_type < ARRAY_SIZE(cper_proc_error_type_strs) ?
> +		       cper_proc_error_type_strs[err_type] : "unknown");

Ah, there it is, much better. Now this tells us what component it is.

So cper-arm.c does the same thing and there's a similar thing in cper.c -
cper_print_proc_generic().

Let's not tri-plicate that code pls and have a generic function instead.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
