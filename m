Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971980AbeEYAqI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:46:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42573 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970030AbeEYAqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:46:04 -0400
X-Google-Smtp-Source: ADUXVKKETtAtZMHZn0+n7l+G4txNQV/+wV8UYpzHHmOMUJId9DGlfajIc3ZA2ql69DYdOlGJ70UZeg==
Date: Thu, 24 May 2018 19:46:02 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, ben.hutchings@codethink.co.uk,
        stable@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
Message-ID: <20180525004602.gh3ys4dbj6panv2y@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524180652.7bqyquqfe2nqdxfg@xps>
 <20180524190806.GE31019@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524190806.GE31019@kroah.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 09:08:06PM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 24, 2018 at 01:06:52PM -0500, Dan Rue wrote:
> > On Thu, May 24, 2018 at 11:37:37AM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.4.133 release.
> > > There are 92 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat May 26 09:31:28 UTC 2018.
> > > Anything received after that time might be too late.
> > 
> > Results from Linaro’s test farm.
> > No regressions on arm64, arm and x86_64.
> > 
> > Summary
> > ------------------------------------------------------------------------
> > 
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

Our normal process for failing tests is to skip them and then
fix/report/etc separately until they're fixed, at which time we
re-enable them. Otherwise, we would have to wade through too many
failures in every result set, and we could miss actual regressions.
We've never really reported things as they've been fixed - just
immediate regressions.

However! We are working on 'known issue' support in qa-reports (SQUAD),
so that we can run failing tests and the system will mark them as a
known failure. This will allow us to keep our baseline 'green', and also
let us run the failing tests so that we can see in realtime as issues
get fixed. Once we have that, the only tests that we'll carry on our
skiplists are those that cause boards to crash or reboot.

If you have the test cases in mind, I can check them. Otherwise, I can
run our full set of tests in staging (without a skiplist) tomorrow and
see if any are now passing.

Dan
