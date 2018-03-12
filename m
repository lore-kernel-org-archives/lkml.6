Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-563962-1520866862-2-3748375033483722058
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
    t=1520866858; b=SauxwVjXquFEvNNepoiWikNX405KzOXDIkiqyfzO/L4RMOA
    6gE2Lf8eHNsolL/wvdK0wW2PzEHxoCKp2cqq3ERlDrv9x4yDR17P4NJqlGYsHv8G
    rKHlLddpc1n/6iSPQwjVG3lawwhirrSjC19lYlAoxMi2df5kLWNxacx8a1OY+i+1
    L+FjeTRFI531s2oEks8tGD2NnzR53ZMo5DGzUw7fOdLDWDB2eEk3Ea1JS1wkL1FX
    Cd/9xjOlJ4iNlZB+l5sH8jpYeZVE+KIIQyjes03dkePU8JBEP8v5oZgGU9Y7Ef4F
    MfpwXw1U3XSM7QFVx8TbN1BqkvTSvy3+CGQH12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520866858; bh=0tFpErhDKt6LELoihtxUxbvNwk
    G7vtJpUWsDiPFXMdM=; b=hXBAGS+uep3Owqtan05LUqn5JGkR57RXefGHNrn1Ly
    hRQR/iZVUMOevlGrPmYSezuw8Qp+7XBYvcY/2Xq1hKokZKIF4yL6bDnUSWr+hbnU
    SQjAVzGrH8fTJtRwk5MniwUySnk2Q/C7Vol0pGX2TUuj/+LN7mXqZPRlHaKklPVi
    1Ifgprpg+3n6zhdvxiESGY6e6SWQXeXhLw7aPlFQlc4Rsxl7ZNOIRq2d5NfXfcQw
    ulaWsnReYIDxk3Vsop1Dw6Pgi+46PzsCNaL5dCJdANKB578/dBCsgTyg8wsEowjo
    R3VDIrXqsa8kUEw+gdRdcn3K7wJgtGCkumkPi+GXwRpQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=g3lshSDD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MQ5Hfggd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=g3lshSDD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MQ5Hfggd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeCLPA4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 11:00:56 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:44396 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeCLPAz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 11:00:55 -0400
X-Google-Smtp-Source: AG47ELswfpJZK94vHXBfpnv2vYW8ct4HLcrpSfLdDSGJGBNp5lDFtdoGqKznUWMW7tgoWtfrkRPMkA==
Date: Mon, 12 Mar 2018 08:00:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH 3.16 00/76] 3.16.56-rc1 review
Message-ID: <20180312150053.GB3917@roeck-us.net>
References: <lsq.1520823971.5976735@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 03:06:11AM +0000, Ben Hutchings wrote:
> This is the start of the stable review cycle for the 3.16.56 release.
> There are 76 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 14 12:00:00 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail:0
Qemu test results:
	total: 115 pass: 112 fail:3
Failed tests:
	mipsel:24Kf:malta_defconfig:smp:rootfs
	mipsel64:malta_defconfig:nosmp:rootfs
	mipsel64:malta_defconfig:smp:rootfs

The failures are due to newly added tests; the init process crashes.
v3.16 passes those tests, so the problem was introduced later.
I'll run a bisect later to see if I can find the culprit. If not,
I'll drop the new tests from this kernel version.

Guenter
