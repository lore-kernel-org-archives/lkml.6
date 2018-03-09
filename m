Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065042-1520617763-2-13610630378954280819
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520617762; b=NfPLMzyei32aR3ykvjG0uy34Xa/DGmL6WlY+dlj7oLu/2Wr
    l/ZMPiQ2a5xo4mPhYW1yPRrxao+yYH+b1bT3BkoPh1Qj95Q/R/nJDzyBlwNnMze7
    9YCG1y+g7YNOpdI/Ei/lko/JtRaTkcQagylZoSwYq2mY7B7MI3BLbUeMqEw+KpeP
    fsIRzo/O/UJgZkdSBD52/b1y8iZJTpeXGj8B/XqS1dC256ng7wQe5cs8eT48lJ1C
    lGhQ3hfC+rS6RlWdkiB4tMp+6U/9w2jkreqm3ZyfPdgqALXTP1J3yxu/+PaLVkqM
    Kln2DP7AVrhxR/zb3V5dsYq7MHUX7CCXykOmyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=arctest; t=1520617762; bh=885V02qwsPCBBpUhLtQnw72Wlu
    dQcP/QdwdH3eX9NNQ=; b=oUJiERAcIWFW6rfxNM1RJLvW5uZuWBBnBe0vbZv7U7
    0Gf+C6zfEB4YOtvtk+0BvO+rxdmeAV9ugzH8peHjwIwgK53/zyEjIzouGNseSN7o
    WZdaBgYz+tjU+FSXVauxRzAYbnb3Ujsm9J0KJ4SBtmEncCBfvs6Ib/+JdXd1cPwp
    4x5CTkdmP1Y0eoUUsqYjb/6HGGLuRtRyDIPNXnescKWrOdoAVub/6/zdumrM0kky
    J9XjTUeSCLfrsa6cQ7miaVmm8oi0g/SkLsc9ymkgXQTSHJLTsS086Knm7rV2WXSU
    mlwGvEBjj36XgS/jO0khVo+GZwpyxzgK9q5DTN5mKmwQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b=JcWzQHsM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=baylibre.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tNQIuc1g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=baylibre.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b=JcWzQHsM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=baylibre.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tNQIuc1g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=baylibre.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeCIRtU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 12:49:20 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37553 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeCIRtT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 12:49:19 -0500
X-Google-Smtp-Source: AG47ELvxS2gotAJGh/T3XOHE8v7grIB8mvaIlwJ+8M70LVIal7+UQlc6gC+jF+O4RB8c+S3WJN3sOg==
From: Kevin Hilman <khilman@baylibre.com>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: "kernelci.org bot" <bot@kernelci.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, kernelci@free-electrons.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: Re: [PATCH 4.14 000/110] 4.14.25-stable review
Organization: BayLibre
References: <20180307191039.748351103@linuxfoundation.org>
        <5aa0b9c4.f8aedf0a.117e1.748d@mx.google.com>
        <7h4llqf70y.fsf@baylibre.com>
        <20180309080235.xu2ocjy3axsbn3wz@qschulz>
Date: Fri, 09 Mar 2018 09:49:15 -0800
In-Reply-To: <20180309080235.xu2ocjy3axsbn3wz@qschulz> (Quentin Schulz's
        message of "Fri, 9 Mar 2018 09:02:35 +0100")
Message-ID: <7hr2otdtr8.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[+ Guillaume Tucker ]

Quentin Schulz <quentin.schulz@bootlin.com> writes:

> Hi Kevin,
>
> On Thu, Mar 08, 2018 at 04:05:01PM -0800, Kevin Hilman wrote:
>> kernelci.org bot <bot@kernelci.org> writes:
>> 
>> > stable-rc/linux-4.14.y boot: 148 boots: 4 failed, 133 passed with 7 offline, 3 untried/unknown, 1 conflict (v4.14.24-111-g66060ac1dfa0)
>> >
>> > Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.14.y/kernel/v4.14.24-111-g66060ac1dfa0/
>> > Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.y/kernel/v4.14.24-111-g66060ac1dfa0/
>> >
>> > Tree: stable-rc
>> > Branch: linux-4.14.y
>> > Git Describe: v4.14.24-111-g66060ac1dfa0
>> > Git Commit: 66060ac1dfa02f02646a55f6ed888c0f2001623e
>> > Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>> > Tested: 76 unique boards, 23 SoC families, 17 builds out of 182
>> 
>> TL;DR; All is well.
>> 
>> > Boot Regressions Detected:
>> >
>> > arm:
>> >
>> >     davinci_all_defconfig:
>> >         da850-evm:
>> >             lab-baylibre-seattle: failing since 1 day (last pass: v4.14.4-76-gf91a57b206e0 - first fail: v4.14.24)
>> 
>> Operator error in my lab.
>> 
>> >     multi_v7_defconfig:
>> >         armada-375-db:
>> >             lab-free-electrons: new failure (last pass: v4.14.24)
>
> We're having a hard time with the serial of the armada 375 db since the
> beginning. We're trying to find solutions to get a more reliable serial.
>
>> >         sun8i-h3-orangepi-pc:
>> >             lab-free-electrons: failing since 1 day (last pass: v4.14.18-23-g8d861f5b27b0 - first fail: v4.14.24)
>> >
>> >     sunxi_defconfig:
>> >         sun8i-h3-orangepi-pc:
>> >             lab-free-electrons: failing since 5 days (last pass: v4.14.18-23-g8d861f5b27b0 - first fail: v4.14.23-116-g0ae11358b0bd)
>> 
>> These three are also not kernel issues.  Seems the lab having problems
>> connecting to the boards.  Cc'd Free Electrons team for closer look.
>
> It seems like the bootloader is corrupted somehow. I'll reflash it.
>
> These issues are definitely not kernel ones as you rightfully stated.
> IIRC, LAVA in its latest version has updated the returned status of jobs
> and shouldn't return the same error if it fails before actually starting
> the kernel. For example, I have a "Job error: bootloader-interrupt timed
> out after 294 seconds" for the OrangePi.
>
> While we really appreciate you giving us feedback on these issues, I
> think they shouldn't be mentioned in your overall boot summary (or at
> least in a different section than kernel errors).

Agreed.  This is work in progress.

> Or maybe you're waiting on all labs to migrate to v2018.02+ so that all
> have this enhanced job status report before actually using it?

I added Guillaume for clarifcation, but I thought once the lab is
upgraded, it should report these issues as OFFLINE instead of FAIL.

It might be that the kernelCI backend changes haven't been merged into
production yet.  Hopepfully Guil

Kevin
