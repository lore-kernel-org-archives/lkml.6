Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971993AbeEYALK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:11:10 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45704 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935679AbeEYALF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:11:05 -0400
X-Google-Smtp-Source: ADUXVKKy3GehdF3mipcxE6ujtucHjmxbD7xZDB9xyTYN6CwX8/JsroO6PrLQ7GZ6lbciLMdIKWJIeA==
Date: Thu, 24 May 2018 19:11:02 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
Message-ID: <20180525001102.tuq5b7pyhnibddsb@xps>
Mail-Followup-To: Shuah Khan <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524180652.7bqyquqfe2nqdxfg@xps>
 <20180524181739.GB13327@roeck-us.net>
 <CA+G9fYuB=H6Dzd3u9hEOGcb1rCy2uvuLzhvgZ7LpmVeSXgYqvA@mail.gmail.com>
 <c088b1d1-7e4c-118f-972c-ef0cfe66658c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c088b1d1-7e4c-118f-972c-ef0cfe66658c@kernel.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 03:52:49PM -0600, Shuah Khan wrote:
> On 05/24/2018 03:34 PM, Naresh Kamboju wrote:
> > On 24 May 2018 at 23:47, Guenter Roeck <linux@roeck-us.net> wrote:
> >> On Thu, May 24, 2018 at 01:06:52PM -0500, Dan Rue wrote:
> >>> On Thu, May 24, 2018 at 11:37:37AM +0200, Greg Kroah-Hartman wrote:
> >>>> This is the start of the stable review cycle for the 4.4.133 release.
> >>>> There are 92 patches in this series, all will be posted as a response
> >>>> to this one.  If anyone has any issues with these being applied, please
> >>>> let me know.
> >>>>
> >>>> Responses should be made by Sat May 26 09:31:28 UTC 2018.
> >>>> Anything received after that time might be too late.
> >>>
> >>> Results from Linaro’s test farm.
> >>> No regressions on arm64, arm and x86_64.
> >>>
> >>> Summary
> >>> ------------------------------------------------------------------------
> >>>
> >>> kernel: 4.4.133-rc1
> >>> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >>> git branch: linux-4.4.y
> >>> git commit: 915a3d7cdea9daa9e9fb6b855f10c1312e6910c4
> >>> git describe: v4.4.132-93-g915a3d7cdea9
> >>> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.132-93-g915a3d7cdea9
> >>>
> >>>
> >>> No regressions (compared to build v4.4.132-71-g180635995c36)
> >>>
> >>
> >> Shouldn't this compare against v4.4.132 ?
> >>
> >> I looked into kselftest/rtnetlink.sh test results.
> >> The test history is a bit confusing.
> >>
> >> - v4.4.131-57-ge33795f7a573 and earlier passed
> >> - v4.4.132 failed
> >> - v4.4.132-30-ga102378c6551 passed
> >> ...
> >> - v4.4.132-70-gaa7ab28e9c5e passed
> >> - v4.4.132-71-g180635995c36 and later failed
> >>
> >> Does that mean that this specific test is unreliable ?
> > 
> > kselftest rtnetlink.sh test case failure is not a regression on 4.16,
> > 4.14, 4.9 and 4.4 builds.
> > Because it used to skip due to missing tc tool.
> > 
> > Now the ''tc' tool added to Open Embedded build and test running and
> > reported failed.
> > This is not a regression in the kernel.
> > It is a change in the user space.
> > 
> > Old output
> > ============
> > SKIP: Could not run test without the tc tool
> > selftests: rtnetlink.sh [PASS]
> > https://lkft.validation.linaro.org/scheduler/job/225015#L2255
> > 
> > 
> > New output
> > =============
> > RTNETLINK answers: Operation not supported
> > Cannot find device \"test-dummy0\"
> > FAIL: cannot add dummy interface
> > selftests: rtnetlink.sh [FAIL]
> > https://lkft.validation.linaro.org/scheduler/job/226352#L3375
> > 
> > Ref bug link:
> > https://bugs.linaro.org/show_bug.cgi?id=3834
> > 
> > - Naresh
> > 
> 
> Which kselftest versdion do you run? Is this from linux-next?

It's using kselftest from 4.16 (latest stable, as a rule). I think this
patch will fix the 'Operation not supported' issue:
https://patchwork.kernel.org/patch/10424807/

Dan
