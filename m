Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1D1C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 17:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6286C2075B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 17:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN8evliZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6286C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeIIV42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 17:56:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36334 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeIIV41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 17:56:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id r69-v6so35920291oie.3;
        Sun, 09 Sep 2018 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g0rImkJbXK/2u4pnCxl8vbZIf3rx6dl/B9QfOyt759U=;
        b=hN8evliZzqG21U4D2PRe06pm+i50O4LxVCILWQS7TjReVdPdv3L9RBnqa/XxPnnfcw
         1O0exvMSQfJ2G2yXvhrNyNXg8/GgVGqy3Yz0y5/PWOu2YbGFsaLHAOz+0/n6dMMywpiE
         BsMVlsdh8ENmByvTl3BsXg1ea3yBbLSaYN5Nkw+D/bDvGIHMStpFanzPu8NcUH4+8So5
         v/CfXZMFX5YufPTFOzawCJMljSQhHza1GmPby1yE7+7Cq2Q05hrfQotsOB8QOLhCuLU5
         AwBYbfawepLXpkQ+/meLud28ZPlNcesCls+7YjkzOjPkxatIY8i3HMqV3n2hH+E+P96v
         jGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g0rImkJbXK/2u4pnCxl8vbZIf3rx6dl/B9QfOyt759U=;
        b=meVENQ0W21Gld898i/j7bHPFgr8VmSgt4jIOOjKuMq1qT5h4NN9SyD/5V9WNSl5wL9
         +uOMk3yhjkjaRfK8n/0ZToZQNmg+swTIQi6Np1NIpKI2JgFyXTKM67Vxp4HFIR3SkFQE
         6lSs8a2dGSfsgWpPzlJ/KAttcd3/3ijR6oDdrp0UCAzIKWuV1KmPTU/sFgsqADakI7xv
         lXpGjhcyanbYacv/z8WyRwjntq2MUeSnUrBOVtdhBmTCatOOUWD5RR7koPXDehD04L0+
         Wdxrl3Np6OIW5bxh9idJmbtT9tcBINLY7P653zOn6m7Hlb9ETX1ab5HQQWAc9Lw3c0og
         pyhQ==
X-Gm-Message-State: APzg51BQ0wiR0sQqsua7e+e4raurxfqLUYVez/vMi3TQpRgNJtjww/ov
        c3zVvQT+x/lYnpL2NG5YHcmoLVCl
X-Google-Smtp-Source: ANB0VdaFCP2Yzr8N0Bgrt697vTjyONKbZaedmXVw0Kp00A3oR54M6akZhq8O6tyPm1sppPrneLtJKQ==
X-Received: by 2002:a54:4d9d:: with SMTP id y29-v6mr18675921oix.273.1536512769854;
        Sun, 09 Sep 2018 10:06:09 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p15-v6sm7636175oip.6.2018.09.09.10.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 10:06:09 -0700 (PDT)
Subject: Re: [PATCH 4.4 41/43] x86/mm/pat: Make set_memory_np() L1TF safe
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Hocko <mhocko@suse.cz>
Cc:     stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180814171517.014285600@linuxfoundation.org>
 <20180814171519.769320295@linuxfoundation.org>
 <1536511561.3024.115.camel@codethink.co.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5438e0f8-f5e0-99ef-fbdd-b5f4a079f254@roeck-us.net>
Date:   Sun, 9 Sep 2018 10:06:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536511561.3024.115.camel@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2018 09:46 AM, Ben Hutchings wrote:
> On Tue, 2018-08-14 at 19:18 +0200, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Andi Kleen <ak@linux.intel.com>
>>
>> commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream
> [...]
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -378,12 +378,39 @@ static inline pmd_t pfn_pmd(unsigned lon
>>>   	return __pmd(pfn | massage_pgprot(pgprot));
>>   }
>>   
>> +static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
>> +{
>> +	phys_addr_t pfn = page_nr << PAGE_SHIFT;
>> +	pfn ^= protnone_mask(pgprot_val(pgprot));
>> +	pfn &= PHYSICAL_PUD_PAGE_MASK;
>> +	return __pud(pfn | massage_pgprot(pgprot));
>> +}
> [...]
> 
> This (and the backport to 4.9) are missing the fix from commit
> e14d7dfb41f5 "x86/speculation/l1tf: Fix up pte->pfn conversion for
> PAE", as that was applied earlier in the series.  But since PAE implies
> only 3-level paging I don't know how the PUD functions get used or
> whether this actually matters.
> 
Excellent find.

e14d7dfb41f5 (re-)applies cleanly to both 4.4.y and 4.9.y. Since most of its
changes are already applied, the only remaining change is

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index c535012bdb56..5736306bdaab 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -420,7 +420,7 @@ static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)

  static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
  {
-       phys_addr_t pfn = page_nr << PAGE_SHIFT;
+       phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
         pfn ^= protnone_mask(pgprot_val(pgprot));
         pfn &= PHYSICAL_PUD_PAGE_MASK;
         return __pud(pfn | massage_pgprot(pgprot));

after cherry-picking it into both branches.

I think we should re-apply it to both 4.4.y and 4.9.y be on the safe side.

Thanks,
Guenter
