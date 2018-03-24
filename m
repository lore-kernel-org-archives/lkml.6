Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2522873-1521850149-2-5494535260303012255
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
    t=1521850148; b=D0BLF0rClmgs7oqUsFprxfGMLptK7np5w528KLM1e33rEhV
    gk55hjtjJibYeLSct8XIhi4Mlq1HSGrk0psjzXBT7sOp2X5WbgvUOS0ZCwA73arr
    iqZ572xL4dAbMmD5ipvcPoJ7PYM8H6i7dwlmOyEewz2OhBYa2I7EIZAXrWxFQmBb
    Ig5C3qUX91cIw0QIkekcTtEpFFtsKImX7whiwAheGV8cvpM+uCKrB6vQ91/JO4kL
    AS4vCOEPFn9bOqBfA3H2I1y2vtByr50YKKCO7Ml0d3kNRojov2grZYoq1Ft7gBwu
    m+VRybyEKyfbFsOWD+8ePhC77G5Za0+jw3VufiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521850148; bh=UQ6UjaZky/vFo3HvUa/6zOab5Y0cG/w2c0m9vzbMGWU=; b=A
    oq4FYMZYDsBnEf8jUDauXs3YYscKsSoV3BenbYya/K92GYP4FLcGZvcJn3JY+Zb0
    I28F+b1B6gcj7hSk242cZPkLbbVVyL68oYEt2taHWEFhQiRtqOF2qG8gmk7rF1/F
    xDwNkp2rVQ9p+CYrXfD5cqmo+cXLCaIY95ifjljZDPEDW7/dCN2IkCJfBqIvI11Z
    3VsbeuMPUPC5OXVKqSwVrvVrwweeK+OAnk8AY1eBKZ7cTo4C72axBMdoC8iWH6rX
    R4Nek/Na5QAJ9n/qUQdp9qFuCp8kHWwHNrrEFCuANIJzNFB7OPl/HQvcDO3IWJh0
    lyTMDWwYCLZW2LEET7rQg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ku/yC7gf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dQo+vyOR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ku/yC7gf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dQo+vyOR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeCXAJH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 20:09:07 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45496 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeCXAJG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 20:09:06 -0400
X-Google-Smtp-Source: AG47ELs0+K6W0vzpZZAYIVqMoSrK1TF/hZ5Vy66Jpn+vGj3mATtN+Nil8ObAbatxq1YlZsrJ0HJOrA==
Subject: Re: [PATCH 4.4 00/97] 4.4.124-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180323094157.535925724@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f0610c7a-2ff7-5058-f6a3-3d3aca85a357@roeck-us.net>
Date: Fri, 23 Mar 2018 17:09:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 02:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.124 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 25 09:41:34 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 127 pass: 127 fail: 0

Guenter
