Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654150-1519743375-2-11225000106371555949
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
    t=1519743374; b=Hswh7m8fAI9g/nXVVtsCxHRXDKTkIiyKxbRa4eS6zHIsTnF
    itl+HVNZWneVnFnfQiKKYx+nOZWgl7+/doHX+ztu5fZnchSbv+y8zb4qZss02WUa
    SVZXJ9B1ibre6dWsCci8jXbVeKNt6yVlLHFP8xAcKY96+BxdqB28Y2wOo5kfE5bz
    xXyFWCjyBDeXY9PaumdDGhdDO4AJ4FOVZi8PWAogbVEaQhRGGN/ZpVV/a4mb+Nyl
    QeLz4NnUYk8j8Oi8TA4TRMVYsEJoNf0PqH7AIs4GsKtpoYWG/AyWKrUSQ1Bw4u34
    XKLS2748GkPmhIEt0WVBzDLvD0h9I/WnJwKRbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519743374; bh=Vi6u6sCd2Ni3px2cbiEenWaVj6A1vAFnnuQ3fWRYeJI=; b=k
    XkOhbxIqS73D13S0Ic5ecGWNLR6HL7/aQcAIcK+gIqVdKXAOBqwV/xfCVcV23zZd
    C+ogWZ4LoTtYLyqeWzS5XXCLeUdIy6lEGvF3Bqj/a08iu9Rb3HPGLOVM2D2lR1G5
    QX9kZeUXzduj06cDpsIX9CKc1KRNBtaHyybQ/qgbc8IZAKC3uiEz+RYZnPJMvreq
    OWAengRTucrGTSBDvBHgAMSzhh423CgHtnfjLaz0nOur3k7CiqbamfcUR6qb9DgO
    d41gQqvRfFlazbSragP2DZH9HZRXyx6sl78zPivx6k3UHFZwkHGXm+VJ+KqgIO/v
    8joOInTirXurTGTobfbsg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ijeClNzr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IExa1lCJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ijeClNzr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IExa1lCJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeB0O4M (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 09:56:12 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41964 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeB0O4L (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 09:56:11 -0500
X-Google-Smtp-Source: AG47ELsuwPmWwLRWT70Kr3Xa1CS3RTpvbl/i5kGaxZZOnDeiB+OLxa6qZjAhcefcwos5c+mI+/8auw==
Subject: Re: [PATCH 4.9 00/39] 4.9.85-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180226201643.660109883@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e6e1abd6-cbfc-d54c-fef1-ef1acbbe798b@roeck-us.net>
Date: Tue, 27 Feb 2018 06:56:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 12:20 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.85 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:16:31 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
