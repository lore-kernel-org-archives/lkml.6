Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2147157-1519756581-2-11012010155210737299
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
    t=1519756580; b=gtC5+14u4SsmU1h8lY9kjhvOAGGaNj+oet2epUGi9wA2ROu
    YjnNKPQF3W3Mml3IY5s2PuZEUuFvsKulVt2piOw8gAl5D+UqmJdfEq8eBPVlCs8J
    Dim8RA9kAFpdr3W+GI+UvhqsCxot1dzVErIXSL6nEtlyvIHWgcZS7SKUyJBqmEp8
    YDssKA0O06ddbd5uin9Mlp/ybCXPM1TlN8x7M7wPfNct/ZkDpUq6m9V8AbSF5a4j
    ZcL8Pe8agT87+dWH7Hk81QiAPj0GiqvvhX/wo4ekVTjDf43ZlN/nXktoRHBnLk9R
    tuar3aLqedukuOiVvPNTNoNdR/MI7mXLUiAQUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519756580; bh=PTHCODu
    87F3t9FfW2vpDhlUJOi2geLE5U8jD2itDhK8=; b=Btoed5QqwbQV9r1dPN0gPli
    XT5mwZ873OPrc4efBunfXjgNFnv0h9xwy1s/iZRLhvg7iSwJ1Q9ey49SEICqGkqF
    caP2FZQD8nxa5cl2S6aAkY0LKDwZ11rVNja9vmPVpPefUzucXPS4eeq6BPIHFUhw
    ijc0+PuhUKKRHqVDLAAgp0aZxsblZ/hpkI9ibKVXN1sJGB5PeH0zVsXecJmoqsN4
    vyFtS5GJTfMVu9gGuqmis4tNVNlu/PYO4w5i4ktVHNGSP7VNeb34wH7SSCmeYUHz
    R1MuIiVbmjc92GDdyI0bv7Tfb7CeyLaSce9SoiFK8Fp5oj/sTW6Q98dlYgT7FlA=
    =
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
        id S1751062AbeB0SgS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 13:36:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:57514 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeB0SgR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 13:36:17 -0500
Date: Tue, 27 Feb 2018 19:36:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
Message-ID: <20180227183618.GF20601@kroah.com>
References: <20180226202144.375869933@linuxfoundation.org>
 <d4f09175-d9f0-6251-ef34-14934fce5186@roeck-us.net>
 <20180227130859.GC32493@kroah.com>
 <5ce01b6c-3fbf-03d3-071e-b794b76ef849@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ce01b6c-3fbf-03d3-071e-b794b76ef849@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 06:38:59AM -0800, Guenter Roeck wrote:
> On 02/27/2018 05:08 AM, Greg Kroah-Hartman wrote:
> > On Tue, Feb 27, 2018 at 02:59:39AM -0800, Guenter Roeck wrote:
> > > On 02/26/2018 12:21 PM, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.14.23 release.
> > > > There are 54 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed Feb 28 20:21:22 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > 
> > > microblaze, m32r:
> > > 
> > > include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
> > >   #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
> > >    ^~~~~~~
> > > /opt/buildbot/slave/stable-queue-4.14/build/lib/find_bit.c:176:15: error: redefinition of ‘find_next_zero_bit_le’
> > > 
> > > v4.15 is also affected (m32r builds in v4.15, though, for some reason).
> > 
> > This sounds like Arnd's Kbuild change 101110f6271c ("Kbuild: always
> > define endianess in kconfig.h")
> > 
> > Does this problem also show up in Linus's tree?
> > 
> > Arnd, any ideas?
> > 
> 
> Missing for m32r: c95f121142a41c951fd62683a5574f2a7b37c573
> Missing for microblaze: 71e7673dadfdae0605d4c1f66ecb4b045c79fe0f

Thanks, both queued up, and I've pushed out new 4.14.y and 4.15.y trees.

greg k-h
