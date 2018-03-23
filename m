Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2138683-1521837849-2-4438969736330580667
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521837849; b=wvFzyM6GIsvHlB/b/vxTVuYWlYo4Xkjxls/im4/groGa1kM
    dff9/Hiru49NdZVIw8Jq2qkGxNikNXHsPhkMOnPu0xEgUIOOHXYGcGvbmSYIXeo6
    q741j2ZehzL3eVgdwzmfzIRJh2nROgA221cpQGuUaPFZN7ijKG3cTU3Uli+4jLxJ
    AggEu2gy0dXN5mohfsDBLNyQak6lDmXCKHAheH10MdjYCDdWOnM188OHzy5ElJ5q
    8PDGkXdBQTPqxwd/QC4RtfNbs1JqXJGbF6LFPVU9N21d0R76aJdDTUAX0alBxd8p
    hhVsvB44MbIwHJB1y3pSLePnForf2c/eLxebfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521837849; bh=pUuPvEcc8yPkHwxXeCeK2qeJFqFAy7/86+iMKQ3/n8U=; b=Y
    T30888LV/mNavEcMU3XyC4KlcZROpc9WEoLnGhO31ocMtX1Z4b2GD58TResuP3u6
    xVLGjArjG6Cm1G879rGwH2qEV2RUiUk1crmuZVWHo/MfjYyahH/tKEkjIrJCmjL6
    Xw8YGwOW+Dof2KHeadboYdBFE8C1Y/PCsdI+wixf65zBrkCSZpebG6poh59LxQ3A
    JS5N1UyeyssXIoH66opfQDDHpr42AcIPYfKG90LSNdTDdoHDqt4XpfYMCyK9X5Mk
    G+f5zBgBBGqu3KInar06rxuIQ3tH4uL14kjqryOh8tumJ4KbK+UG2vHBohDnLXR4
    9h6QrK6jCuvYh//1B2zPw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeCWUoF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 16:44:05 -0400
Received: from osg.samsung.com ([64.30.133.232]:55911 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbeCWUoF (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Mar 2018 16:44:05 -0400
Subject: Re: [PATCH 3.18 00/47] 3.18.102-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180323094248.117679641@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <7ab0b0c8-8943-8db2-8de9-fe2a77e820c2@osg.samsung.com>
Date: Fri, 23 Mar 2018 14:43:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 03:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.102 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 25 09:42:36 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.102-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
