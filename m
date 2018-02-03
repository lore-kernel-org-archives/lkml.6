Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1170116-1517672062-2-6275744877292642525
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
    t=1517672062; b=adsA4+v0KVYQ0/J4pW4SUxo5G01S8BmLxR8Rest0FhGY00b
    btZi2fsAc8rmFZz7e9wN/inTZFoDkIlStrNMTCs5EdidlJ6KtpPDv5KeLw2364p/
    o1gaeTzC97h9IMR/1P1/cMAkjVqtosoOfSMZSwpKO8+yR4agK90DlGVDifCu2McJ
    KDvKSprqOv1RCw/udtTgVlcKCWRIX+8Q/G+kT2lgFLpC8HQLcjnnasS6QH1SoxRT
    YMbt7vCK11JTvKbrY7xR1ZP+GKT9+hthK0LSVzHgONToOOpIxewxeKiEmhgTfHhm
    4mlrG7pDgFCkwiux787RhVBMBE0NLOgcJ5uCMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517672062; bh=6vxds3r99LetKveYT74CMvbG3jvG41dp234iJbnzv2Y=; b=q
    59fJh4qk3uiBJI3VR8RmWeKTVehXpMpADw6InPthDpreogrMi8xcE8Np7u+9jDmH
    iVBbEUlIMbmGUJOzITnHO6ASJWCdxLUYRv2Y0kKSQ/OLnJ7VbEc1RvQCNJyp5wJG
    B6N4g5/ML1PX1AT1p6UMFfmrlTDDWHWPcXdAwT3vKEd9axlEqUwcdpkGlSe3oSRg
    aHhwuieGo4M1hx3dOo2WkNN6GyW5KGC+qzYnEFYR9p3mB8f3KLfC9I3mdMRyEZgc
    dAkoSkDZGPnQQ3+r6zYhy/UwO5tww0K3vrNolR2nv6VaYE+SaKcAUwFO2QUb3OZ4
    d89ZpcZQPAAkZ42/muZIQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rzxYisxv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iVmwW+lj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rzxYisxv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iVmwW+lj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeBCPeU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 10:34:20 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38794 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeBCPeT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 10:34:19 -0500
X-Google-Smtp-Source: AH8x225pRHkdS1KhnQ3Inp9TPp0MZQPJq+1rYa2aVJnXGMK5237iGfEGZ17Cmc8vH1DgH1ieTTRKTQ==
Subject: Re: [PATCH 4.15 00/55] 4.15.1-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180202140826.117602411@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c6ea53fb-ad96-dc63-4113-9bb1d2314334@roeck-us.net>
Date: Sat, 3 Feb 2018 07:34:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/2018 08:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.1 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb  4 14:07:50 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 147 pass: 146 fail: 1
Failed builds:
	mips:allmodconfig
Qemu test results:
	total: 126 pass: 126 fail: 0

The build failure is

ERROR: "sgimc" [drivers/watchdog/indydog.ko] undefined!

The problem is inherited from mainline. The fix should (hopefully) make it
into mainline in this commit window.

Guenter
