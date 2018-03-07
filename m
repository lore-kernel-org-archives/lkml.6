Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-306372-1520467052-2-7111581990133095144
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
    t=1520467051; b=KT7LcrAuI5PfFtAjPc3OFhK2W1UcKvJd7jH1/ytKcbkXUz8
    JEFdEuDLUTP89/HAQI2z7bjlEK6jQDv2/N7nMrS1hK2+qMg5kBM1GYa/Axtlw9Pk
    4H24sgTiIDLcSzrMrRrsGiYFfyzJGIbHv+3Ru7+slvlwcfsPA48D5pGO8/qA+pm4
    ppGKdaH0CsQr/DKHfGQbFAama20ImvE1Kwu3qLwzB3KhpAr1ClKmxjdr0XqgdEoz
    mcZUFn77i5geevW7W1VHYsqFEC63GRAQcJiOLvtE/Wg3o1ORfCdiipOhFU+gGrpJ
    D18TQHpQywwCeRqFq+2dzI6QNX6Qlsbzmp6F7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520467051; bh=3ZPXlLuFfC5X76zjgOXuutwjkhJt8bVGlAh6oUM9RNU=; b=o
    dYtlZ5YWrVIC+X6wk+RZB5O+iNkfLyN2BNqKUM+jnMW+lLP5d5ty0/UhQWcDOXZG
    jPcZgc7N4yGFa8b1bsRYK/4du0xTUGtHUkK1aM80ZZG103YOLwiRvJrAmMCE/bBD
    DZGOkdad0tjmbBzfhUTW5glSbUDhcEKZrbns41+YbqHXTJIG3X8Y0N+WGWG7Zr6v
    dpdphnFkSxUc7L2mrpxXIKR8Ld0VojR8Muclbd1UsQlX0s/wcaNv4gt35rj1O2ID
    l59/A5nDmxFOnKOPS4qRugLPN8C2A8ohBiwctn748yZAZGav0y62q7ceEcaeS14o
    yg3eMXnlt7/D1RawSljFw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755065AbeCGX5a (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 18:57:30 -0500
Received: from osg.samsung.com ([64.30.133.232]:39385 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755058AbeCGX5a (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 18:57:30 -0500
Subject: Re: [PATCH 4.14 000/110] 4.14.25-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180307191039.748351103@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <5cdc4d45-cf16-fe85-5ba0-cf983c65935c@osg.samsung.com>
Date: Wed, 7 Mar 2018 16:57:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/2018 12:37 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.25 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar  9 19:10:03 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.25-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
