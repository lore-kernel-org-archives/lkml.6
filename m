Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969047AbeEXUcP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:32:15 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33881 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968994AbeEXUcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:32:12 -0400
X-Google-Smtp-Source: AB8JxZqmFPQymcay1uXnNu+5EIFkv47tVkcXZlv5kCCm/J0Ntv68leR9ctsjLKSFYurGawlNKGmOQtRqU0WMJvEA5lk=
MIME-Version: 1.0
In-Reply-To: <20180524190806.GE31019@kroah.com>
References: <20180524093159.286472249@linuxfoundation.org> <20180524180652.7bqyquqfe2nqdxfg@xps>
 <20180524190806.GE31019@kroah.com>
From: Rafael Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 24 May 2018 17:31:30 -0300
Message-ID: <CADtBP2B=Yb22dUjW-X-1OEGUvMX81gfpQ2FqFAaQUnExduwq7Q@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, ben.hutchings@codethink.co.uk,
        stable@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > kernel: 4.4.133-rc1
> > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > git branch: linux-4.4.y
> > git commit: 915a3d7cdea9daa9e9fb6b855f10c1312e6910c4
> > git describe: v4.4.132-93-g915a3d7cdea9
> > Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.132-93-g915a3d7cdea9
> >
> >
> > No regressions (compared to build v4.4.132-71-g180635995c36)
>
> It should have gotten better, as there was a fix in here for at least 2
> LTP tests that we previously were not passing.  I don't know why you all
> were not reporting that in the past, it took someone else randomly
> deciding to run LTP to report it to me...
>
> Why did an improvement in results not show up?

Are you referring to the CLOCK_MONOTONIC_RAW fix for the arm64 vDSO ?
I think that CLOCK_MONOTONIC_RAW in VDSO wasn't backported to 4.4.y
(commit 49eea433b326 in mainline) so this "fix" is changing the
timekeeping sauce (that would fix MONOTONIC RAW) but not for 4.4.y in
ARM64. Needs review though :\
