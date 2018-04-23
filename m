Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-962895-1524477257-2-13261715959996362612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524477256; b=PjsmyDIxNu1N54yRjQXCHqg3YEWSnresERKqLVtWIipenA5PXo
    I2Kp0dp4h+JZixFfWjuu0qnO4loaZpngDQXGxgxXmq4sOhv4nBLZPpaXbS+MW98i
    2Yv8i521bC0Cw/P2Ej2gf5xj7O4ASe6aFKJVBRwThs+asUru8WT+K61tPu7Gn7VO
    VH4Imv6e1xErE6vcmF732Shgsp8hHft6sXkhtG4I1hNah9N9rDrvMzCxD7ws8SM8
    Vgs2p8/9KNRQelUFLpqGg8AYb9nUlFg0MIpZUYGZCcItRRTCqCIfUoS94LbcRpcm
    xsPe6W/tCGGz8VzIQJxSncGsdXE2diZxIRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524477256; bh=0I0JyUqJrDq+9g+WhIoIU/w5DYV7RKYZV4s1wBCI8D
    M=; b=OZ/1zQNgJApin9v2uHfD/lhAnLZLwX5Bmd6/CMrBQN8Ypwseqj5NMGEl0f
    3kqTcoJMZ8t1l8/3g+oD3X7YT8as6VJG3AeuwmUpvB+A71cUgdBl5a0ULPbRqv48
    6aLDT6Z14rd6mo/s2yfoYeMdnrkuibJJm/OfCBF5ayMJdRUAF20ayGLo5bnYI/sE
    w0wlFI6aLqHDuAtlw3x79x9sZb4pkPeUtcrVyQTWqLbGDNFFIUWhgulSEZy3Br5e
    CKiSr7nCK3GoBVkng1EGqLncRlHY1uIrE/VyeymoPP8/M5nZAtaCRojqg0PopGM2
    OGdn82cyLtnJ7N+LnJMsuFGioerA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=CES/wpml x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gqdy3QKw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=CES/wpml x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gqdy3QKw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF/07aTHSfTHzbra/DQK4AWsZofSopCGAlE0NUaVuW71CeEUfOB9GPF3cKrRvKAtLdfZjnvbr9jJLEkKYJTT9nJmPHpLCqUZHfOC63qy2ISTY1HN8N3P
    qL4pyDGRwo39sF0B7LhISj+XmqNJBTKAF+mq+A6IvI4v7Jd56NIMXnSrVlhMQICaQRHujTKnY4M7a+Hd6KsEDCfaDAT3t++7Bv9aRUGtoSFXFfTEAijMCeZz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=RMlRvZAwo0AA:10
    a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=hTwAogZJNQr__nulrw4A:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeDWJyN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 05:54:13 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38648 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbeDWJyM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 05:54:12 -0400
X-Google-Smtp-Source: AIpwx4/S0x4nhUnHNAU759rK64kId+EmSQykALCVPH/y6sx3UT/RV5UIeJJYqlUUyJ0jHWRqHqNV6FhoCaefrmkAHbo=
MIME-Version: 1.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 23 Apr 2018 15:24:10 +0530
Message-ID: <CA+G9fYttQ_ZsqhyROxYvH_hOOKQu6V0E8jRoLcCFeM_ALZLy5w@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/95] 4.9.96-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
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
Boot pass on arm64 dragonboard 410c board and qemu arm64.

I have started bisecting this problem.

Boot log:
------------
[    5.521472] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
[    5.526923] ------------[ cut here ]------------
[    5.526940] WARNING: CPU: 0 PID: 1331 at /srv/oe/build/tmp-rpb-glibc/
work-shared/hikey/kernel-source/kernel/locking/lockdep.c:2879
lockdep_trace_alloc+0xc0/0xc8

[    5.526943] Modules linked in:
[    5.526946]  fuse
[    5.526958] CPU: 0 PID: 1331 Comm: systemd-cgroups Not tainted 4.9.96-rc1 #1
[    5.526960] Hardware name: HiKey Development Board (DT)
[    5.526963] task: ffff800074241600 task.stack: ffff8000739e8000
[    5.526968] PC is at lockdep_trace_alloc+0xc0/0xc8
[    5.526973] LR is at lockdep_trace_alloc+0xc0/0xc8

Details log can be found at,
https://lkft.validation.linaro.org/scheduler/job/192779#L3095
and
4.9.96-rc2
https://lkft.validation.linaro.org/scheduler/job/193871

Best regards
Naresh Kamboju
