Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD53C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B8921B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440222AbfBNVcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:32:10 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:46044 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392871AbfBNVcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:32:08 -0500
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1ELQhpY005571;
        Thu, 14 Feb 2019 21:31:51 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qnedr8uhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 21:31:51 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 9A8B070;
        Thu, 14 Feb 2019 21:31:50 +0000 (UTC)
Received: from [16.214.130.214] (unknown [16.214.130.214])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 094314B;
        Thu, 14 Feb 2019 21:31:48 +0000 (UTC)
Subject: Re: [Patch v3 0/4] Protect against concurrent calls into UV BIOS
To:     Dimitri Sivanich <sivanich@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        x86@kernel.org, Russ Anderson <rja@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, stable@vger.kernel.org
References: <20190213193413.25560-1-hedi.berriche@hpe.com>
 <20190214212149.GB5073@hpe.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <6d2c7655-a8f4-e2ef-1479-f43e707c6a86@hpe.com>
Date:   Thu, 14 Feb 2019 13:31:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214212149.GB5073@hpe.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2019 1:21 PM, Dimitri Sivanich wrote:
> For the series:
> 
> Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>

As well as I:

Reviewed-by: Mike Travis <mike.travis@hpe.com>

> 
> On Wed, Feb 13, 2019 at 07:34:09PM +0000, Hedi Berriche wrote:
>> - Changes since v2
>>    Addressed comments from Ard Biesheuvel:
>>   * expose efi_runtime_lock to UV platform only instead of globally
>>   * remove unnecessary #ifdef CONFIG_EFI from bios_uv.c
>>
>> - Changes since v1:
>>    Addressed comments from Bhupesh Sharma, Thomas Gleixner, and Ard Biesheuvel:
>>   * made __uv_bios_call() static
>>   * moved the efi_enabled() cleanup to its own patchlet
>>   * explained the reason for renaming the efi_runtime_lock semaphore
>>   * dropped the reviewed-bys as they should be given on the mailing list
>>   * Cc'ng stable@vger.kernel.org given the nature of the problem addressed by the patches
>>
>> ---
>>
>> Calls into UV BIOS were not being serialised which is wrong as it violates EFI
>> runtime rules, and bad as it does result in all sorts of potentially hard to
>> track down hangs and panics when efi_scratch.prev_mm gets clobbered whenever
>> efi_switch_mm() gets called concurrently from two different CPUs.
>>
>> Patch #1 removes an unnecessary #ifdef CONFIG_EFI guard from bios_uv.c.
>>
>> Patch #2 removes uv_bios_call_reentrant() because it's dead code.
>>
>> Patch #3 is a cleanup that drops test_bit() in favour of the ad hoc efi_enabled().
>>
>> Patch #4 makes uv_bios_call() variants use the efi_runtime_lock semaphore to
>> protect against concurrency.
>>
>> Cc: Russ Anderson <rja@hpe.com>
>> Cc: Mike Travis <mike.travis@hpe.com>
>> Cc: Dimitri Sivanich <sivanich@hpe.com>
>> Cc: Steve Wahl <steve.wahl@hpe.com>
>> Cc: stable@vger.kernel.org # v4.9+
>>
>> Hedi Berriche (4):
>>    x86/platform/UV: remove unnecessary #ifdef CONFIG_EFI
>>    x86/platform/UV: kill uv_bios_call_reentrant() as it has no callers
>>    x86/platform/UV: use efi_enabled() instead of test_bit()
>>    x86/platform/UV: use efi_runtime_lock to serialise BIOS calls
>>
>>   arch/x86/include/asm/uv/bios.h          | 13 ++++-----
>>   arch/x86/platform/uv/bios_uv.c          | 35 ++++++++++++++-----------
>>   drivers/firmware/efi/runtime-wrappers.c |  7 +++++
>>   3 files changed, 34 insertions(+), 21 deletions(-)
>>
>> -- 
>> 2.20.1
>>
