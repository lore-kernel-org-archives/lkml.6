Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31E1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B079A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B079A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbeGXQxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:53:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:35536 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388300AbeGXQxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:53:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 08:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,398,1526367600"; 
   d="scan'208";a="242919380"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.93])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2018 08:46:06 -0700
Subject: Re: [PATCH v6 11/13] x86/mm/pat: Prepare {reserve, free}_memtype()
 for "decoy" addresses
To:     Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, linux-nvdimm@lists.01.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, hch@lst.de,
        linux-edac@vger.kernel.org
References: <153154376846.34503.15480221419473501643.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153154382700.34503.10197588570935341739.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180724073641.GA15984@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.jiang@intel.com; prefer-encrypt=mutual; keydata=
 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
 o6nmKbYpUAltQObU2w==
Message-ID: <896ea559-8fe5-9b2a-e763-407fae55cc01@intel.com>
Date:   Tue, 24 Jul 2018 08:46:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180724073641.GA15984@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/24/2018 12:36 AM, Ingo Molnar wrote:
> 
> * Dan Williams <dan.j.williams@intel.com> wrote:
> 
>> In preparation for using set_memory_uc() instead set_memory_np() for
>> isolating poison from speculation, teach the memtype code to sanitize
>> physical addresses vs __PHYSICAL_MASK.
>>
>> The motivation for using set_memory_uc() for this case is to allow
>> ongoing access to persistent memory pages via the pmem-driver +
>> memcpy_mcsafe() until the poison is repaired.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: <linux-edac@vger.kernel.org>
>> Cc: <x86@kernel.org>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  arch/x86/mm/pat.c |   16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
>> index 1555bd7d3449..6788ffa990f8 100644
>> --- a/arch/x86/mm/pat.c
>> +++ b/arch/x86/mm/pat.c
>> @@ -512,6 +512,17 @@ static int free_ram_pages_type(u64 start, u64 end)
>>  	return 0;
>>  }
>>  
>> +static u64 sanitize_phys(u64 address)
>> +{
>> +	/*
>> +	 * When changing the memtype for pages containing poison allow
>> +	 * for a "decoy" virtual address (bit 63 clear) passed to
>> +	 * set_memory_X(). __pa() on a "decoy" address results in a
>> +	 * physical address with it 63 set.
>> +	 */
>> +	return address & __PHYSICAL_MASK;
> 
> s/it/bit

Thanks Ingo! I'll update when I pull in the patch.

> 
> Thanks,
> 
> 	Ingo
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
> 
