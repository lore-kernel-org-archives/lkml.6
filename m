Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0780C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC1120870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544741406;
	bh=KOLyTbt2eJZVTQoX46XCSKQoQ0awCa1Lgzc2sFY6Qm0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=2awZL70R6Sgd/GwDy091wQ6utSn6/uwkInGKEp7em+ES11cAMwDwfu3u0HfketpXa
	 /mbd7jwyxM+s83j0EQhLYnJwjPEPwCocHT/YIqXLIdzvCaY8+PYjLi/maVQI8YjiHC
	 W+cN3gMsxVKSdPBwmgKfC8s9vC3SxMzXKzRp3+ec=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC1120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeLMWuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbeLMWuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:50:04 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4483520851;
        Thu, 13 Dec 2018 22:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544741403;
        bh=KOLyTbt2eJZVTQoX46XCSKQoQ0awCa1Lgzc2sFY6Qm0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HFfzGchLILxHJ9nU1SBjFriTv/fM6Lee/l4SClyy4NeCgcYcXzjuEjqk0hkptBwac
         4uVtSG61uPWa4+4/eu2c1/RzYtz0lQ+6wCAli+IWEdAg0yXGcmzN4YQ3HALbqGk6zN
         uKFm6f5dxXrbZ/mCw/Ajp61tsNQ1ixTQRG4dny0A=
Subject: Re: [PATCH] selftests: Fix test errors related to lib.mk khdr target
To:     Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        bamv2005@gmail.com, brgl@bgdev.pl, fathi.boudra@linaro.org,
        anders.roxell@linaro.org, daniel.diaz@linaro.org,
        pintu.ping@gmail.com, drjones@redhat.com, hofsass@google.com,
        peterx@redhat.com, peng.hao2@zte.com.cn, wei@redhat.com,
        davem@davemloft.net, dcaratti@redhat.com,
        akpm@linux-foundation.org, mhocko@suse.com, khalid.aziz@oracle.com,
        mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com,
        dima@arista.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, stable@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20181213200011.10779-1-shuah@kernel.org>
 <623cdf7b-fc3c-2a93-c61a-a043e3d7f75b@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <25593aa4-a2a7-6567-11f2-b702b6e5563c@kernel.org>
Date:   Thu, 13 Dec 2018 15:50:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <623cdf7b-fc3c-2a93-c61a-a043e3d7f75b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/18 3:40 PM, Paolo Bonzini wrote:
> On 13/12/18 21:00, shuah@kernel.org wrote:
>> From: Shuah Khan <shuah@kernel.org>
>>
>> Commit b2d35fa5fc80 ("selftests: add headers_install to lib.mk") added
>> khdr target to run headers_install target from the main Makefile. The
>> logic uses KSFT_KHDR_INSTALL and top_srcdir as controls to initialize
>> variables and include files to run headers_install from the top level
>> Makefile. There are a few problems with this logic.
>>
>> 1. Exposes top_srcdir to all tests
>> 2. Common logic impacts all tests
>> 3. Uses KSFT_KHDR_INSTALL, top_srcdir, and khdr in an adhoc way. Tests
>>     add "khdr" dependency in their Makefiles to TEST_PROGS_EXTENDED in
>>     some cases, and STATIC_LIBS in other cases. This makes this framework
>>     confusing to use.
>>
>> The common logic that runs for all tests even when KSFT_KHDR_INSTALL
>> isn't defined by the test. top_srcdir is initialized to a default value
>> when test doesn't initialize it. It works for all tests without a sub-dir
>> structure and tests with sub-dir structure fail to build.
>>
>> e.g: make -C sparc64/drivers/ or make -C drivers/dma-buf
>>
>> ../../lib.mk:20: ../../../../scripts/subarch.include: No such file or directory
>> make: *** No rule to make target '../../../../scripts/subarch.include'.  Stop.
>>
>> There is no reason to require all tests to define top_srcdir and there is
>> no need to require tests to add khdr dependency using adhoc changes to
>> TEST_* and other variables.
>>
>> Fix it with a consistent use of KSFT_KHDR_INSTALL and top_srcdir from tests
>> that have the dependency on headers_install.
>>
>> Change common logic to include khdr target define and "all" target with
>> dependency on khdr when KSFT_KHDR_INSTALL is defined.
>>
>> Only tests that have dependency on headers_install have to define just
>> the KSFT_KHDR_INSTALL, and top_srcdir variables and there is no need to
>> specify khdr dependency in the test Makefiles.
> 
> Looks good.  Could you please provide a topic branch so that we can
> avoid conflicts between our trees at the next merge window.
> 

Thanks. The topic branch is

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next

I will apply it in a day or two to get ready for the merge window.

thanks,
-- Shuah



