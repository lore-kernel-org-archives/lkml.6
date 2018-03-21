Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3996454-1521637920-2-1196345053119971604
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521637919; b=XsGzqgN/luSg9pp0u2HUCIEorZFqKSZ7AWhQBBJIZ/wPY2L
    4nUf98F8472AAQTF+PefFBpVGJME8CJJr/uIY9aEdzBiIx9397yz9K2Q3fPewZSj
    iUDklqBhMzzq0R4Jpor+68NbTZmdCYI5aS+6Fa/WQ/IlesEZ/FBMs3NQkcdQTpXd
    o6U9UQZwBP5kFBgwH0oJt4Eo9GKuvTvvHcNXdy1KtBqsEHh67z9QoUCpiypqk/TP
    nAdo7QymcygSzzNgxVbusDAuy+znzKBPkkosj8aHtNRy4lo9WDQkU5RUKiSK1Chy
    XPF8n98kaEwHIc84hffrHE+ijCFElM+P5SoXNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521637919; bh=N1l2LvFOw1a7f5Si21G4PKDuaS
    DJdEfXsLt8yOmRhsc=; b=buaQImDV7G9j6+ZwgBHR01MnmsbAs58+S+V+a7Mja+
    PueE2s4X21wj3kt/wheJr+7JqPuW8eVVTpB04fhBNqZEbV6gfi6o9usFZOUnIr95
    9d0uvFrDS1R3OYof940s6CKiK/jJb3be5nouRseGOgufqgzkV/8LRqEPPaeTePTQ
    qL8ZZU+peBbthlZCVPiCLThOEkqScphV1GnB4Llug1t0mC0s9teC+/V4qgZiOpFz
    aseOBGqY87JBb3yUPUxvSvVG5YDD522sFNDKRxFCDy7UtKHwGidXcjr8gQ0x3jXN
    Rn3nlpDUKCo5WHIwIG0BOvntD+sNKT9yIVFyjo5GluuQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeCUNL5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 09:11:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34954 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeCUNL4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 09:11:56 -0400
Date: Wed, 21 Mar 2018 14:11:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
Message-ID: <20180321131154.GA11241@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <29591855-050f-073a-bc29-f0ff2832ab40@roeck-us.net>
 <20180321052911.GA14175@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321052911.GA14175@flashbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 10:29:11PM -0700, Nathan Chancellor wrote:
> On Tue, Mar 20, 2018 at 06:32:00AM -0700, Guenter Roeck wrote:
> > On 03/19/2018 11:04 AM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.4.123 release.
> > > There are 134 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > For v4.4.122-134-gb4e03b4:
> > 
> > Build results:
> > 	total: 145 pass: 140 fail: 5
> > Failed builds:
> > 	arm:allmodconfig
> > 	powerpc:defconfig
> > 	powerpc:allmodconfig
> > 	powerpc:cell_defconfig
> > 	powerpc:maple_defconfig
> > 
> > arm:allmodconfig:
> > 
> > drivers/net/ethernet/marvell/mvpp2.c: In function 'mvpp2_probe':
> > drivers/net/ethernet/marvell/mvpp2.c:6451:10: error: 'struct mvpp2' has no member named 'hw_version'
> >   if (priv->hw_version == MVPP22) {
> >           ^
> > drivers/net/ethernet/marvell/mvpp2.c:6451:26: error: 'MVPP22' undeclared (first use in this function)
> >   if (priv->hw_version == MVPP22) {
> > 
> 
> Caused by commit 6349601ed3e1 ("net: mvpp2: set dma mask and coherent
> dma mask on PPv2.2"), which seems irrelevant for 4.4 since PPv2.2
> support was added in 4.12 per upstream commit fc5e1550e5c3 ("net: mvpp2:
> finally add the PPv2.2 compatible string").

Dropped from both the 4.4.y and 4.9.y trees (I saw it was failing the
build in 4.9.y as well.)

thanks,

greg k-h
