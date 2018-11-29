Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC289C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9E02081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9E02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeK2XKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:10:08 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbeK2XKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:10:07 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id F1F0A8D430A06;
        Thu, 29 Nov 2018 12:04:50 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 29 Nov
 2018 12:04:44 +0000
Subject: Re: [PATCH v5 2/7] tpm: remove definition of TPM2_ACTIVE_PCR_BANKS
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     <zohar@linux.ibm.com>, <david.safford@ge.com>,
        <monty.wiseman@ge.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
 <20181114153108.12907-3-roberto.sassu@huawei.com>
 <20181116133851.GB4163@linux.intel.com>
 <1602133e-6a41-ea97-d985-6eca0831898d@huawei.com>
Message-ID: <4a55ba02-87e6-9258-038e-e4c57f00f033@huawei.com>
Date:   Thu, 29 Nov 2018 13:04:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1602133e-6a41-ea97-d985-6eca0831898d@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/2018 1:17 PM, Roberto Sassu wrote:
> On 11/16/2018 2:38 PM, Jarkko Sakkinen wrote:
>> On Wed, Nov 14, 2018 at 04:31:03PM +0100, Roberto Sassu wrote:
>>> tcg_efi_specid_event and tcg_pcr_event2 declaration contains static 
>>> arrays
>>> for a list of hash algorithms used for event logs and event log digests.
>>>
>>> However, according to TCG EFI Protocol Specification, these arrays have
>>> variable sizes. Setting the array size to zero or 3 does not make any
>>> difference, because the parser has to adjust the offset depending on the
>>> actual array size to access structure members after the static arrays.
>>>
>>> Thus, this patch removes the declaration of TPM2_ACTIVE_PCR_BANKS and 
>>> sets
>>> the array size to zero.
>>>
>>> Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware
>>> event log")
>>>
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>> ---
>>>   include/linux/tpm_eventlog.h | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
>>> index 20d9da77fc11..3d5d162f09cc 100644
>>> --- a/include/linux/tpm_eventlog.h
>>> +++ b/include/linux/tpm_eventlog.h
>>> @@ -8,7 +8,6 @@
>>>   #define TCG_EVENT_NAME_LEN_MAX    255
>>>   #define MAX_TEXT_EVENT        1000    /* Max event string length */
>>>   #define ACPI_TCPA_SIG        "TCPA"    /* 0x41504354 /'TCPA' */
>>> -#define TPM2_ACTIVE_PCR_BANKS    3
>>>   #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2 0x1
>>>   #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2
>>> @@ -90,7 +89,7 @@ struct tcg_efi_specid_event {
>>>       u8 spec_errata;
>>>       u8 uintnsize;
>>>       u32 num_algs;
>>> -    struct tcg_efi_specid_event_algs 
>>> digest_sizes[TPM2_ACTIVE_PCR_BANKS];
>>> +    struct tcg_efi_specid_event_algs digest_sizes[0];
>>>       u8 vendor_info_size;
>>>       u8 vendor_info[0];
>>>   } __packed;
>>> @@ -117,7 +116,7 @@ struct tcg_pcr_event2 {
>>>       u32 pcr_idx;
>>>       u32 event_type;
>>>       u32 count;
>>> -    struct tpm2_digest digests[TPM2_ACTIVE_PCR_BANKS];
>>> +    struct tpm2_digest digests[0];
>>>       struct tcg_event_field event;
>>>   } __packed;
>>> -- 
>>> 2.17.1
>>>
>>
>> NAK for the same reason as last time.
> 
> I added this comment to include/linux/tpm_eventlog.h:
> 
> /*
>   * http://www.trustedcomputinggroup.org/tcg-efi-protocol-specification/
>   *
>   * Set the size of 'digest_sizes' and 'digests', members of 
> tcg_efi_specid_event
>   * and tcg_pcr_event2, to zero. Structures with variable-sized arrays 
> placed
>   * midway are not suitable for type casting.
>   */
> 

If this comment is ok, I will send a new version of the patch set.

Roberto


>> /Jarkko
>>
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
