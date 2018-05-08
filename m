Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZqUKl2ahCJYvWh/n3NmGdby2GHUzC9BCSMiN2js0HYQDkQCXaJ/cP8TD9GUqvybBLtmDZ5a
ARC-Seal: i=1; a=rsa-sha256; t=1525810885; cv=none;
        d=google.com; s=arc-20160816;
        b=cis1rHe97CY6HfsT1a4UFKaCvp3eMk0hLdPZ9jVueK3A76d3d2WceEHksu/xcRPSNb
         G6PUu+2C0JmzRhlfQKSSVD/GIQmC/wMRaapKp0f4OGzFngHIQjlmhr5yjDDQFte1RT3l
         oeORA+/CGayw05BiNkKz2wNZPZy55T0sPi5Kk+/9iI0k+Ppco4Tu1MASRVB01GkJ3QJV
         ZfCRT2RmDfFxNPVYOjZ/f3ezmJvNwGUzoZIZd92SO22doZXaxg2JgJh+rEczW7vXfAKO
         H5kk5z+fTtwEM6jJRzHZvzdJL4IkyAJMCK6erpjGIzbgMjLVl4vSaJLJpyRjQVVanRjm
         vQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=QIrMUyELNdHd8d6DqE8BQQr7Rdnd0rqG83SD6nH40l0=;
        b=DfTD3TcLdMhE52MkHeLnSxAo1e7TOwBgfNg3oq8/LCzGa7Slxl5+Jq3TaF4HAAQDpB
         lnY86jj4qtBojlbe7kkENFk0bAGxlM1KKrUeLOVXDWxviCF8eu9MKIuRSuTYCQPaJYWc
         UheKYc/O7ZNdXYUEJ+fjlMqCGv2ixAFKZsvFWF1yjH6gM7iAlIFKbBaq7LYNLGUlTYPJ
         STK1bDX4sWKVQjRkxFwd2hpPA9MU/OvRjydXhxF+X5C/McAnuwqNMwRQoEEybOn91H5K
         pYGP97fm8DeDFA1wtv5Zhu2zI/B4BVPkslAaBu7ezZogF+iA6t5rEuYAQDoBDK8XNs2K
         iLXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH] selftests:intel_pstate: fixes typical crash of a testing
 script for Intel P-State driver
To: Jeffrin Jose T <ahiliation@yahoo.co.in>, kstewart@linuxfoundation.org,
 daniel.diaz@linaro.org, pombredanne@nexb.com, gregkh@linuxfoundation.org,
 thomas@m3y3r.de
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeffrin Jose T <jeffrin@rajagiritech.edu.in>, Shuah Khan <shuah@kernel.org>
References: <20180429191226.14242-1-ahiliation@yahoo.co.in>
 <62c2484a-b8fe-513c-a9c7-dff1f3f3979a@kernel.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f19c0a3f-a881-fbb4-ed0b-bf20bda730cf@kernel.org>
Date: Tue, 8 May 2018 14:21:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <62c2484a-b8fe-513c-a9c7-dff1f3f3979a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599109031684062016?=
X-GMAIL-MSGID: =?utf-8?q?1599928675544831915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/04/2018 01:47 PM, Shuah Khan wrote:
> On 04/29/2018 01:12 PM, Jeffrin Jose T wrote:
>>  Testing script for Intel P-State driver crashes during
>>  the run.  this patch fixes that crash and produce typical results.
>>
>> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
>>
>> ---
>>  tools/testing/selftests/intel_pstate/run.sh | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
>> index c670359becc6..cd32aca8806f 100755
>> --- a/tools/testing/selftests/intel_pstate/run.sh
>> +++ b/tools/testing/selftests/intel_pstate/run.sh
>> @@ -27,6 +27,7 @@
>>  # and the test will error out in those cases.  The result.X file can be checked
>>  # for consistency and modified to remove the extra MHz values.  The result.X
>>  # files can be re-evaluated by setting EVALUATE_ONLY to 1 below.
>> +#set -xv
>>  
>>  EVALUATE_ONLY=0
>>  
>> @@ -101,12 +102,13 @@ cpupower frequency-set -g powersave --max=${max_freq}MHz >& /dev/null
>>  echo "Target      Actual      Difference     MSR(0x199)     max_perf_pct"
>>  for freq in `seq $max_freq -100 $min_freq`
>>  do
>> -	result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" | awk ' { print $4 } ' | awk -F "." ' { print $1 } ')
>> +       result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" \
>>         | awk '{print $4}' | awk -F "." '{print $1}')
>> +	result_freq=$(echo $result_freq | head -n1 | cut -d " " -f1)
>>  	msr=$(cat /tmp/result.${freq} | grep "msr" | awk ' { print $3 } ')
>>  	max_perf_pct=$(cat /tmp/result.${freq} | grep "max_perf_pct" | awk ' { print $2 } ' )
>> -	if [ $result_freq -eq $freq ]; then
>> +	if (( "$result_freq" == "$freq" ))
>> +	then
>>  		echo " $freq        $result_freq             0          $msr         $(($max_perf_pct*3300))"
>>  	else
>>  		echo " $freq        $result_freq          $(($result_freq-$freq))          $msr          $(($max_perf_pct*$max_freq))"
>>
> 
> Thanks. I will get this into 4.17-rc5
> 
> -- Shuah
> 

This patch didn't apply. In any case Daniel Diaz sent in a patch a coupld of weeks ago
which did apply and fixes the same problem.

I applied Daniel's patch to linux-kselftest fixes for 4.17-rc5

https://lists.linaro.org/pipermail/linux-kselftest-mirror/2018-April/000858.html

thank you both.

-- Shuah
