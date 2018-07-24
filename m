Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120E4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED7F20844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED7F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbeGXSSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:18:33 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:47423 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbeGXSSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:18:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 0CFE5217D0;
        Tue, 24 Jul 2018 17:11:05 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id letNZcnudMnF; Tue, 24 Jul 2018 17:11:05 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id C9F58217F7;
        Tue, 24 Jul 2018 17:10:43 +0000 (UTC)
Subject: Re: [PATCH v4] selftests: add headers_install to lib.mk
To:     Anders Roxell <anders.roxell@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Bamvor Zhang <bamv2005@gmail.com>, brgl@bgdev.pl,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, aarcange@redhat.com
Cc:     linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20180413090351.25662-1-anders.roxell@linaro.org>
 <20180607110911.12252-1-anders.roxell@linaro.org>
 <CADYN=9J=hSFb2wCZ1+dXL=023p9y05MEGUPvH48WfPX7XDZvwQ@mail.gmail.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <f222aa8d-88b8-140c-30ed-83fd908bfd09@kernel.org>
Date:   Tue, 24 Jul 2018 11:10:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADYN=9J=hSFb2wCZ1+dXL=023p9y05MEGUPvH48WfPX7XDZvwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 02:49 PM, Anders Roxell wrote:
> On Thu, 7 Jun 2018 at 13:09, Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> If the kernel headers aren't installed we can't build all the tests.
>> Add a new make target rule 'khdr' in the file lib.mk to generate the
>> kernel headers and that gets include for every test-dir Makefile that
>> includes lib.mk If the testdir in turn have its own sub-dirs the
>> top_srcdir needs to be set to the linux-rootdir to be able to generate
>> the kernel headers.
>>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
>> ---
>>  Makefile                                           | 14 +-------------
>>  scripts/subarch.include                            | 13 +++++++++++++
>>  tools/testing/selftests/android/Makefile           |  2 +-
>>  tools/testing/selftests/android/ion/Makefile       |  2 ++
>>  tools/testing/selftests/futex/functional/Makefile  |  1 +
>>  tools/testing/selftests/gpio/Makefile              |  7 ++-----
>>  tools/testing/selftests/kvm/Makefile               |  7 ++-----
>>  tools/testing/selftests/lib.mk                     | 12 ++++++++++++
>>  tools/testing/selftests/net/Makefile               |  1 +
>>  .../selftests/networking/timestamping/Makefile     |  1 +
>>  tools/testing/selftests/vm/Makefile                |  4 ----
>>  11 files changed, 36 insertions(+), 28 deletions(-)
>>  create mode 100644 scripts/subarch.include
>>
>> diff --git a/Makefile b/Makefile
>> index 6b9aea95ae3a..8050072300fa 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -286,19 +286,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
>>  KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
>>  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
>>
>> -# SUBARCH tells the usermode build what the underlying arch is.  That is set
>> -# first, and if a usermode build is happening, the "ARCH=um" on the command
>> -# line overrides the setting of ARCH below.  If a native build is happening,
>> -# then ARCH is assigned, getting whatever value it gets normally, and
>> -# SUBARCH is subsequently ignored.
>> -
>> -SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
>> -                                 -e s/sun4u/sparc64/ \
>> -                                 -e s/arm.*/arm/ -e s/sa110/arm/ \
>> -                                 -e s/s390x/s390/ -e s/parisc64/parisc/ \
>> -                                 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
>> -                                 -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
>> -                                 -e s/riscv.*/riscv/)
>> +include scripts/subarch.include

What is the reason for this SUBARCH block move to to scripts/subarch.include?
Is this necessary for adding headers install dependency to lib.mk?


>>
>>  # Cross compiling and selecting different set of gcc/bin-utils
>>  # ---------------------------------------------------------------------------
>> diff --git a/scripts/subarch.include b/scripts/subarch.include
>> new file mode 100644
>> index 000000000000..650682821126
>> --- /dev/null
>> +++ b/scripts/subarch.include
>> @@ -0,0 +1,13 @@
>> +# SUBARCH tells the usermode build what the underlying arch is.  That is set
>> +# first, and if a usermode build is happening, the "ARCH=um" on the command
>> +# line overrides the setting of ARCH below.  If a native build is happening,
>> +# then ARCH is assigned, getting whatever value it gets normally, and
>> +# SUBARCH is subsequently ignored.
>> +
>> +SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
>> +                                 -e s/sun4u/sparc64/ \
>> +                                 -e s/arm.*/arm/ -e s/sa110/arm/ \
>> +                                 -e s/s390x/s390/ -e s/parisc64/parisc/ \
>> +                                 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
>> +                                 -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
>> +                                 -e s/riscv.*/riscv/)

thanks,
-- Shuah

