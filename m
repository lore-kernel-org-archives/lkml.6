Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F0996C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B152520891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B152520891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934574AbeFMJrE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:47:04 -0400
Received: from ozlabs.org ([203.11.71.1]:37719 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750939AbeFMJrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:47:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 415MNM0cL0z9rxs;
        Wed, 13 Jun 2018 19:46:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laura Abbott <labbott@redhat.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Andy Lutomirski <luto@kernel.org>,
        mjw@fedoraproject.org, "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCHv4 1/3] scripts: Preprocess module-common.lds
In-Reply-To: <1d6bf671-ec88-2d04-065c-96045759c680@redhat.com>
References: <20180612003224.3658-2-labbott@redhat.com> <201806120915.NeKL1aUj%fengguang.wu@intel.com> <8736xsv8w3.fsf@concordia.ellerman.id.au> <1d6bf671-ec88-2d04-065c-96045759c680@redhat.com>
Date:   Wed, 13 Jun 2018 19:46:57 +1000
Message-ID: <87y3fjrpbi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laura Abbott <labbott@redhat.com> writes:
> On 06/11/2018 11:03 PM, Michael Ellerman wrote:
>> kbuild test robot <lkp@intel.com> writes:
...
>>> All errors (new ones prefixed by >>):
>>>
>>>>> ld: cannot open linker script file scripts/module-common.lds: No such file or directory
>> 
>> This seems to need the following.
>> 
>> diff --git a/Makefile b/Makefile
>> index 73f0bb2c7a98..55a5725b6606 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -425,7 +425,7 @@ KBUILD_AFLAGS_KERNEL :=
>>   KBUILD_CFLAGS_KERNEL :=
>>   KBUILD_AFLAGS_MODULE  := -DMODULE
>>   KBUILD_CFLAGS_MODULE  := -DMODULE
>> -KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
>> +KBUILD_LDFLAGS_MODULE := -T $(objtree)/scripts/module-common.lds
>>   LDFLAGS :=
>>   GCC_PLUGINS_CFLAGS :=
>
> Thanks for pointing that out. I think I missed that when refactoring.
> I'll fix that in the next version plus adding your powerpc patch.

Thanks.

cheers
