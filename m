Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-287146-1526676326-2-8941145717023772096
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
    1526676326; b=IsUAPe2As8LHPrHFvrWV/vX1SYJUIuBb5pY9kwpv/l05DUANyb
    EaDmGUm8vKejL1prMqnHk3H/Qt9HeRQVzih4tA5qtJqBHmSc1RbweV3LHlVwm1Gv
    aJ7dPK3HkLx6ZWzpdxohvHlerf+9nDUVhprCCFVlUy7+v6VNqo85bmuOr4r07jDz
    EeZaHnZ3y/4i1OncqMZ342mDSdzMipQ3bJoDotyLuBLIZIy/8neOG0DgCYI8yEqc
    zipW+MbSviWTRsGrEVGmlDoffGqlheFWTQcS1gQNLrRMSPBuO1n41OYj4Z+j8Bgs
    6x0WVx3zpYqjhF29R9XIA+y3NCf4PPZG8tQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526676326;
    bh=M1USAIHkhTXBVN5X4xm3OKIorMLxEvxy9fy9f53yJ9Y=; b=TNHAnkiS1CoS
    /z0OQy9m7s5tZexrpRmC5y74y5uKq/LGRkC4uZ/As2N1LoOtH307wSWwJLTdNfAT
    DH06DhuDZePcOfxiLwCVaeHgxZSEHnCKDON91q58pD4BGC/Daegvv0AY+3rAQyyp
    bQIokX6qyWY27nh1N7nSNRQbpB21Kg0LRXdRZ4RaBmwCvXZrQIwmYMmnsGyox0ea
    APriMgTbHqSwGfeP0YWvjHxbqhWJbq0EchQEMQc5sk+q3HlxFLC1PzvzEjlZ/2UV
    n37IL9tZhdvCSCR4IkjuTqLkumx1/SH7tRiOA6kLrdl6JCf5HvMXG34gWH4E8ifR
    UHdH0Vr+dA==
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
X-CM-Envelope: MS4wfJwhutbyZIKkN6+za1bRjOQhQMg9AHG4eN7nXfN2nlHZUJiHi/zfrwr9ThIOAIHAhfxDIOSCzxkNPuDOpb9aWlintXuG3wiVlRWc+wozimhT7s9fJ/nu
    4J0IgGovp1cGp/Y8mrp2vD8D6lL159FAq2m8fN3oSsoTZBt9oXewz2nGqHA9vIi6r22mTcyvoNe66VI/Kzwy8YBqAEpd8gwAlwjpaPtRnIp9ihcoT+bCiLw9
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=cED_tJPvky8A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeERUpX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 16:45:23 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:35364 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeERUpW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 16:45:22 -0400
Subject: Re: [PATCH 4.16 00/55] 4.16.10-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180518081457.428920292@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <d603f3db-1b88-c145-f51c-137adcf1c69d@kernel.org>
Date: Fri, 18 May 2018 14:45:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 02:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.10 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun May 20 08:14:42 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.10-rc1.gz
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
