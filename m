Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2522873-1521850290-2-15349030035721204991
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
    t=1521850290; b=Rv4WOuBj+M7+ClcE0t1SOs+k/J/C3RSWW6csZghRriLiYN4
    iDFrFJd0uOqqJYwa2O3UkirrkaXHA4/FtTX9Sjeim5edLMAnLtIWIYtbAx+e0v0O
    q1edl0zEm8hvaMGgYFw0RpFIriFR0JmvH/cKzHrkiC81R0Z9DvOOI5wbFYEmiQ5s
    19wpGuwAFoOTyH77g+TlTxOqzMblyNT1ejKTrbuMTJYmTh+jwQKGI2yj1J+0tlzO
    cQCVAVN2vtivRVCJcp9QvQgKQf9L7XGHBqoaREz014lvMO6mBvxB0cujSIrYxLmx
    9Ye5JD4p2NOlWr2OLNGWxavSus5P89U5IH4pYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521850290; bh=HZxS/JoVjIuWRq00oIy8McoIgRO2Gv6FLVUmhfkMhf4=; b=S
    otCqm3VnTLymjyCdfaUmPLihlz1i2uX+H25UKPAW/IwL+CJMUkmOjLxd6/Iv88u0
    skLFTfOQHgiqkDTJ06SLDijufzgc9Gd4/mGd3t4Am5yHDwlnFCulwGQGV+vzscp4
    ywWvKClACpZpWXVWH/86uGSCaV4gzROtNs4Ug7O+kz8K6sslbOBjX1dZAxmhIukd
    qVE6r2sTmUswrDG4hT1jg6Gz73JMrDZCaq8Vg2tPIgLLxtr1cjWNTFU84jQF//CO
    akOLs4HdqiKY3N5z4IRGxRDyjSHkurvOYA3NFVuohdGIOQqKcgxnyazH2/PWK4PY
    08ea+xIDPKnoiO7pAEbkw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=taZbyqOc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=P0esFBQw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=taZbyqOc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=P0esFBQw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeCXAL3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 20:11:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45005 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeCXAL2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 20:11:28 -0400
X-Google-Smtp-Source: AG47ELur2TG0Toxvy1/bbBqhIOEDBW+kCsgOqxqAWuqzOm2pAWvL6ifEybaXCJxNsZyHrczmPlqWRg==
Subject: Re: [PATCH 4.14 00/77] 4.14.30-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180323094142.260022880@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <eafd7c54-2d18-5a5e-fbfa-74005c4ae6b6@roeck-us.net>
Date: Fri, 23 Mar 2018 17:11:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 02:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.30 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 25 09:41:18 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.29-77-g8a1e5a4:

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Guenter
