Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1266991-1517672686-6-9272758519970625028
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517672686; b=p+RjXv1EMFkCClh0qbzPSKMhOy/xgsSG8GC9+X7rRSvkwPB
    ENO0nmZghEe9AaOKrMggX0nFdqPlP1I173cjdIMb7GDmGvr6RsrhH45lUXd6bCny
    nyMtwhXKY2jb+v7VFj2vbv5vYF3MeOgurkVQ9vwE0uDvZfFf+IRVzRQq6aSbnAG9
    /jEHnysLdxAqRFQPxTov+kw/0RdQzjv/d0J7xcGavFyk3OQCUXUZMv4zMZrdWlPx
    HThvWxj39WzoKS89vas4D2IcqbouFDPeLbyeKYhMqDsRk5TN5Ipzq3mbc26CUINo
    d2BTu/ty5IJyuVkV5JblO+Vx/KWiacTUr8Fl3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517672686; bh=FG7XehLNglcBVa7Zt0u43ZV8CC
    xoWNL4BRMXmwbQA/E=; b=iHNSuHzIkLD6f6rLzWbcTn7/6FG3dOVswMZyaM1zUT
    MihvHisu5PaUiIKqSne3SXELbBGfJzth7/QEQg9/VifI2rOdr0Pekf4r4cPrgrcC
    YMrcSG2mqfd3Jxc1dMJHLwaEYEhq2fq4roYL6Zvb5GJiAeWDwe9ZdscNc2u84RWB
    oxx+NZTIhzm80+Cl9peqXTRPJHgqupjpeXm3sxtKlOhh1iV4HgzlbUeozzibf1GY
    eulPEKNiKxZQyV5T7ah7bxpo/YoFLv+wcSM2mCKPQRKi3BPQdgOGT24Cym3Iv1oh
    CBi3Su821hswYcl3kW9jPcxac2LfXCrwUFFrz2EKJozQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeBCPoo (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 10:44:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36978 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbeBCPoo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 10:44:44 -0500
Date: Sat, 3 Feb 2018 16:44:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/55] 4.15.1-stable review
Message-ID: <20180203154441.GB9631@kroah.com>
References: <20180202140826.117602411@linuxfoundation.org>
 <c6ea53fb-ad96-dc63-4113-9bb1d2314334@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ea53fb-ad96-dc63-4113-9bb1d2314334@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 03, 2018 at 07:34:17AM -0800, Guenter Roeck wrote:
> On 02/02/2018 08:58 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.1 release.
> > There are 55 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb  4 14:07:50 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 147 pass: 146 fail: 1
> Failed builds:
> 	mips:allmodconfig
> Qemu test results:
> 	total: 126 pass: 126 fail: 0
> 
> The build failure is
> 
> ERROR: "sgimc" [drivers/watchdog/indydog.ko] undefined!
> 
> The problem is inherited from mainline. The fix should (hopefully) make it
> into mainline in this commit window.

Great, I'll watch out for it.  What arch is failing here?

thanks,

greg k-h
