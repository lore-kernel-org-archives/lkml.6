Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1311000-1517927569-2-17242193736327085881
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
    t=1517927569; b=Wn2Xh2vgzlkOGoyr/6hah4ycOa1thKvLC3KlYDefHRqhBpy
    6H83ZDI/SMV89hQ+hBfBee0T+F86GIHhP3cMTMjhbyxOMGxBoCAcv+2pcPSThsSM
    I7HcvB65KX6/gwBbYBWdRffUXJhO2vtBpR/+LZMnzCgeH7JdJZvRPsXBhb5cNZXt
    5FTeT/HX52Lz81or+JqeJ6S1ld8pCmVr7TiEkYtVmDNH7W6Wyj2/gOQ4nRv3EJRO
    ykIQzt9oFULD1OE5900NkOaSH2scQScl7AYWe5ELSIhgdETjaS8wxckQTR9nDwKj
    uuuKsNQJ9ySoifvjWU+jzLENexxn7ArwdXmmPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517927569; bh=3CI4eaMSVWH6vqn7RX80WXejXxtx0AQbxK1/t0MxE1A=; b=Q
    waZec14BHLi8foKXC38MAuINIzGPLEHTyjgLvejPiYLTQFTPqWiPEH77MX/Wisnz
    usau8Mt4k6Hk7mDasN/Zp8vnyCdLBDxPjBXAAzswnnv+wiSI+AXr6UVNC7ZgjgnA
    kFLPi1O6mVzWfD3v1ZH8t8ifwFt14w8EpkNmR4dKv8pOG0RZPt+FxqCTb+g/tMzE
    1bjD6Jtw0kcBy7FYn4P40TOCKTEjTvVnRVi2oSTX11Ni88UAenWgX1u/RNPmQYi3
    tJGSG1Vd3XBFXgfSQ4leXD9HpRBoTgFIix80s8NG28SEXyISUZ+TR3yv6jwNY+Og
    peH3YDJzFNn6Wedra+7kg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FhCeowiE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p/7lNtaD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FhCeowiE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p/7lNtaD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeBFOcr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 09:32:47 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44478 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbeBFOcp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 09:32:45 -0500
X-Google-Smtp-Source: AH8x225wLoAsQwcIrCXH2N9/7R7hQb0zY36OExW8k2GwjZDZ28gmARQXDvC50Yuta/gYUoZ8xZnTOA==
Subject: Re: [PATCH 4.15 00/60] 4.15.2-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180205182213.902626065@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b16b6d88-345d-0da6-b914-403b9d0780a1@roeck-us.net>
Date: Tue, 6 Feb 2018 06:32:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/05/2018 10:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.2 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  7 18:21:57 UTC 2018.
> Anything received after that time might be too late.
> 

Crap, the previous log was for 4.14. Here is the correct one.

Build results:
	total: 147 pass: 146 fail: 1
Failed builds:
	mips:allmodconfig
Qemu test results:
	total: 126 pass: 126 fail: 0

... meaning the MIPS build did not magically fix itself. Sorry for the confusion.

Guenter
