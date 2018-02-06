Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-874968-1517913204-2-5887398481595926862
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
    t=1517913203; b=Yspzdv6xvh8Bd4mHEnKx1U4RQojo4D+yzSwHUrunHxfYg41
    E0w4b9GJXlWI1jsSbIWj+mJs/lpTkr5zU+j8+KD/w1KMIlsP5sPVO+eRhxHl0d38
    cNpsnsvyenDZ90JbuVJJjmCEXMWKd/vMGTUvpWGSAdmxgqrLPiOsxm4389KJi/nA
    GplYkH7lywNu3k13+zMWxoBd9bGinosLAwJ7xXnyO/hKqV/eU7A2tn1J3GuvmWKh
    4WnA2n1c+u2T89mWABK0CHIDARX2JaiGGKdXq2v6ZDVxbTkyITggcjY7JP0QhIW8
    q5mAf5M+a0dQhZCEtPiGnUAXmZDbfRjPjtZVxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517913203; bh=IgMn5onUu8NhiuWiJZIxJfo738
    YohANJPcawtDYxq/8=; b=XsnTBa2ma7fZQMJFYoJ6juEYA65OEHICpYGT4onEpA
    9XXW2kI4NA2J6N+N7ppxslRz1rMWJMvy7DbNJGK1PY/2lPT3j4Qty4EQd7zx33So
    4n25vtfP4M8sBLC5pptXTFMHyuNQuncQl2RlegwIVfaS9RP6uGnv1jZy86FANxaH
    XoR5mG+igQWE+EfZ5Qs8xo9m0m0ovFN90pbgDAwxEvOmXh5uezoLwJELx21aNtLP
    3xzy2mUOYQoZg20wBWonHElGpWNV4TFNm6Oo307KKT/XePrb2wK9Yuk4VzjHTrbu
    Dq6Cf7fU4GJSMoarUzhaVTm8MbK0Dd8uHMHK84KqhRxA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeBFKdV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 05:33:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbeBFKdU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 05:33:20 -0500
Date: Tue, 6 Feb 2018 02:33:18 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/60] 4.15.2-stable review
Message-ID: <20180206103318.GA10790@kroah.com>
References: <20180205182213.902626065@linuxfoundation.org>
 <79440d42-68e4-142b-80e0-4019cf9d0e92@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79440d42-68e4-142b-80e0-4019cf9d0e92@osg.samsung.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 03:14:22PM -0700, Shuah Khan wrote:
> On 02/05/2018 11:22 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.2 release.
> > There are 60 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb  7 18:21:57 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.2-rc1.gz
> > or in the git tree and branch at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Great, thanks for testing all of these and letting me know.

greg k-h
