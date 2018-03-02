Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2080671-1520010982-2-842263457836520950
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520010981; b=NjbY92tmcLuaIT4y3TDD/nb1Ow49o5AE0H0lCE9g2dyZqzS
    UutItFEdeNUi0iFwsaEcnpluhm3VfMs+ZOQEosaoXyg40Xwh69/+rwvQ5i3CeY84
    Cj2N0QdvEG3vbbrLJ0IEUum1wTu0lnAXHCrR1goIwanCSjIgFLE+kqfRy0mnkiV9
    tdFDu8mUOIln5BkclM+rlSie1ZG7nLpaVW1i+42/U2ATGAzfTc6cysKVj8eXhNxl
    pEOA4bnLqyD8L7gT262979EEkNreCUWCWL+SM/WJQRYvQm3JRMboGBMfEP0643up
    Ez2rctTJR7Dd9a6nyZMc9/abi0mU8d6mpBTKGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520010981; bh=wQ5Y/wQrWQNL8drFYaQFqN4Yk7
    1Dksoa41VEpBH2QiY=; b=EuL6wCWZfr/df0DWTO5BYZVG1M+Jaxy1YE2ayWeKNN
    DUzthHYvN84gBag3B5qtcU6VHpG2KEMThSN0XWFOv/0q7tP3lSI+y+lf3UhFCzK6
    Oe9fy41lCx9NQKPMgNyYDiZXYRDwasW+dGcXEVLPv/bjZuMVxBWSvedpu6kwzSd2
    vpcz2Sv7XAhsJD6yiJsYfWcD9p9+u7lO98IDnEi1JBw1X4oz1/aRGCjUITx0oIXQ
    KvQKyDTgE7YWrNZYJA20/YidV8vkJYcFHEiBYANQS0wxY+e+iCzkFwROTbHdWZLe
    WACwJ+HgBgHCfK9h/n9vlcBk7zdSp14hvL5FxnsdYLyA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fJbGoGXh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b+Mxxbr9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fJbGoGXh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b+Mxxbr9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427676AbeCBRQU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 12:16:20 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43680 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424699AbeCBRQT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 12:16:19 -0500
X-Google-Smtp-Source: AG47ELvyPYZFv7lOm9LR6tItsPJ9YXb2gRE235X5lztkmi38XoHAf880cDMvJeZThHtdQMB7CVefNg==
Date: Fri, 2 Mar 2018 09:16:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/34] 4.4.120-stable review
Message-ID: <20180302171617.GC9473@roeck-us.net>
References: <20180302084435.842679610@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 09:50:56AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.120 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar  4 08:44:20 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 125 pass: 125 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
