Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2540971-1526995796-2-3930206856330354319
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526995796; b=MeHcF0jsFF9pouQPCR1cRpiYDZl3QvpBLdiDuR/hmYFarXhBJp
    yE9kPyOpesfJPktw0nFeXzFyRC4gsTGV+EJDcFMY2pm7M2pRG0ldZexGgJGtuQ/9
    Y0QY5hZrE+HRMayAN+AmR9nkQzbWtTceZLCi9u2XekE0ZD8yxAUHVsgHPjBefsM/
    +vUvU+6uiOs6iY7apYnacq+ZNsgEmz8e6/Xa1QnbfNrcKtNHtf9UPYmaxGKo53j+
    tysnrCdqcNPy2pgHbWvJ7XXi5g/M+HrFdQsMZsO7JCDDO+aWRoyyKEek+vXSqQVV
    SyE14KBb4U5HJWu4XSYZGq53/oVfkXR3I99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526995796;
    bh=ewpN26SxOYBH9l5JudDDZ+UmzWf0ls29I+peI63Efrc=; b=cE5mRUARvZ0m
    AfaxHdC7Z7JOAkLr+wn/EbGzVW58sKUlPHb5SPVNWZKefXQZ+/wnm0sbGTjcVRZS
    8bP6AaIsMyly5JON0Q3lCBVxQnmCx5ZqOy58bHiJIU4I9GgtdTGEsgjemSJZ1UVJ
    Zs90FFkY+pkRsJGBAXZDVJt6rNwO1+Ek8tAhOvIYT3xHxbgUi1kTeX7492lCK8uy
    JFUlRtYkSwrVOm0bpG+AACPpu+zu+cRVk3CSB5jyFFVH++vQ9ClzA7AFp4tdw+3P
    MyqF6nj6Ej1TfNA/rECx4QYI7q/Mtlp116mqx+Zq9DT3vI/FGbPxa5kjWL0X4gzH
    +xZkCu6XWw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=RI66+oIe x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=kVqNK+4E;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=RI66+oIe x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=kVqNK+4E;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCqwsE2Y0fhLH8A2iDRqAzFn+SlFov9Jw0hvE0qXoRLDzX+tscwKT1nk5+uhVBJWXhPq7jhAcd9SA8/fRn6u1UdM5PIdaC5yfoszDxlU4l1b4ML98HKk
    vlHEEz6Z0Fm1AY5HvGwtzV7yk7UjjELzPuqLgASsWAYn0qlp6VG9Qp1XUf+NTM9q5Lyiohaopgt01O9xPy1xcxTLi5kPXG3rp1A2aJ3dlllfDpB7/ipmDogC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=GkQz-2DCOnYA:10
    a=VUJBJC2UJ8kA:10 a=YWtRXzOXAAAA:8 a=HoCkWmlCV56ydFt2py0A:9 a=QEXdDO2ut3YA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeEVN3w (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 09:29:52 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35151 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeEVN3u (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 09:29:50 -0400
X-Google-Smtp-Source: AB8JxZp+NF9+xl/0uZUfw4v8GhwMxDLffP4gFVQXxfi0rSK+oooJSMs2zu//MXDaw5NhZvZr6LeJ8Q==
Subject: Re: [PATCH 4.14 00/95] 4.14.43-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180521210447.219380974@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b9177f4b-2687-28e4-c5cd-f550ba92b3ed@roeck-us.net>
Date: Tue, 22 May 2018 06:29:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/21/2018 02:10 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.43 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue May 22 21:04:09 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
