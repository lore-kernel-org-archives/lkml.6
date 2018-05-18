Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-295341-1526676382-2-12030041543091076791
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
    1526676382; b=QRpJGcrBR6RyCavACtbESTnF4B5lv0thTJ6yWClQF63vvVm7nV
    NJWEUwSUAUaWy0XYRZs3QVZBu+t9CwG2Qx+RZE8BTfINK0AGY+tSo7wXm8zKwKRJ
    VZwKsEY0ssJ221nK5DXCflhp4gwE7cOg79kqEfsNjj1q0sDdP6V0AoNX9I6qMVR+
    i+cKNBeBf0A/Zbfngff+udu9JyDlftugKX4O9lY7eNdIg5IgEfGktd5nqJgm9Bc2
    rAMtF9E0tPqDWYRVGLt4aeRKNMEvWAeLvde+m9D13Sjmm1u2okwatKG4RlTJD61u
    tRiLHfGhb7nvHTtbi0siPg6VCfw9lnYhLYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526676382;
    bh=3bD0B/hWqpVI7CAMVwJalFq3qIyMcgiZB16GVuQiw0Y=; b=cTW/YGslEdbe
    xU4oUGFnMUnuuHJkt5N0N5mQ8jwnMvCx51RT/490n40Tw9K2anRPrraMIr3qPRDl
    LJ3Z4TdLMAIipM1KYQHjwhXIbUTym3F4w14bWG+8lOiA3Mzcv5UEtLU+pMrHNigG
    wEOsYYZApfpR+k/sv1KBrGw4Q49iqNuBjYfBIu9gzt40VrfNfOKocZCqA5kSUSE2
    Z+3rnVaZ9ivYLW4eHCT77bqd4il0QjXxaASVeQkJKC5Va2kiHGyKd+EWqDGsyn6n
    jCQuM4tVii0CAn+cxJKOl/aJ9fxLAq/b5w08pFONNTNRdljm7qylp6YIGAWEheL0
    NG3d8YljKg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfN3xmCbBZdLeLbesdj5/GRC0ZFsF51MqT2ic5rmo6b+mguayQSurYi1jdeMHz7geysXho7UqJ4F0Af1guJV/zFIBYcwmx7InYjKRVAbd1vH7YIC3LUAq
    SAM/nZiPp1CmbU2J/NKkStoQVzSeJLUNctHfvj5a5uw67M4atbMSPQmGHkCmqxrkCufSfQxewzet4dth+gLvHb3dBgcRGAjeAWsn2X7r6325OMDwAHDBS0Bj
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=WWs0EKWmijYA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeERUqS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 16:46:18 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:36554 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbeERUqR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 16:46:17 -0400
Subject: Re: [PATCH 4.14 00/45] 4.14.42-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180518081530.331586165@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <af2198f4-d771-6373-2634-87bd7239f44d@kernel.org>
Date: Fri, 18 May 2018 14:46:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 02:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.42 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun May 20 08:15:14 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.42-rc1.gz
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
