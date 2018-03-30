Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3731766-1522423113-2-9055599627881170948
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522423113; b=tjFe//AePZ9ojNIn7vDycxm8dpMzXa1InRJ5JH5Ct9lcqxqyzR
    HjaOEXjObV1U+pbQVfNG0vBpLoBD7gjEzPEL8aFX5bj3SZQgdJYDYOxkeoxPdruq
    L/MvWMKhC9qHz7X+UjjFbZ5SX7DUMMQHrGzjjUA2dgK1PCS919uXkk4aEwq+HcyT
    rpvYWCOSrLV1aEr4hWKV2qWuzKlKi+2ayJylXJa7V6Lke5icnoMEg1uLJiPo14Oe
    Atqjkb/lEGdt7xfQ9eko5bV3c7zxS0Bn9nNPTarwOmpb6kn8cXezI/mQGMAOmSzw
    MfM2YgLSsRpL2KUAIOdzC3NE3s2qaxa+YMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522423113;
    bh=nxqt1Ytsf112XkDn9eC/uz8qkt9lvER+pEXw9FeluYs=; b=Gcg7Juce+b8O
    3OzPeAJtHJcyjkxQnbFP83LZCwC7DQaYU5ySGyMA7BPGtV/8vOi8O7DRfFDmoisa
    ShQ8ZESgCdTxR+Y4LVDqBHjHZi+UCNZAWDzvLPL9g+xhwhaw418xsQGPy1NXRHvb
    7RThmEswrCqgwJ4oS8kMzcPYq8IV9yW1/AeAl1vOI4jDHzv/VfgmYN03qaTLXFMb
    U5O6XZZ23U0QTdpP7UcGqxVRv1lco4maQTRqx/+XVBIC0DKtN0fl+TY3Dc7CPOoc
    qJSw0NoRap21pnd9lPShIW/G/RNzG2EE9vbuaSjVvwdQLwQkJmh096bbCrGUpjNC
    KtZV9chkUA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HqfTQjOV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TCXueMiI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HqfTQjOV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TCXueMiI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLrd+EZVPFZX/Z+fR+NupYepwTZL/AY+ayN1/TsJmizY8l3tulei5WJmDftg+AQQ+QD75QRHiJkYoVEOwlw88BPDHfhSav3J+yI939sX3kjuMI/kWcxm
    3xujPcW68AQViwo+WQs+OPcYjgpNVBlroUNyKoD2mRiGnVHoY5awXHqGWaRltbJk5ZTwrh19kGV/3o6h8hap/XrIxEcOr72OMATVYcxk+eSJZK9JTmVG7AHW
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=J1gerpJq6k4A:10
    a=v2DPQv5-lfwA:10 a=clqvZBQN-S0fMu0yQwUA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbeC3PST (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 11:18:19 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:39509 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeC3PSQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Mar 2018 11:18:16 -0400
X-Google-Smtp-Source: AIpwx4+GuL1jvK9JB8l78d6xlwcY+tqr7gHcmBFWkyZulVbmktMzuwPx5QuB3am4YNj45EXo4t/wOA==
Subject: Re: [PATCH 4.4 00/20] 4.4.126-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180329175741.886181131@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cbdbef75-8f2e-6546-0f54-71454629d323@roeck-us.net>
Date: Fri, 30 Mar 2018 08:18:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/29/2018 11:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.126 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Mar 31 17:57:30 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.4.125-21-gcc5630a:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 127 pass: 127 fail: 0

Guenter
