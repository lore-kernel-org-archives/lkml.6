Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3608014-1519801961-2-3588265322816819696
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519801960; b=Y2wNsaf9mttMwqGNARJ++mr9LgYQ0y02TfSHgjl6hvapQbt
    A12jSP5HzQX06EiNgDmFpHEKDA6RniwSaLC8qJyEyczwCmTpjYARz0iBmHOmDOub
    6XebWXROPvR6G2OGrA3cbqCu58Y6cKHfpfCsmw7S6T4eGF2OrXHgdjD5BIUsUxtd
    /yLgq9uORJnTnBOEdv5a6PozBHOYQzQ4OFDd6e2KEQuTqI+GOiN2Y/Yf6p5HXZfJ
    fsouZE47FaGGnjDYUlFsVJepqz3drPMo+aQ8PIPBsObsJLFAN/1EPUy0dF5dhkWs
    LjuM/G+rh/D/ZYfPmKL0kz66XH6VuhzIM42aQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519801960; bh=QTLcWno
    M/yiuHoyfU9R/R7zVCqapotlLSNxcNImFFNk=; b=NT0DX101WW+4rNrZS+pPChp
    ZViw6mxW44xuOxUjKEflaAzpIj4qc3BwmSW24ABjkZweAGRkDZj+896zQXFATWcH
    t3dlTrrKEh23myUvUd3TEsHho/Ykv19XWzSfFR1462B4CmryAxvFYUMU3tosXg6K
    o5703PQnVdnoiQKvSnKPv5yzxVrM+DMmRq17y8OmVwVE7BvSHDsFK49xXgpF85r4
    EHtdqSbF5Z0OKaEFqO6XuDqJYbKv+rBzmuueyu7GQ8SA1sy1H3REBHaMPLYX54Bj
    Ac5h0gLakeTYgK0Z9QyRYGn+7keVGhr8TmkbbkcRjYLOIYLK8cEkJF9pB9dlBSw=
    =
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
        id S1751758AbeB1HMj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 02:12:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeB1HMj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 02:12:39 -0500
Date: Wed, 28 Feb 2018 08:12:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
Message-ID: <20180228071237.GB17185@kroah.com>
References: <20180226202144.375869933@linuxfoundation.org>
 <d4f09175-d9f0-6251-ef34-14934fce5186@roeck-us.net>
 <20180227130859.GC32493@kroah.com>
 <5ce01b6c-3fbf-03d3-071e-b794b76ef849@roeck-us.net>
 <20180227183618.GF20601@kroah.com>
 <20180227231202.GA20500@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227231202.GA20500@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 03:12:02PM -0800, Guenter Roeck wrote:
> On Tue, Feb 27, 2018 at 07:36:18PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Feb 27, 2018 at 06:38:59AM -0800, Guenter Roeck wrote:
> > > On 02/27/2018 05:08 AM, Greg Kroah-Hartman wrote:
> > > > On Tue, Feb 27, 2018 at 02:59:39AM -0800, Guenter Roeck wrote:
> > > > > On 02/26/2018 12:21 PM, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 4.14.23 release.
> > > > > > There are 54 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > > 
> > > > > > Responses should be made by Wed Feb 28 20:21:22 UTC 2018.
> > > > > > Anything received after that time might be too late.
> > > > > > 
> > > > > 
> > > > > microblaze, m32r:
> > > > > 
> > > > > include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
> > > > >   #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
> > > > >    ^~~~~~~
> > > > > /opt/buildbot/slave/stable-queue-4.14/build/lib/find_bit.c:176:15: error: redefinition of ‘find_next_zero_bit_le’
> > > > > 
> > > > > v4.15 is also affected (m32r builds in v4.15, though, for some reason).
> > > > 
> > > > This sounds like Arnd's Kbuild change 101110f6271c ("Kbuild: always
> > > > define endianess in kconfig.h")
> > > > 
> > > > Does this problem also show up in Linus's tree?
> > > > 
> > > > Arnd, any ideas?
> > > > 
> > > 
> > > Missing for m32r: c95f121142a41c951fd62683a5574f2a7b37c573
> > > Missing for microblaze: 71e7673dadfdae0605d4c1f66ecb4b045c79fe0f
> > 
> > Thanks, both queued up, and I've pushed out new 4.14.y and 4.15.y trees.
> > 
> All builds are confirmed clean. Tested:
> 
> v3.18.96-13-g98f6a49
> v4.4.118-22-ge62da23
> v4.9.84-40-g8a6c3b0
> v4.14.22-57-g02ee682
> v4.15.6-66-g53e92b3

Wonderful, thanks for testing all of this and letting me know.

greg k-h
