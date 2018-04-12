Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1017744-1523539034-2-1840275554000279817
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
    1523539034; b=UGeiA3ZrkYoXu+wOapX6/BreSo//lWAW9kCkgW1WICSyztQSQ6
    aX/xtsFmxR4H3BBUDHJXdCurG5LXudQ4MMNL+SS7Qkc9AVptjaqQ7BNW/d0ChI9p
    WoIzV248VT0ZatmwerYZiU9teHHnnbnsi9yC8yxPetlJMIJ9rDMKGgyiYGvf0cOr
    vrbTL8zAxZUcsjTzPkI5gccgVZ01ZHW5Rw29GXLdvU/JwWlnqHiwj44TYVWhQ8dn
    LLNg4VNfwAd+rjj+5B0PQDyPJru27+Ta3qKu9ne39eKeuOGx+NI6IDTznsxH48Dy
    RyTDcLD64iP1dNT2P5UbFZebBHsKczG9ubhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523539034;
    bh=SD81GwXHJ+s73ws09FBnAhnuIcDzvnw00pk02ojEz9Q=; b=rXMz8aFR+FjB
    tehasuoh+B9k81AtBEuH3IaVpDpqdx8OzMqqfDQqWi3N/gcF4RSPu/fSgKGjZIHE
    npKh9UhJv8JU5jT0zCAc9W/JV1aVkBzhVq1tmvVs8iv7EgFZY6ETuDrnu7gZbU+C
    fPILvFUCN8lqLCM3i5pr2wQgH9ZTYaLixqYqjVnoG6FPs3TJFe8JkVMpO1pqdB1a
    cUSFyXNNRXX/wqmB5E4ha1rYAjWzlKm/yOH4nEdeavJNVgYgUEJPsN9LELqSqfIU
    q7WAF2+APvIL0ZIIx01OYFntB+YqrknjS0shWxVna9M4IConp2DXS4eLWk7YxjtO
    tbrHf4OenA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Acnb5BC/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TUWqKA2a;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Acnb5BC/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TUWqKA2a;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMglJkpRx4nBajrGbAv/IJDuu3PXlXxyLSGF2tpAytOh1Eqsx3ZPLJ12ieDokw8jr9FTwLUUUhlmuW5fJTzw/2ZOmaG+oqG5WPrvc08pw2Hu2Kqh/SlA
    Td6titcUwLzX3fsdS6zrhwng3LeC2jjktI/tUGWv5NaQKgf5rsRHwNyUrz77l7z4YWZfRE0QmuSEKQJw5XWeL9e6j5xk1AOuLzAXUJ5yr96ReQH6kxf6PFz6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=vSoj_SWoPg4A:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=wSFAT0bzRL9SllPayaAA:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeDLNQ6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 09:16:58 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36481 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbeDLNQ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 09:16:57 -0400
X-Google-Smtp-Source: AIpwx49wDm80FJn3FCZDXFqK2d4c4gfN5uHivGEcmsNh45R9aMwT2vOLH28d6/R2go8OlmNYzH0KZg==
Subject: Re: [PATCH 4.9 000/310] 4.9.94-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180411183622.305902791@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <53f2486d-c028-abf6-7fc3-5c22ff2a4118@roeck-us.net>
Date: Thu, 12 Apr 2018 06:16:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 11:32 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.94 release.
> There are 310 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Apr 13 18:35:00 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
