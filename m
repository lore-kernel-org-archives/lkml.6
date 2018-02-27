Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654150-1519742065-2-18426327595819688308
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
    t=1519742065; b=Xv/0XijixyYwj8AdlaiEl4ljkt0LZpctXH8S5W7SVEg/iWN
    oKgmymT9+BuLUOe7oneCohSQGR636ApdSupUtybPr/3osKX1kvtccLGJlRcNC1HP
    TJ2iSH5/mlV/89OMYyzh0WotFNoaKJVA24YqlVK9zcLxcnA929kw2usiV2K7y02W
    WVklTdyjqtysRHu+kmSgu0lA2HXDn07ENhpUDqRVnLED62Q5tN+lh5QJ1ZQ7wu+L
    jIZL3l1+FCZQ0nUWeB4MPH1cWjF6skBBYC+fZnL5guIhc8R8qNp7u04MOtB9z6ab
    lBOiLxTqxmseqn0rNfeUMQ1c0oiwvP3eWBcdKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519742065; bh=qU+VlefjsNe1L3MWt6rQgiaj1dorKdd6XEp2gNB0AMU=; b=f
    G6FFthq9cvlPXj7fScdyO7pek7/X7oH7exXTGcAcAdNZEGBQvCKfGDsqBnfW6tXn
    8FyazPJvtAcOooUGDz7op1B7NqzxvQH4PZlhsgPFo0I8/LoC6bg9HTaGaqOK3GMq
    9g6CzWaqJq8R6UyDJCvfAftEoyHPCVDfDukpNCgHBk8E+1IP3el/RZrUyX+e0b6q
    YIevh7yf4Othi6iE3knz8CjxZoNs4Ix3+SOEtYaDbpD0xfbz5q5p8FzySfIB8AAd
    o7pqp0FgcAYxW0apEYJroGs7KHB2+Pa0VX3h6gepBlUnSOaUtDcSaW6XOxxJeq9I
    6vWpiEir1SzlSPGyNsi0A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZmXlv+xz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pWpBB4sB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZmXlv+xz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pWpBB4sB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753461AbeB0OeO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 09:34:14 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41325 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbeB0OeM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 09:34:12 -0500
X-Google-Smtp-Source: AH8x226PZxVA/LFXpuf9Y2CNC/x4buSLJA6y2jcCIR4d99GQRZSzRcWh/3INxHEhPOWSkGIqA2PwQw==
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180226202144.375869933@linuxfoundation.org>
 <d4f09175-d9f0-6251-ef34-14934fce5186@roeck-us.net>
 <20180227130859.GC32493@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d67ba57f-c6df-b854-9487-70ce95a321f9@roeck-us.net>
Date: Tue, 27 Feb 2018 06:34:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227130859.GC32493@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/27/2018 05:08 AM, Greg Kroah-Hartman wrote:
> On Tue, Feb 27, 2018 at 02:59:39AM -0800, Guenter Roeck wrote:
>> On 02/26/2018 12:21 PM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.14.23 release.
>>> There are 54 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed Feb 28 20:21:22 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>
>> microblaze, m32r:
>>
>> include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
>>   #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
>>    ^~~~~~~
>> /opt/buildbot/slave/stable-queue-4.14/build/lib/find_bit.c:176:15: error: redefinition of ‘find_next_zero_bit_le’
>>
>> v4.15 is also affected (m32r builds in v4.15, though, for some reason).
> 
> This sounds like Arnd's Kbuild change 101110f6271c ("Kbuild: always
> define endianess in kconfig.h")
> 
> Does this problem also show up in Linus's tree?
> 

No. My guess would be that some context patches are missing in the older kernels.

I also get lots of

include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN

which as it turns out is also seen in v4.14.22, meaning the actual problem
was most likely introduced earlier (I don't see that warning upstream).

Guenter
