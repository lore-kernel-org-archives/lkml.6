Return-Path: <jeffrin@rajagiritech.edu.in>
ARC-Seal: i=1; a=rsa-sha256; t=1525876079; cv=none;
        d=google.com; s=arc-20160816;
        b=ulzFSMjySLn3JS96LYADEtPG0pv87vNE/qsBfjgEgfEplAAy1pbvwjaiFN4sOfMDiO
         e9dRf4AXLUcjWCtNltNB7SL8QrtJVHcMuvq306x4EkcC8UYFeUrfDMtIfOCs6kC+efsq
         zaMuuHCeHGy8S/IE6Kgu/u5GUFt7jAOrmvAj5ENDynakX2sGsJ7TwzeqAkc21A4J5KyG
         sLZSBbH2GP9GOdNgteeuTdm/ZWmppsbYiDu5gGSzzN7zN2TL9qJ+4nMeeMvNeXZU9FxY
         QwV5TeLjZ34SaDAWg/1jjk7t0QS9ubqx+p0H5ejlljhAvXRF4/ba58tJ/xjsp9Kwwyxn
         wVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=wGRsaFg2ri/g3PYz8tej+Ke4ENs8ciabKoWuCrxgXRc=;
        b=zqCLZFGHEQxqwVSawPEn70yJJMuc7WarvgzYLX4wNF9boJb1T104/U7lTjr24BMaEc
         Yh3ipUwFnEzELK024Mry7TuwbyGT48037Tbz3GiCTzwNVQ9jjFyjMYGyZPzOS7xn7lIO
         iTekiQjxQRtF7LI2FFVfO0K0Zzsc/5jhJDfDVw9Z5rTvjxYWAvrKisczswH9/WmexzbX
         QClEMij79ay24cxLPeqUMJoU67aiUM/8MPXAtGEgQNaQmDYArKXtyOPEx4gNUKfEJXMZ
         3INtplG5JPHH8ArY9eW0hXDD5KQFSjl12VJubc25qBS/qz05ueT3IEq5q3w77VDmwQL6
         dM6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=1NOl/jbw;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of jeffrin@rajagiritech.edu.in) smtp.mailfrom=jeffrin@rajagiritech.edu.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=1NOl/jbw;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of jeffrin@rajagiritech.edu.in) smtp.mailfrom=jeffrin@rajagiritech.edu.in
X-Google-Smtp-Source: AB8JxZpg42Kw2ntMvkIRYCGCWXHYuRCrdsXQW1tHr5zSoQjlPmjZyXEbLVhIolnUjettj3BMA+LpBdhaiuR5jVUop74=
MIME-Version: 1.0
In-Reply-To: <f19c0a3f-a881-fbb4-ed0b-bf20bda730cf@kernel.org>
References: <20180429191226.14242-1-ahiliation@yahoo.co.in>
 <62c2484a-b8fe-513c-a9c7-dff1f3f3979a@kernel.org> <f19c0a3f-a881-fbb4-ed0b-bf20bda730cf@kernel.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 9 May 2018 19:57:57 +0530
Message-ID: <CAG=yYw=4yKar6DocK1Ng00_KyNkC9pXjnTj67BGcD1n5107cnQ@mail.gmail.com>
Subject: Re: [PATCH] selftests:intel_pstate: fixes typical crash of a testing
 script for Intel P-State driver
To: Shuah Khan <shuah@kernel.org>
Cc: Jeffrin Jose T <ahiliation@yahoo.co.in>, Kate Stewart <kstewart@linuxfoundation.org>,
	daniel.diaz@linaro.org, Philippe Ombredanne <pombredanne@nexb.com>, gregkh@linuxfoundation.org,
	thomas@m3y3r.de, linux-kselftest@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599109031684062016?=
X-GMAIL-MSGID: =?utf-8?q?1599997035184005599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

hello  Shuah,

i had  later send another version of that patch.
anyway thank you  daniel for your effort

thank you both.



On Wed, May 9, 2018 at 1:51 AM, Shuah Khan <shuah@kernel.org> wrote:
> On 05/04/2018 01:47 PM, Shuah Khan wrote:
>> On 04/29/2018 01:12 PM, Jeffrin Jose T wrote:
>>>  Testing script for Intel P-State driver crashes during
>>>  the run.  this patch fixes that crash and produce typical results.
>>>
>>> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
>>>
>>> ---
>>>  tools/testing/selftests/intel_pstate/run.sh | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
>>> index c670359becc6..cd32aca8806f 100755
>>> --- a/tools/testing/selftests/intel_pstate/run.sh
>>> +++ b/tools/testing/selftests/intel_pstate/run.sh
>>> @@ -27,6 +27,7 @@
>>>  # and the test will error out in those cases.  The result.X file can be checked
>>>  # for consistency and modified to remove the extra MHz values.  The result.X
>>>  # files can be re-evaluated by setting EVALUATE_ONLY to 1 below.
>>> +#set -xv
>>>
>>>  EVALUATE_ONLY=0
>>>
>>> @@ -101,12 +102,13 @@ cpupower frequency-set -g powersave --max=${max_freq}MHz >& /dev/null
>>>  echo "Target      Actual      Difference     MSR(0x199)     max_perf_pct"
>>>  for freq in `seq $max_freq -100 $min_freq`
>>>  do
>>> -    result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" | awk ' { print $4 } ' | awk -F "." ' { print $1 } ')
>>> +       result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" \
>>>         | awk '{print $4}' | awk -F "." '{print $1}')
>>> +    result_freq=$(echo $result_freq | head -n1 | cut -d " " -f1)
>>>      msr=$(cat /tmp/result.${freq} | grep "msr" | awk ' { print $3 } ')
>>>      max_perf_pct=$(cat /tmp/result.${freq} | grep "max_perf_pct" | awk ' { print $2 } ' )
>>> -    if [ $result_freq -eq $freq ]; then
>>> +    if (( "$result_freq" == "$freq" ))
>>> +    then
>>>              echo " $freq        $result_freq             0          $msr         $(($max_perf_pct*3300))"
>>>      else
>>>              echo " $freq        $result_freq          $(($result_freq-$freq))          $msr          $(($max_perf_pct*$max_freq))"
>>>
>>
>> Thanks. I will get this into 4.17-rc5
>>
>> -- Shuah
>>
>
> This patch didn't apply. In any case Daniel Diaz sent in a patch a coupld of weeks ago
> which did apply and fixes the same problem.
>
> I applied Daniel's patch to linux-kselftest fixes for 4.17-rc5
>
> https://lists.linaro.org/pipermail/linux-kselftest-mirror/2018-April/000858.html
>
> thank you both.
>
> -- Shuah



-- 
software engineer
rajagiri school of engineering and technology
