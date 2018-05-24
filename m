Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2424450-1527189800-2-9435448301229769230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527189799; b=gmXP5WFjXF4ujdmI4u7i2Ek82JPq7z8RIeqWP/oMf2PMpAJDFY
    F2L3ij4DqUHMtStGhIK9JyfYdlijaOKKvQakR61QB+bh1PFwBqjxROQCA6wuOvlh
    ETqd3yawupFAMqDAeIj6pfhiCWMpjeuiNtjZANq3NgsF6RjlK7NsBcnrtSnYHcuG
    Wl7BKHt5ZhvGYt+hlstE2c9n9H85xN2sWgpYluX2ofsY2nS2uvY/I/AsJW8tq83Q
    1hAwThHUnm/75XmGpw4y/UvnZYUJf/Mz8zM09gLlPFtaaxu/VNy0TtIfmO9a7YL9
    9xKsqDbvWJTrCQGE9l1yZVG5Syh9scJdGFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527189799;
    bh=iPTLjnbmKmnKONXvdA6AtQvoFqc00Mm6D/YgFS0X+dk=; b=FfYSwS2kZP+N
    h+/ff+r5St/FSdgHxbglyMykJpR/iLGtYnsSF0WQAPjaloE62nYMkqSWMGjPD9bx
    aSJu3JWN6ofN+6+I2/vEaDug1bidiPqUC5kyESBqrZCmJw5wjbn2ImBm2QSD8JCR
    Shfv4BnJlnIK4VWAav/Aew8d3jR2+uBD+GtxCGYn6f/ng8JppXyxugFAYQrBhrJa
    J7je7BcYsBOTd11jhFm+UcE3iPsYUZ7+zJe6RCV0LK82sBXKdiEJOotPKk9+kgmY
    tfycDMg/hGTfbMvSGdLH3m84ly8cMohRQZKK6v3LXn4IjrLD9mIb65BshxqvPE59
    OQKXtgZCMw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFoxqOH7d9huF90KbxOIM0hDDvYVPlAXB2Rk9reaIMIjvGij50q8fBHJd7rCRkKEVBQqXR+mfXCNwKqeb7KPVe2NNMEjU5RpLeSgFY9gW2FomFLE95cy
    jGKRwkY2XtnprYFzmuhRDarXdOs5lpGwB2JYx3Y42uWLdqBzvQ+9ns0JAF2uDpPNRL56e+DEVtvl4pocOl0zEZFD0LMrBhPqQWwdfD5Ds9NKkLfRmYQqP4co
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=6xLPOHPkGDIA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967440AbeEXTXQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 15:23:16 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38229 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967322AbeEXTXQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 15:23:16 -0400
Subject: Re: [PATCH 4.14 000/165] 4.14.44-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180524093621.979359379@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <1799bdc3-2925-2df7-c503-26a1b3c2a138@kernel.org>
Date: Thu, 24 May 2018 13:22:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/24/2018 03:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.44 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:35:46 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.44-rc1.gz
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
