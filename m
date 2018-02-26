Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeBZRs3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:48:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeBZRs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:48:26 -0500
Subject: Re: [PATCH 1/1] Additional strict check on ELF file. Checks segments
 are followed in order of 'p_vaddr ' value ascending. It fixes erorr in
 total_mapping_size with computation total size. This error happens if
 segments in ELF file are not in order.
To: Ilya Smith <blackzert@gmail.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180226154659.10218-1-blackzert@gmail.com>
 <20180226154659.10218-2-blackzert@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <16811dde-abb3-1504-003c-475d40610f9f@infradead.org>
Date: Mon, 26 Feb 2018 09:48:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226154659.10218-2-blackzert@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/2018 07:46 AM, Ilya Smith wrote:
> Signed-off-by: Ilya Smith <blackzert@gmail.com>
> ---
>  fs/binfmt_elf.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index bdb201230bae..970b42044240 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -524,6 +524,52 @@ static inline int arch_check_elf(struct elfhdr *ehdr, bool has_interp,
>  
>  #endif /* !CONFIG_ARCH_BINFMT_ELF_STATE */
>  
> +/**
> + * elf_check_phdr() - common check ELF program header.
> + * @phdr: The program header to check
> + * @phdr_num: Count of program headers in @phdr from elf header.
> + *
> + * Checks ELF binary meets specification.
> + *
> + * Return: Zero to proceed with ELF load, non-zero to faile the ELF load

                                                         fail

> + *		   with that return code.
> + */
> +static int elf_check_phdr(struct elf_phdr *phdr, unsigned long phdr_num)
> +{

And it would be nicer/better to have all of the "intro" text in the body of this
message instead of in another email.

thanks,
-- 
~Randy
