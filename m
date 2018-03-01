Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AG47ELv4l9fUmet5txDIhCvw1gXn3g5RISa9ctfIOLzgI0YER0JyWRDiA7N9amMxpkEDZplF+C4f
ARC-Seal: i=1; a=rsa-sha256; t=1519915296; cv=none;
        d=google.com; s=arc-20160816;
        b=EGsFigvaLZSEeYfqL/FnhpTckiUT41U6ZtRHbjuM52b6ktQQgxuq/Z/PayoYXMjns9
         JC4v1FzqcQ20WIIcq526tMIqHYhb3t3urkRmedB6VpwN8DwdjuzuxMRD5Hi1KnMabyeQ
         9S9/rmpm3LGXFO6XACxt9zesHmKahBJGLaRgR3nQXO0FeFj+QcLjA/H2+Aeun1gul2CF
         WUyxA6eMkb9544nM+wuv6kCwET+rva0zbA38l3D7pxsblkBgynH5Wn4VqTNOWB/tVchB
         i5dcaMrXMMRyYPNfbOigxVD5UtG5DoE41vo5L9T4oHRN4c5Twq/h/0Zq/p0ec/58oZz8
         fhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=VzbCRf3CeWapGreyNCO/NXaS6gdYtRUjqEfBXELN/OM=;
        b=yrfew6gRsybareRSpHhFAxGVULsrVzC7vcgYk+lqBcY/gXUdSZyyUo8AW8pBV686iT
         GkUDLNto9rG3o/Ifv403f5HOKhHwhZIdUpIa75RlffanRjac5cC/ToA/UMnlA1/rdXMl
         k3ENC4J43l6L3puhEuLv2Iy2T7Dq2mnVpUjCweatklhBY0/cRX/TkZHgiaOnaizcpf7D
         7zdjfq7teTQxdL65Zw7bJk/TpJQZHWm0VggAlh0m7uCYDBZYCixtHjLsOWUL4PE1ERuT
         vfGNvB9xq0snu5WgDUXFR/jGmcGfZqsAb7q02OhsK0ZCCkhhf6CzKsAn4ypX/pPcrE5i
         ZyfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Subject: Re: [PATCH] selftests: memory-hotplug: silence test command echo
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>, lyang0 <lei.yang@windriver.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Dan Rue <dan.rue@linaro.org>,
 Shuah Khan <shuahkh@osg.samsung.com>
References: <20180213214407.21717-1-shuahkh@osg.samsung.com>
 <CA+G9fYsE0w00aeE3jxJU3Q01Yz_C95zn+kguMHqg6M9PRmhemg@mail.gmail.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <7475d5ca-3fc6-260b-a1d3-60a3e1263769@osg.samsung.com>
Date: Thu, 1 Mar 2018 07:41:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYsE0w00aeE3jxJU3Q01Yz_C95zn+kguMHqg6M9PRmhemg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592323763418926951?=
X-GMAIL-MSGID: =?utf-8?q?1593746701515667522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/01/2018 02:11 AM, Naresh Kamboju wrote:
> On 14 February 2018 at 03:14, Shuah Khan <shuahkh@osg.samsung.com> wrote:
>> Silence the following command being printed while running test.
>>
>> ./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" ||
>> echo "selftests: memory-hotplug [FAIL]"
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>  tools/testing/selftests/memory-hotplug/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/memory-hotplug/Makefile b/tools/testing/selftests/memory-hotplug/Makefile
>> index 86636d207adf..183b46883875 100644
>> --- a/tools/testing/selftests/memory-hotplug/Makefile
>> +++ b/tools/testing/selftests/memory-hotplug/Makefile
>> @@ -4,7 +4,7 @@ all:
>>  include ../lib.mk
>>
>>  TEST_PROGS := mem-on-off-test.sh
>> -override RUN_TESTS := ./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
>> +override RUN_TESTS := @./mem-on-off-test.sh -r 2 && echo "selftests: memory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
>>  override EMIT_TESTS := echo "$(RUN_TESTS)"
>>
>>  run_full_test:
> 
> The test execution broken due to this patch ?

Thanks for reporting this. I will look at this. The change probably
broke the EMIT_TESTS case.

thanks,
-- Shuah
