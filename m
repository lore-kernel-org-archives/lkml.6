Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474721-1526335402-2-8664613903517046912
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
    1526335402; b=nMSfv2VnKj6DlLas+fopn3RShM1zpuPrrcoqFYevyzpTuF2nS7
    QyC9R2f9MODvXgu1fmShinh3Td8AdiqGwfvOmwnvxadVa55PcKnfOdhbu02M6hQU
    5gOfFzopLG9O2pYkaC/oltE7SoiyzsvmkeX9rRZxgP2Ax/OBUth0lFKt1gEPhKeB
    pm2Umu1JQJRrSUZMclYED4rhYhmAD5ecPs3uq9lga8Zpex795SL8TrWSj/XE3YZA
    7vBpGsbssJoQOZ2cyYmmVzn6TPTcSdyaeQGFf1vFAC14cMVpOqA6sbGBTFp3S9zf
    s4CXPmggS8hmiXDtrpZwmHA0RQj0mqNg0Tmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526335402;
    bh=RCrPZNZ57e2YUunROi24mupSAaJb24sd8XhIJmnvEiw=; b=OptloislMkjA
    yDpsENUlF6Ot2i30APe6Vk3gUchOo5bdCIBz7ZgV6ateFsIefJfQ5gVbk+rdmyuz
    a3vQMRnthsYHDliA36V6DKrfk0WgalUubsUP73XLNzEruOg/7eV9FHze4IAtyvh8
    ctNQe9cOs1cjq/8ncgvnjdM86Z+SmHukqGbWPb9j76WE0nxM7yScozS2W4nLDTog
    bOk3FUcncXGkC30aoRELuZ1qqBu1g6KsKY267X83+rVqw4NRnpylVGr18oYCEQrA
    XRRfbPzuebicdfGRJbN/XcQVf1Xi3artpIvtc7zNHvYXGU/gd5o9eQoOI5lshj3z
    kwkNFDactg==
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
X-CM-Envelope: MS4wfHkWZ35BprBAaeplIasdP61ZownHRXZXinUvKycKId4ENHnqfoecvvsx5TzxrVPXzZGMf+7xDgJemziXhMCBfvx5QlO1uyGxz/gSRRwcxghfKCqKG98o
    tTkL+onvvHuFg1g2l/DFDKQ/tB0PJSPXC3WJZ09XBw6HQ+ybM51QtE6bv83DJaGW0Q4bqUw1PJXAnZd98w/8nfEgWfqaAUxftoyZWowts0L6wIt3eJ6d7jN8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=TttDjgVrrK0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeENWDT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 18:03:19 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:44692 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeENWDT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 18:03:19 -0400
Subject: Re: [PATCH 4.9 00/36] 4.9.100-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180514064804.252823817@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <d0978a2a-6070-a8f2-48ed-efed5712c960@kernel.org>
Date: Mon, 14 May 2018 16:03:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/14/2018 12:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.100 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May 16 06:47:47 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.100-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
