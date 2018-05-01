Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3623125-1525201710-2-6522494900062196760
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525201709; b=MemD5CrGEmXi2KpOYbo3rNLR0yUd5RSh66c8yOHFV9UUdzLNqW
    4eP7rngCwh7OqulGgB5aQmU8OKbVlCoJ4OepOZZgW7w6d0ENSzpGcC8yrlDhr3aX
    py4b/2aqA5WNCoiNUoiiUZ4Bul6vk5cSp/MKptGp5hYvs3yk+Doog4Bc3Qd+h64I
    /qUBXlVLx4rO3XNsGcgYdRB8YfhrzboUuFHZrtM5Z4tV8+LmHLhDM6gfx1mRayvg
    enSUSMpRkEjr/jAFFmes5+IBn2SG2Yjs43mnJ1GfgojqHdTJD4wIS/s547kD/fV0
    wxwSIbbv6lj94XnyAEl5PhGzZYLsZIh8jnJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525201709;
    bh=/IHAULyaMODaRgxKsNCXbBCLPxXxYTcCPJFV++yArAY=; b=B5rrYVJQh4/O
    qcEYBoo0c9OvxAaZSYExbFcrOeYSdCLhwKQi5buI8S/j6K8QRxqd/eF75J0Nt975
    YYRyw0j63rEYuI4L6XVkDw2f0ATxFWQiHIihiwp430rVVW+t7090uwhDQOYZ+y0a
    GjyogSVU+fo2CkGSQMwnKpfmuMow1ft4SPj7uYly0q05Rcg5YKVABXqp0JUITezz
    l3BbY/VwHLIaJeV02hnWxDTA3X4tjLNAfnHPf2YG309WygYOP7hS/+OefUQpuw50
    4sFQdVhkZhltLaTHCu9rzR+2flANsbiSW8pflmYfwZzag3Wsnb+MCoquFLfXeQbZ
    lH6BfYCnqQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
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
X-CM-Envelope: MS4wfGTAIz8qUpXoKDLp/mGKm0y22X9RDOsK5GlzQXKEGd5aG2usLnvsOgGwxObA3pxPjkN1aZQs1sCsS1lVYokoQveWaem3JYUpMmtv7o7rt4nlPYbEPr59
    rmkk8eSJmuYS2U20jS6E+tGXjSN1ufjTMMUiaQlGg/MZOLLl8Gzd3jduLgaWePDvUDmlQ1Zr5pKsdZkGVHIZrqyT4MpvvzOvcWEXzMQ/4YWPNz/U6S/tkVpH
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=J1GPtOpRGk0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755402AbeEATI2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 15:08:28 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:51450 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755727AbeEATI2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 15:08:28 -0400
Subject: Re: [PATCH 4.4 00/44] 4.4.131-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180430190946.093694747@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <a742a266-1dcf-0842-a445-a267581df034@kernel.org>
Date: Tue, 1 May 2018 13:08:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 01:24 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.131 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 19:09:34 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.131-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
