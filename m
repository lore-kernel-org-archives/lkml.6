Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3189361-1525180818-2-11552997676294936362
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525180817; b=QBZVYht5df7oHXAC8bXxk8t/7difWR17OlGmCSvKiIC9MgoHdA
    d9tWeQ8WWW/pNIsDK+bTDg8mK6ET690Ex14eFJFmtJf2Ua9Atw5jyrbyagf9Qet1
    W+DN4deMTpfO4gjw+4x1dRZGzxxS4Yyylml6T46JPH6LJvcF9SuSWTP6eYEslhOB
    R/N284F8UXWmKJWb8eRi/I/pIwiXfKzaxQeJT/fdlPGFOTpe2pW5CBlAB6foDoqn
    n23+S1LYlyG27noPndVYt4iS7E5GMui0XVVmmZDB0pit98r9JlO3yFVnLsGbRjKQ
    o8SVdyHBPdy/z++Zq4CYmOL/6U0AQ7cmFyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525180817;
    bh=ahh+9oO8lNzNUs3r7c7T30U9tWNTvXhMbr7X8hhlfVM=; b=CLJUi8d0rlzR
    Bk34fdnGTdg/ouwabK3Lk3t/TD4bzdU/AQKypffb8xLx6bP8Ka6+l+LQOxfvUF+Y
    RMNFQrpdmddkjq7yGNKKoU3Bcx3qjCP/lx9DOA1lzAAWeOudpqGXL2sGl/XlkklN
    /WC3ZQWU2StfTOmF95cqgcDyHyXMeivWDKQxs6NvMsnb33YxLqfTIB+0LpcZfZIa
    5Voi4FOZIwL+WUJTC4MF0mJ6QW6AGyRIpJYsv65mIIo2EYny8ioAcLzqrp3X0jfI
    Z4vKYllZJXn7NZbBQgkdLCzFTjEEVv29qDRvS7LN/XlT2ZSotivIL6ol4SNPo8Hp
    8ay918UkTw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=ORD2ge4X x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=cCqY3UIL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=ORD2ge4X x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=cCqY3UIL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKWuXSyeccuTecVoWCCVdkRHWOgFnCVyFvtr7RppBQON+bP0cfe/C9omJUk0ZaFSE2VfJryJMTdqtsmnMaetFGNUAOHxFFymVzCrpXttvGkXA6DVAvzC
    K5t/FiOrj20jxfjKwEz9qeGaiWMpcxNXjyk5OfpFz41Altm8oMkBTLRFO3X3bAzu2Q/9tccnXBduhRJC+E9tv0COGU5nuhZ17CHbiaQQK9MHWPSqjB1jisvy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=q3LV17KGstoA:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=HoCkWmlCV56ydFt2py0A:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeEANUQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 09:20:16 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:37022 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeEANUP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 09:20:15 -0400
X-Google-Smtp-Source: AB8JxZqaUX+acONp3S8Yuj3vilQZT3op3uttPMQlnYBT6pJ/GpPbFy3uq4gyy478uePAz+ScKDt8eQ==
Subject: Re: [PATCH 4.9 00/61] 4.9.98-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180430183951.312721450@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c30f5082-ce44-038d-0508-0e86d7034cc0@roeck-us.net>
Date: Tue, 1 May 2018 06:20:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 12:24 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.98 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 18:39:31 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
