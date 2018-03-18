Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3741325-1521368863-2-1103480504875563744
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521368863; b=wnAHpF5IS7LOHID27C+R1fYGKc9F1FYaOJzp/WAROGgrE8l
    d4vyIv7ER5rcAP74nm8BBHNBc5KQrF4g8FdbOTQ3OLaEgIVbOlYcMaUdL8iOywGs
    Fm3ThDG6VpAj3Wgvh0CdlLnMd8YXS0jRpfLPWsELGJfBARdrB4doGqOibsjEA5WI
    BaTilNd0269EiLJky93293LHR4WWH4eOxelaCAwDx/wEU5sHWOY5BVz7UitOgQ/v
    PCS1lyL+95H6O3qtarYfTEv3HJIyapvRwfM3u6LYA9h40+Zfrzh6AIykX2yaKtrP
    RXMsfkB4rBqHqCPmR6GdfJw+qk0mUhla9IcBJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521368863; bh=I12SLjz
    muYYVwrhjc2EMCWHtzdE3Pqm9hAcN/icyNlE=; b=NsAhHrPXDBWOT8fO7o9h03H
    UfGcQ7jBnPs4fgVicMLKmXd9eapqJRKG4nuoQ6xFVX784bAIFZJGFSUIRbk5QD1m
    ZCgZzQkF2REjLfcaAAW2YQj4VcfsAYQN8I33HPILA1hN6W3sF/HB+xR/ofBNKXV2
    RSxNxgbTQQXJk+JB7M6dY8IWJfX7vBywXxi8R8zlWiAEdv7G8Xzibk7nEx7jfjCf
    JenI3IwA5LAh9BfsT51+nwu76QtJousQZfb3khHXwPUzTZ8fpmz67Rxrh1pMNgUs
    zLxfYal8YUqCrE7sd54GmbagfB9N+WtoXTPgLk6U50JAVhlrb+z7f/K9e0KhB4g=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeCRK1k (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 06:27:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeCRK1k (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 06:27:40 -0400
Date: Sun, 18 Mar 2018 11:27:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.9 00/86] 4.9.88-stable review
Message-ID: <20180318102738.GF32470@kroah.com>
References: <20180316152317.167709497@linuxfoundation.org>
 <CA+G9fYth+j=QNYM-6OBnxncfBruy6W7hXuw-Srt_RMSTqXQ=XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYth+j=QNYM-6OBnxncfBruy6W7hXuw-Srt_RMSTqXQ=XQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 03:48:24PM +0530, Naresh Kamboju wrote:
> On 16 March 2018 at 20:52, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.9.88 release.
> > There are 86 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Mar 18 15:22:47 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.88-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, qemu_x86_64 and x86_64.
> 
> NOTE:
> CONFIG_LEGACY_VSYSCALL_EMULATE=y is enabled from config as default.
> Enabled vsyscall=native and vsyscall=none from kernel command line for testing
> selftests/x86/test_vsyscall test case on x86_64 and qemu_x86_64.
> 
> test_vdso_64 failed on x86_64 device when vsyscall=none is enabled.
> We will investigate this new test failure.

I think vsyscall=none just went away :)

thanks,

greg k-h
