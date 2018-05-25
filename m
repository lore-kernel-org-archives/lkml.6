Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964782AbeEYCYW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:24:22 -0400
Received: from mo-csw-fb1116.securemx.jp ([210.130.202.175]:38430 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935184AbeEYCYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:24:16 -0400
X-Iguazu-Qid: 2wGqt639vbQqP7Y0BM
X-Iguazu-QSIG: v=1; s=0; t=1527212078; q=2wGqt639vbQqP7Y0BM; m=4JEGKXbB2FsiupPvK7SdkP/ADHAkuz3l9JYVIb3oFYw=
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: "'Rafael Tinoco'" <rafael.tinoco@linaro.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc: <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
        <patches@kernelci.org>, <lkft-triage@lists.linaro.org>,
        <ben.hutchings@codethink.co.uk>, <stable@vger.kernel.org>,
        <akpm@linux-foundation.org>, <torvalds@linux-foundation.org>,
        <linux@roeck-us.net>
References: <20180524093159.286472249@linuxfoundation.org> <20180524180652.7bqyquqfe2nqdxfg@xps> <20180524190806.GE31019@kroah.com> <CADtBP2B=Yb22dUjW-X-1OEGUvMX81gfpQ2FqFAaQUnExduwq7Q@mail.gmail.com>
In-Reply-To: <CADtBP2B=Yb22dUjW-X-1OEGUvMX81gfpQ2FqFAaQUnExduwq7Q@mail.gmail.com>
Subject: RE: [PATCH 4.4 00/92] 4.4.133-stable review
Date: Fri, 25 May 2018 10:34:33 +0900
X-TSB-HOP: ON
Message-ID: <006a01d3f3c8$88c24c40$9a46e4c0$@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHyOjw/2UIYPy6ZRGrtHaW6etfoGQJRUQMkAZFkJwoB+cXzNKPUNgMQ
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafael,

The tests fcntl35 and fcntl35_64 should have go from FAIL to PASS.
https://www.spinics.net/lists/stable/msg239475.html

Looking at
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.132-93-g915a3d7cdea9/testrun/228569/suite/ltp-syscalls-tests/tests/
I see that these two tests (and other important tests as well) are being SKIPPED.

By the way, I see that select04 FAILS in your case. But in my setup, select04 was working fine (x86_64) in 4.4.132. I will confirm that it still works in 4.4.133

Thanks,
Daniel Sangorrin

> -----Original Message-----
> From: stable-owner@vger.kernel.org [mailto:stable-owner@vger.kernel.org] On
> Behalf Of Rafael Tinoco
> Sent: Friday, May 25, 2018 5:32 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org; shuah@kernel.org; patches@kernelci.org;
> lkft-triage@lists.linaro.org; ben.hutchings@codethink.co.uk;
> stable@vger.kernel.org; akpm@linux-foundation.org;
> torvalds@linux-foundation.org; linux@roeck-us.net
> Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
> 
> > > kernel: 4.4.133-rc1
> > > git repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > git branch: linux-4.4.y
> > > git commit: 915a3d7cdea9daa9e9fb6b855f10c1312e6910c4
> > > git describe: v4.4.132-93-g915a3d7cdea9
> > > Test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.132-93-g915a
> 3d7cdea9
> > >
> > >
> > > No regressions (compared to build v4.4.132-71-g180635995c36)
> >
> > It should have gotten better, as there was a fix in here for at least 2
> > LTP tests that we previously were not passing.  I don't know why you all
> > were not reporting that in the past, it took someone else randomly
> > deciding to run LTP to report it to me...
> >
> > Why did an improvement in results not show up?
> 
> Are you referring to the CLOCK_MONOTONIC_RAW fix for the arm64 vDSO ?
> I think that CLOCK_MONOTONIC_RAW in VDSO wasn't backported to 4.4.y
> (commit 49eea433b326 in mainline) so this "fix" is changing the
> timekeeping sauce (that would fix MONOTONIC RAW) but not for 4.4.y in
> ARM64. Needs review though :\
