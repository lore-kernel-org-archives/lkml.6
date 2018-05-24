Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033497AbeEXQLc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:11:32 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46259 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030730AbeEXQLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:11:30 -0400
X-Google-Smtp-Source: AB8JxZpzjeM/GTG72yqR+oAE4zrCEfp31bDOQBvePLyG6NXn5yXAnCjsIpZT/w43NJOMdkh+NleROw==
Subject: Re: [PATCH] scripts/dtc: Fixed format mismatch in fprintf
To: nixiaoming <nixiaoming@huawei.com>, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180524025018.73187-1-nixiaoming@huawei.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <6e8298cb-795d-f786-0fbd-c77835f3ab91@gmail.com>
Date: Thu, 24 May 2018 09:11:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524025018.73187-1-nixiaoming@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/18 19:50, nixiaoming wrote:
> format specifier "d" need arg type "int" , but the according arg
> "fdt32_to_cpu(xxx)" has type "unsigned int"
> 
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
>  scripts/dtc/fdtdump.c  | 6 +++---
>  scripts/dtc/flattree.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/dtc/fdtdump.c b/scripts/dtc/fdtdump.c
> index 7d460a5..851bb6f 100644
> --- a/scripts/dtc/fdtdump.c
> +++ b/scripts/dtc/fdtdump.c
> @@ -66,12 +66,12 @@ static void dump_blob(void *blob)
>  
>  	printf("/dts-v1/;\n");
>  	printf("// magic:\t\t0x%x\n", fdt32_to_cpu(bph->magic));
> -	printf("// totalsize:\t\t0x%x (%d)\n", totalsize, totalsize);
> +	printf("// totalsize:\t\t0x%x (%u)\n", totalsize, totalsize);
>  	printf("// off_dt_struct:\t0x%x\n", off_dt);
>  	printf("// off_dt_strings:\t0x%x\n", off_str);
>  	printf("// off_mem_rsvmap:\t0x%x\n", off_mem_rsvmap);
> -	printf("// version:\t\t%d\n", version);
> -	printf("// last_comp_version:\t%d\n",
> +	printf("// version:\t\t%u\n", version);
> +	printf("// last_comp_version:\t%u\n",
>  	       fdt32_to_cpu(bph->last_comp_version));
>  	if (version >= 2)
>  		printf("// boot_cpuid_phys:\t0x%x\n",
> diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
> index 8d268fb..28da281 100644
> --- a/scripts/dtc/flattree.c
> +++ b/scripts/dtc/flattree.c
> @@ -393,7 +393,7 @@ void dt_to_blob(FILE *f, struct dt_info *dti, int version)
>  			padlen = 0;
>  			if (quiet < 1)
>  				fprintf(stderr,
> -					"Warning: blob size %d >= minimum size %d\n",
> +					"Warning: blob size %u >= minimum size %d\n",
>  					fdt32_to_cpu(fdt.totalsize), minsize);
>  		}
>  	}
> 


We import this file from the upstream dtc project.  Please send patches
for this file to:

   David Gibson <david@gibson.dropbear.id.au>
   devicetree-compiler@vger.kernel.org

Thanks,

Frank
