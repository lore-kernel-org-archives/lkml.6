Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3418695-1520696774-2-13501103649279886768
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
    t=1520696774; b=EiC0BVHEuslSjEACEDvzxgYfjFeKBj88MCp0u0yq2oOXIqf
    ggHHGEBGxaZb9behXgzT5D0ejcoatgP9gRxEusYE7K0kMIQOKCV60B0UVjddycpE
    xuVkRtGPCqsbolo7u3h89BvnP/i9jpEWael454+gVVgqwQIkVuoUO/QF2c76Nsxy
    Nk/8GQRLQKjxGy50SaLArUDtWPFn1HDbAXLilhJQlQI2cU77IqbJnjtMNScpg8Nj
    TJw2ixtCl5UQCV8LkGJHV7D286hDZ7DD2zWEAiRjFWIF2roY/oUDkTFVUqPu8rEV
    nTHemxgB655xAwt35QHuYoAdazsfUAy6/RHQYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520696774; bh=c+tUV3+6+NH8WY1igbE65i7GgZbCyN9XQ5c+IjRlkF0=; b=P
    Wo5iAwQUOC/u9oDlAYIjVdIRM1LySHR/ZbDo7A4mzqAkMDMBOdbINg4zkXIEjww/
    OUdRTfQZe7VbdUgiv/CqtLN5RWEgWoSXVBoL+uLRjz23rMVnjcs/s1ieaknrNfpS
    rSaHZdRyyva9Sn29P3OVzLE+uili8yBm+Ctu41ezYe+VxbdqfMtwUcxsaBM3ByYo
    TA+2gQQpX7q2SZk2JiUcS4y6FkLTP8MTDPbw4zSfh11Gee3X0nyaCsxiHm/3cSjr
    2VxNZWgrDmUWhVhvBe3j/P6FBE9Rr5PEdPmJOBd6zvqZvcyA+tqMjZFLLRpMzhnB
    frhFKMlzd39pqi6DoYPMQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SzI3TQYW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dsnyXOBq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SzI3TQYW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dsnyXOBq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeCJPqB (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 10:46:01 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46892 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeCJPp7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Mar 2018 10:45:59 -0500
X-Google-Smtp-Source: AG47ELv+VPefqqx6NrHH1lvKu1TbIYu0H996Pphsok+lwi6LiRwXoXAWOy/3VOSRsF3hkiyAbV/b5w==
Subject: Re: [PATCH 4.15 00/11] 4.15.9-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180310001834.560857664@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e993513b-4972-5d0f-ebef-5d6d01d47eb4@roeck-us.net>
Date: Sat, 10 Mar 2018 07:45:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001834.560857664@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/09/2018 04:19 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.9 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar 12 00:18:21 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
