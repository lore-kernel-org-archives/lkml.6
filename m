Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E032C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2483623E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HNW1rU2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2483623E5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932133AbeF0Xs5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:48:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932068AbeF0Xsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ucy7nMzedmnMqbA2yf9rk1Za77JYGQcK2CzmrWW4MsA=; b=HNW1rU2CnrEuY3uJ7HU9OrBQm
        QAtcDzDdquOt/yajJxVACCHlC3LW5sGY1VQ1eWopCmsQZ2yEulAhaUVUBZFobfR/Ge/hWIhNwp/se
        I8+z88HotSgy7uWhWugmKKWMDEuR0ZT2wD+I6v0NLx2YEQY9aw3sFrHmmUFxQ9FpH1vYjLpg4W0Nm
        VG5OZ3xcrvTJwpqH5o/uPCKt35iX3dcTwLCFeMac0Rov/UvlDM9VcQPOS0Zw15WquSocelqqn/sDa
        vtMJi9jXI8ITStTs/rLE2uVA4hWINT+QwhXaa82AvY3eFmMy6afSpCFf25iSEyYvmOTUvxCOUk6OT
        z7Zu93RgA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYKBB-00039X-VO; Wed, 27 Jun 2018 23:48:54 +0000
Subject: Re: [PATCHv4 18/18] x86: Introduce CONFIG_X86_INTEL_MKTME
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-19-kirill.shutemov@linux.intel.com>
 <ecf92475-93b4-295c-f1fc-7efba4843d98@infradead.org>
 <20180627215726.l5syzdcc26hgihtt@black.fi.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3a284a7a-821e-f539-0fe8-90f35cd8ff08@infradead.org>
Date:   Wed, 27 Jun 2018 16:48:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627215726.l5syzdcc26hgihtt@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/2018 02:57 PM, Kirill A. Shutemov wrote:
> On Tue, Jun 26, 2018 at 05:30:12PM +0000, Randy Dunlap wrote:
>> On 06/26/2018 07:22 AM, Kirill A. Shutemov wrote:
>>> Add new config option to enabled/disable Multi-Key Total Memory
>>> Encryption support.
>>>
>>> MKTME uses MEMORY_PHYSICAL_PADDING to reserve enough space in per-KeyID
>>> direct mappings for memory hotplug.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> ---
>>>  arch/x86/Kconfig | 19 ++++++++++++++++++-
>>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index fa5e1ec09247..9a843bd63108 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -1523,6 +1523,23 @@ config ARCH_USE_MEMREMAP_PROT
>>>  	def_bool y
>>>  	depends on AMD_MEM_ENCRYPT
>>>  
>>> +config X86_INTEL_MKTME
>>> +	bool "Intel Multi-Key Total Memory Encryption"
>>> +	select DYNAMIC_PHYSICAL_MASK
>>> +	select PAGE_EXTENSION
>>> +	depends on X86_64 && CPU_SUP_INTEL
>>> +	---help---
>>> +	  Say yes to enable support for Multi-Key Total Memory Encryption.
>>> +	  This requires an Intel processor that has support of the feature.
>>> +
>>> +	  Multikey Total Memory Encryption (MKTME) is a technology that allows
>>> +	  transparent memory encryption in and upcoming Intel platforms.
>>
>> huh?  Maybe drop the "and"?
> 
> Ugh.. It has to be "an".

an ... platform.
or
in upcoming Intel platforms.


-- 
~Randy
