Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935791AbeEYGLy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 02:11:54 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:34966 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935619AbeEYGLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 02:11:51 -0400
X-Iguazu-Qid: 34tKJF2XmDARxaNvgA
X-Iguazu-QSIG: v=1; s=0; t=1527228675; q=34tKJF2XmDARxaNvgA; m=certYRU3T+t3Du3cguCet/uBY/IcasCqiX1y5eQ5C6c=
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: "'Rafael Tinoco'" <rafael.tinoco@linaro.org>
Cc: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
        <patches@kernelci.org>, <lkft-triage@lists.linaro.org>,
        <ben.hutchings@codethink.co.uk>, <stable@vger.kernel.org>,
        <akpm@linux-foundation.org>, <torvalds@linux-foundation.org>,
        <linux@roeck-us.net>
References: <20180524093159.286472249@linuxfoundation.org> <20180524180652.7bqyquqfe2nqdxfg@xps> <20180524190806.GE31019@kroah.com> <CADtBP2B=Yb22dUjW-X-1OEGUvMX81gfpQ2FqFAaQUnExduwq7Q@mail.gmail.com> <006a01d3f3c8$88c24c40$9a46e4c0$@toshiba.co.jp> <CADtBP2CDjgB_xizZdoKVQjxTcs7uKQccR3Phkd-0aEcogv912Q@mail.gmail.com>
In-Reply-To: <CADtBP2CDjgB_xizZdoKVQjxTcs7uKQccR3Phkd-0aEcogv912Q@mail.gmail.com>
Subject: RE: [PATCH 4.4 00/92] 4.4.133-stable review
Date: Fri, 25 May 2018 15:11:12 +0900
X-TSB-HOP: ON
Message-ID: <008501d3f3ef$2e39ce70$8aad6b50$@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHyOjw/2UIYPy6ZRGrtHaW6etfoGQJRUQMkAZFkJwoB+cXzNAHu0+UkAaAyxSOjt/AMUA==
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rafael Tinoco [mailto:rafael.tinoco@linaro.org]
> 
> Thank you Daniel! Will investigate those.

OK, thank you :).
Notice that I did those tests on x86_64. It seems you are testing on arm, so there may be some differences.

I just checked these tests on 4.4.133 (on x86_64):
fcntl35: PASS
fcntl35_64: PASS
select04: PASS

I am currently investigating other tests that are failing as well. They are not regressions, just some patches have not been backported yet.

Thanks,
Daniel


> 
> Meanwhile, Greg, I referred to:
> 
> time: Fix CLOCK_MONOTONIC_RAW sub-nanosecond accounting
> 
> Since we're not using this type of clock on arm64's 4.4 kernel vdso
> functions. This commit's description calls attention for it to be
> responsible for fixing kselftest flacking tests, we wouldn't get that
> on 4.4 according to bellow:
> 
> stable-rc-linux-4.14.y
> dbb236c1ceb6 arm64/vdso: Fix nsec handling for CLOCK_MONOTONIC_RAW
> 49eea433b326 arm64: Add support for CLOCK_MONOTONIC_RAW in
> clock_gettime() vDSO
> 82e88ff1ea94 hrtimer: Revert CLOCK_MONOTONIC_RAW support
> 9c808765e88e hrtimer: Add support for CLOCK_MONOTONIC_RAW
> 
> stable-rc-linux-4.16.y
> dbb236c1ceb6 arm64/vdso: Fix nsec handling for CLOCK_MONOTONIC_RAW
> 49eea433b326 arm64: Add support for CLOCK_MONOTONIC_RAW in
> clock_gettime() vDSO
> 82e88ff1ea94 hrtimer: Revert CLOCK_MONOTONIC_RAW support
> 9c808765e88e hrtimer: Add support for CLOCK_MONOTONIC_RAW
> 
> stable-rc-linux-4.4.y
> <none>
> 
> stable-rc-linux-4.9.y
> 99f66b5182a4 arm64/vdso: Fix nsec handling for CLOCK_MONOTONIC_RAW
> 49eea433b326 arm64: Add support for CLOCK_MONOTONIC_RAW in
> clock_gettime() vDSO
> 82e88ff1ea94 hrtimer: Revert CLOCK_MONOTONIC_RAW support
> 9c808765e88e hrtimer: Add support for CLOCK_MONOTONIC_RAW
> 
> Yet, the second fix was backported to all (including 4.4.y):
> 
> stable-rc-linux-4.14.y
> 3d88d56c5873 time: Fix CLOCK_MONOTONIC_RAW sub-nanosecond accounting
> stable-rc-linux-4.16.y
> 3d88d56c5873 time: Fix CLOCK_MONOTONIC_RAW sub-nanosecond accounting
> stable-rc-linux-4.4.y
> 7c8bd6e07430 time: Fix CLOCK_MONOTONIC_RAW sub-nanosecond accounting
> stable-rc-linux-4.9.y
> a53bfdda06ac time: Fix CLOCK_MONOTONIC_RAW sub-nanosecond accounting
> 
> Not sure you want to keep it in 4.4, thought it was worth mentioning it.
> 
> Cheers.
> 
> On 24 May 2018 at 22:34, Daniel Sangorrin
> <daniel.sangorrin@toshiba.co.jp> wrote:
> > Hello Rafael,
> >
> > The tests fcntl35 and fcntl35_64 should have go from FAIL to PASS.
> > https://www.spinics.net/lists/stable/msg239475.html
> >
> > Looking at
> >
> https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.132-93-g915a
> 3d7cdea9/testrun/228569/suite/ltp-syscalls-tests/tests/
> > I see that these two tests (and other important tests as well) are being SKIPPED.
> >
> > By the way, I see that select04 FAILS in your case. But in my setup, select04 was
> working fine (x86_64) in 4.4.132. I will confirm that it still works in 4.4.133
> >
> > Thanks,
> > Daniel Sangorrin
> >
> >> -----Original Message-----
> >> From: stable-owner@vger.kernel.org [mailto:stable-owner@vger.kernel.org]
> On
> >> Behalf Of Rafael Tinoco
> >> Sent: Friday, May 25, 2018 5:32 AM
> >> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: linux-kernel@vger.kernel.org; shuah@kernel.org; patches@kernelci.org;
> >> lkft-triage@lists.linaro.org; ben.hutchings@codethink.co.uk;
> >> stable@vger.kernel.org; akpm@linux-foundation.org;
> >> torvalds@linux-foundation.org; linux@roeck-us.net
> >> Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
> >>
> >> > > kernel: 4.4.133-rc1
> >> > > git repo:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >> > > git branch: linux-4.4.y
> >> > > git commit: 915a3d7cdea9daa9e9fb6b855f10c1312e6910c4
> >> > > git describe: v4.4.132-93-g915a3d7cdea9
> >> > > Test details:
> >>
> https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.132-93-g915a
> >> 3d7cdea9
> >> > >
> >> > >
> >> > > No regressions (compared to build v4.4.132-71-g180635995c36)
> >> >
> >> > It should have gotten better, as there was a fix in here for at least 2
> >> > LTP tests that we previously were not passing.  I don't know why you all
> >> > were not reporting that in the past, it took someone else randomly
> >> > deciding to run LTP to report it to me...
> >> >
> >> > Why did an improvement in results not show up?
> >>
> >> Are you referring to the CLOCK_MONOTONIC_RAW fix for the arm64 vDSO ?
> >> I think that CLOCK_MONOTONIC_RAW in VDSO wasn't backported to 4.4.y
> >> (commit 49eea433b326 in mainline) so this "fix" is changing the
> >> timekeeping sauce (that would fix MONOTONIC RAW) but not for 4.4.y in
> >> ARM64. Needs review though :\
> >
> >
> >
