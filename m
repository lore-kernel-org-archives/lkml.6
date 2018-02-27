Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeB0Mpk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 07:45:40 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45178 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeB0Mpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 07:45:38 -0500
X-Google-Smtp-Source: AH8x2241rXtO4PTNfMsYZtVqx2utWCqFsozzdCqE0MoS05/suM6DhDoQMRCGe6h2KAWCTuFaxWvvzw==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/1] Additional strict check on ELF file. Checks segments
 are followed in order of 'p_vaddr ' value ascending. It fixes erorr in
 total_mapping_size with computation total size. This error happens if
 segments in ELF file are not in order.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <16811dde-abb3-1504-003c-475d40610f9f@infradead.org>
Date: Tue, 27 Feb 2018 15:45:34 +0300
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <AD3CF79A-0AFC-4447-BBC7-8EA5F036B623@gmail.com>
References: <20180226154659.10218-1-blackzert@gmail.com>
 <20180226154659.10218-2-blackzert@gmail.com>
 <16811dde-abb3-1504-003c-475d40610f9f@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1RCjmpr013962

Thanks for that, I will fix it in next patch. Any other feedback?

Thanks,
Ilya

> 26 февр. 2018 г., в 20:48, Randy Dunlap <rdunlap@infradead.org> написал(а):
> 
> On 02/26/2018 07:46 AM, Ilya Smith wrote:
>> Signed-off-by: Ilya Smith <blackzert@gmail.com>
>> ---
>> fs/binfmt_elf.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 51 insertions(+)
>> 
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index bdb201230bae..970b42044240 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -524,6 +524,52 @@ static inline int arch_check_elf(struct elfhdr *ehdr, bool has_interp,
>> 
>> #endif /* !CONFIG_ARCH_BINFMT_ELF_STATE */
>> 
>> +/**
>> + * elf_check_phdr() - common check ELF program header.
>> + * @phdr: The program header to check
>> + * @phdr_num: Count of program headers in @phdr from elf header.
>> + *
>> + * Checks ELF binary meets specification.
>> + *
>> + * Return: Zero to proceed with ELF load, non-zero to faile the ELF load
> 
>                                                         fail
> 
>> + *		   with that return code.
>> + */
>> +static int elf_check_phdr(struct elf_phdr *phdr, unsigned long phdr_num)
>> +{
> 
> And it would be nicer/better to have all of the "intro" text in the body of this
> message instead of in another email.
> 
> thanks,
> -- 
> ~Randy
