Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934349AbeEILhI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:37:08 -0400
Received: from mail5.windriver.com ([192.103.53.11]:48692 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933832AbeEILhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:37:07 -0400
Subject: Re: [PATCH] selftests: memory-hotplug: delete RUN_TESTS and
 EMIT_TESTS overrides
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        <po-hsu.lin@canonical.com>
References: <20180502211848.22404-1-shuah@kernel.org>
 <20180502211848.22404-3-shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: lei yang <lei.yang@windriver.com>
Message-ID: <71d76124-fbe8-c475-3bb9-bec645db02a0@windriver.com>
Date: Wed, 9 May 2018 19:39:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180502211848.22404-3-shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [128.224.162.194]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018年05月03日 05:18, Shuah Khan (Samsung OSG) wrote:
> Delete RUN_TESTS and EMIT_TESTS overrides and use common defines in
> lib.mk. Common defines work after making the change the test to run
> with ratio=2 as the default mode to be able to invoke the test without
> the "-r 2" argument from the common RUN_TESTS and EMIT_TESTS.
>
> The run_full_tests target now calls the test with "-r 10".
>
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Reviewed-by: Lei.Yang@windriver.com

Lei



> ---
>   tools/testing/selftests/memory-hotplug/Makefile           | 5 +----
>   tools/testing/selftests/memory-hotplug/mem-on-off-test.sh | 3 ++-
>   2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/memory-hotplug/Makefile b/tools/testing/selftests/memory-hotplug/Makefile
> index 686da510f989..e0a625e34f40 100644
> --- a/tools/testing/selftests/memory-hotplug/Makefile
> +++ b/tools/testing/selftests/memory-hotplug/Makefile
> @@ -4,11 +4,8 @@ all:
>   include ../lib.mk
>   
>   TEST_PROGS := mem-on-off-test.sh
> -override RUN_TESTS := @./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
> -
> -override EMIT_TESTS := echo "$(subst @,,$(RUN_TESTS))"
>   
>   run_full_test:
> -	@/bin/bash ./mem-on-off-test.sh && echo "memory-hotplug selftests: [PASS]" || echo "memory-hotplug selftests: [FAIL]"
> +	@/bin/bash ./mem-on-off-test.sh -r 10 && echo "memory-hotplug selftests: [PASS]" || echo "memory-hotplug selftests: [FAIL]"
>   
>   clean:
> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> index ae2c790d0880..ff4991704d07 100755
> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> @@ -133,7 +133,8 @@ offline_memory_expect_fail()
>   
>   error=-12
>   priority=0
> -ratio=10
> +# Run with default of ratio=2 for Kselftest run
> +ratio=2
>   retval=0
>   
>   while getopts e:hp:r: opt; do
