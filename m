Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4A5C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CCF214C3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CCF214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeI1UQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:16:55 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:42787 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1UQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:16:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 7923B40F47;
        Fri, 28 Sep 2018 13:53:00 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bkfXeLTEicM4; Fri, 28 Sep 2018 13:53:00 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 1B09E40CBE;
        Fri, 28 Sep 2018 13:52:34 +0000 (UTC)
Subject: Re: [PATCH v6] selftests: add headers_install to lib.mk
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Anders Roxell <anders.roxell@linaro.org>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        bamv2005@gmail.com, brgl@bgdev.pl, pbonzini@redhat.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        aarcange@redhat.com
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Shuah Khan <shuah@kernel.org>
References: <20180809080402.24469-1-anders.roxell@linaro.org>
 <20180904104721.27535-1-anders.roxell@linaro.org>
 <87y3bmte9l.fsf@concordia.ellerman.id.au>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <4473d2b6-a760-1a48-68e7-9f90023b57b5@kernel.org>
Date:   Fri, 28 Sep 2018 07:52:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87y3bmte9l.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 10:52 PM, Michael Ellerman wrote:
> [ + linuxppc-dev ]
> 
> Anders Roxell <anders.roxell@linaro.org> writes:
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
>>
>> I sent this (v5) a month ago and wondered if it got lost. Resending
>> unchanged.
>>
>> Cheers,
>> Anders
>>
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
> 
> This broke all the powerpc selftests :(

Sorry for thr breakage.

> 
> Why did it go in at rc5?
> 

This patch has been in linux-next for a sometime before I decided to send this.
My original intent was to send this for rc2, and my schedule was messed up with
traveling. Since I didn't hear any issues from linux-next soaking, I made a call
on sending this in for rc5.

On second thought I should have waited until 4.20. Sorry about that.

thanks,
-- Shuah
