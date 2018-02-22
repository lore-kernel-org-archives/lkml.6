Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-293599-1519308837-2-17682724636481275912
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
    t=1519308837; b=ZbOqbaIgngLTResxO+ImeoibZo1QRwi35tsHVy4E4Fpagpu
    PxBtjfnOjVs2EUfv0K+Xfl0cqZiq5H1JLl1up6osFEl2yi8Buw7qdJtoHla4N4RL
    UECejbXZRPy57QBsh8TCNFamTM/v04iX0pCwMgzz80at+UvqCikYuJ5aQXau7/GW
    MsfO8Fwb8NwXKhD6E41L7HGeKAv+iHw8xWVpffOpn2kQDT2I9/OKAuXw5qiGHcQ7
    JcycUnbB1a75yNu0KSuv1jO7DLGVy9t3v6iWqSSxFLBDxciVIw1ae2D/95eEVdFT
    h3DmUbvP8o5vzRWRC9K75z5OChx+Z0jE3Kuzr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519308837; bh=JYKMnGPD+NREsMOLVXDhVfmURgdnsHpk/HAI9wBGdO4=; b=c
    xJsmw0mLlYPydIkP//k+HQxef/jFhaxdgF1stKFHHvPx50sNoHeWURcmVbJXiHdB
    CON8Jt9gLEgVD3mdZuHjdjUUWlbBMWLIw8EzfUzTctzXSjkJnXk/45aqfxm0+9si
    KWgrVR60iHglWiVDv1+tPQnhD70HWxg1hiqHuAMbD7I3mNV+9taEIDfAajc8n5A2
    ZzUSszoEJ5BTgAUjQEZuVLR+i9tcBmptRjFvjzNNxm/iX8FNXiu05X3wyEDM9e6D
    U+gGNMcMYibbFWExc57fbXPrgt3yTbu6Yaz5HrYBjxboVRn3KDR3jiapxyNbp4BZ
    1NPQFRF3/3hmnsGvrRmrA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Lj0HxmCk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qzPZYx78;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Lj0HxmCk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qzPZYx78;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932810AbeBVONg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 09:13:36 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38635 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932604AbeBVONf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 09:13:35 -0500
X-Google-Smtp-Source: AH8x2254c+pOYuQty0dgrFoI43AMfrOp86xSfCa79+5+h4yRD5EftQAGNFWvjaXQ3OOaqtxne8OXww==
Subject: Re: [PATCH 4.14 000/167] 4.14.21-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180221124524.639039577@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d936f278-1763-9597-ac58-13329cea5445@roeck-us.net>
Date: Thu, 22 Feb 2018 06:13:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 04:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.21 release.
> There are 167 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 23 12:44:42 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 126 pass: 126 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
