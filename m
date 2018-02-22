Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-294332-1519308700-2-7940878061439938065
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
    t=1519308700; b=isqL+iFV7wEt411itoevm+JAVKsiRkLpSYK75MdQDDuhrbK
    NW0hEfSC3ZyRF9ageZieRs1tF8SqdLLadCjRd6pLDkIjJM7Oeb3tRpOHiqa4n4KC
    VIkUDuWc6AM+JhTf40KEnGqBiLWr2SVMW+M4J2LXQ4LeuAyh4hNv3aQwhQtiWMJV
    bVTwlOwgaFlfmMafp+olJm05pmjVgyY79oxCVFDvf+s8aGiHgdXanvBTOcwkybD7
    9W0O88Az/lc+0lZ7//QAN4eOOWCAqXs2/MVyElowPfqxGacXEaJIKQy9Ih8dW963
    i7utM+4h/b7lDfM96uXnfglyPvyp5hDU8QeTt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519308700; bh=XeAvgmntjL095D8LfVusNqobudpNJjLFZ4S+dR7o6+s=; b=J
    BBL+AEHKQTjrxPqREi2y1mKXb3sgBeFblGLVhdqLmgo1xRx1UHRGUIEpZwRGobuj
    F0ah/AB6RSm3b4O2Y+dC6hoKDawNSde0cUvivFGWuFsEMaI2hUSMiSV8SvJ/auXx
    dep2D1JOxkd+r7/mtdXOxb9NVdMTZANS9s7m3E3hSH8giAFUOetCUCmdl3Xt+3mK
    zKSWUHhF2G/P7WO7sQqlr5yTnD9AW1diTNxmWqo5SUBR/Fyh+oz5ZuPKQ9ZafkVq
    LoSqCgbAEJH+geHAYO3gW+vKX8a9MPqofJZ6QM4ONv+m+tfqzkoxYoI9EwskmRGB
    cNFsRo++FRYokDkIlItIA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZlUBybl7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MsynONS5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZlUBybl7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MsynONS5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932633AbeBVOLh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 09:11:37 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35439 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932616AbeBVOLg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 09:11:36 -0500
X-Google-Smtp-Source: AH8x226sz3hl3CcrR5JB20nAFCco69XF9dr2+YXoRkOOG4fch1lHjKheYhxSI6IRFoSzRheUxN5SGA==
Subject: Re: [PATCH 4.4 00/33] 4.4.117-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180221124409.564661689@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1e5834ab-5dae-8010-ce74-e201814da14b@roeck-us.net>
Date: Thu, 22 Feb 2018 06:11:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 04:44 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.117 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 23 12:43:54 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 145 pass: 145 fail: 0
Qemu test results:
	total: 118 pass: 118 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
