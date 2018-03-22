Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeCVHtW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 03:49:22 -0400
Received: from goliath.siemens.de ([192.35.17.28]:45993 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeCVHtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 03:49:19 -0400
Subject: Re: [PATCH] builddeb: Fix header package regarding dtc source links
To: Riku Voipio <riku.voipio@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c6e11bd4-3d22-f8aa-c905-d06b16b1f5e2@siemens.com>
 <CAAqcGH=fFv=Fh43mbi19_A-c551adVV5OSJ-53HF09ev2u-E1g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <87a8da66-c610-9b61-d0f8-b5bc7faf2dd7@siemens.com>
Date: Thu, 22 Mar 2018 15:49:05 +0800
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CAAqcGH=fFv=Fh43mbi19_A-c551adVV5OSJ-53HF09ev2u-E1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-22 15:45, Riku Voipio wrote:
> On 21 March 2018 at 07:15, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> Since d5d332d3f7e8, a couple of links in scripts/dtc/include-prefixes
>> are additionally required in order to build device trees with the header
>> package.
> 
> A bit odd usecase IMHO, but:

The use case is not completely odd (I hope): Jailhouse hypervisor. We
build it as out-of-tree module so far, and we both need dtc for the
driver module as well as the guest device trees.

> 
> Reviewed-by: Riku Voipio <riku.voipio@linaro.org>

Thanks,
Jan

> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  scripts/package/builddeb | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
>> index b4f0f2b3f8d2..13fabb1f81db 100755
>> --- a/scripts/package/builddeb
>> +++ b/scripts/package/builddeb
>> @@ -313,7 +313,7 @@ fi
>>
>>  # Build kernel header package
>>  (cd $srctree; find . -name Makefile\* -o -name Kconfig\* -o -name \*.pl) > "$objtree/debian/hdrsrcfiles"
>> -(cd $srctree; find arch/*/include include scripts -type f) >> "$objtree/debian/hdrsrcfiles"
>> +(cd $srctree; find arch/*/include include scripts -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
>>  (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
>>  (cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
>>  if grep -q '^CONFIG_STACK_VALIDATION=y' $KCONFIG_CONFIG ; then
>> --
>> 2.13.6
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
