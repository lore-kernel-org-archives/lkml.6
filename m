Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-296820-1518791237-2-16724017444192911858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518791236; b=nhfYgAmXH6kwtqCX7hg0NgfS0FUQQmdAT+iQikcrCgl6Zfm
    akXcKmeMNSPATK+9puIMumOhhLbllw9EOzGSZgItZs3hzCG4YaCltZeieQwBQirs
    Lt72o9K2FiEreWxwusCb2cra0EpKS27JpO+FwKX8DlRbJ/h4IE+HI6leoU2X+LhU
    oOk7CpY+5EFyPY0Hu0tmGaOLTBWEBNbb4wKVy/o2ZfKmcSBhtVutWberhcVlIAHJ
    Lh/uCJ3GtdsJynw0yrssrqvP/8DMOE/KrDyRnhWbF4WL81qjAM0Rs7hcVjyNNyka
    ukjMt04Yg2A+2IS9/OwzxVFGGRxZBsH5GSjSlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518791236; bh=F9uv7Cf1ekEEfAVUnnKQTFQiMwyy+fI3T2915eBG1hA=; b=a
    Z7/UnLCjkPeCD1L68N+vIyG5qXgBIn9iFyqDoYwVDjaBfi9xORi4OTbzKl+3jmqu
    vJoUliXwXbXdyu8qkIfRh+r5UwlZgWO3eMcLhtVlOlHMmF+tQKjbXNTplM0zMK4M
    HqolRZKqgvSGS5HZ+QblPj1id9SviumcGSRirsiiDHP2HKNLP7xXSW7mWAEmOzbq
    28u3+QI27UY8wGmO7wtFrs6WwG32O7UlnXLEvu6Bnz1vUoLqq65EPh0lVyU95ETC
    Sa6ISGifzna7vlqBU5r7I04Fl1J4s4eDmh2mJdPYOyMH1/9gOtD7+oi+fVk2eKG4
    Tks1B07DTTFkFcx+M6r1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KvG4Yiti x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a+aVAlSN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KvG4Yiti x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a+aVAlSN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034331AbeBPO1O (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 09:27:14 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44358 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034273AbeBPO1M (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 09:27:12 -0500
X-Google-Smtp-Source: AH8x227iAht3O5TN2ulAXHFyVo5FE09Mo1BVm4KBpktTOnQPg1lUWLluENhpuKC9I77s1HLV63rP/A==
Subject: Re: [PATCH 4.14 000/195] 4.14.20-stable review
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
References: <20180215151705.738773577@linuxfoundation.org>
 <CA+G9fYtfZB+=wL69ferRmD3oOqqfgvXA8WT9UoihOUafyYdCNA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b16a4cc8-370e-f2b8-79e1-a0c68b7bab38@roeck-us.net>
Date: Fri, 16 Feb 2018 06:27:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYtfZB+=wL69ferRmD3oOqqfgvXA8WT9UoihOUafyYdCNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/15/2018 10:00 PM, Naresh Kamboju wrote:
> On 15 February 2018 at 20:44, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> This is the start of the stable review cycle for the 4.14.20 release.
>> There are 195 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat Feb 17 15:16:22 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>          kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.20-rc1.gz
>> or in the git tree and branch at:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 

I somehow lost the original mail, so I am replying to this one - sorry.

Build results:
	total: 145 pass: 143 fail: 2
Failed builds:
	powerpc:ppc6xx_defconfig
	powerpc:mpc83xx_defconfig
Qemu test results:
	total: 126 pass: 124 fail: 2
Failed tests:
	powerpc:mpc8544ds:mpc85xx_defconfig
	powerpc:mpc8544ds:mpc85xx_smp_defconfig

Build failures:

Building powerpc:ppc6xx_defconfig ... failed
Building powerpc:mpc83xx_defconfig ... failed
Building powerpc:mpc8544ds:mpc85xx_defconfig ... failed
Building powerpc:mpc8544ds:mpc85xx_smp_defconfig ... failed
--------------
Error log:
drivers/crypto/talitos.c: In function 'talitos_sg_map':
drivers/crypto/talitos.c:1131:3: error: too many arguments to function 'to_talitos_ptr'

Details are available at http://kerneltests.org/builders.

Guenter
