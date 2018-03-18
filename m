Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1222381-1521412896-2-5171672245689374815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521412895; b=rJWio35Gu3v9r3ICDqwnakgSQRUIXiOIM4QPE06uOdX3Rf7
    sIz26s056INzmMiOSkSriA4JIdUpzDz3LR0I0ZgbmgH/z2mCLwrPgD47ZsxRKY0Y
    czIOku6VSHHRVf5Q3ZDhRI2TuU89H4O7RYg0veznr9FSUuBeQtdwnubBcq4iN/Lr
    62wSN2yON3TLMAReV951Fi5wTsEbI5dN+FMo5Eun1LPnVZDKRe3THuTJ0AmxVd2N
    Rtg/QonqgzOO3RI6jzngvM3is+VT+EUrSdErCAIdhZ18k0zJihrlyruSs8yPiTZA
    f1Ng3lCco9eapvDf11+LL2zBNmAqHxeL22xWAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521412895; bh=e3FFCDIWx/eBX7h+JE/wT1qR/l2qvSTM2WC7JCwqPVQ=; b=j
    sPIq3mPV2ovN7iwCu4xRuCD4tezLhKr5vz+QIy/nc+/oVYV8ljlOkVJ5nNlubu7I
    17ChAmLp7CG3pVs+mBNAnn9ugqXAIZUtdyT3nLQt1z8W0NZBY4gsEUAjxn3sJnd0
    lBXBr/JfUfwAMVkTqAn/KVVrKkiLVLvs7Cy6CFB+WwIMTCk+pxiP/JCQkahwBZ+a
    DdVYcuSwecjIF0ehFesL0z+H9l8Cm4sDH+11P6sVB9weh02zfexw7orxQfstFPvm
    vRIu6MUot4heB1KxdgNjxEL+81hnyuT4WuqCAAPz3d9VVS+TvVx1RMRWLNvH2aYx
    9bfPVkbQdqF/wXq6d0xFA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Xos+mRkA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i5BZloiN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Xos+mRkA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i5BZloiN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754638AbeCRWlc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 18:41:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44171 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbeCRWla (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 18:41:30 -0400
X-Google-Smtp-Source: AG47ELtgOjK7DYHkqHa4+LGk+CloB4c2o6Tbk0iZw7eJrQyM0lKCK3onCacGTawBZrIfdMi2c2UbtQ==
Subject: Re: [PATCH 4.15 000/128] 4.15.11-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180316152336.199007505@linuxfoundation.org>
 <20180318102526.GC30164@kroah.com> <20180318111523.GB4607@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <76a09f16-a4a3-c860-7c9e-2a6a6ffe0b73@roeck-us.net>
Date: Sun, 18 Mar 2018 15:41:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318111523.GB4607@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/18/2018 04:15 AM, Greg Kroah-Hartman wrote:
> On Sun, Mar 18, 2018 at 11:25:26AM +0100, Greg Kroah-Hartman wrote:
>> On Fri, Mar 16, 2018 at 04:22:21PM +0100, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.15.11 release.
>>> There are 128 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Mar 18 15:22:57 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc1.gz
>>
>> -rc2 is out to fix a build error on some configs:
>>   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc2.gz
> 
> And -rc3 is out that at least builds properly:
>    	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.11-rc3.gz
> 

For v4.15.10-127-g19c3db0:

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Guenter
