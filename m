Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-897562-1518810268-2-8706043147488131512
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
    t=1518810267; b=Vs3tcqT5+iMHc+FLTCmTGyYXMXNb2Sf/Q79oc1RhsYyUKVB
    aMu+BfN4SaYuq2hW1p+APFl5qCI2FuXRD+NO52necRt9ZlyfgwHGz48jbmPF1yAv
    GO00gIytw9jRLPAgealLx30tSjGBjTZi6UcvFLg6ceQUknQWMq/f4w4YYC01F1g2
    GGgFkpT3lHT1CCTMqqdKBXqvRViWuiPs289NvRi0iuNm4msq9nMRE1gnI4QpEidU
    KrgYpvI6A188ojoqFHJOMWsVLlaCJb9OZMw7xvcX6QdkzwN+ln66tW/7DLRF7nqk
    oVajD8ayH99qRgUmRIDD4FWKWGvk0Xat4oJVbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518810267; bh=/NIk6fbUNWThd1/QoTx0DcF/qi
    V1bwdLLjp18t7XKeA=; b=Ki5Pm49MEaDABcc+5rPnnteJmHXNNH+tPnxssbHcBy
    XgMEUO9Z97YdgX/PsnEWb6HtRhY+uQczW+xfWTYzNkT7lG7VVqp8kqz47qeeObJt
    hcMo6EGmWX1IoWrUOIk6Xv789BPiQx4CBqv7DWJpGwmCsMXCQ+sTgPw8KE06n7Wk
    XSgNBiuigXtbUb54dpYfc1Uv5JtgqxrATlAepWoqx2CkScw8jCoxZZPO6bHrebHs
    NjTvJXuJya8/yoImFjmGG3xO7imYJUhN/hSv392HnegaPH+jPgAgJzHthX0yY+0g
    Avdds7qfJBXsvLtN5Y8/3T2gEz+v5ijZ/oFPwj5CZ8XQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbeBPToI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 14:44:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbeBPToG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 14:44:06 -0500
Date: Fri, 16 Feb 2018 20:20:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 000/195] 4.14.20-stable review
Message-ID: <20180216192004.GA11682@kroah.com>
References: <20180215151705.738773577@linuxfoundation.org>
 <CA+G9fYtfZB+=wL69ferRmD3oOqqfgvXA8WT9UoihOUafyYdCNA@mail.gmail.com>
 <b16a4cc8-370e-f2b8-79e1-a0c68b7bab38@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16a4cc8-370e-f2b8-79e1-a0c68b7bab38@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 06:27:09AM -0800, Guenter Roeck wrote:
> On 02/15/2018 10:00 PM, Naresh Kamboju wrote:
> > On 15 February 2018 at 20:44, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > This is the start of the stable review cycle for the 4.14.20 release.
> > > There are 195 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat Feb 17 15:16:22 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > >          kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.20-rc1.gz
> > > or in the git tree and branch at:
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> 
> I somehow lost the original mail, so I am replying to this one - sorry.
> 
> Build results:
> 	total: 145 pass: 143 fail: 2
> Failed builds:
> 	powerpc:ppc6xx_defconfig
> 	powerpc:mpc83xx_defconfig
> Qemu test results:
> 	total: 126 pass: 124 fail: 2
> Failed tests:
> 	powerpc:mpc8544ds:mpc85xx_defconfig
> 	powerpc:mpc8544ds:mpc85xx_smp_defconfig
> 
> Build failures:
> 
> Building powerpc:ppc6xx_defconfig ... failed
> Building powerpc:mpc83xx_defconfig ... failed
> Building powerpc:mpc8544ds:mpc85xx_defconfig ... failed
> Building powerpc:mpc8544ds:mpc85xx_smp_defconfig ... failed
> --------------
> Error log:
> drivers/crypto/talitos.c: In function 'talitos_sg_map':
> drivers/crypto/talitos.c:1131:3: error: too many arguments to function 'to_talitos_ptr'

Ugh, sorry about that, now dropping this crypto patch from 4.14.y and
4.9.y to fix this issue.

greg k-h
