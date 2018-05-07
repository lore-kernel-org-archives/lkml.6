Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753379AbeEGVQ3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:16:29 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:45853 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeEGVQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:16:28 -0400
Subject: Re: [PATCH 21/24] selftests: memfd: return Kselftest Skip code for
 skipped tests
To: Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org,
        marcandre.lureau@redhat.com, lizhijian@cn.fujitsu.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
 <20180505011328.32078-21-shuah@kernel.org>
 <a5fff7b0-f308-25bc-909b-8579f6f14546@oracle.com>
 <f2b3f38a-7c7a-43ec-9c2d-94bbb7d56eb7@kernel.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <72a499bc-5c32-b553-88c6-a56704c398fc@kernel.org>
Date: Mon, 7 May 2018 15:16:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f2b3f38a-7c7a-43ec-9c2d-94bbb7d56eb7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 12:45 PM, Shuah Khan wrote:
> On 05/04/2018 07:52 PM, Mike Kravetz wrote:
>> On 05/04/2018 06:13 PM, Shuah Khan (Samsung OSG) wrote:
>>> When memfd test is skipped because of unmet dependencies and/or unsupported
>>> configuration, it returns non-zero value which is treated as a fail by the
>>> Kselftest framework. This leads to false negative result even when the test
>>> could not be run.
>>>
>>> Change it to return kselftest skip code when a test gets skipped to
>>> clearly report that the test could not be run.
>>>
>>> Added an explicit check for root user and return skip code.
>>>
>>> Kselftest framework SKIP code is 4 and the framework prints appropriate
>>> messages to indicate that the test is skipped.
>>>
>>> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
>>> ---
>>>  tools/testing/selftests/memfd/run_tests.sh | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/memfd/run_tests.sh b/tools/testing/selftests/memfd/run_tests.sh
>>> index c2d41ed81b24..88dc206a69b7 100755
>>> --- a/tools/testing/selftests/memfd/run_tests.sh
>>> +++ b/tools/testing/selftests/memfd/run_tests.sh
>>> @@ -1,6 +1,14 @@
>>>  #!/bin/bash
>>>  # please run as root
>>>  
>>> +# Kselftest framework requirement - SKIP code is 4.
>>> +ksft_skip=4
>>> +
>>> +if [ $UID != 0 ]; then
>>> +	echo "Please run this test as root"
>>> +	exit $ksft_skip
>>> +fi
>>> +

Moving root check this far up messes the test up and requires root access for
run_fuse_test.sh and memfd_test which is incorrect.

I will re-do the patch

thanks,
-- Shuah
