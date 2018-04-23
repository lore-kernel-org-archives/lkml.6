Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1898641-1524522360-2-14896893997025572624
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524522359; b=Dni8Vk0sI0UOc8hvUJWJ3n4ZNBm4jSjiyE+bCIVmPdiSnGL9M5
    nKTo90XljqrYeRBtTtaMupfN46jclyD25cugOFCPuhNtVK2stinOU6m6OW4ZGhmg
    VnynKsJdTE5eYHjgC643Lb6ZcZez0YGTr2YJ7Qa1FaRZVa2O5ZqmYSRKU7eODfhw
    DqcwgVf4nk4h0tzz+hBIoTGPH+nEtrdDXxWERWyw8gPV2ld5Cr4G1FEBqwO/5cDA
    EP9kaVEfamzB6SGW0o/vOd4LyUOVDe2qIRnoGdcZfMLP/WYmZIbU0rSzw7IEh4J+
    xj9GSbodZQsNbOYK4vnox6sXLhLXeRcO+B8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524522359; bh=lR+Ke/+OQAA
    XBWNzUHx/5EJn7HGGHWNVLJ+n1YkCAts=; b=PPj/wfcreftCjl6mW8y6KWhIMzl
    BpCH1GFnW9BiscoWXOA9Ifxu4O5Mmmb9CiKRz3+oN7A66k9ukGCxrbQQq6T4yCCG
    ZaOHlCvpYKjQ5VdcH/Z7oS88Rizo0xJXxycHWZwk4GD6R780PC1OrJ2fV5/pUTgu
    FgyCB7E5NeMlf2B4yYfdpJtpWRG/MBBD33oCLeVx5sONMRayUftrVvlA0TzbJTAQ
    V2mfas76DqOskBPOYX6zx+Y5yXwJv9Wg+M30IhYD/BaEBDaI/tD99tfI7zbRug+3
    7zzXRGwbKl4/VNWzGKiA11QoXSFGVci2jj68fQwoFCU83C3kg2iuRMb3yvg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=dElPS/7E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LPxibX6V;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=dElPS/7E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LPxibX6V;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKoM7mgI8ZSCTklDLGIkP91ZcfvSXwFy3Zpftmopt7JMD1Ywe0fhsN2qO1BlVZtv+uo6F/1WR5xm44Qlpr863n2UW30bcmRbhx+GlIzjjjeIviZhwDTu
    XfzphIRYpledKreMbldelQrkwQ8/EaZoHzCh2/ePT3doXOREhIwytKn7sdYK9Y3qbVSfejP4bqIwAfnS2Q+SdxbBzOovc4LHBKqvjZRW+/D40znTUXWvnl4w
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=RMlRvZAwo0AA:10
    a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=lwGKUhC0Ut62Y2StlccA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932530AbeDWWZ4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 18:25:56 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:54990 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeDWWZz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 18:25:55 -0400
X-Google-Smtp-Source: AIpwx4+pckBx0K38bMs0cYDE0pTjxO856QaTJ4EoXTMR7sm/wrW2bRIbRyFh4RnaGi1a2ma7W8kSAQ==
Date: Mon, 23 Apr 2018 17:25:53 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, tytso@mit.edu
Subject: Re: [PATCH 4.9 00/95] 4.9.96-stable review
Message-ID: <20180423222553.lbxx3cwly2fbvabs@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, tytso@mit.edu
References: <20180422135210.432103639@linuxfoundation.org>
 <CA+G9fYt_OKQOx7xFPsbgj8+vXDJGR0Oc3XWJ8iQfMM=UkFVAeQ@mail.gmail.com>
 <20180423165750.GA27986@kroah.com>
 <20180423180137.GA26974@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180423180137.GA26974@kroah.com>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 08:01:37PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 23, 2018 at 06:57:50PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 23, 2018 at 10:23:49PM +0530, Naresh Kamboju wrote:
> > > On 22 April 2018 at 19:22, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > This is the start of the stable review cycle for the 4.9.96 release.
> > > > There are 95 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Tue Apr 24 13:51:53 UTC 2018.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.96-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > 
> > > Regression detected on arm64 devices Hikey and Juno.
> > > 
> > > Here is the list of bad commit patches to be reverted.
> > > git bisect found first bad commit as "3"
> > > but reverting 3 patch failed.
> > > so i have to revert all four patches and boot test and the boot PASS on hikey.
> > > 
> > > 1)
> > > Theodore Ts'o <tytso@mit.edu>
> > >     random: add new ioctl RNDRESEEDCRNG
> > > 2)
> > > Theodore Ts'o <tytso@mit.edu>
> > >     random: crng_reseed() should lock the crng instance that it is modifying
> > > 3)
> > > Theodore Ts'o <tytso@mit.edu>
> > >     random: set up the NUMA crng instances after the CRNG is fully initialized
> > 
> > This is the one I need to revert anyway.
> > 
> > Let me see if I can just drop that one and do a -rc3.  Give me a few
> > hours...
> 
> Ok, I've dropped just patch 3 from 4.16.y, 4.14.y and 4.9.y and pushed
> out -rc3 versions of all of these.  Let me know if that works or not for
> you.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

I made a few comments inline regarding the reported failures. Also, as
this report is pushing 200 lines now with all of our tests and
environments (about 8*22 test runs), I'm planning on making some changes
in the next few weeks to make it more concise and useful. Any
suggestions or feature requests are most welcome.

Summary
------------------------------------------------------------------------

kernel: 4.9.96-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: 8617c15e22fdfa0451d34bc07fb3f0fc85fbb310
git describe: v4.9.94-164-g8617c15e22fd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.94-164-g8617c15e22fd


No regressions (compared to build v4.9.94-165-g54c571bb567c)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20,
* kselftest - skip: 27, pass: 35, fail: 4
  ^ kselftest failures caused by kselftest upgrade to 4.16 (in all cases
  in this report)
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 19, fail: 2
  ^ this one is an intermittent failure specific to db410c.

* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 135, pass: 1015,
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - skip: 24, pass: 38, fail: 4
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 136, pass: 1014,
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - skip: 24, pass: 38, fail: 4
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 135, pass: 1015,
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 10, fail: 10
  ^ infrastructure issues
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
* ltp-fs_bind-tests - pass: 2,
* ltp-io-tests - pass: 3,
* ltp-securebits-tests - pass: 4,
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 20,
* kselftest - skip: 27, pass: 37, fail: 4
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 2,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-securebits-tests - pass: 4,
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 22,
* kselftest - skip: 13, pass: 4, fail: 2
* kselftest-vsyscall-mode-native - skip: 27, pass: 49, fail: 4
* kselftest-vsyscall-mode-none - skip: 27, pass: 49, fail: 4
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 147, pass: 1003,
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 19, fail: 1
* kselftest - skip: 24, pass: 37, fail: 4
* libhugetlbfs - skip: 1, pass: 87,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 2, pass: 20,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 75, pass: 1075,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 22,
* kselftest - skip: 25, pass: 51, fail: 4
* kselftest-vsyscall-mode-native - skip: 25, pass: 50, fail: 5
* kselftest-vsyscall-mode-none - skip: 25, pass: 51, fail: 4
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 5, pass: 9,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 116, pass: 1034,
* ltp-timers-tests - pass: 13,

-- 
Linaro QA (BETA)
https://qa-reports.linaro.org
