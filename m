Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3081717-1527021864-2-9391779315649546371
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
    1527021864; b=XGPVmrbIMt0zxRJ25Q6xjRqxlz5MmwFnJPBHX7hQYGSDFc+YVG
    M1GbAhNak2G4WrOtkX7DznBw2Co+5Eu5yfYQBmz2thpkE+/hp17aBOYO+Tpwp776
    YG8QcZz93RBy3KAHIatpZSFBmRjmkeLcUxiUF+uAB+c9pw+4gzysjAjaxq6s2QxY
    adFk7HQh0w6+n91yZTiWTYmKSQZePyzTX0AFDUpQIhjyFV+SPO3jFwWpHkgY8vZ5
    Z2UyIUN94h78YPTvUuUZTHrLkCidJMpVvmuKGk+Nre+61j3ieBXkemFaz/feBtXi
    m/T87npThvZ5fa0T4/L57i8eVMIR3DCHi1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527021864;
    bh=2oiVbnMf6rn660GB2lPFb5qVPzYGJitWzQ398NyOG50=; b=K7devXQNYzYM
    l2Gi9SFnW1rR2Ny/91cDljzY5m3SuefEgx55z+ZavL3Z8R968YPRouC0//wbeh5M
    fjKQasa/dSfXK5Kgof+W/zpiJSNYk2ScuUw3HH/2qw11nSfsSKfze4FB84zkEcj8
    KKi/1eOsYC3eDoOCQ9dyV4hYs4Y9D6RpYe0NLsaZLivKuyC4YT+Gs3OAIEqurdC/
    Xc+PQ4Fpv0TGUffwPwlLPdLFT4w2p9DXuKDjlM8TDvg3ZigYcAC5C7w7SBCe3I79
    N96UQmFGCEb7KQD/zEFNJys1k0FVYEjXFBjXzBfhTQPpF3O25apLdNbWGb1WiPE7
    9Bdcttyk+w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfOGsTh+S0Knz42ZXc61z3+Q6dzFWORR3Kxo2tjo1e7pwVEu9iO03bmJ8Rkwu8z48QE9c5VFEkLQrkAe/RO5816BwEyugyHNSABzirNOkQcnSgmaIYTVe
    2cpABse5lA+gzwRbemT2ftcohlHErAC3H/fN9OAglIWuhGf7mFtHdwcoqA6E1g+NxMa51qQBMfYBvxBZmGzufNoafklIaJXBmLiRKmpaGWgod073HcPqstih
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=GkQz-2DCOnYA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeEVUoW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 16:44:22 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:47719 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbeEVUoW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 16:44:22 -0400
Subject: Re: [PATCH 4.14 00/95] 4.14.43-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180521210447.219380974@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <dd9aa6aa-c67e-a673-ed37-6de7c7ecb856@kernel.org>
Date: Tue, 22 May 2018 14:44:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/21/2018 03:10 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.43 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue May 22 21:04:09 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.43-rc1.gz
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
