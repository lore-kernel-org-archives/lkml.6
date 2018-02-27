Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1199706-1519729002-2-4871061987789023659
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
    t=1519729001; b=VO7Qnw8vTblHqyGP0bxmFrN21uibEc1IWLu18qWtDsd2I5U
    63t7MB9hUJ0ePADbFcNLwpju5A3mTFg6lhwK6Dmtx/2uf2SzSku5S1qqHz32KeCU
    r+CwO175jsYqUPIyAJfmJm8kbddz0BZHXnjTh4Q96rip03B3ASv/dEAbnI1y8YDY
    LG9h9vC/4eQUaDoHOR1PwqWgErd+MeZZxwem2s3yxVj2jn4rs8+Arp/6/f/o/z00
    2QMQ+h8f13MqMGT2UrOfhefftBYbtudQ42wndASpUKucTBmwZwxvCyWCpH37Omwe
    0DA2jCQ3usXY+d2A4c1HH5kWFqupU2L0Unm61gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519729001; bh=siw/4elkWoDnaF4D5mTV3bawCLbLxjeuSJuSwFyVPNA=; b=o
    OVDcCTMupKG9HmtFvAr1u5+gRMnIZQvNHa2q2B7WIPOc4McTv7fP/UuOjpLGrBCm
    +wdtW/JEdN/EvKte+dpQnM0yupZXsX8X0AyEUy9YVYdOeBXBksrKPiXEJ8bn49vF
    5Ao4xgHyh9W9VuO+NN8d9lfpMh56XWSFSVuzLtOYlEk2aQyu33xiiS17L+KTIv8X
    +26gLON1D+YgvTi8h4yu72HnqBDI3D+ACo+e4+Gp/1SQFfY/Xs6jth4QoOTI2wGj
    v1wKaxDvoOG9H5QI/wom+lEwQpz2nyep0m6as25HjnEreuuPO9ueoLA9vus5X83b
    cfQz6PJJRtgJymPpjeJMQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=V0eSggRQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SpTx4xD7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=V0eSggRQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SpTx4xD7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeB0K4i (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 05:56:38 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39980 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeB0K4h (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 05:56:37 -0500
X-Google-Smtp-Source: AH8x2262fjYy949EVW1AouaPZvE68OJ1xqj25M/4CA9zcA0tRz1Ae81/0D7FFw0Kj83aE5sLMTKzOw==
Subject: Re: [PATCH 4.4 00/22] 4.4.119-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180226201558.681421374@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <83e6d140-bf24-0d20-5e0b-e442b6419e9a@roeck-us.net>
Date: Tue, 27 Feb 2018 02:56:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 12:16 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.119 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:15:48 UTC 2018.
> Anything received after that time might be too late.
> 

xtensa:

arch/xtensa/mm/init.c: In function ‘free_highpages’:
arch/xtensa/mm/init.c:335:2: error: implicit declaration of function ‘for_each_memblock’

and several additional errors in the same file.

3.18 is also affected.

Guenter
