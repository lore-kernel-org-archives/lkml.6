Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2543453-1524554756-2-17455576769677597494
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524554755; b=wkOeciFP6s9F+8SepXM2p8maecb+UZTT6rwZ3RVaQKQFW5Qd9Q
    7zCwyk5KIdTjNRuyqrya3vX7wiGl7XZLMS+CvPWCVRdDR9OGXW7HykbTndNi2MV7
    2RlB7cLVpxNAHscB4ZEpotUom0/j5zpUCiMlWWC1wYv/J5pq2ZC/tF6mt8tg7vHh
    ehy1W6N/vafEvx3TyNqjTVo/70cQyLrLveIKc/XbhKYqjFUSH5dWyMN2AeRVxz3A
    8lfv6PCZpdGB7/hY4PAXIJ3lxf7vwPbWqFalOg2NST6NGAHTI97YEhn+8xY1SZSN
    71MmlOjHPHcjU0MlDAF0zok6p5ZjXu6lh97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524554755; bh=1tjeR9cDUIi
    Qtc5tTaGu2VezkIXzcM0Y1uAjk4BYobs=; b=kI/r0qVlLwVCL7JKvo4CpCwCVRA
    gt/entmGu8Zeks/25oAubxMOiS2Op8mJCNRWaEvNrxcGe1X8hdF9WXkudGei4OOq
    lPuVZDbPMN4zNaVHmXckXfHI073jOSdUxaf1+r8G/OuzrMCcbAcoFY9ck2HETjFY
    MtS26mg0mz30EBW41P1Yq+TDOzMVPgkyhlhW3N8CN1DXEtB9q593Yf900bq3Lznr
    DNTfgSp6kUn+TG+ugcMZqGQY6utU6AkqyAJpvGt5d2cLkywE+002CEzQ4PFo6/Vy
    BAooYCrGM0WOIxJYNRwsIrmVmuGb5e2RjKyYj3oo/QLTgfFQpM6XhugI7ew==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfApJ/Bjz2jQ7ZhDgu/h87L6a3umIKF3e41nJyr7JGf/FXiYrg4daM+XQArbcb3FO2C/vZ5DZFRcKhYPkPtCYrUot8X9D0Vh+R4VyFsLqAZKfEsiSpxW1
    8kZZwhkP6zNwDyj62HHbKzbOk7GcUhrspEPJF+DNlrI1b3TyBKyEY80IPgRXbajGpeTmuwrre9TSGJw/NcnWzEzuYTM22Vk6KwRH8INRSTAtHptv7fyOJ4qW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=mxXUtGV5dC8A:10
    a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=NHK9Jni_Rvh18itvlagA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756023AbeDXHZy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 03:25:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755224AbeDXHZy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 03:25:54 -0400
Date: Tue, 24 Apr 2018 09:25:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 000/164] 4.14.36-stable review
Message-ID: <20180424072547.GC18419@kroah.com>
References: <20180422135135.400265110@linuxfoundation.org>
 <CA+G9fYs94xCb+hzFymcAbumR0+a-kGmcAqd4U3jxtLeyxBWzpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYs94xCb+hzFymcAbumR0+a-kGmcAqd4U3jxtLeyxBWzpg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 11:31:27AM +0530, Naresh Kamboju wrote:
> On 22 April 2018 at 19:21, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.14.36 release.
> > There are 164 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue Apr 24 13:51:05 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.36-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Yeah!

greg k-h
