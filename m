Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2406842-1522244339-2-3501731955343344683
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
    t=1522244339; b=nV0kelkT3PaaSwu/mzr8HM0YcJOTypddV4mrROvE1RS3hht
    4EVvzGILy6HaDt1u1F5VHXskwfpaZuRvKlm3TksyjUADDPW3rs1cJKbKBSQ/7qAM
    qrM52eQ8Z41Bx02FWEjHmRobE2Yw/Zmm1FrspDly1hjZDo45fnEckkW7VRYlf4BO
    iAzU6tNJ6OUk5BOA28wx694VGC99+KoOEnRN3oprTVbw/Zeme6dB9ISCJ1lI44yg
    WL2eT8LyfTn7CyZZyKoz61H418mFULy2uJa1IKWqjehv/XVuvpVun2rJjS41I87y
    hbfqpWmLX3Yoq1wYgima5qE7qqSdsrjNXCHN0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522244339; bh=HWedjXGRBDEvDAJ5HMHvSVcjd6dT6XBg2eguvffBwG4=; b=b
    VvucBLwouWXH8xS2O/WsMw49Dlz4/Y5llYNkpl0mcvWEsc/rVB9fWVHV+VnBDPRG
    2l62vwu+cmjQQuHaCoWS9aaYut8l4RKVVbs2BNIQsO8OVPf41a7uAgT8fiEJBpxS
    PfbW5zwoJmMZMI4YIYqAdgd62R3nI0Ad/FGTPhe43WdGQMAJSVwS2UyAccrMXHzK
    2u4+FIKq2jU4NKUiXoZhmwJDV6U5+u85GPXIecMrQCMTLjeB0+A8DHcFPsdHUKcP
    6hRghpjwhihoOFduA1sE1kK0Bg3fP1nHx/P7Lir7ggevCR/gdidr15F+DpfBruNL
    NRivO74vdTSg+1Qhijt0w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZToj6MGz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s7Oinmfq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZToj6MGz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=s7Oinmfq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKQ2PQxKCohHRbGZwdM2VuHKLDYEXvfNiNMV7OrQZ4sXQZGRp47qdebecLY/f0pZsa0k9b+RLoiwa4jzQdYuUlYzoobm9UNBsI8LJTClE1PYaMSRf+6R
    LJMD+4p9BWDvyKrIJOQ3gc6vRNoUiv1+KHIA10aok99cYRG8dE1vRGsyjtMWxAfqSjpufiOkuN5lv7VRg/+MIlQMYpv0R8Wj75AntkcPfoY7Y535B5cQsWrS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=lOsWcqUcs_UA:10
    a=v2DPQv5-lfwA:10 a=wSFAT0bzRL9SllPayaAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753053AbeC1Ni4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 09:38:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44096 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbeC1Ni4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 09:38:56 -0400
X-Google-Smtp-Source: AIpwx4/c6IDynNDFiPz/ssrOFHaqoV7FaJePZBVt8eJYBzM3qJDfadj0Ref5PWEAG2ySABPTkSIREQ==
Subject: Re: [PATCH 4.14 000/101] 4.14.31-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180327162749.993880276@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ccc26122-eeb2-8b56-f8ff-51655af96822@roeck-us.net>
Date: Wed, 28 Mar 2018 06:38:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/27/2018 09:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.31 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 29 16:27:21 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Guenter
