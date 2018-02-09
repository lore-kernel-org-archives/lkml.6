Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2177121-1518207834-2-12163268839637310590
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518207834; b=HKdWkF/QEHWkMv48wL8eAVsyQe4qtHv38u1TNq10EieCdek
    ASoFPcXTSkYlFKRmIud1eJbaxLXQ1FVLCFMTlkZybip7hDXVFhGhMVbz9c6kP4/Z
    zN8g35i1Ei9U4Bjb7VkVWfXPM9yBtIl+L32JOnsixCowbepHdMi/+d6Om5cIYNsu
    ht/sIumsKhS31HlZUPd0gmzcTy6hhqE8RfkLgd4lVdM3KbM5WXuSQJ8SlgWr1hwK
    nVlw26SIQXA2vqK1fx5HqPg3dud6heZYXZuWI/66WZpDwiScFMb1KwZj7Fft5lms
    T5osCHNTQPnvgNuVv6BO+fbx3ASMtflrKoTEMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518207834; bh=cZVJb+aOVbX9kHyEnKrsQUN6rLtm/2ONZKRMn8
    kKgfU=; b=GPOoxeCjoK1Yx7IGLjGwXaeT5x2O7eiLAXpwzUKXfdlVoX7bp2Zy7N
    FyTMMCvPC5gRbVBAM1PyDOGe6dkEqubIuo9LOT0a4qAAB0CSHKxmp5qQ+o6iyQ8r
    3nAazB51I1HSFvukQJUA9dqu+m8XyypT4lJexIKUeHTDsJIjM+cs6FAAEl+44zNY
    no+OIUrgg1UquvmwRJnaES4NtofKuB2unedLNPWPDB+NAW+brPsxXYT9dh7KF9Af
    RJrDEEBQzGecw21YXxIgW7U4c/s3MxUo7PHPvl6HmSMfM5jfiO5kkzpuzD5XgfFr
    0TJgvy5N/2bDPnzcSKazHWGVtlCSZ5dA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeBIUXv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 15:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752409AbeBIUXv (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Feb 2018 15:23:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52858217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=khilman@kernel.org
X-Google-Smtp-Source: AH8x224QhE8pgoC7OJBsMi8LaXXRgLkQgoqLcSsSymO24fSQxLp4E4+x3/ZkZMmXBPNsDkkaDv6ZCNcqeHmRveS/uz0=
MIME-Version: 1.0
In-Reply-To: <5a7df838.2696df0a.9695f.475e@mx.google.com>
References: <20180209133934.024795822@linuxfoundation.org> <5a7df838.2696df0a.9695f.475e@mx.google.com>
From: Kevin Hilman <khilman@kernel.org>
Date: Fri, 9 Feb 2018 12:23:47 -0800
X-Gmail-Original-Message-ID: <CAOi56cU8LBDB5sQpouGiQEMyAntxospAxcJO1qmNj8aV57DVkQ@mail.gmail.com>
Message-ID: <CAOi56cU8LBDB5sQpouGiQEMyAntxospAxcJO1qmNj8aV57DVkQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/22] 4.14.19-stable review
To: "kernelci.org bot" <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 11:36 AM, kernelci.org bot <bot@kernelci.org> wrote:
> stable-rc/linux-4.14.y boot: 111 boots: 2 failed, 109 passed (v4.14.18-23-g8d861f5b27b0)
>
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.14.y/kernel/v4.14.18-23-g8d861f5b27b0/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.y/kernel/v4.14.18-23-g8d861f5b27b0/
>
> Tree: stable-rc
> Branch: linux-4.14.y
> Git Describe: v4.14.18-23-g8d861f5b27b0
> Git Commit: 8d861f5b27b05466ce2a9d3c4108367555dccefe
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 63 unique boards, 22 SoC families, 16 builds out of 185

TL;DR;  All is well.

> Boot Regressions Detected:
>
> arm64:
>
>     defconfig:
>         bcm2837-rpi-3-b:
>             lab-baylibre: new failure (last pass: v4.14.18-19-g44b8fc264b98)
>         r8a7795-salvator-x:
>             lab-baylibre: new failure (last pass: v4.14.18-19-g44b8fc264b98)

Both of these are a bootloader failure to TFTP a kernel image.

Kevin
