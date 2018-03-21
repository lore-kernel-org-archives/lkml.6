Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-331223-1521654613-2-9446484467270308071
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521654612; b=Gc2gGYksd4pNO0vuWoz1sdZVS93XNOwTBO/pwmNk1MPgVjh
    lH8cKxDCQ0Tl2DINr8qYQmlj9RVoBPjNUCbsOZSq5zWm/lME4L3jkYaDRNfjPRU1
    OOayrLPTgs/owcjOcVplg5k0/Trs1JyoKZQ/eQA1/AWIb8y2smVt6xPNayhYaB3W
    FfhYW9lE4Hm7XjAmKI4QtdrdndCze2uqrDYR86fhhJgPnl5VcN7MQ4nldXQ2gYLQ
    nf+5YFckEThsu/ejjPfsZTAK0prMm4BvrqmyBdgI3yynMWYTwM9VttPBjuH/XDNR
    LcJkOStwhjATVG6qDi/HLuPAppeAZrcKCBH7Nug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521654612; bh=sNON8r+xNyzVaB/AY148IJBOLqvmSr2pN5/90W7VcJQ=; b=b
    8aj7jk/f8F6SG2bAHHTpOTSbb30U6bnEfkXE7mxjqsuPtqXEsm8F9G4rR1zSWaLV
    EH2Q2yCoVdBF/PTI8H+QyErrE/Xtj/w6R7vn+2gHztGpwuzKO6Gw9nDiiyvi0H1G
    8rLLh2M6gjbMCNjaaEOVwVzWg1IvLn26uQH8XqxxFirkakom/dZv+AiSAIX6Rux0
    wIdadpmSpUn5nuXQDghMygqcyC4ya354hya8jggekb/y5S7LEnJDag2HFDTOAj0/
    bzXMs7q4u/7mDeMgfwUNa9GVdaC+AgK/1zNpM+kOItQ1rSDujDqX6IDSl2mYvI1X
    lODtjungZ1M3EptlJJ5Vg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Qbo9vUKJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hUkd04Ko;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Qbo9vUKJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hUkd04Ko;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeCURuJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 13:50:09 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39699 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbeCURuH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 13:50:07 -0400
X-Google-Smtp-Source: AG47ELst8XYTWnZZyn+OZqph/XZxCdCK8Nb5eqiiOVCNBUVixQwExmq/AouuZjP2ZOK4GhzV/lzF8vX8SAwvxkTikMg=
MIME-Version: 1.0
In-Reply-To: <20180321133256.GB21153@kroah.com>
References: <20180316152317.167709497@linuxfoundation.org> <CA+G9fYth+j=QNYM-6OBnxncfBruy6W7hXuw-Srt_RMSTqXQ=XQ@mail.gmail.com>
 <20180318102738.GF32470@kroah.com> <1521589759.23626.120.camel@codethink.co.uk>
 <20180321133256.GB21153@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 Mar 2018 23:20:04 +0530
Message-ID: <CA+G9fYs6qkB84N1Ghu4aaZ25tzXy7DHjOiGkd+8icT+fqQR8UQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/86] 4.9.88-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21 March 2018 at 19:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 20, 2018 at 11:49:19PM +0000, Ben Hutchings wrote:
>> On Sun, 2018-03-18 at 11:27 +0100, Greg Kroah-Hartman wrote:
>> > On Sat, Mar 17, 2018 at 03:48:24PM +0530, Naresh Kamboju wrote:
>> [...]
>> > > Results from Linaro=E2=80=99s test farm.
>> > > No regressions on arm64, arm, qemu_x86_64 and x86_64.
>> > >
>> > > NOTE:
>> > > CONFIG_LEGACY_VSYSCALL_EMULATE=3Dy is enabled from config as default=
.
>> > > Enabled vsyscall=3Dnative and vsyscall=3Dnone from kernel command li=
ne for testing
>> > > selftests/x86/test_vsyscall test case on x86_64 and qemu_x86_64.
>> > >
>> > > test_vdso_64 failed on x86_64 device when vsyscall=3Dnone is enabled=
.
>> > > We will investigate this new test failure.
>> >
>> > I think vsyscall=3Dnone just went away :)
>>
>> No, vsyscall=3Dnative went away upstream.  vsyscall=3Dnone should still
>> work everywhere.
>
> Ah, sorry, got that wrong, thanks for the correction.
>
>> However, test_vdso_64 isn't able to detect what the current
>> configuration is and it will crash with vsyscall=3Dnone (or the
>> equivalent default in kconfig).


Shall i skip running "test_vdso_64" when vsyscall=3Dnone ?
or
Shall we fix the test case to work when vsyscall=3Dnone ?

"test_vdso_64" test failed log when vsyscall=3Dnone on x86_64.
This is a combination of VSYSCALL_EMULATE=3Dy and kernel cmdline vsyscall=
=3Dnone
With this combination test PASS on qemu_x86_64 fails on real hardware.

[  744.132422] test_vdso_64[3957] vsyscall attempted with vsyscall=3Dnone
 ip:ffffffffff600800 cs:33 sp:7ffcf7192e18 ax:ffffffffff600800 si:7ffcf7192=
e4c
 di:7ffcf7192e40
[  744.146945] test_vdso_64[3957]: segfault at ffffffffff600800
 ip ffffffffff600800 sp 00007ffcf7192e18 error 15
[  744.157058] audit: type=3D1701 audit(1521968691.345:4): auid=3D429496729=
5
  uid=3D0 gid=3D0 ses=3D4294967295 subj=3Dkernel pid=3D3957 comm=3D\"test_v=
dso_64\"
  exe=3D\"/opt/kselftests/mainline/x86/test_vdso_64\" sig=3D11 res=3D1
./run_kselftest.sh: line 233:  3957 Segmentation fault
  (core dumped) ./test_vdso_64 > /tmp/test_vdso_64 2>&1
selftests: test_vdso_64 [FAIL]

>
> That's good to know.  Naresh, does that help out?

Yes it helps. Thanks

>
> thanks,
>
> greg k-h
