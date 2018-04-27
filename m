Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-599407-1524852967-2-17061104784186392732
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
    1524852966; b=Snbm/oiMFvAFiZ1j/NXNgbZfew/IhBh0RVDq6apGAt+RQNtBBW
    Ekk1O8h1ziT8pZ0/4lXdN/IDIA6xH4r+j6Bc8vgthTjhpLna7f1JMoyQJJ2EY120
    Z19ldFyHdllzHcxmBdb5DhFvxmwl3m3jvDTa3gTUu87ffBUvfdyG2kpfbt3MAzDT
    cLAJiRCMi6es3gVVj62eYNhQqQgzka2iL63mzVbT5hQqgbOPlU8fRvRewZF1N7RR
    /HxuOQsJ4VBm7ZX6nAUnTuRJqJW4d573jLt5bv6SM+x6LQ4yTycDgvlT2a79JYMb
    GXYQPuXJDerehkOVzn5Qh23wCGbHL4WRc8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524852966;
    bh=P49JHLVJEjXD0xrbnngo2qhvMdcDk1PemoPksBaosBM=; b=CwnmVjOwuRge
    bdkDHjwqR8ghJXkQUI1znZdbz0zqP+uxgD1c1oNn4tnQkWvc7FZdhcOsQ4F9Kgye
    5tgMdlp2Q0AVpjGdWWtGFwdbX3gLFqDcinIGY5nZkoj7fzVlKRgsNFVd/J1N1PdQ
    m4Umb37YtPEAZfLhTI177HhTfQveAo4JnB5yNrBOx5cUKriX+D167HGw+TU4eOuA
    z/+ujpYVUhUpb4pWQrR0w/XBHkKOCCB/TaysQ4EeCsUA3kd/tPQNqgQiLYX9Dy88
    lbBbZySZbClBDF/LkqrEtW5stDT8qtHkIAUReLkkWbYYCVs9ziw7RQmNlxIMJgRR
    4rKpQtPeuA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK1eAMoYT1LT+5vNRifT2us/66gPGg/51U6fU8kXz6dP+9f6syU7NP/KLl0Kas5t/aNVSCoaGMamH4CYF4DpLTWksGNXOTdtOW5oDz0ZKTGATLLkTZov
    Yy8qPvjdtYDGaf2/z/oWMJ9ZdEGGbPd8h8Rrc7lQAizI+YJ8fAz4SbEYADI/qg4+ltFa/pCWIrq8s9WaPJtqSUFXi+IrnyEZpv9tKLuC7GPEc/ltcjkj5LF1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=9hA1FEcAjjIA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757920AbeD0SQF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 14:16:05 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46479 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757856AbeD0SQE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 14:16:04 -0400
Subject: Re: [PATCH 4.16 00/81] 4.16.6-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180427135743.216853156@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <5d8a3b5c-7617-d11d-13af-d285dd47e275@kernel.org>
Date: Fri, 27 Apr 2018 12:15:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 07:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.6 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:57:21 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
