Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2157884-1520520546-2-18193548290008091688
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
    t=1520520545; b=Y7lkUH41b+LxhUlFWbqCle7LdykU8tcg5+2YRLAZjm1T4Rv
    0QUAnRMc9N5mBNR8ezZR7Z7mTGGo6KNKP5725y9ypOX09Ocw7S8W074ZT7RkK2u5
    zTQamkiKAv1rqKSkpvKaVWtkZE22mwpgBFVQxh8w878Hwc96gfQePlwVMWJIekI/
    ej3GcblS5Hl7EPrOqZ0rZ2/hfORWwOF1++llTjEI7RMWbVEOsWPdSZAc/ugfhthk
    g6dCMtFILCpc5bN5paH8+/395jls4yEyRdy0wMdKkbKzXvMVcJWO2ikR2gNqlOmg
    bc6DydFv5FSQpnr4VQUMtqrAkjjjK2aJEZIAIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520520545; bh=TEIr23oKiLEVZkE1pfgTNRVLYZHAWqmCu+77JB39vPg=; b=i
    72zKvGo1XU7YyVVKw4Aj9l/6dGg3Eu4630bqV1VCLQlqGUv/VpmZXd8JFCctsB15
    bO/fqc++CC9R1RnJnS/tKfxBJ6p/vrhByUUTsP6OPA+4VyB8A8KtZmZPmzBH9xy8
    ZE2UciaUKbE46p7S9U3/u8xO1C70zf9cYx+aFLSIm2Gjg9hTaIapgV+Bir16Kfk8
    DZrfOmqLRrhIniQG3yWedGe+K0BwxzO0QbkQnZKkmfbdc+zsucXNvbz8c+X+SQXK
    aGk8A6ZlA+R1VSkPYjYVOfTzc9i+tQR0cRed92/DjDiyhs/cQwdKlq6hUvBUhDTY
    XTAgotlOw/lAEVi0JbZbA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eRcbwZdn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qxPtrEJR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eRcbwZdn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qxPtrEJR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeCHOtC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 09:49:02 -0500
Received: from mail-pl0-f45.google.com ([209.85.160.45]:44346 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754762AbeCHOtB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 09:49:01 -0500
X-Google-Smtp-Source: AG47ELtYH1cgrP/+U2jrAk30ZGf5MbF9VT+7E/OpobkVbgLLP2w/KkNiL+29skm8iKFUUNquyhiDiw==
Subject: Re: [PATCH 4.15 000/122] 4.15.8-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180307191729.190879024@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <ac613883-0310-9af9-0025-d105511d6d05@roeck-us.net>
Date: Thu, 8 Mar 2018 06:48:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/2018 11:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.8 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar  9 19:16:43 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
