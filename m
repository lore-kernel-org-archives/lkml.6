Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3215875-1525803507-2-14285733294973457853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525803507; b=eFCvQixccrnJrpCq9HmTyQB8ystPP1oR8C8y9djju1597Glm+I
    SlmiYpwGwkuBPG9p/TBdCm27x7lBb3hJhDLlV0lniKK70pdwDHjP15dZvkGGFfdx
    Fryb25c2kM19Xgu4R6JdBAcxLi6N1xfug8AwS5XLHNvvRP5RnmnN4sRZS9gIwYEV
    kV0AAae3D/qa0dTpa7jmoVNG19Ab2dPbJDfsvNtt11yUPVOjsH+kwaF5npZWJis3
    NASBZ/2l+QmQA3nV1OfE5QKMhP7ZNEtQhUa0T0tl6TZsI0vmbmwVMFm0zvM8EcxK
    Y65Ej54oDJ6adl8g5GlFyrsKkGgFdqk7CZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525803507; bh=TwqsJE9KIhtzC/3l2xIhVcBmmIsfw7kjGXIQazVDSn
    U=; b=B/f6B8GcsesDcitSIxRT2WMG4YZ3VKzLfRAqQsEt81m3MGheIq7xqsFNWv
    RjMfpmiuvUymkrThvRyWTSTmdquMewbO+jNO4bWj54Mzi/6f+guAmIyJaeIXTmoK
    behwtQdhLgygRxfh6RoXgfw5qsIbKEfpuZ0cC79utWItBTr9N9j6+wx3hbb6Zxtx
    ACGTOJ6tgSAP80wOCI4UzCiIHjbUrgGBEuexWlRhmM973LjuD0G2YPHo8trdGDWj
    e63zujQ4xtV9hw61wrn4FuAmo6ukaYc8yLRw7wchRGDV8H80U0g+Byondh3kpCWz
    gU2tI5Ers0GIvv9328sR8le3+hZw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=GWSxmsWl x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=nV1POK05;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=GWSxmsWl x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=nV1POK05;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEgqcjD9oPFv+0CfVJYzRfDjvl6Ry3IEqtiOBVDoTx1Tv4aDJKzZJ/EHXs0UBc7QpZaV848hCb0eevCh/OgI3gL/r4D7hWNYOJ6swdohlPfydNl3dzYR
    A8rzCZcnDpD0dPvvjgaBJCiW8/+IblhoA5WjGmKW4NG4dFv3YPc1Czhtjp7xpO1nfDccRmF80zIAgN7MLOtTZ/MABu71UQDOhpx83d8tZNQHIJt6k30P4ex3
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=bdhgAJw2s1sA:10
    a=VUJBJC2UJ8kA:10 a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
    a=efwVt8yOurbDeEbbW5IA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933596AbeEHSSK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 14:18:10 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45980 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933120AbeEHSSI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 14:18:08 -0400
X-Google-Smtp-Source: AB8JxZpgklZ9YOurfcCUWkxHK+tUC5GxA3miI+cVxAsTVp/63pK5A9VM3nrrRo+5mE+OaL3zvCj63Ja99MBj7NN5uqA=
MIME-Version: 1.0
In-Reply-To: <CA+G9fYvoNi9qg3Gb0cU=y9hhSZX6FKt5D151GUAnXGJ_tS4g-w@mail.gmail.com>
References: <20180508074003.984433784@linuxfoundation.org> <CA+G9fYvoNi9qg3Gb0cU=y9hhSZX6FKt5D151GUAnXGJ_tS4g-w@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 8 May 2018 23:48:06 +0530
Message-ID: <CA+G9fYvunoGdC8gyph2iL6mLOnMqqbFGOOWtXJe4hTsw94idYg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/43] 4.14.40-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 8 May 2018 at 23:41, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> On 8 May 2018 at 13:40, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>> This is the start of the stable review cycle for the 4.14.40 release.
>> There are 43 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu May 10 07:39:32 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.40-rc1.gz
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h

Please ignore 4.9 results summary in this thread.

- Naresh
