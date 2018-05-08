Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3628101-1525823711-3-10349785306207242776
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
    1525823711; b=QqMCAKDy7wb5I90ok/9S+LOwJw8dPktXh8O3kaGiFlVJNO9a+f
    rV5NBio98J/zzDpTNcxUCbAIMehqpW5c3J6d1GLsSwnm8Uni4ki8kr5ZscluEC5N
    zJ4hY2nThRZ+as0YuJ1MksIdtwSVAUNeq06lOqU4BSQLtxW0qT26dDFTG3WH0Os4
    bpRg0/+/I/m1oExvnuxnuXrJwbucrfafTcH3dUoPs9WHcSlNsWR1kAxO5pnUGcqb
    Y4DHXQ2sS8K0wQhfOfTQt6oRARtQTHy08vEYVtrgXA9/4wJUT9Zli/yHOwmQxMqG
    g6MpWGtkCP8Va74utzOTWWb0RmwE7mPk2+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525823711;
    bh=b74Goa7ClbwbnwWJHct23tR8PguNznaO9XWIp90f5yI=; b=bPq5hLgKhdtY
    Wq047hlsq0/vrnLetgGJse/Rgcol2Z5gz9INmqAUY/p5waKaNm/OwRQawGltvqk2
    JPODcn7HyBMubL6SxcfTgPnoe9uJJnkaKOxKouXCukD3Bze2USd2xcdUcoUmTMHY
    p5vsKKFEIzHlgsXzM74lcT8hmyLJ7/YCIc6cKUr55MhVyktTghdt7w8GnhN63G0z
    ewPhMV1rAo26mcdxm9CtsoIWlvAHTbYupaw/mU9f6QSDSq/p+CnsqxVFNLxWCohg
    bEq/cAPgv76cuZw1x1a8++HGM7EJBXBtAuUNiP4MciQIy5hG22gEW+Pfnfy60H2/
    Hc06e4y+hA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfDZVLaWITO6jhnbxJ7xtfYlYgia2wRqB5ZolNFf65eTxEC+NcddyH2psaqj0Lf+aMoJfMUf5KCIn5GjGekZI9De6LnDlIHmxLpnhAbUub+h3RKUIumdF
    +zJNBgXnqE8DpYOy/Fy6UDjQDarIUgn0eB7NCwvlBhOnYknkXDI8ObSnGQiWfnEXkPj3jSmeAVHSuRX/L2KaYdA8RFMRM90FGW4kqKeUR/b5HFVHWuFO49lZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=bdhgAJw2s1sA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932368AbeEHXzI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 19:55:08 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:45344 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932344AbeEHXzI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 19:55:08 -0400
Subject: Re: [PATCH 4.14 00/43] 4.14.40-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180508074003.984433784@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f1a8fce3-8e18-14f2-9003-62508becaebe@kernel.org>
Date: Tue, 8 May 2018 17:54:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/08/2018 02:10 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.40 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu May 10 07:39:32 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.40-rc1.gz
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
