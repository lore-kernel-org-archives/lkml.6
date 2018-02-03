Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1369506-1517676380-2-16452814644927100485
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
    t=1517676380; b=E54TkpTfVOmOV0N4PPK4epWNCHNW098t8ds2RgIfGEdwzPC
    4F23udU+l1UVjbZcbUoxgID060qG10EKy1uJxNKQ09A+qCg2ezcpD48U/Zna9gTJ
    m4tlXo/xI91c7hhn8/w7InlA2OwAmHzCVMEMQRZI/bWCrIzQw5kge1CAWduiAJd3
    UA5s2NLdFOCli7nMbLBiUC1jiyzAHS/V+W+3SB16ePreU2aghQ+H+GtCxYbvaJlw
    8GQo/uMOM+ceCwhDPRK4PPG/0kCR3x/IAuAEUh9XknBtAOnLGmxkETHbKgm/jAII
    qXUFAtDuPM4s7fjwecQCTaIG2gE/zthtIFbbYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517676380; bh=Y4/CT+oSObujNo7yx0oMpU6Fyh+eG23RuXj6QDKMHRU=; b=G
    1BmhqLV9YrcLKp8Xk1YwJufdLMOsvRw08DA/tWJVd2+rTcclsVuKHpoRCYZmYBnn
    LYNY0+B3kmUHYDeioZ4WFmD7UdOdJ7iA7D+ZXmFC760P5DDMqWXd/uOsYeCC2WxB
    QWJPvqp5WWvpFEgUdBTFWDnfsFcJBANNJ8PDkN8WxqenhcQoNrnEW7Kok29XMQlX
    I4dqBk2wj4TIHc9IVqBHKQeYFX0FMKt3WJiHLg4QDEFlemUK1s+pCZpr0u+25XxG
    bp5iyB9vw0hsjEK0Y1hpbAHk1eYmQNhCb0nd5/mHlw2QI8/HqmhAMvlVA4NrX+y5
    1QcUZshSMbPGQmQMxAZyg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QYIpgmT1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aEP8mi+j;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QYIpgmT1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aEP8mi+j;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752363AbeBCQqR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 11:46:17 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39786 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbeBCQqQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 11:46:16 -0500
X-Google-Smtp-Source: AH8x2276IReHnNf0tgwyYGSR3PfSGFT59XMKOluagAd/RqVoCHhRs/DvOymiKwrSLynd8JpU2Wrdew==
Subject: Re: [PATCH 4.15 00/55] 4.15.1-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180202140826.117602411@linuxfoundation.org>
 <c6ea53fb-ad96-dc63-4113-9bb1d2314334@roeck-us.net>
 <20180203154441.GB9631@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f1fbb8d6-f552-1aee-110f-9e926cce6428@roeck-us.net>
Date: Sat, 3 Feb 2018 08:46:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180203154441.GB9631@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/03/2018 07:44 AM, Greg Kroah-Hartman wrote:
> On Sat, Feb 03, 2018 at 07:34:17AM -0800, Guenter Roeck wrote:
>> On 02/02/2018 08:58 AM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.15.1 release.
>>> There are 55 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Feb  4 14:07:50 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>
>> Build results:
>> 	total: 147 pass: 146 fail: 1
>> Failed builds:
>> 	mips:allmodconfig
>> Qemu test results:
>> 	total: 126 pass: 126 fail: 0
>>
>> The build failure is
>>
>> ERROR: "sgimc" [drivers/watchdog/indydog.ko] undefined!
>>
>> The problem is inherited from mainline. The fix should (hopefully) make it
>> into mainline in this commit window.
> 
> Great, I'll watch out for it.  What arch is failing here?
> 

It is mips:allmodconfig, though other mips configurations may fail as well.

Guenter
