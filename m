Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2522873-1521850341-2-6865466230169359636
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
    t=1521850341; b=JhRclkVuO2JWL5c4eVsBV5wO9zm0U3ZsalgyS08c5FR3vuk
    g3wit8+CZNoleWcTwfYh/oPgUKxhJVIsAH3pd1dNUlfkNsqu6Y+i7z5WNZoSMQzp
    FsDpOwlOleY6L74SQDpIZf8Z6TO4up/ohkfmZVvY/HSfSYv4O0Nhj3Ph3SNH3NeN
    qFAawzpTkbkSXhr2gDSTLECQXJtDYxs2IBD8AlyTECsC0JA6l9NNQUotrAhB1l/Q
    duyEAzYdnXHJpdL4PYxUhMsIn5C76whgs6IpDT7cqRBugcT2d3qfwNTcB8+XNbbu
    +IXuN4d7wmtVxCXcIif4lLy2Am3761/5PG6prog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521850341; bh=E+U3wFZgWyUoS6P9sURFz3yUeYGI7C/Mqj5AQb2uT00=; b=X
    WoRfvfqq53bayunDH1AGgfzNuhFnGhqdqxl9HPqaxIQ7SVwlDHfP/gskTYxsh/Bu
    WcWDCMLurSPNgmtv0gFt6sovybdaRxFh2gJUOs/YWVwB4YA+wv4OaW0oWHBdUiwD
    xUeTe0CRIUKWGXOlSH3OYRoSoc3jSpy+Y78nAs8r/ToUJ+fwWwJUm6rtJHf5Yv8b
    FzgTFi7zfDinmCFFShjuaYkpMEFyUdflPzTCO/dL7zPaiu2a0uRZSak1mtcrJAcN
    UKiZbtVRJ024zD/gB8+uxc71J+piczi0jPWYperfKWVduek1VAZiDU0XMwdO+QKb
    Yag7z8q3hjSTGiSfY7a+w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QcHC79ob x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bBbeJQO3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=QcHC79ob x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bBbeJQO3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeCXAMU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 20:12:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41769 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751818AbeCXAMT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 20:12:19 -0400
X-Google-Smtp-Source: AG47ELtjunDIqWeKbiyNZIBVqYF2YEWORrbybaVl2dIBNB4J2h5oKWSB7eR96DIr/ARrOS/raVMMJg==
Subject: Re: [PATCH 4.15 00/84] 4.15.13-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180323095411.913234798@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <260984db-e162-23ee-d848-9208f40b5dee@roeck-us.net>
Date: Fri, 23 Mar 2018 17:12:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 02:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.13 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 25 09:53:34 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.15.12-84-g85ccdc8:

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Guenter
