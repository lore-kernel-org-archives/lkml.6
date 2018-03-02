Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2080671-1520011986-2-14054713053096120326
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
    t=1520011986; b=fr+vKqMe27xavH0pdDRr393fHNv+Lq2+gsgJHBsqipTzTJh
    S8ZoFv2l7UxQp0JbMZLogXPsHCgxJ62cwneuZSUJrtHmApu7fb6kc1zQSuDfrgPC
    2l/+SZ0J+nyO7m3VwuyHUrPHMQjmAqWnGmB/J+RdRHBBso5QRrBpIzK8rF0uudSB
    Ln1PG+qJguQL6lt2PP25AvjSpnen6rmRgCUxSq/IhtoPjnkqoPGyQq86OOkJ8hkk
    5VVRMxYcpWotqa20U7IsTKL4jfBrb5/z8I6WOuR/E0CMv8MANyKuijg9kXRvLDao
    d/MwNU2M+LrObM6D06lD62R0WmzdPXo9/hM4iyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520011986; bh=U41XRJAxuMcW2MU7aRac01F0ip
    NketjPzR4oRNLHgoU=; b=dbYX+kCHwXAhMY/mcbVgF8fB7jZCNoNNE8ILaKBMiW
    FjS9PKwMBW/ERN3BUVHgXoQoatxFAXP2aTo4liunbxdKJF09BSqAgXdkO6UVjAQJ
    f++Zv18VKKUt3W2lcaE/GUHqS4Aa98hjHxJA3dxO7M2z6lJOiLxvHb98JLmESo/e
    pKWmj0CLHVQ3gXJFnzgSLmhOTJXz9xB2TKIl9kBiX0LTC6idn2Bc7sRnTsfdZOaO
    JgR5F2mCLTU6/aGF46ANkDvg8AzPxprZSPo6iVuUXnKp/GCsoc28t0gcNoyCki8C
    KVc5B17sDbNaNTP3OUqHMutPwo/Ky+6tSgloxaLJ7ulA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QqwUsyWY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bZaCQ7Xr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QqwUsyWY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bZaCQ7Xr;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424977AbeCBRdD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 12:33:03 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:47098 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424427AbeCBRdC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 12:33:02 -0500
X-Google-Smtp-Source: AG47ELtrMzJv5kBPr/kdF4/f42e99URV+oDs33jIXqZCDnqQ/v3L+t+4p2CzkR4KHp9c/bFhwQlgxQ==
Date: Fri, 2 Mar 2018 09:33:00 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/24] 3.18.98-stable review
Message-ID: <20180302173300.GA1777@roeck-us.net>
References: <20180302084239.157503766@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 09:50:57AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.98 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar  4 08:42:22 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 117 pass: 117 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
