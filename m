Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2002674-1524925599-2-13002509579041123051
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
    1524925598; b=iwdhRKEhl8ZP0L5+l7OB1i/iurgvqgEetnKGT8TXQvoybfCl2e
    rGxRF+nKJQ9LLQnFiU/3soibdm2Bf2fapa3HELu9mrk7lW+Tiha8+wmVzAK9JyjT
    UqD3IaAa2zxnkZcEBoLAgM1TmIdN35JuQi6Gsbm5/c0zq7ggYRIwfX+gvA/PJ+E/
    DSp5VVMxmvBuBKT2r/JUg0moyriAGQkHurdY6MRae0LeDiv7tAYqGXo8gyKFVRla
    QeMe42TcwETqJ33NMhSlUJ7rxFvwrgl4V+BUDZQ3BuDZey2+5gn3vZgGJ5eIgC0c
    0LDoEecp0wf9Se0ArxXH4m4pcaC7RaBjWLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524925598;
    bh=eec3AY5EMNSHDCDpVlILeZ/PmaNRbOlGNAAca8eACzc=; b=dBS/l72tVflf
    AiN/WDVFwPMRrowJ8x49n/ecn4A8bvo4JNDpGoIADaDGMpSZV4ccnJoZhUuy22OX
    w0xt0Ap9aw/D3+5PNEyDf6SZbF43Xts7Gr9DPPfsPBSo9F2LPtajDxGzXhBOSasN
    oSNyYb2vX+wq0bUqId2t6SveIu9HzKZc/9D3ob+SV8BgSAb6v0Q2aJ4jrQugA305
    Sla3gV7DgzB8L+ADxO1plql932wHixkJZgFfZ6AvK4kRV3v6PEMtlz2zMZQmp49U
    3FaZGfCDOaoCHr16QN7A4PMEfetrgzEecLwur9bKYIH2JkklUpJMeh43hVpuqbJL
    Z1g3w2PqzQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=A/0RB6Qa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Tolm6STV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=A/0RB6Qa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Tolm6STV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI7T7qEArPcofTj0PD6uK4PgYuzmA4DmDkdQBZQQ0BSEkEpLiORb8Xr09ThRGQR0RvZ3tKL5eK81vmhmzMzvahzVYlZXp8L0wkSsp8yr0zfzpeyoxKHZ
    HXoB+O3MyBuYzcMi4yrfyAsNtTqWJU8Ub++BAjUrtZXKa/xL2iek0EY7emiDLGtObNAsEhq4fsknnwzZE63j5obJC9MHfU1nZFnGbcVtBJV3liVkYCK/iw7f
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=cfKjV0Cyj4QA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=HoCkWmlCV56ydFt2py0A:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbeD1O0h (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 10:26:37 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33477 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeD1O0g (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Apr 2018 10:26:36 -0400
X-Google-Smtp-Source: AB8JxZpd3OPtKOln/N/4EK/4urONlSdMAQVRuI/J/P6gVF0Kq4qLq2TRl4KgJRAeJSj5Oqwpf/ARRg==
Subject: Re: [PATCH 4.9 00/74] 4.9.97-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180427135709.899303463@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f40ed34b-b163-4e45-bff0-e54a5da1af30@roeck-us.net>
Date: Sat, 28 Apr 2018 07:26:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 06:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.97 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:56:52 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
