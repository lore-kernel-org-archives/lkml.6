Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B24C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EC921A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EC921A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeHFTOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:14:24 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50297 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeHFTOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:14:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id AAAE340EB9;
        Mon,  6 Aug 2018 17:04:22 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k-BD-Shx30nq; Mon,  6 Aug 2018 17:04:22 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id E35E040E79;
        Mon,  6 Aug 2018 17:04:01 +0000 (UTC)
Subject: Re: [PATCH v4] selftests: add headers_install to lib.mk
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Bamvor Zhang <bamv2005@gmail.com>, brgl@bgdev.pl,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, aarcange@redhat.com,
        linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20180413090351.25662-1-anders.roxell@linaro.org>
 <20180607110911.12252-1-anders.roxell@linaro.org>
 <CADYN=9J=hSFb2wCZ1+dXL=023p9y05MEGUPvH48WfPX7XDZvwQ@mail.gmail.com>
 <f222aa8d-88b8-140c-30ed-83fd908bfd09@kernel.org>
 <CADYN=9LSA60E4mFwrbeY-RGi4kZV6hO0ygz0-C6QB3+KKaoxQg@mail.gmail.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <3f332e65-0b33-9952-6aba-f9c8953a1f26@kernel.org>
Date:   Mon, 6 Aug 2018 11:03:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADYN=9LSA60E4mFwrbeY-RGi4kZV6hO0ygz0-C6QB3+KKaoxQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On 07/25/2018 10:08 AM, Anders Roxell wrote:
> On Tue, 24 Jul 2018 at 19:11, Shuah Khan <shuah@kernel.org> wrote:
>>
>> On 07/23/2018 02:49 PM, Anders Roxell wrote:
>>> On Thu, 7 Jun 2018 at 13:09, Anders Roxell <anders.roxell@linaro.org> wrote:
>>>>
>>>> If the kernel headers aren't installed we can't build all the tests.
>>>> Add a new make target rule 'khdr' in the file lib.mk to generate the
>>>> kernel headers and that gets include for every test-dir Makefile that
>>>> includes lib.mk If the testdir in turn have its own sub-dirs the
>>>> top_srcdir needs to be set to the linux-rootdir to be able to generate
>>>> the kernel headers.
>>>>
>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>>> Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
>>>> ---
>>>>  Makefile                                           | 14 +-------------
>>>>  scripts/subarch.include                            | 13 +++++++++++++
>>>>  tools/testing/selftests/android/Makefile           |  2 +-
>>>>  tools/testing/selftests/android/ion/Makefile       |  2 ++
>>>>  tools/testing/selftests/futex/functional/Makefile  |  1 +
>>>>  tools/testing/selftests/gpio/Makefile              |  7 ++-----
>>>>  tools/testing/selftests/kvm/Makefile               |  7 ++-----
>>>>  tools/testing/selftests/lib.mk                     | 12 ++++++++++++
>>>>  tools/testing/selftests/net/Makefile               |  1 +
>>>>  .../selftests/networking/timestamping/Makefile     |  1 +
>>>>  tools/testing/selftests/vm/Makefile                |  4 ----
>>>>  11 files changed, 36 insertions(+), 28 deletions(-)
>>>>  create mode 100644 scripts/subarch.include
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index 6b9aea95ae3a..8050072300fa 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -286,19 +286,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
>>>>  KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
>>>>  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
>>>>
>>>> -# SUBARCH tells the usermode build what the underlying arch is.  That is set
>>>> -# first, and if a usermode build is happening, the "ARCH=um" on the command
>>>> -# line overrides the setting of ARCH below.  If a native build is happening,
>>>> -# then ARCH is assigned, getting whatever value it gets normally, and
>>>> -# SUBARCH is subsequently ignored.
>>>> -
>>>> -SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
>>>> -                                 -e s/sun4u/sparc64/ \
>>>> -                                 -e s/arm.*/arm/ -e s/sa110/arm/ \
>>>> -                                 -e s/s390x/s390/ -e s/parisc64/parisc/ \
>>>> -                                 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
>>>> -                                 -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
>>>> -                                 -e s/riscv.*/riscv/)
>>>> +include scripts/subarch.include
>>
>> What is the reason for this SUBARCH block move to to scripts/subarch.include?
>> Is this necessary for adding headers install dependency to lib.mk?
> 
> This is needed to create headers for cross build.
> 

I am sorry for the delay on this patch. I am going to get this into 4.19.
If anybody has objections, please let me.

Anders! Will be able to rebase the patch and send me the latest. I think
I have Acks from kvm, android, and vm so far.

thanks,
-- Shuah

