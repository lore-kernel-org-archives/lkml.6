Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2424450-1527190287-2-9347729670881405692
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
    1527190287; b=Fdh6ftzuKX6rT8AJaPfPHU+G2BFr1yV284hT0moAZCx35EYtMd
    /KtaSubRLUMEVbwtexNv2QRb62Dmt3lexgwfsR9xQOjaIrqvTwT5CyvlpE9LLMBK
    83TDUHXUSMWr+jKfBQKaQdhec3/qCnrqmGqav9bnSJUspo4q4KxK2A6oyqQvXqu8
    TG0vvbPwPil2dvqRzpsDNo+zl3JjsuDvzFfblP8CcY5NJG9e4bzgbVCkryGN57zf
    JkbDS5d2wXtTSo+aQYeW4JQE6SC/0NmxFAYeHOTqqaRTvjQajtFCifKwAc3j5ZJv
    leBV93q/9S56sb5P/jjyrvjf34sdvabasdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527190287;
    bh=TB9YdWY1GKXYA8A/+MmCdrXhu9PmxkKtnmtXu1oCd5o=; b=e+51g2xQ+2QB
    7NtnD+ECdELohQvDdrikKNQu0/DrvUGTIaPLnYHj4zt+jdk5ABHurn+HhX9h7UA1
    P/il0UQ+UT4rCmUqLt4epRwG7vNMzc1dG6kh/3kxrqzxAjnkNC0VYu0r4bKcVMVZ
    UWbuIgeDyNknfFjfWqCV5yQoM0PkNERVGcbqMBV/J5TpiGT02I+qf9lxBT4a2n2P
    dnSd8u4+vdhoWD2Bo9jjVSJCIiZ4tNKXfzHA7v/7QYnJpMJ1Ly4zOzoYoe5rdqnR
    Kk4lMuzxh7uqvxv3xXXlTUp2G+9PKd9p8kxGbKz9JLHxp0h6pqsvV+SRvaHVUCwx
    EU8vmulbRA==
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
X-CM-Envelope: MS4wfAJcLnoSbI9sg1m6POcYh5ftgrdCN8DLJCZi/mRZ/Jh+mTC0RtkZCYFoOxdyqyKenTRgXCQUNY5MZSEML2GFJ8ou7UIZvHYyXZoJ35ifVGpS/muJAIKD
    zSzfY6CjtiVGuQsGAwrzqcVbIzRzmXwYgVXt+cOiIU7u8hJLVb6cIFUtaH0mAV1a1oHZG8ovQ2JgdpEYoUyhlqNLvXGEx0KgAxL+s1hlyZwYhGk7v/Wzhqn6
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=MQJW2e49u_IA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034531AbeEXTbY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 15:31:24 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:33166 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034514AbeEXTbY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 15:31:24 -0400
Subject: Re: [PATCH 3.18 00/45] 3.18.110-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180524093120.599252450@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <d21eef6d-b706-1d13-5ed1-75679d4c4a1f@kernel.org>
Date: Thu, 24 May 2018 13:31:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/24/2018 03:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.110 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:30:59 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.110-rc1.gz
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
