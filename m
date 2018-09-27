Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212ACC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F882170B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="bKdvhgjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F882170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeI1Ahz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:37:55 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:58640 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeI1Ahy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:37:54 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 20:37:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=843; q=dns/txt; s=iport;
  t=1538072304; x=1539281904;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cAG8rOD6AL/BWLmyRIVLF6FwD6JtQPyY8cfvn+rw6AM=;
  b=bKdvhgjhNsXt2H7YX/D3la59e1xBHCPEees8+Gg2amy7XUl3j2ANaARB
   ReqP2+I5nIbzXt4DjcRI7vwvZGEBR5ggqeMG2RJm8KW1052EZ6u58jrKX
   yIegtDqP088IZoCQn4rXOkpsK7ExUbXsI7YVJtJsGkE7/AY7afusLFXhZ
   c=;
X-IronPort-AV: E=Sophos;i="5.54,311,1534809600"; 
   d="scan'208";a="461535457"
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 18:08:56 +0000
Received: from [10.24.65.89] ([10.24.65.89])
        by alln-core-10.cisco.com (8.15.2/8.15.2) with ESMTP id w8RI8pMg000694;
        Thu, 27 Sep 2018 18:08:54 GMT
Subject: Re: [PATCH 0/8] add generic builtin command line
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Maksym Kokhan <maksym.kokhan@globallogic.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Walker <dwalker@fifo99.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <CAKv+Gu-AxtOO04iwPSri12tkb9NRugXV9E2LGrfJT-LJjf4_ow@mail.gmail.com>
From:   Daniel Walker <danielwa@cisco.com>
Message-ID: <3320a561-2287-63f7-2162-84a639a22a8a@cisco.com>
Date:   Thu, 27 Sep 2018 11:08:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-AxtOO04iwPSri12tkb9NRugXV9E2LGrfJT-LJjf4_ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Outbound-SMTP-Client: 10.24.65.89, [10.24.65.89]
X-Outbound-Node: alln-core-10.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 10:05 AM, Ard Biesheuvel wrote:
> On 27 September 2018 at 18:55, Maksym Kokhan
> <maksym.kokhan@globallogic.com> wrote:
>> There were series of patches [1] for 4.3.0-rc3, that allowed
>> architectures to use a generic builtin command line. I have rebased
>> these patches on kernel 4.19.0-rc4.
>>
> 
> Could you please elaborate on the purpose of this series? Is it simply
> to align between architectures? Does it solve an actual problem?

1) It removed a lot of code duplication between architecture

2) At Cisco we have issues where our bootloaders having default boot 
arguments. Some platforms we can't update the boot loader and it's 
helpful to be able to have boot arguments which are prepended to the 
bootloader arguments , and some parameters which are appended. These 
changes allow that.

Daniel
