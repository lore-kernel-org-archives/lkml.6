Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-294332-1519308863-5-12604394961253957964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519308863; b=vWA8yD8nVF1QoZU9Y/Rfs4BO0oOyR691naGl2VRk3OVMaPT
    GnRuPg23thvtB/B6AjgBEojX85zCEUZULR6XjUyKHKS29K5e+pId+pJHlh0EfoFJ
    vfJimscfpG9VTgKk4lBniivY+6ItxIPUA0lMKnNGrufg957oUw0i1Q0XChWf7mbH
    P5o//CI2Hw8v7k6o2CXzhOhctD/4qFLrpKiT2QxYL6JlCkrP/etlutJ4bpe1O3Gw
    jG9lhYHCmRSuXAb88ME3q4zX4y5peMRGCAxe16jqZJEvQJPQ0Vy+LbxoTEfjSeip
    CCUA0CSAvq+fSDONzdWG1w+hS/JdG3NycAjg9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519308863; bh=YQQ/na1LLXzqnsb2/NhrjzOl2vKFgRqSLustwOVwefU=; b=H
    sArhNQM6LSch5lGBxyeeqZ2OoUqBJCQraWK7tLy8nkHugeWq+E/s5LdLxoAPMbcj
    ZnxLTRVne1rSX0jSx6e+r9aVafLB32w0EkKnrT0vM2UV4HaOA2DsWDjYAFMZXgOq
    j4EcQKvAGAq5UbDJ9ZPFq2QG1R00WmA0fzEeWarm6qEGvRN8xnofokkoZnfdVgWR
    G4bFdSxRVnQ0Nx/0mL3ZibIKz+wvhO0gssDgXiljKrJ4PCpt6oN+f9EK25ayVJsM
    4gIODwaNwHPQRQDDVFBz1BntIQi3mU6EdAcQ4e60bYsEwiNQwBfPru5q8hpCy9pX
    foa+zIkdmZskviOIm6BfA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GfsAToCr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UwLORXns;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GfsAToCr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UwLORXns;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932717AbeBVOOS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 09:14:18 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38725 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932604AbeBVOOP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 09:14:15 -0500
X-Google-Smtp-Source: AH8x2262L2JZjzlBx7u+qVcn1eWKE1PAzlKn56DJxdunufMobqv5Mi9Spq+H4xVS0UG5dEqu4URY2g==
Subject: Re: [PATCH 4.15 000/163] 4.15.5-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180221124529.931834518@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1fede8ac-6adb-ab72-e620-31f726d738a3@roeck-us.net>
Date: Thu, 22 Feb 2018 06:14:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 04:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.5 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 23 12:44:46 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
