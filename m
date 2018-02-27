Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2254233-1519758765-2-6701014944824226455
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
    t=1519758764; b=T92dXBUHytyj7Erb8fYQsQdD5zF5lQPRPm+MZp026t+J/V4
    SWLlXCNF9Ks4+Z+IDrP7k9I62t4bFU9NtpUTBiMJcaQrQTUVp8yHK07fAWxs5d47
    Ml0hQ6drpblTZjGlaiCFszQUZJESdoDM7ksMp4i09dVpPaWZ/Y8CZepUkZ9swLmU
    HjkFnvwwZqm1lMYnPVUl0tgbTnfKCxOv5J6MKO/RjkZ5euGZRH6ys7+8ZQz2KCRS
    rszTEyJ7nEhOh0LD1slQ5qmjWbCtRGF5lkME2FXq2UBPHOWI4f/4Qloo3/vAHfAA
    4BqENnIxRwK/gaIF1qITlU5P+8VPJZdGiCbVyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519758764; bh=l68IkVX
    fO4O/ipBGnMxL9aUkWypzunBLMZKdwt4ZG6o=; b=fMCN5hHxeB2g47yQscLW+8u
    FHEYJdxYbXXqRzVYrXA+7Bt53k9PuNoicD4LRnh8ZOTDaHWmKBvpivtSv+g0yxui
    XNpqmerVvTuMJKuMfOhEIdoU0XBmiYm+izwbZfFUWKuvohsQYT7SRWF+XLGxXBDr
    Ixf9dD+/EWjwanT+qlncv4N0oO+JK7d5iwY9X4wbqw6uo8/KdxQcptEKgjxtupza
    Xy3RQGA51w3qGShH8xSGmmgxBkFfuX8jealEYTWQa+wqjjwYk6OBO3cVzYl3am/2
    APYsUy5S5UurrIN67I6GtzmmPiWUguDtW3+RRyzCLJvpAQqH8uCVcXFZG7e2JVQ=
    =
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FBBOa2Mx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fpHL5YwR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FBBOa2Mx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fpHL5YwR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeB0TMl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 14:12:41 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34488 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbeB0TMk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 14:12:40 -0500
X-Google-Smtp-Source: AH8x225xYri3iQ0icOFe/3rSJR8xDfrQu/D+UVWKVX8eRpHt3uzR+A9bLYptGyWX47aQPHdWEYwJkw==
Date: Tue, 27 Feb 2018 11:12:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
Message-ID: <20180227191237.GA9497@roeck-us.net>
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
I started another build to test it; I'll let you know after it is complete.

Guenter
