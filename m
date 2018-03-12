Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-584461-1520866491-2-2862851868195333482
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520866490; b=r3vsuCXORkd8lLX6eJrYLF71sqTpI7x4fkdBJ0Or/iA6Gzy
    ltio45dbflrMx8Zy+0PDBjwVR9AcCV0ekGBG7TTUVNVzZVIDPr6JXRNhZt2mM9Ap
    o9dR7c1UlmvpskTd8foR922mIWtg2bTdn/C0Om/fAXMnP4dsHVzenrxIcBxhNMQE
    CI5qTsDXcZotqhQY5Sk16WrckLcNCfGPpW3lRL3hA2esliLX53N5wVQM19sLfdK5
    elDL34BmjHmBEIk0Er9PnKYUXI9Ibtn7iEfsk3Ky12S85UW4rWJ+fQPUvPC3n+7W
    +SKvh7bPYcSZDriH52jhZT9kNKHPJug4zr3S/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520866490; bh=6lJF9V5mQEcSuuO12r2AgId9m9
    Ir3rwjlK0A3iZbFT8=; b=vFw0sC6jAUPDLPGAftg3lfoPMI231gN32Bey5N2Mpm
    LMH2PBX5ad5BcSJPt7Gszk7fgbaLAuJ4w0hsgV1ho9OCX55G4HgIB9U5HzCgKcKK
    t/UuL4asUKIZPdijuQ6bl+EpHry/yCXGSTuoB1fUHN4nNaM1D66OztRITp3sipsh
    LRy4cRqpBePvSyPT+3gv1vBIb0spgcgGWVbBx+CfR2fLMYVBjJuDK+5Wpk9JNSbo
    Vr6Tdca4AoTCGG9Q0LgzWZ4o2x6UDDbv5cxVatYHUNW5ZaStQFqqSpxfZgsn7tV6
    Tg7CCjxUdICGVAwTzOsQeW1VMwyDrd2LXaedzAy2yiUg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=L82wm3hr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gkoEY/2g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=L82wm3hr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gkoEY/2g;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeCLOyr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 10:54:47 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:46361 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeCLOyq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 10:54:46 -0400
X-Google-Smtp-Source: AG47ELvEOgnILSqYYwHWD6FoeD2H4AIEvh+M+4kIfBRu1I45p7MaLRLh9mcTUFh2S7nTlpoS5JeF6w==
Date: Mon, 12 Mar 2018 07:54:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.2 000/104] 3.2.101-rc1 review
Message-ID: <20180312145444.GA3917@roeck-us.net>
References: <lsq.1520823814.606620518@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 03:03:34AM +0000, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.2.101 release.
> There are 104 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 14 12:00:00 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 86 passed: 86 fail: 0
Qemu test results:
	total: 73 passed: 73 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
