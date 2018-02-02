Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3551165-1517609988-2-14139147407119034651
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
    t=1517609988; b=P/sdgmjJfTQNxHlZu+nHmdB+oR25aRvYImhKKe+ZSqlsVap
    6EzKyJ6uaFQOi52DNnSNxPwX/K1+ecQl3lW/bApOWqgvHfIS2IcShVxZvJqCAT5C
    cm9z/yju3FGWnWILrhGA5/UUOCabPvqqdjVzDDp/z/ze8P3AhzMvxpnFXb6pdjfi
    uRQCPk+ucwz+fv+5krWStXkkqbRMAv+uX1+KC8CAoKSJ84x7DKxf4gLz6EDvNv9d
    nUnJvo0f0+sXsHo+vrhMMj0/6g6NFLQ+VKRI/Flb2GqFNVW2qso6bqutDb0S5QGj
    LTnU/vNeT6xSMBSoki/aD1hddKt0hs37NbPOCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517609988; bh=OtkrgeDIA9W+8CMATFL0pZdgqI5mENsiw7cTN83wXik=; b=j
    KQbbABvyIJy4Sq2PoyPyIuJ5fmbbGum1a6zZWotDV3HXCHnYrse7vv8/0E2gtmkg
    xr5V5EiCZSVRUHMMqKhyZEMxEyg+ih8M1NjJLsZAs2YqEIhRxAKKwGJG+y744jo1
    sH7hYeiFufrL3qwlN/Fo1+ynKLs9qKSPmkLQpQ2R22zcLIxoGW1ZTV3rHMg/L0K0
    Xe32tNltNvfUEbaBNne5MwvgDIef/Uh0RExeB3yIWtZHw8tTA0uhOV6O0nIHG7K7
    sfyRWdJ0HakO6I7TzAh7dj0EuRuYA8L/vDM3fJWLFEr5KmJMQ9PkyGL55dMV1s4N
    DerTJ6d3HCewVzoz1e+RA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeBBWTo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 17:19:44 -0500
Received: from osg.samsung.com ([64.30.133.232]:33522 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752909AbeBBWTj (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Feb 2018 17:19:39 -0500
Subject: Re: [PATCH 4.9 00/86] 4.9.80-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180202140822.679101338@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <027ae1a9-b6e4-6217-ff29-33d0e217e136@osg.samsung.com>
Date: Fri, 2 Feb 2018 15:19:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/2018 09:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.80 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb  4 14:07:37 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.80-rc1.gz
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
