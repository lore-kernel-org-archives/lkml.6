Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2510764-1520530931-2-10736091334602512683
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520530930; b=Z2jjSKNaE241Vv04w+zDtK1jzKnoYtg9UkLIJFa7I5mO6tz
    sDagNKlRj2FJY4/C//CRldOxSXwVKvLCkqpsaePFPimBctoLqg2ALStWyAIKaHgo
    jhXAs/jZe27YSqQpvPwwH4qz5Ba7V065AfMCvKT8VR+bxmuNqIxOgpfRjtNGUmhF
    Fvxey4ACyJzIfOWwsT7MbNWJI0z0xJb4bWHBqWSAjJewG8JkeKn729OP38+KdJfK
    ipLAVehFSd91rHPWLeUDBEYznQMMDWDfmgnsWPo92Pv5DBR+l7E98QL1uFRO/roA
    cltHBMYlA7icBqoNdyyufr24BbDGXn+2N/bI67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520530930; bh=RqUN7DJc0Mt8jE5AejEMDfCghw
    P1B6OXnUlz/vDOqGc=; b=qrceir2dRjOHmiCqFf2OfjNXvpZNAIX7yz2omZqfNe
    +z2/IXUYiKOkGhBUFtRTxpoOk8bFRzhljHxc8P2+8yQxoIoRh6pxgpKUGKoZueuF
    HbmU42ajkDgy9NeMbG9CeSEL2xryYRQKPR8ZEg2yUcuZk+yUYgA6a6tV1CnLxZzM
    cNAD/PgbpiSuaAuZgh2V37Ds1wXafGzUncMLg8foprQ9jdr8ydsy/VmiS/q9wjT0
    nvhhVxZRD9dj/bvJCYIfJ5+upcvaAyDdXOmksOZhvzryx8Fj0Ag7uTatZo0/Vw0Q
    5YrdGlVTpcI8Gx09jlNYNI9MyL16zwxEt+UQ0dt/VvxQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934121AbeCHRmI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 12:42:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55880 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933221AbeCHRmI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 12:42:08 -0500
Date: Thu, 8 Mar 2018 14:42:03 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/122] 4.15.8-stable review
Message-ID: <20180308174202.GB3303@calabresa>
References: <20180307191729.190879024@linuxfoundation.org>
 <20180308103539.GA3409@calabresa>
 <20180308172723.GC22996@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308172723.GC22996@kroah.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 09:27:23AM -0800, Greg Kroah-Hartman wrote:
> On Thu, Mar 08, 2018 at 07:35:41AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > On Wed, Mar 07, 2018 at 11:36:52AM -0800, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.15.8 release.
> > > There are 122 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri Mar  9 19:16:43 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.8-rc1.gz
> > > or in the git tree and branch at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > > -------------
> > 
> > Merged, built on amd64, arm64, armhf, i386, ppc64el, s390x.
> 
> What do you mean by "merged"?

That I merged it with Ubuntu changes as in
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic.

> 
> And what are the results of the builds, do you boot them as well?  If

All builds succeeded. I was planning on reporting it if they failed, but
thought it would be useful to report that they succeeded just as well.

I have only booted the amd64 build on my own computer so far.

> you boot, are you running any tests on them?  Is this QEMU only or "real
> hardware"?
> 

We run tests on some (mostly virtual) machines for those different
architectures before they (the Ubuntu kernels) are released, but not on this
phase. In fact, we only merge them or do any build testing after they (your
stable releases) are tagged and pushed.

By my own account, I decided I would contribute somehow doing those build
tests, but might push for those tests to be run earlier, so we can report back
its results, if you find it would be useful.

Regards.
Cascardo.

> thanks,
> 
> greg k-h
