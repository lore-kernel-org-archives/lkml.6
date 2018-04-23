Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524502431; cv=none;
        d=google.com; s=arc-20160816;
        b=Cy3q+oUSb+dIbw0PE5arAdTo2LjYI2GgVsCe67dSGrezlPp3fZTBtyLyJCMH56Mqou
         71h+3MQMsQPy7HyzueStRao7+g/mfg1ZkduaBoMyf+XFZy+Grh+MnTnzZmIq/pkqFkT0
         8Pfbi0d7daZLg8FA0JWvfk/dydO+Wa8rZAZYCCRUdulLIhoEf63uaQiPWnmuYuaIHa/2
         viZNlFXl6Y17yYNfzSmAnRe7QRjYF8gWaLpSGSBSBpoQ/6mi13hVeaGM8hntB8ZTqEcY
         IBahNnX3ZbQu4dJjDSH/BXCQwXHwtj2rI53ajykn7G2AnWVGx47q8xaUnsMw4a62Z/fr
         pFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/pjSBm2A393XVttwOwnpShOK6kgXD50Owpap8rRvQw8=;
        b=igXI0jButPJIg8ZVhF+asUWbf0QsAw8fW6coEAxM5kIz/OJyjgFrTNkHPZxpINmttH
         KQ08nUnWnwKTFfux1xp3DqvWB9EZtkqCdCbhQHIVqECK4R5HdyiWZtj2oO+iuO6955/m
         oaGdsgg7JQQA21CSt3Q/Zc2lC6rPIZl2opl4Shat202SjCV7ZduTlHNXDjkP+J4V3ysg
         oZNXwiOxKImbTmQcaw8Xb6eNUyZ0hnILlf6kJ38v8cZqfrYfVi0rTacc9fJm9gGp6+cO
         kpaG6OWsLJuJ0e3IYRWg+FG5RYmHVzicKq0kpkxBtuZtUfR5pU7DPxVthHNZCS6Bhb9n
         DDlw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JQ2RddO6;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=JQ2RddO6;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49Qd7QpA3CCAt22asH6vLRyKGMzkg2CBPKvT+yz82VoAbaCuE5rGHJ1Yhfn0U1aSO1wJGnGE+13zNzlqHSEckc=
MIME-Version: 1.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 23 Apr 2018 22:23:49 +0530
Message-ID: <CA+G9fYt_OKQOx7xFPsbgj8+vXDJGR0Oc3XWJ8iQfMM=UkFVAeQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/95] 4.9.96-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
	lkft-triage@lists.linaro.org, Ben Hutchings <ben.hutchings@codethink.co.uk>,
	linux- stable <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598455883527705799?=
X-GMAIL-MSGID: =?utf-8?q?1598556661186226003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22 April 2018 at 19:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.96 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Apr 24 13:51:53 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.96-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regression detected on arm64 devices Hikey and Juno.

Here is the list of bad commit patches to be reverted.
git bisect found first bad commit as "3"
but reverting 3 patch failed.
so i have to revert all four patches and boot test and the boot PASS on hikey.

1)
Theodore Ts'o <tytso@mit.edu>
    random: add new ioctl RNDRESEEDCRNG
2)
Theodore Ts'o <tytso@mit.edu>
    random: crng_reseed() should lock the crng instance that it is modifying
3)
Theodore Ts'o <tytso@mit.edu>
    random: set up the NUMA crng instances after the CRNG is fully initialized
4)
Theodore Ts'o <tytso@mit.edu>
    random: fix crng_ready() test

Additional details,
------------------------
Boot failed log details log can be found at,
https://lkft.validation.linaro.org/scheduler/job/193871#L3120

[    5.789114] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
[    5.794551] ------------[ cut here ]------------
[    5.799216] WARNING: CPU: 0 PID: 0 at /srv/oe/build/tmp-rpb-glibc/
work-shared/hikey/kernel-source/kernel/locking/lockdep.c:2879
lockdep_trace_alloc+0xc0/0xc8
[    5.813339] Modules linked in: fuse
[    5.816850]
[    5.818351] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.96-rc2 #1
[    5.824630] Hardware name: HiKey Development Board (DT)
[    5.829866] task: ffff000009104680 task.stack: ffff0000090f0000
[    5.835803] PC is at lockdep_trace_alloc+0xc0/0xc8
[    5.840605] LR is at lockdep_trace_alloc+0xc0/0xc8
[    5.845405] pc : [<ffff000008133778>] lr : [<ffff000008133778>]
pstate: 600001c5
[    5.852820] sp : ffff800077f02d60
[    5.856141] x29: ffff800077f02d60 x28: 0000000000007ffe
[    5.861472] x27: 0000000000004000 x26: ffff0000090fa508
[    5.866804] x25: 00000000000001c0 x24: ffff0000091ed000
[    5.872136] x23: ffff800005f03c80 x22: ffff00000867d864
[    5.877467] x21: 0000000000000008 x20: 00000000024088c0
[    5.882798] x19: 00000000000001c0 x18: 0000000000000010
[    5.888129] x17: 0000000000000007 x16: 0000000000000001
[    5.893460] x15: 0000000000000006 x14: ffff000089ebb12f
[    5.898791] x13: ffff000009ebb13d x12: ffff000009cb9930
[    5.904122] x11: ffff800077f02b40 x10: 000000000000017f
[    5.909454] x9 : 00000000ffffffd0 x8 : 0000000000000002
[    5.914785] x7 : ffff0000090f0000 x6 : ffff00000813de38
[    5.920117] x5 : 0000000000000000 x4 : 0000000000000001
[    5.925449] x3 : 0000000000000002 x2 : 000000000000000


Best regards
Naresh Kamboju
