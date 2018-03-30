Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684987-1522423195-2-5322438639066208711
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522423194; b=QYGAwqghjRNY/W2M8qnwOu5BmqsmiT7/FWn8dCKAjkY3qIu4IS
    +Fc+nCCMstlA0T7LXa3KKXUfPKChl/IZkKoTUhWm7Yrec50J7JodKuXQ53ElKKCE
    2zB02Zi9Da0nI8jKKpRddKmJ9GFeNb3MAmKoWDmrLdeOM2Az/pWG5NYz72gCZIS+
    Jko5wnNY6Cp4WjNbwb8GNEWuexMgGCK2Szi4ThvlW3UYj1lP5V6FsJwqatFs7GwJ
    Sn7a+eZTMRFR6YzpNYERkYQ5e8Gp5hjYgzG/4nyf29qfAEaCpAdjIYwl4TqYCFtf
    9VDq6mrn24/NemS9hKkJxK8p5rST9ZcPYQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522423194;
    bh=Zi9C93zjIyPTZeDKcrluGHV+Us4sK0IUOuF2Mwi8SIs=; b=ehEfv9mPAWGw
    EVU/v3oqAxmMycL3pwEq+X23Tvtz1mirDDTke7OhdRk/9B6mik9r80MHYvZPW2aQ
    S2U83zrweDwJ3dBO11UXldPfmck5NZirA8EbYtnefIgiIOgDrHhe3Hp0CsgORDoJ
    pto74SMAncNmsk6A74a9c9tufb6AOHf7VeN94qwz/hKPrxvotnbGiEs5an/KQ0PX
    h84n5byX72hL8BzFfGJOJylLxDj0hT0ssoPlz0x3FmFIx3eS0scXw6G7wDT0WJSm
    DRbTGfF37WrPzUtpJy/yRAsolKEiw1RFU9SzqI61yDPamVHMnFnhiUNiZ/Dce9Jt
    0crqlYAX+A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hEfIMyax x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mfdu7ihX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hEfIMyax x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mfdu7ihX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDg1HBMGyNMSMLpyto9QEt6CpH6HwikvHGpoe1JO+6nnQ5f+dQzPE2zwqPH+BrcTemEdW0pnQmBEgjhn5PETP7TApS2DDwlScBjNvABHpJubshq9GLvY
    XfWPgBr2Ytx/jx1ksgvjcECInvvcVYRN1ttSD3JmfffhpZ8IfpLxEjb37hbc0DeePFrwbW2Yy2nrvNbVQWWHmI9Syb24l1Cq5HT9vSZtBedU2hzqbOCRQj7R
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=bdhgAJw2s1sA:10
    a=v2DPQv5-lfwA:10 a=fXDnvd45PkOifeEcT_IA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeC3PTw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 11:19:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38495 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeC3PTv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Mar 2018 11:19:51 -0400
X-Google-Smtp-Source: AIpwx48Xrae1NJYovCW7LXCnpKBE6j8/3iaAXtx0GidVLt5fgstYocLYeWZcO2itMLgg2TnxpDySRw==
Subject: Re: [PATCH 4.14 00/43] 4.14.32-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180329175730.190353692@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <74cfb8c0-b4f9-19a4-729f-ef5081d1752a@roeck-us.net>
Date: Fri, 30 Mar 2018 08:19:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/29/2018 10:59 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.32 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Mar 31 17:57:12 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.31-44-g0bfe33a:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Guenter
