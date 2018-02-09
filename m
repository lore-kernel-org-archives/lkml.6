Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2177121-1518207547-2-8702588568496248356
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518207547; b=kqj7z7v5AbmMP+ZzOMy3VgUjwAir6Ig5ADCZCbYyCOcXS4H
    NhW9Ux/BA05xKa7FDfNqY0xPN077RQJ56xJF2JcpNXasCX239LCfCAEOEyYvwMdJ
    mLCp6K8xwHeo2adT8r4EIgcwPVxmZDvlMd0OvV//O+UFX6gkmFTEALyqtN7aNdfq
    h1Vkga6SawFtLgFV32it3Sa5gAI+Gb/8kw4tO2ip0mM8AnBokFHqpVEAbKWTUW58
    rQZnKvD5hOxQLnhDpRlbSwTWe8oCrV2bmjFw1J1STTbDxvdAj4Vl52pU15G3xLez
    luDOPSXMUx2EYr132yH9IihkGs1XqqHBtft/PLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518207547; bh=mA5PTDYmq9dHJm7w0MvBf0Iq/HfHZGYkOkojtNxpkOE=; b=Z
    HJJhhvOR8iO/LWsOCQwV/DfCibzADTvplVs4kcVGfSI2yBu8T76TkimJbkLuQ3t5
    AQH4EY+YbhcvX7UH6CAPg0Uxzx5e0AMpqQja6/Z85l/1Mt2k1HbKbO/cu13R2WAV
    0BAOwSeAUO8jUFFXTeaRVSNVotXNhCEnj+I2Ek74Vz+jp2rdS6untmfqBI1LC8vv
    SM1iwX5ownQazLm12DTehZIEZfQ7g+1Fd/+qVqymUv8Qw4yEjF3V75+2MhGy1orh
    ZcCBl+Zqi2G0/1ADhR5HDIHE6tHlM6r7jGBLpZ6W6WCplCKALBzr9irwTmev05BI
    H9atkBDTiuhS8qzmOvqAQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeBIUTD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 15:19:03 -0500
Received: from osg.samsung.com ([64.30.133.232]:34207 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbeBIUTC (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Feb 2018 15:19:02 -0500
Subject: Re: [PATCH 4.9 00/92] 4.9.81-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180209133931.211869118@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <5fecc901-d183-b160-70a9-b1af84361b7c@osg.samsung.com>
Date: Fri, 9 Feb 2018 13:18:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 06:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.81 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 11 13:39:04 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.81-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
