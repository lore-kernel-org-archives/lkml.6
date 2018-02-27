Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654150-1519743490-2-7725493587473872269
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
    t=1519743489; b=i/L/Md6b1Ri4yRMUY2OUIt8kltNeVzF9vkenmCTGs80upOD
    4ptQGk/1AoLMnAgXni0mly286abdd6QnBktjGLPOHiImGER0o+hoJ3kftx9+6U9d
    L3xSJ3W6QDDH7lFZSxlLehcvvyESGmlGdpn/QaVB/Jv1Wj08VHNnD65Sh81HeGiE
    MuSFWOtPbdEi1OruFAmhGVJ0S1uWw2iranPGoYLL7Whj1BtMzy1nvhJV83cUCv79
    jTRIXI1D1raIydz/pL5MKFVsfDtFc8IEuj1BnTWmSp5RMIv9xg26uGKmHrqDZTTd
    9HElDKBqwpAIldsrEXCjHyo0Ir4/Qk8Mb2rAFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519743489; bh=oJH0a0m9LO0/Z5O1MBAbKelaHmwMb3jQi/FzueVi6tY=; b=n
    cb3t/iGe8zlntrjjHq4oET3YsjZCD12MyFDtTCL1igD4FZWbSzvw1UvL/uytck9w
    QewCwwOdTmpjpJVqmNOKGBrGRwnQD+kqOn12/JZbjE0RhszaK55odaK0uWBhxAfi
    nUnXLUL0ADi2wtCpFmXNgxS4sybI3fMJXfYNkvxo4ycT9GLSMY/G3iJgOTA/o1+a
    Sbz7K3V44xpkukE/y0v9jeB2L/P9AjjX96DvF7MZepSQbrEfDoRjMPwRaCn0wBJE
    Bq26fgXgTNjHeEGRKwJwpsNo2wcbcFWQQuq7Rpusxl7dFYpSCev4yUsPyyQcBUcX
    eJi0W6TP3YXjLHWJreSZw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J6vLqAZU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=orq8lJvU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=J6vLqAZU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=orq8lJvU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeB0O6H (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 09:58:07 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37318 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752573AbeB0O6G (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 09:58:06 -0500
X-Google-Smtp-Source: AG47ELsdKqWVZL2o7eYaeGFlvflqPDMMLIIuf7j9Gu7tziNFQuTs5uCCaSKdkBMdszCDAY24zYiPBA==
Subject: Re: [PATCH 4.15 00/64] 4.15.7-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180226202153.453363333@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ce53b79c-3881-0998-0ec1-291cd1ed9d3f@roeck-us.net>
Date: Tue, 27 Feb 2018 06:58:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 12:21 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.7 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:21:30 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 144 fail: 3
Failed builds:
	microblaze:mmu_defconfig
	microblaze:nommu_defconfig
	microblaze:allnoconfig
Qemu test results:
	total: 127 pass: 127 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
