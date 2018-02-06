Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1345673-1517927435-3-14140768667685630250
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517927435; b=e5YsIc6rZfhjM/KbBWNUSWwr5go/7mvmmQpUlZLVx8XM02v
    yXonZduWZUOBOoD/ZPF3ID4TnTPvbsMvbiepFNVEbXJTxdXUgtdgXfYjWSG8JFAu
    NOpqIsyMxbQhImvhzLdmj8IxB0ipwMYuG5Uug2iX9FVNT1tf8EyLNKaUKinen0Id
    lS269i0jyggx3ZIdMt6iJLVluS0XRckzNK6uzfl2vw8ReWNgJO0OwixA4Ym9tX/N
    5+lE+gn36YKLvvEMAS/F85tAsckZG1CG4dd+yMjSjd3t5Z04lxAjL6TJ6of9YpAB
    ojBb3aBRzO/sjvASPDWdJGUELveqhknl1bv2FxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517927435; bh=6VA+yTdrHozX7pD/d7/uFOfxQhqJCxnOPSNfKvKQh1Y=; b=e
    LyPP4D6xawUKnKqyFVKeswc0sEhiRzCHSy+CCyzy/Y06nrvxdu3SSdmcl8HW6VCb
    kgK6dLSLWxrFiDPhtdNXlBbK0JKmNZi168J0XTK4MD9zLZ8rJm0lamkDP9dZIU0N
    bmjLcufkJVTZmKdYtkC5/7PK2ZMAUD/ZKPfgNc//B711e5bxu8XqzXVZb28w/i+G
    24UPpbYLBYk6WzC/MpsdVNVJIU3yRmgEdCgElFefhUaFnAhlWv3CPDeMM6n8BWUc
    06w3RkFzoeQnCo58PviwhtKcLM7IO5vDIYhv6YASnLF8LNvo60Q9rs1VbkzZOD0z
    vBVguUltfZDAaRwyD2gmA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=a/QJG93i x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QDHggSTq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=a/QJG93i x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QDHggSTq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeBFOac (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 09:30:32 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44679 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeBFOab (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 09:30:31 -0500
X-Google-Smtp-Source: AH8x226L2GV1tJa7trRdhu/6EDdZUn/hDlRqYNuid7D/IZ5drsE+ngbsVNu24JCe7NRCYVf/zwo+mg==
Subject: Re: [PATCH 4.14 00/64] 4.14.18-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180205182138.571333346@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <46e9a4c6-9c83-a6f0-46eb-da16658afb01@roeck-us.net>
Date: Tue, 6 Feb 2018 06:30:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/05/2018 10:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.18 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  7 18:21:22 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
