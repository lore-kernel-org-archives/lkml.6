Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AIpwx48h+ZGDk9ylVctZrSz9MaXLMhuLcqdV2UocoU604HRgc5U6yVOWBCgxWTc5QtjZ5FKkuGFO
ARC-Seal: i=1; a=rsa-sha256; t=1523417056; cv=none;
        d=google.com; s=arc-20160816;
        b=rmloC80gYbbxm+tlImGqEGrXLGOYo5Pmr+w2G1hYt7Q3KiYjM+ivbNUHOFMzipXlwt
         VeRL6sUqlUZJDJHLyGE+KOHY7p9UnvgtcrtC0kIM8yEDTWkNy1sFLP8kfzMDvsOOLTUT
         NuWJEQ70J0sHoMAgxCnvz8Fm3Z1tWBojk7SxTw12itmjjG5x9LusItNAKWRDnW6BNBOj
         uhoI4dgwQQY6cIXmfexU+0qP30uDAGIlc/VYF4wxlk/xB05XjdoMIFAISQM4IrFnj1WG
         R59gsj3q6Ih81J5e8l2HGnt+Bd+592/kIYQc2RfIE8voQIq264oYRb84QMOtpLL9UAS1
         qqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=IPp/q3pyqq7Rvnu0TaksgpDyI7v/oTLymWW5+NyGay4=;
        b=PepwTsYzb4yyEBijIGGGFr3u0dFvP5C5Z2zCvRAQpAXh9NrbBr8GfZUGBIFLeMDR5A
         42e6fkjfYWZDqaGNPo3B8p0bD3tFyvp2QRSnNVWvjjoJ6v2FAJL0PEXFFCE1XeKn4ndz
         bNKmPhdJqVY0T9ziZFqJBbbitHZbxw/roONTrMPsXoDn6eGx8lkOVIeMjWtsOrIWdioM
         plw1FASAVRQCmMAljVVwsIqntqxQnAkNCIbZmsy8DR7bl4rGgqdHf5bGZV7GOydk8HPX
         9oSXRImAtrq+zhb+V0Ch3qAXf7Ei44eewFpsJuVvSwLjdz+TRshoXpGLUgcVxtRbhF7f
         ddTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.11.71.1 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.11.71.1 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shuah Khan <shuahkh@osg.samsung.com>, Christian Brauner <christian.brauner@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, ebiederm@xmission.com, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/filesystems: Don't run dnotify_test by default
In-Reply-To: <3fb54ca8-bd31-4937-75f9-415a72eafaf2@osg.samsung.com>
References: <20180410062053.8816-1-mpe@ellerman.id.au> <20180410094553.GB3438@gmail.com> <3fb54ca8-bd31-4937-75f9-415a72eafaf2@osg.samsung.com>
Date: Wed, 11 Apr 2018 13:24:12 +1000
Message-ID: <87fu42l92b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597339082431063754?=
X-GMAIL-MSGID: =?utf-8?q?1597418563464010281?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Shuah Khan <shuahkh@osg.samsung.com> writes:
> On 04/10/2018 03:45 AM, Christian Brauner wrote:
>> On Tue, Apr 10, 2018 at 04:20:53PM +1000, Michael Ellerman wrote:
>>> In commit ce290a19609d ("selftests: add devpts selftests"), the
>>> filesystems directory was added to the top-level selftests Makefile.
>>>
>>> That had the effect of causing the existing dnotify_test in the
>>> filesystems directory to now be run as part of the default selftests
>>> test-run. Unfortunately dnotify_test is actually an infinite loop.
>>>
>>> Fix it by moving dnotify_test to TEST_GEN_PROGS_EXTENDED, which says
>>> that it's a generated file (ie. built) but should not be run as part
>>> of the default test suite run (it's an "extendend" test).
>
> Typo - I can fix it when I apply it.

Oops, thanks.

>>> While we're here cleanup a few other things, devpts_pts should be in
>>> TEST_GEN_PROGS to indicate that it's built, and with the above two
>>> changes we no longer need a custom all or clean rule.
>>>
>>> Fixes: ce290a19609d ("selftests: add devpts selftests")
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> 
>> I'm not sure if I should've made it to be built given that it wasn't
>> before but it probably doesn't hurt. It's either that or remove it I
>> guess.
>
> This way the test gets built and gets included in the installed tests.
> This way somebody can run it by itself.
>> 
>> Acked-by: Christian brauner <christian.brauner@ubuntu.com>
>
> Thanks Michael. I will get this into 4.17-rc2 or rc3.

Thanks.

cheers
