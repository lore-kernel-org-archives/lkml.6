Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3587241-1517868866-2-10401284791579845150
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
    t=1517868866; b=OXLuaXW9TnWyBy8HgjNC9bcEg052iB+R3zvz8uM9MWwAzp6
    RFaeKixyn136TllZgpFKym+DOeVboInUyT/mNrdNu19WkbHGkbIvEZpACOE3qptQ
    LkXC2P48GFW5xQq9xHx81V4+f9U3tgsBLY4HmcTr44kaECkfHid9ot+/L8liG+vo
    jiUdKL+IMozFhemfqYJOfhPc/GPx0RutraFaocWByIF8DSTCYkYmr7lNw5GK7aJx
    Ey629T7o6QfK4mADfrIq1M5iStN6hYXDuy8JLh2fhz55Mpua0waOyh5yZ/UafHQi
    FWPCihS82cMsKWlcXvYA5vBICGNXQ7kKhXXwMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517868866; bh=jfaV17uTQkddCimo5zy7+7BlTBagBtdqYrmTwPAjmUk=; b=n
    2yUaJq7uMGHZwUXa89UGe4XLBMnFt6OIZduQOx0isw81miCi/d17CwB5Lt5J+714
    Mj/UUUK3hmK30cm99rd3ye0nsx+AnkWMaC8I9pVFHZaGuiBJJDThsMHk7piORi09
    Ud19GToLI4uf/PbtIhC9FRBf5fomWcOmWg7rwurOzXVZ6v2T++u42NZhVTBAa0IT
    bfGDOFex8VIIt6uUbPonaPckBV7Yw3hh6+hEnr2rkuDhZ898M/fWP996Fo5Stbhy
    N9lXJWsND2mYD5tgUqtACIJXA87hJfBbr4scShXpyRTtozjMTDpEjQ1rYIGIlQTr
    NTWRp3qrH9dsGrOqzdJ1w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeBEWOZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 17:14:25 -0500
Received: from osg.samsung.com ([64.30.133.232]:48922 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751801AbeBEWOY (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Feb 2018 17:14:24 -0500
Subject: Re: [PATCH 4.15 00/60] 4.15.2-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180205182213.902626065@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <79440d42-68e4-142b-80e0-4019cf9d0e92@osg.samsung.com>
Date: Mon, 5 Feb 2018 15:14:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/05/2018 11:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.2 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  7 18:21:57 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.2-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
