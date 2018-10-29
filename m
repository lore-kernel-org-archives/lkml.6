Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED6AC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129012084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129012084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbeJ2Sdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:33:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37602 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729343AbeJ2Sdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:33:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33D78341;
        Mon, 29 Oct 2018 02:45:46 -0700 (PDT)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 698823F557;
        Mon, 29 Oct 2018 02:45:45 -0700 (PDT)
Subject: Re: [PATCH] efi/fdt: Indentation fix
To:     Joe Perches <joe@perches.com>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1538389776-8432-1-git-send-email-julien.thierry@arm.com>
 <61d7bd590527166c58670b4c0ab65a08710f81cf.camel@perches.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <d7d0641b-f2a5-a51b-f52e-3db3b873f209@arm.com>
Date:   Mon, 29 Oct 2018 09:45:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <61d7bd590527166c58670b4c0ab65a08710f81cf.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 02/10/18 17:05, Joe Perches wrote:
> On Mon, 2018-10-01 at 11:29 +0100, Julien Thierry wrote:
>> Closing bracket seems to end a for statement when it is actually ending
>> the contained if.
>>
>> No functional change/fix, just fix the indentation.
> []
>> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> []
>> @@ -381,7 +381,7 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
>>   			}
>>   			*fdt_size = fdt_totalsize(fdt);
>>   			break;
>> -	 }
>> +		}
>>
>>   	return fdt;
>>   }
> 
> Hello Julian.
> 
> [trivial style bikeshedding follows]
> 
> I think it better to add braces to the for loop so
> this stands out better.
> 
> Also, I would generally write this so the if test is
> reversed and uses a continue so the match block saves
> an indent level.
> 
> This is the only use efi_guidcmp with a == test in
> drivers/firmware, so perhaps remove that and use ! as
> the other uses have no == or != test.
> 
> Lastly, a direct return might be better and the return
> fdt could be removed and converted to return NULL.
> 

The suggestions make sense, I'll respin this taking your remarks into 
account.

Thanks,

> Something like:
> ---
>   drivers/firmware/efi/libstub/fdt.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 8830fa601e45..2d0b895e2f67 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -366,22 +366,23 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
>   {
>   	efi_guid_t fdt_guid = DEVICE_TREE_GUID;
>   	efi_config_table_t *tables;
> -	void *fdt;
>   	int i;
>   
> -	tables = (efi_config_table_t *) sys_table->tables;
> -	fdt = NULL;
> +	tables = (efi_config_table_t *)sys_table->tables;
>   
> -	for (i = 0; i < sys_table->nr_tables; i++)
> -		if (efi_guidcmp(tables[i].guid, fdt_guid) == 0) {
> -			fdt = (void *) tables[i].table;
> -			if (fdt_check_header(fdt) != 0) {
> -				pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
> -				return NULL;
> -			}
> -			*fdt_size = fdt_totalsize(fdt);
> -			break;
> -	 }
> +	for (i = 0; i < sys_table->nr_tables; i++) {
> +		void *fdt;
> +
> +		if (efi_guidcmp(tables[i].guid, fdt_guid))
> +			continue;
> +		fdt = (void *)tables[i].table;
> +		if (fdt_check_header(fdt) != 0) {
> +			pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
> +			return NULL;
> +		}
> +		*fdt_size = fdt_totalsize(fdt);
> +		return fdt;
> +	}
>   
> -	return fdt;
> +	return NULL;
>   }
> 
> 

-- 
Julien Thierry
