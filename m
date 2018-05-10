Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966785AbeEJRey (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:34:54 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:39231 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966770AbeEJRew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:34:52 -0400
Subject: Re: [PATCH 0/4] selftests: rework RTC tests
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rtc@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180419125030.5076-1-alexandre.belloni@bootlin.com>
 <95d19039-69ee-cda5-3cfe-918283cf9913@kernel.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <0efabd57-040b-d4d6-e9a1-21a0a8746086@kernel.org>
Date: Thu, 10 May 2018 11:34:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <95d19039-69ee-cda5-3cfe-918283cf9913@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 01:33 PM, Shuah Khan wrote:
> On 04/19/2018 06:50 AM, Alexandre Belloni wrote:
>> Hi,
>>
>> This series separates tests using the RTC devices between the one
>> testing driver agnostic kernel facilities (timers) and the others that
>> are testing device drivers and hardware.
>>
>> Then, rtctest is reworked to use the test harness and be much more
>> robust. Skipping tests is now easier and tests will not block
>> indefinitively.
>>
>> I'm planning to send more improvements later this cycle.
>>
>> Alexandre Belloni (4):
>>   selftests: timers: move PIE tests out of rtctest
>>   selftests: timers: rtcpie: restore previous PIE rate
>>   selftests: move RTC tests to rtc subfolder
>>   selftests: rtc: rework rtctest
>>
>>  MAINTAINERS                                   |   2 +-
>>  tools/testing/selftests/Makefile              |   1 +
>>  tools/testing/selftests/rtc/.gitignore        |   2 +
>>  tools/testing/selftests/rtc/Makefile          |   9 +
>>  tools/testing/selftests/rtc/rtctest.c         | 238 +++++++++++
>>  .../rtctest_setdate.c => rtc/setdate.c}       |   0
>>  tools/testing/selftests/timers/.gitignore     |   3 +-
>>  tools/testing/selftests/timers/Makefile       |   4 +-
>>  tools/testing/selftests/timers/rtcpie.c       | 134 ++++++
>>  tools/testing/selftests/timers/rtctest.c      | 403 ------------------
>>  10 files changed, 388 insertions(+), 408 deletions(-)
>>  create mode 100644 tools/testing/selftests/rtc/.gitignore
>>  create mode 100644 tools/testing/selftests/rtc/Makefile
>>  create mode 100644 tools/testing/selftests/rtc/rtctest.c
>>  rename tools/testing/selftests/{timers/rtctest_setdate.c => rtc/setdate.c} (100%)
>>  create mode 100644 tools/testing/selftests/timers/rtcpie.c
>>  delete mode 100644 tools/testing/selftests/timers/rtctest.c
>>
> 
> Looks good to me. Thanks for doing this. I will queue this for 4.18-rc1
> 
> thanks,
> -- Shuah
> 

Applied to linux-kselftest next for 4.18-rc1

thanks,
-- Shuah
