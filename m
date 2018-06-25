Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E00261C7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E00261C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754591AbeFYWSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:18:51 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:59760 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752155AbeFYWSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:18:49 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fXZoq-0006z1-TZ; Tue, 26 Jun 2018 00:18:44 +0200
Subject: Re: [PATCH 2/2] x86/microcode/AMD: Check patch size for all known CPU
 families
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
 <39d0efb50538e4a1a06da693559bb13b060ad676.1529424596.git.mail@maciej.szmigiero.name>
 <20180621083649.GC12742@zn.tnic>
 <a2275167-f650-b73f-0de8-1aa78b3281ed@maciej.szmigiero.name>
 <20180625183709.GA3024@zn.tnic>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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
Message-ID: <04535fd8-0641-2bf3-5764-2efd997445b6@maciej.szmigiero.name>
Date:   Tue, 26 Jun 2018 00:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625183709.GA3024@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.2018 20:37, Borislav Petkov wrote:
(..)
>> +		break;
>>  	case 0x14:
>>  		max_size = F14H_MPB_MAX_SIZE;
>>  		break;
>> @@ -251,22 +239,41 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size,
>>  		max_size = F17H_MPB_MAX_SIZE;
>>  		break;
>>  	default:
>> -		max_size = F1XH_MPB_MAX_SIZE;
>> +		/*
>> +		 * Don't know the max size for future families...
>> +		 * Set a patch length limit of slightly less than U32_MAX to
>> +		 * prevent overflowing 32-bit variables holding the whole
>> +		 * patch section size.
>> +		 */
>> +		max_size = U32_MAX - SECTION_HDR_SIZE;
> 
> No, just do a WARN_ON_ONCE here.

So you want to have just WARN_ON_ONCE and no max_size (or fam_size) check
in such case of an unknown family number?

We still need to cap patch_size at that default case above value (or less)
so adding the section header size later won't overflow.

> 
>>  		break;
>>  	}
>>  
>> -	/*
>> -	 * The section header length is not included in this indicated size
>> -	 * but is present in the leftover file length so we need to subtract
>> -	 * it from the leftover file length.
>> -	 */
>> -	if (patch_size > min_t(u32, buf_size - SECTION_HDR_SIZE, max_size)) {
>> +	if (patch_size > max_size) {
>> +		if (!early)
>> +			pr_err("Patch of size %u exceeds family %u maximum.\n",
>> +			       patch_size, (unsigned int)patch_fam);
>> +
>> +		*crnt_size = min_t(unsigned int,
>> +				   SECTION_HDR_SIZE + max_size,
>> +				   buf_size);
>> +		return false;
>> +	}
>> +
>> +	if (buf_size - SECTION_HDR_SIZE < patch_size) {
>>  		if (!early)
>> -			pr_err("Patch of size %u too large.\n", patch_size);
>> +			pr_err("Patch of size %u truncated.\n", patch_size);
>>  
>> +		*crnt_size = buf_size;
>>  		return false;
>>  	}
>>  
>> +	*crnt_size = SECTION_HDR_SIZE + patch_size;
>> +
>> +	/* Is the patch for the proper CPU family? */
>> +	if (family != patch_fam)
>> +		return false;
> 
> Why are you moving the family check down?
> 
> What it should do instead is the moment it knows the family, check
> whether they're equal. If not, skip over with minimum of the size of the
> corresponding patch_fam and buf_size.
> 
> And then you do all the remaining checks.
> 

Previously the family check was done before computing patch_fam so the
biggest component of the move was jumping over past that computation
(which we have to do anyway to know how many bytes to skip).

Moving the family check further down past these two last checks visible
in the patch hunk above allows us to:
1) Produce an error message that the indicated patch size exceeds family
maximum - for CPU families other that the currently running one.

This is useful in case the patch actually should be of that indicated
size - for some reason - since in this case by skipping over a smaller
length we will end in the middle of a patch and so we'll produce a
bunch of error messages about invalid patch section type field, etc.,
until the driver finally resynchronizes on the next section boundary.

2) In case the last patch (for another family) was truncated a proper
diagnostic message would be printed instead of the patch being skipped
silently.

Maciej
