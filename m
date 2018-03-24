Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2522873-1521850244-2-7688785539187908614
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
    t=1521850243; b=Tev8vA7vg7HW+adSYKD3zm1ElH768rwYKVa8uccliQzAfoO
    VjabE5Q0DrFxQ2H20h7eRvlf+Q3DLVkwSjkDW81IiHvS8z4mfP9GYtthBr5Gm0v4
    xkyBRxgvrjU0SdIHNHwlN9RxHte94TfI7ymugqtu+0bp89z6zu6y1bbEJ240QBBN
    RBC5WVAFUpmve3ruH138Pyi63ppgIAXf1voui0Z/ZkxmQ9Y4LXFdtVsM0CZ4J0YJ
    pbtbkw3DCqXKPRBFpncELp6VSvucPTnFuwgh5dCTb18bkm6V9/GVS9VEWFKML4MV
    FUPjn3sC7NwnHhHcTWxbH5MC+47XMr4tU67xVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521850243; bh=hfalMJT39Zva4twPKVZPs0pTo3xXkfeqPaBkqckajrE=; b=F
    ocBf0Pk6dtfkGWMhSlvhSRQ7cbikK4+2PPGr+pbI5gaxv3n+2wd14HcRHaSm9Qa0
    jUNKZvV4vwzT3PTMwbRifGO+Ujv/5oaTGG9KspVXVUis/UDu1vRnPX4IpV41T5fj
    ysJ30e2Yf4qne7cLLhT7sONfCsX8HHY+dyMKjG401qySW3iNTgNMsYTyBuY6Vr+F
    U4zgiFnqBCI7vlcSBqjewsR/juFtYxC9OOhqzZ394Kv94F7cAmGfbBb2JA5bTf9/
    F7IqOJqHaAy0rkDe7RLBCBKceaaS4D2jRdqP9lmsDuTr+IFWky22P+nPB0A5HkY5
    vNe000EAg2baE1hqU6wPA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=boUvsSUh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X47SfzVP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=boUvsSUh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X47SfzVP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeCXAKm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 20:10:42 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42367 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCXAKl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 20:10:41 -0400
X-Google-Smtp-Source: AG47ELupq16Y5BUAkF2nsQ/IgFrJwDTJjJpGM6c0qYzaJeyuYILuva+Y+kIYPqtROzGQx28TW9f86g==
Subject: Re: [PATCH 4.9 000/177] 4.9.90-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180323094205.090519271@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <aa0b00fb-06e0-f119-0085-f28582baf0a0@roeck-us.net>
Date: Fri, 23 Mar 2018 17:10:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 02:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.90 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 25 09:41:28 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.89-177-g87485cf:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Guenter
