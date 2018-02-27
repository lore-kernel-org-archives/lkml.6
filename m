Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2716167-1519773139-2-18163926091282337825
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519773138; b=oLe8e3E1oM0zVOX0nHDd4uaA9/1UTqxOaUkAcv9a2ZuT9yc
    vYUGtdqetrUp4RF/y1e0cC218P57ay4neEnhfbhOXrHwAnpYFdV/yqpuAM48MtCF
    ffTSUPQquCJXiTr63a1EMcP4xUcMoO5MTkaj0w6d1466c2XA7xnNx/4mh2WwJvHS
    NqjlNnZsccFTslKxRVVx8/O6rETcCjMtApdRR06oOlvTF/ylxZ+QHDsMRllo9VCE
    VfB60+xZgwBVQRjANwgzRsWctchnfzyeO7ulyOKFrev5kS5WLerEwOH3YOPkem9B
    dhnlqV3y1b1nF1McjORwmf4IY6qOVyDyV8Vq6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519773138; bh=r9qS039
    TYzBFI7ImYMnHI1OYS8picZaw01DZ3P9LTEU=; b=F7+xjiBSmU/qrm4Ry7lSqQ7
    20QX8cR2CETmS8OLsPWmBKTYMSzGEbr4SeoTybxp7WUzaSca0kow7YNovk4JfBuu
    cLk/fY4nzmyP1Pm+cp53/2sk71gkjsAaYm81cxWi4J+TTR1ysan61+DO7AqSetp4
    9b9tiVxQW0X4w3HV2GhWqhsVZmPAEWVxrkT/XpqJMZ8AMMFIgx+GNQwNJ+8I9fh6
    qwIT89THLo8wcJtTypwIQmnrE+L3a31Z+xl7/2bZ/1rZCX3pht2III92DjzxtEH9
    4yKhJGV+9qvX8LeNIxXFZSaLaX/RYxGFHEBXSmsnABEe6Lpro6mlJ1z2Fc7d7lg=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LOq7Xuk5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AY36nT+x;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LOq7Xuk5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AY36nT+x;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeB0XMF (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 18:12:05 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41947 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbeB0XME (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 18:12:04 -0500
X-Google-Smtp-Source: AH8x227eHczwmjwRUOxY9fee71nDPqS2MAe7GAQHcMNAimLie6tGr5a9qyhrFqYqJzuKzrgikWasDQ==
Date: Tue, 27 Feb 2018 15:12:02 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
Message-ID: <20180227231202.GA20500@roeck-us.net>
References: <20180226202144.375869933@linuxfoundation.org>
 <d4f09175-d9f0-6251-ef34-14934fce5186@roeck-us.net>
 <20180227130859.GC32493@kroah.com>
 <5ce01b6c-3fbf-03d3-071e-b794b76ef849@roeck-us.net>
 <20180227183618.GF20601@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227183618.GF20601@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 07:36:18PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 27, 2018 at 06:38:59AM -0800, Guenter Roeck wrote:
> > On 02/27/2018 05:08 AM, Greg Kroah-Hartman wrote:
> > > On Tue, Feb 27, 2018 at 02:59:39AM -0800, Guenter Roeck wrote:
> > > > On 02/26/2018 12:21 PM, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.14.23 release.
> > > > > There are 54 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Wed Feb 28 20:21:22 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > > 
> > > > 
> > > > microblaze, m32r:
> > > > 
> > > > include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
> > > >   #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
> > > >    ^~~~~~~
> > > > /opt/buildbot/slave/stable-queue-4.14/build/lib/find_bit.c:176:15: error: redefinition of ‘find_next_zero_bit_le’
> > > > 
> > > > v4.15 is also affected (m32r builds in v4.15, though, for some reason).
> > > 
> > > This sounds like Arnd's Kbuild change 101110f6271c ("Kbuild: always
> > > define endianess in kconfig.h")
> > > 
> > > Does this problem also show up in Linus's tree?
> > > 
> > > Arnd, any ideas?
> > > 
> > 
> > Missing for m32r: c95f121142a41c951fd62683a5574f2a7b37c573
> > Missing for microblaze: 71e7673dadfdae0605d4c1f66ecb4b045c79fe0f
> 
> Thanks, both queued up, and I've pushed out new 4.14.y and 4.15.y trees.
> 
All builds are confirmed clean. Tested:

v3.18.96-13-g98f6a49
v4.4.118-22-ge62da23
v4.9.84-40-g8a6c3b0
v4.14.22-57-g02ee682
v4.15.6-66-g53e92b3

Guenter
