Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DE9C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5402F205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="FwenmNBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5402F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=runbox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeGVQzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:55:10 -0400
Received: from aibo.runbox.com ([91.220.196.211]:56144 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbeGVQzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=rbselector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject;
        bh=Yh6DNV5D3nYX3NDB0gm2gMvBguLVMLqONxLWyoB6kwY=; b=FwenmNBIeTcFXvvRox6SpEf6GA
        OpbZ4XCFKZVDWawgrFhbHt1zMPPyXolGboO2Bq1ojXzi1NcOoe00NwgnuOfF5FMBKxSUUfm3NZsb1
        Bg5yDfh9gwezqM3hW/Fq8ICpCW3vUUoY9R1M+jADQWAaz5cHI1JHLnewOkgdwLMPrc+x7arPcv4rj
        HTnme0oX7V6+Bi68WmNIjNn7XO0jQh9uKQ69q+Ld4CLKR9IyzlxpMoW5gsqQcYTIE3iZ9hz+24KrE
        3/te/lZ+54nOBmjg1QOS2Tusxgb03nN8jbdxZBwnFGuTr29kPOHttr/WllPKtykjkRIQFb3SZyIRv
        vUIT/vfw==;
Received: from [10.9.9.212] (helo=mailfront12.runbox.com)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1fhGk5-0003em-Ms; Sun, 22 Jul 2018 17:57:53 +0200
Received: by mailfront12.runbox.com with esmtpsa  (uid:769847 )  (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        id 1fhGjy-0005XQ-G6; Sun, 22 Jul 2018 17:57:46 +0200
Subject: Re: [PATCH 2/2] xen/pv: Call get_cpu_address_sizes to set
 x86_virt/phys_bits
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        stable@vger.kernel.org
References: <20180721194909.23903-1-m.v.b@runbox.com>
 <20180721194909.23903-2-m.v.b@runbox.com>
 <90bc371d-a296-51b3-8b78-62106c9690de@oracle.com>
 <d85c93da-4549-a7c1-af48-9c62cba8ae71@runbox.com>
Message-ID: <13b774d7-bc8c-039a-fbc0-52318f535883@runbox.com>
Date:   Sun, 22 Jul 2018 11:57:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d85c93da-4549-a7c1-af48-9c62cba8ae71@runbox.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/2018 07:17 PM, M. Vefa Bicakci wrote:
> On 07/21/2018 05:25 PM, Boris Ostrovsky wrote:
>> On 07/21/2018 03:49 PM, M. Vefa Bicakci wrote:
>>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>>> index 439a94bf89ad..87afb000142a 100644
>>> --- a/arch/x86/xen/enlighten_pv.c
>>> +++ b/arch/x86/xen/enlighten_pv.c
>>> @@ -1257,6 +1257,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
>>>       /* Work out if we support NX */
>>>       get_cpu_cap(&boot_cpu_data);
>>> +    get_cpu_address_sizes(&boot_cpu_data);
>>>       x86_configure_nx();
>>
>>
>> Have you observed any problems without this call? get_cpu_cap() is only
>> called here to set X86_FEATURE_NX, and is then called again, together
>> with get_cpu_address_sizes(), from early_identify_cpu().
> 
> Thank you for the reviews! Without the call to get_cpu_address_sizes,
> paravirtualized virtual machines do not boot up kernels with versions
> 4.17 and up at all; this includes dom0 and domU. No domU logs are
> generated in dom0's /var/log/xen/console/ directory either, despite
> having earlyprintk=xen on the kernel command line for my test domU.

Hello Boris,

I debugged this further with a debugging version of Xen (so that I can
get early kernel print-outs via the "xen_raw_console_write" function),
and I found the root cause of the boot up failure.

In summary, the issue is due to the following call path in version
4.17 (and higher, I assume), which the kernel goes through /only/ when
CONFIG_DEBUG_VIRTUAL is enabled:

enlighten_pv.c::xen_start_kernel
   mmu_pv.c::xen_reserve_special_pages
     page.h::__pa
       physaddr.c::__phys_addr
         physaddr.h::phys_addr_valid // uses boot_cpu_data.x86_phys_bits

The return value of phys_addr_valid is used with the VIRTUAL_BUG_ON macro,
which evaluates to BUG_ON in case CONFIG_DEBUG_VIRTUAL is enabled.

It looks like the call to get_cpu_address_size is required in the
xen_start_kernel function. Perhaps there is a more elegant way to
resolve this issue as well.

Another approach could be to check in the phys_addr_valid function whether
boot_cpu_data.x86_phys_bits has been initialized or not, I think, but I am
not sure about the correctness of this approach.

Thank you,

Vefa
