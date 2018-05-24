Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1966932-1527168137-2-15006353714854996850
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
    1527168137; b=TSmuwUFAHi65yoPksPElWJiMbeBrbD8i1t3PCwecQj4wFi1zfr
    RGRDVdCLqOEYlOZRZCet2P6PKcJiJpUATEO7IBLIa1dQGiEAri7zRsvklC/kPt3j
    imzkLJ+i4T1UAMOBesCP8RUiKZsw00RZj0u+wNDVnTN8xTugWtjNe6iy694a3naj
    ve0ShFaoWdmtzKA1G8oXgTaBsGbUVLIk3UPlIGF2/6e9QGjVnDmF6sEQ4NLmmzwB
    /XNwT3PRPNoSgwwFV0vsc3dZcy2HLbcY5K9C5eE/gLpisU0SA+1v0N6QvOXM3iUd
    6h1b4XIWhZ296GcxVn5yxeexp0WIGDuNcAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527168137;
    bh=Joo6kXxc9Lo/aM3nxtL5MneO9ZqBUZ/zMYweeu2GrOk=; b=Xhc/iazp7UMR
    umyaDG6cnmloi3fm2fUcukU1e//78YsbJSIROZTnZfngd3cmgeRo3sr0FAPHUkjw
    zvKBNgpMYNwh5Bgp65Q2NBecFfRlQ5W5Av5fsms8HMYF6RqGsU9qyvTy2o5jbXiR
    LMcH46esGVMh22X8Lifw+ch4NaLhrUMDEbT27WIUGmhFKok5BhQJ9uqPKJnN60St
    Bl0qAPsdodp5i+21qewPTyzxNdtI7yvtewk/ymIZ0TtSBYlMJoxQrCqa1/mXhH55
    NnEpWDW1OJ5/9tu7SRmCY7iV72nAodr7BHQ7bsXDupZK9G3gGXH6E3FYYoqEI0Ya
    fHjd6dVJyA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=gMKUx4cp x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=DMK2mvgb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=gMKUx4cp x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=DMK2mvgb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLeDMEljxLVLLyPFA3di+u9ZHosDSAhhBBuEJH5T/aeynjXwU61BPsciphr0sX1TKk+ReMSKalaygaQnpUmCQ+a7xqnp7B4c0dcaN+sKjlww3r19B1e8
    emn8HNbsEHVguUgP8X1sCoE0Z4BdRhEqbShzZzkXKzo3jWTplyNbimPNp2D7eQcUlPOAFBOoZucB54VJSFx0l/um6USdcnw91e9YiZSljoPJrMmlYEr6gTXN
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=zhKW8NK6TxkA:10
    a=VUJBJC2UJ8kA:10 a=3OPJizyMa2AjPVVRt5kA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965655AbeEXNWO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 09:22:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40727 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965042AbeEXNWN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 09:22:13 -0400
X-Google-Smtp-Source: AB8JxZpMWQzjwJNHLKEwO+KWcFfOyVv2qN/1NCcokK1xxUpGvoVz0oJWcb8HjKHbuDZ85UjQYHFRug==
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180524093159.286472249@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <3114da64-5897-7df7-33fe-c6968cb23fe6@roeck-us.net>
Date: Thu, 24 May 2018 06:22:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/24/2018 02:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.133 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:31:28 UTC 2018.
> Anything received after that time might be too late.
> 

Building s390:allmodconfig ... failed

arch/s390/built-in.o: In function `__s390x_indirect_jump_r1use_r1':
(.text.__s390x_indirect_jump_r1use_r1[__s390x_indirect_jump_r1use_r1]+0x2): undefined reference to `_LC_BR_R1'
make[1]: *** [vmlinux] Error 1
make: *** [sub-make] Error 2

Complete report follows later.

Guenter
