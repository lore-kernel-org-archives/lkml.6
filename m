Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684987-1522423153-2-11938763645275912423
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
    1522423153; b=sb4M6wv2q2Z3xN4vrSDebZrl34/qJG4OZxCg0TLxTVB1GC0ji5
    /lznG9x1wN7FfTRdYP5ZyrGJY3Z5fd4OSHB7QlAiU1GcZWRSiTRzXhuP6LCy+6n6
    l8C98aP6p2iLQ4NADU+qvVv4/+ztHm7jfAA4WhCU8wV/kyhAmuj88Np2HlSYKy+E
    OtpYuZHiHsjrRBVW3ON7SqZ9qlCNXKEP3pJ7TQu5vDJzNSFDQ36YH1Nq0RV7nnYO
    myfP9Q44u/C1HSe51MZkMgCa/nGFWaPYzUAaVs6MhEBksf3lte4f283ACZm/ltT0
    LbDjgzSO6CDa8aun469WF/s0+7PxnDvYUWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522423153;
    bh=PUFiBcFOtJxQp5t7ZV4+u5wN9zGV/4/aK/CSEOtZZvM=; b=VzW3OwXoKsQk
    RHyaAMMCFksjUK168vH9NbfgVzTwgfybwggu1AOiyHAn0XwNEAITepXMHWFtCARr
    wkvOoBs7Yfr7aNDRZGiqjAdwNpxoJsD4AHNE4PJNpS0cYXooZieIbUc1C/0f4VbD
    TE2rNQne5naJ4OnRHBcpYOiZk5DjNL/WoRwjx+YfEz/N/bWT/JinnwsQOi9MQGYo
    rMhJXq7hwS00AyYctKkkvrDQVA2OgtzNCgDEDkm9wes5Dp7lTcX8PzgRnDQPPG7k
    2FZjY+WttmHXbNlkJ6zGCggTxJqZcZmk9UaZ+Ho8LQ6WvpOCBE1nt4foqQGqjjSu
    obnzh2yDVA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mCGBYo+b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q3kGGkbU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mCGBYo+b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q3kGGkbU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE4MBicrFldMgtpQTTkdz0nVonkE5ZZIjZAB0DeCo/UXAp3Vsay4iZxSyKJdmtUKEiw9QobWQ+yxo0cHzOIntk+LQXEeEq1RQsH/jRhCc5Odce2/Ceiv
    Ax9F1Vd1UumpqIqqjfjAjKC2fEX9tn4Iew0MgwsEec2wtIq/EvJjduQkpvKxHuEbJqpnyvDV0J7kiGS3Fu/IdMgaqZsHvUQtjokpcFjM15xNurZUSbYL36w6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=toPVVLyrJj4A:10
    a=v2DPQv5-lfwA:10 a=gEZ-U6LWay6PhFAxq-kA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeC3PTL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 11:19:11 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38138 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbeC3PTJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Mar 2018 11:19:09 -0400
X-Google-Smtp-Source: AIpwx4/ezQ3QPT9MMtc3OnkHBhpebuBOF8Vh1QzTU2M7hs46GVdXc+VQ+Ed/I4k0cXRS7MN79E/fVQ==
Subject: Re: [PATCH 4.9 00/28] 4.9.92-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180329175733.447823703@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a3c6a823-355b-5416-6b3b-f04fb13d3f3c@roeck-us.net>
Date: Fri, 30 Mar 2018 08:19:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/29/2018 11:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.92 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Mar 31 17:57:18 UTC 2018.
> Anything received after that time might be too late.

For v4.9.91-29-gbc89e90:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Guenter
