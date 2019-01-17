Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B298C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E71820856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfAQJG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:06:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:43088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727510AbfAQJGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:06:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24958ACB1;
        Thu, 17 Jan 2019 09:06:51 +0000 (UTC)
Subject: Re: [PATCH v15 5/6] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
To:     Kairui Song <kasong@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, Kees Cook <keescook@chromium.org>,
        Baoquan He <bhe@redhat.com>, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
 <CACPcB9dO8FxpqSeG2whJGpUT7TiuiSJFWNWcF_fkRQwdRHwVcA@mail.gmail.com>
 <20190117062451.GA588@localhost.localdomain>
 <20190117075729.GC31097@localhost.localdomain>
 <CACPcB9c=gPE3CtMFw8kZXnWPDUoRDedKcLjcPDykLNbFoZH5GQ@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a1e14a03-795e-5888-5851-d77f441a60de@suse.com>
Date:   Thu, 17 Jan 2019 10:06:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CACPcB9c=gPE3CtMFw8kZXnWPDUoRDedKcLjcPDykLNbFoZH5GQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2019 09:22, Kairui Song wrote:
> On Thu, Jan 17, 2019 at 3:58 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>>
>> On Wed, Jan 16, 2019 at 03:28:52PM +0800, Kairui Song wrote:
>>> On Mon, Jan 7, 2019 at 11:24 AM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>>>>
>>>> +
>>>> +/* Determine RSDP, based on acpi_os_get_root_pointer(). */
>>>> +static acpi_physical_address get_rsdp_addr(void)
>>>> +{
>>>> +       acpi_physical_address pa;
>>>> +
>>>> +       pa = get_acpi_rsdp();
>>>> +
>>>> +       if (!pa)
>>>> +               pa = efi_get_rsdp_addr();
>>>> +
>>>> +       if (!pa)
>>>> +               pa = bios_get_rsdp_addr();
>>>> +
>>>> +       return pa;
>>>> +}
>>>
>>> acpi_rsdp might be provided by boot_params.acpi_rsdp_addr too,
>>> it's introduced in ae7e1238e68f2a for Xen PVH guest and later move to
>>> boot_params in e6e094e053af,
>>> kexec could use it to pass RSDP to second kernel as well. Please check
>>> it as well make sure it always works.
>>>
>>
>> Hi Kairui,
>>
>> I saw the parsing code has been added to kernel, but I didn't see
>> where to fill in the 'acpi_rsdp_addr'. If only you(KEXEC) use it,
>> I can add "#ifdef CONFIG_KEXEC", but you said Xen will use it also,
>> so I didn't add ifdef to control it. I was trying to do as below:
>>
>> static inline acpi_physical_address get_boot_params_rsdp(void)
>> {
>>         return boot_params->acpi_rsdp_addr;
>> }
>>
>> static acpi_physical_address get_rsdp_addr(void)
>> {
>>         bool boot_params_rsdp_exist;
>>         acpi_physical_address pa;
>>
>>         pa = get_acpi_rsdp();
>>
>>         if (!pa)
>>                 pa = get_boot_params_rsdp();
>>
>>         if (!pa) {
>>                 pa = efi_get_rsdp_addr();
>>                 boot_params_rsdp_exist = false;
>>         }
>>         else
>>                 boot_params_rsdp_exist = true;
>>
>>         if (!pa)
>>                 pa = bios_get_rsdp_addr();
>>
>>         if (pa && !boot_params_rsdp_exist)
>>                 boot_params.acpi_rsdp_addr = pa;
>>
>>         return pa;
>> }
>>
>> At the same time, I notice kernel only parses it when
>> "#ifdef CONFIG_ACPI", we should keep sync with kernel, but I think
>> we are parsing SRAT, CONFIG_ACPI is needed sure, so I am going to
>> update the define of EARLY_SRAT_PARSE:
>>
>> config EARLY_SRAT_PARSE
>>         bool "EARLY SRAT parsing"
>>         def_bool y
>>         depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE && ACPI
>>
>> Boris, how do you think the update for the new acpi_rsdp_addr?
>> If I misunderstand something, please let me know.
>>
>> Thanks,
>> Chao Fan
>>
> 
> Hi, thanks for considering kexec usage,
> 
> but I think "boot_params_rsdp_exist" is not necessary,
> boot_params->acpi_rsdp_addr should be either NULL or a valid value if
> I, later initialization code considers it a valid value if it's not
> NULL.
> 
> For the usage for Xen I'm not sure either, the info comes from commit
> message of ae7e1238e68f2a that's also where boot_params.acpi_rsdp_addr
> is first introduced, lets cc Juergen as well.

Thanks for adding me.

The Xen case is thought to prefer boot_params->acpi_rsdp_addr over all
other possibilities if set. This logic should be kept. It is used for
Xen PVH guests booted via grub2. Xen PVH guests don't have RSDP in low
memory, so this interface is needed.

In any case you should first try acpi_arch_get_root_pointer() as this
is the preferred way to override RSDP address.


Juergen


