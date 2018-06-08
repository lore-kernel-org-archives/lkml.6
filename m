Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mC8jKYNFGlvDDgAAmS7hNA
	; Fri, 08 Jun 2018 08:59:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 49FD06089E; Fri,  8 Jun 2018 08:59:57 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxz3qZ5i"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A980B605A5;
	Fri,  8 Jun 2018 08:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A980B605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbeFHI7x (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:59:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40030 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeFHI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:59:50 -0400
Received: by mail-pl0-f67.google.com with SMTP id t12-v6so7909974plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=4uBFP2hS65FbtUc3YZ5P/sJMZzF6S3m1oX1+dLdnPwU=;
        b=gxz3qZ5i4nd9DW3NkqovUsA5H86Vs1CGWz2+jclcpo5CT7eM7Ieu4Lub//SfFIjAik
         G76FP9MbSxsYYbdKFdaHp1C7VmgvyxxQah76s4pXbmpkZcIGmJ1pRrF0ZcWWcYYoqNOo
         iTAshy3OcxGiLKtZcWmo9Mr9VBDNi+dD8YNQVKJQsRVr1WiMTWGlz6lvIxXBDaTIb7Lw
         cYpNMyisAjtPXTZrrra50ZnHK0jc3gjAKPtvmrIPf5y7IT1LGK4+/XOy9DupDgvZGYc8
         keIfdoYOI9/iRKXvBWBXV2Xv2DhegCusoO8mfM2fDSWhOovbnR6fdC6+qARnWP98euwa
         ys7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=4uBFP2hS65FbtUc3YZ5P/sJMZzF6S3m1oX1+dLdnPwU=;
        b=oR8nTqmCVUd86uAM4o3bq75acCiS+ZW9k1fz8owy7kONR89c+4sTnjXmg1Ewcjwyby
         HA7LqOT1jhs/jYPsn2RXS34RRSd79ooPatdMPo4jftqOn+65JuyI+cY7s20vdzDX9R8S
         OLHkt7LckgebT3mD6vE++7M9cA2yJ3T4cyOn93sDqK36pRIt1lNrX2unxjjMkdSHoed/
         ijvSBqvQPDHtjE/7bSHpC9f4J7PJmcIKKXY9c7nBCi9S3i8yE4fBkLtJfhcyyUOLikRU
         ylwpGhHfPPR0LdATb8iC7qU/ulesA8CDoPyHy29pusXsJsv0nR/LMjpdHk7juHrxSNMn
         Brvw==
X-Gm-Message-State: APt69E2hz8V+SXEqrdHug/c1SdH41956V4jyMw/2/xVMTx5d//JcUUBG
        PBTzbDo5QtC6jN/dlJw9Ajw=
X-Google-Smtp-Source: ADUXVKLEFQmHKZA5QyH/eGwWchOIG3xn+1DM7HfsYtz2DraSFRdaSNZ/XMWritZtfF/wNT58tRkzyA==
X-Received: by 2002:a17:902:7c84:: with SMTP id y4-v6mr5805502pll.262.1528448390005;
        Fri, 08 Jun 2018 01:59:50 -0700 (PDT)
Received: from [0.0.0.0] (67.216.217.169.16clouds.com. [67.216.217.169])
        by smtp.gmail.com with ESMTPSA id d88-v6sm45059475pfb.43.2018.06.08.01.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 01:59:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] KVM: arm/arm64: harden unmap_stage2_ptes in case
 end is not PAGE_SIZE aligned
To: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Suzuki.Poulose@arm.com, linux-kernel@vger.kernel.org,
        jia.he@hxt-semitech.com
References: <1526635630-18917-1-git-send-email-hejianet@gmail.com>
 <1526635630-18917-2-git-send-email-hejianet@gmail.com>
 <2185a61e-c157-e177-9bad-83b6f27fd784@arm.com>
 <50c98169-1606-48bf-0489-124adefd2a54@gmail.com>
 <20180608083414.GA5097@C02W217FHV2R.local>
From: Jia He <hejianet@gmail.com>
Message-ID: <42df5a9e-23bc-79ac-3d10-66da9f05c0ca@gmail.com>
Date: Fri, 8 Jun 2018 16:59:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608083414.GA5097@C02W217FHV2R.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoffer
I ever sent out the v3 patch set with the single patch 1/2
[link] https://patchwork.kernel.org/patch/10413803/
Sorry,I ping-ed the wrong mail thread ;-).

Cheers,
Jia

On 6/8/2018 4:34 PM, Christoffer Dall Wrote:
> On Fri, May 18, 2018 at 09:04:40PM +0800, Jia He wrote:
>>
>>
>> On 5/18/2018 5:48 PM, Marc Zyngier Wrote:
>>> On 18/05/18 10:27, Jia He wrote:
>>>> If it passes addr=0x202920000,size=0xfe00 to unmap_stage2_range->
>>>> ...->unmap_stage2_ptes, unmap_stage2_ptes will get addr=0x202920000,
>>>> end=0x20292fe00. After first while loop addr=0x202930000, end=0x20292fe00,
>>>> then addr!=end. Thus it will touch another pages by put_pages() in the
>>>> 2nd loop.
>>>>
>>>> This patch fixes it by hardening the break condition of while loop.
>>>>
>>>> Signed-off-by: jia.he@hxt-semitech.com
>>>> ---
>>>> v2: newly added
>>>>
>>>>  virt/kvm/arm/mmu.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>>> index 8dac311..45cd040 100644
>>>> --- a/virt/kvm/arm/mmu.c
>>>> +++ b/virt/kvm/arm/mmu.c
>>>> @@ -217,7 +217,7 @@ static void unmap_stage2_ptes(struct kvm *kvm, pmd_t *pmd,
>>>>  
>>>>  			put_page(virt_to_page(pte));
>>>>  		}
>>>> -	} while (pte++, addr += PAGE_SIZE, addr != end);
>>>> +	} while (pte++, addr += PAGE_SIZE, addr < end);
>>>>  
>>>>  	if (stage2_pte_table_empty(start_pte))
>>>>  		clear_stage2_pmd_entry(kvm, pmd, start_addr);
>>>>
>>>
>>> I don't think this change is the right thing to do. You get that failure
>>> because you're being passed a size that is not a multiple of PAGE_SIZE.
>>> That's the mistake.
>>>
>>> You should ensure that this never happens, rather than changing the page
>>> table walkers (which are consistent with the way this kind of code is
>>> written in other places of the kernel). As you mentioned in your first
>>> patch, the real issue is that KSM is broken, and this is what should be
>>> fixed.
>>>
>> Got it, thanks
>> Should I resend the patch 1/2 without any changes after droping patch 2/2?
>>
> 
> That's fine if you trim the commit message to make it look nicer.
> 
> Also, in the future, please include a cover letter if you send more than
> one patch to the list.
> 
> Thanks,
> -Christoffer
> 
