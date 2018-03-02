Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AG47ELtVl97AvDax87OYDuF92G7JE5sV/wmnpoLMIUgWEaAX8pfWS1rjmeNTDQT1AEO5iZjMGM/y
ARC-Seal: i=1; a=rsa-sha256; t=1520011047; cv=none;
        d=google.com; s=arc-20160816;
        b=BFwTUz/VgcVqHbmG/p1wd3dUSdzH+cil4XgdpAb780MkuvNxoWczADh7KRx+RKWOqt
         b7BSjGd2/Smq6KZdw8J8LeqDPX7Mv7iaFK8mKuebzqpCJLRcQl9sDgzdY9ar3ogVLunV
         NzbP0a/KuEw+vUqQkNmT/D2Q//fuE23RzAUP6dF/8i+PZidJMkLScpvszXnKl4kmNXKu
         j0qQ0iyi9Z+JLsdgNcy4I+7848RePbtzOFRwXjoGM+JO7QBqKHGhXpMFZ7uvVIREQUGT
         NyH5aCsRsgfGZnWi/eodsMXNRJMuEJRsA7iDw4wBDzCVvlFfByPI+yhr5Aq+tFi2Cojr
         c5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=N0si3yZ8V95hEWoQ9En8E3V16VmXw12rc+b+k/abkfc=;
        b=W7LYG6t2ACR8xTszUSaNj5drPGwOsIRzrM4crRPxyFUch8NgBU7Y36WeQItQ2EeQ/a
         o26RGqPxZdVIxiBAtUAfKkveit53K/vRgAX0WN6KwTbRfV37QlZgdi+xTNyltVbHxfQS
         NWiSHwoXqa3t49IRRvH3NGrIVsFRQreWKHoifRspujUQu/+xe4vUb1G7CoAIpL78qDHN
         dgTyx4DQlbTZEQfKqgGmzmVSvGgWL1S4x4SDuXSmHgu11+JXzYxgSzlvFaSdPgFvGtSR
         xARhPTs9tfRD3EUXRovZDPO716bTU+bxZh007DD8OouuDnKy4ndW4d8YIaRAO7DgIqzF
         1G/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Subject: Re: [PATCH] selftests: memory-hotplug: fix emit_tests regression
To: Anders Roxell <anders.roxell@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: shuah@kernel.org, tglx@linutronix.de, gregkh@linuxfoundation.org,
 Philippe Ombredanne <pombredanne@nexb.com>, lei.yang@windriver.com,
 linux-kselftest@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Shuah Khan <shuahkh@osg.samsung.com>
References: <20180301201626.17347-1-shuahkh@osg.samsung.com>
 <CADYN=9LGPa+rfnuGJ-nrpxPvw+tuAYNjxCCqefxAuRe-B_tq4w@mail.gmail.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <98a5211d-2b88-1c0c-c5d5-7cfcfa31ef2a@osg.samsung.com>
Date: Fri, 2 Mar 2018 10:17:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CADYN=9LGPa+rfnuGJ-nrpxPvw+tuAYNjxCCqefxAuRe-B_tq4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593767802289906258?=
X-GMAIL-MSGID: =?utf-8?q?1593847104094356164?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/02/2018 01:31 AM, Anders Roxell wrote:
> On 1 March 2018 at 21:16, Shuah Khan <shuahkh@osg.samsung.com> wrote:
>> Commit 16c513b13477
>> ("selftests: memory-hotplug: silence test command echo")
>>
>> introduced regression in emit_tests and results in the following
>> failure when selftests are installed and run. Fix it.
>>
>> Running tests in memory-hotplug
>> ========================================
>> ./run_kselftest.sh: line 121: @./mem-on-off-test.sh: No such file or
>> directory
>> selftests: memory-hotplug [FAIL]
>>
>> Fixes: 16c513b13477 (selftests: memory-hotplug: silence test command echo")
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> 

Thanks for testing. It is now in linux-kselftest fixes for the next
4.16-rc

thanks,
-- Shuah
