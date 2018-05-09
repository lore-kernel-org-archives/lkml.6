Return-Path: <jeffrin@rajagiritech.edu.in>
ARC-Seal: i=1; a=rsa-sha256; t=1525891483; cv=none;
        d=google.com; s=arc-20160816;
        b=qF4VyFau3a86wlCIk1f7LyI4TkSM3r9Qlf2n+6CQISLwxS/6sN7t3jheXBF6+cFtXk
         uadkxERRE7eUH8vVSvUqz0MpsanNm1I5fxubY1ZhuhnIq37H7fuDcRsb2+KPf+uome0C
         RIixWJ/GOnl4TO6uZ3xYYt9KHL7zjGjcL71uuO12rbsR+H/Qzvwn5T+6K3yvVIn2+V33
         kKFlk8fGeE7a5dEgcdJN6b32qGRAUh7fdLmbOr2AHwv/daGSWmeGVAKlpJUd//8V80aU
         0nJMHgm7Ob2RuDTDLAQcm545tHniVJAlfJjotXEowyi021br7A+ly1JpWWd5u8GQuE3Z
         ZgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=mpYzojJd43rxZYE7wqu5kHoCuxipNUWEOdrtKRsLx+U=;
        b=lnPDz+oJMErm6Y/Y9H6Unhs76vVMkDcQ/BsUOfVnkJzadd8lIP11ye+Da94yzi/PUW
         OA3aSIMaiTinVdl0hlf3z5ualdMr/2fMl0RCkw/7eBRaG6hNca+ZoMtfzb+p0CvePXIU
         h5TjtEtKkinRA8Ov8vzBTY7ar+O5iTIG5+O3u2q0bgFhBAw7z1IXBlBqhysL88QPgTdz
         LfaB3Pw6gHli/tdg/Wj0RVBfh7JdAApUKKnH250+5NdRYEuEZOQpYsXJxlCv3JntqMyp
         AtwO+z3s6tWhiJS1A+DthUniPURHobTndlsRexP1FC3wgT/qpX0dH86C5VoMPsRWcsRh
         e2Uw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=uXXY+lfN;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of jeffrin@rajagiritech.edu.in) smtp.mailfrom=jeffrin@rajagiritech.edu.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=uXXY+lfN;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of jeffrin@rajagiritech.edu.in) smtp.mailfrom=jeffrin@rajagiritech.edu.in
X-Google-Smtp-Source: AB8JxZoY7b2CPgF7+8J8gcRLhq8QbESOWHqVRKbhDVtxvNKGArPGJdKABf+YJvfYs2gSAxDtvDbFGnmSMMO1g5HgHkI=
MIME-Version: 1.0
In-Reply-To: <a16db020-045d-a5ba-9106-5f4b4e4920a4@linaro.org>
References: <20180509173819.8017-1-ahiliation@yahoo.co.in> <a16db020-045d-a5ba-9106-5f4b4e4920a4@linaro.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Thu, 10 May 2018 00:14:40 +0530
Message-ID: <CAG=yYwnZdkJWeA=XhH4q-kfq3+QXrV+BNqgHtS0b9Td=W8fpiA@mail.gmail.com>
Subject: Re: [PATCH] selftests: intel_pstate: Fix a condition which does not
 notify user that root permission is useful
To: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc: Jeffrin Jose T <ahiliation@yahoo.co.in>, Shuah Khan <shuah@kernel.org>,
	Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	gregkh@linuxfoundation.org, thomas@m3y3r.de, linux-kselftest@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600009088111663295?=
X-GMAIL-MSGID: =?utf-8?q?1600013187311401081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

thanks. i will work on...

On Wed, May 9, 2018 at 11:54 PM, Daniel D=C3=ADaz <daniel.diaz@linaro.org> =
wrote:
> Hello!
>
>
> On 05/09/2018 12:38 PM, Jeffrin Jose T wrote:
>> aperf program uses /dev/cpu which is normally a root only
>> access area. so in that case to successfully run thet test,
>> root permissions are required.This patch is in the file run.sh.
>>
>> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
>> ---
>>  tools/testing/selftests/intel_pstate/run.sh | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing=
/selftests/intel_pstate/run.sh
>> index 23a2e4e9880e..05d35392dcfd 100755
>> --- a/tools/testing/selftests/intel_pstate/run.sh
>> +++ b/tools/testing/selftests/intel_pstate/run.sh
>> @@ -31,6 +31,14 @@
>>
>>  EVALUATE_ONLY=3D0
>>
>> +uid=3D$(id -u)
>> +if [ $uid -ne 0 ]; then
>> +    echo     "-----------------------"
>> +    echo $msg please run this as root >&2
>> +    echo     "-----------------------"
>> +    exit 0
>> +fi
>> +
>
> Other tests simply use $UID. See:
>   cpufreq/main.sh
>   cpu-hotplug/cpu-on-off-test.sh
>   efivarfs/efivarfs.sh
>   gpio/gpio-mockup.sh
>   memory-hotplug/mem-on-off-test.sh
>
> This doesn't take into account the conditions for EVALUATE_ONLY: When
> it's set non-zero, neither aperf nor cpupower run at all.
>
> While this is under review, you might want to base your change on
> Shuah's patch for skipping:
>
> https://lists.linaro.org/pipermail/linux-kselftest-mirror/2018-May/001074=
.html
>
>
>>  if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
>>       echo "$0 # Skipped: Test can only run on x86 architectures."
>>       exit 0
>
> I'd leave this check at the forefront, as this "hurdle" is
> insurmountable in other architectures, whereas becoming root is attainabl=
e.
>
> Thanks and greetings!
>
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org



--=20
software engineer
rajagiri school of engineering and technology
