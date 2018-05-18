Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-295341-1526676443-2-3255507635239907294
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
    1526676442; b=PgfRPyQ8whKAUkaQz+F8AHgddaMERytO8+K3W7LgFJ5mniLoRv
    Sv0AllY+Jyprw57saLA+rFJ4p/im7usXw+2iSuR6wvM811zFV/65MCCYc6okFh/N
    EZePrknJOeXXLPT7rKYBsWqbVJOvUfTAmAzMAKYHeNPWdV+2iWNTiW7oYYR9/qUC
    74pGi0za+KB5FanMXODxuIVbZ1fvISfC/rNV+u1QHWfWXs/B9923vvs/MK7yiqWj
    0tI7gbIbN7a1/DMxDlEKvgOaXJWq2LFQUrbP2Ztmj5gt09cSz+owED58NoF/fAsF
    +nLz9DVLMdiXfwJ0P5KO5P+1wASyoYXNuveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526676442;
    bh=mQIhBThx8PSk+tF+opKzNzqV/0wP+T8oYlCwsiQC3Rg=; b=G/RkMVO7uMWa
    wh74hUyQR7+fZ0CDhjt4SirNsSH26Tq4/zODFujYQxLolRGFUGgebnW0GdLJtltN
    kD8UoeCVJc+9X6TP5rO10MWbR8WbwyWBI4jP2Hqx+MNzut2FYLtK6SkjUJSsK6W2
    DjoGcNGm2tP6FkTCPU7+RjWlBb/fANOC0uEEM3ZPxgwYNncLfZSZG9HlWVzGATk3
    1qKzTbvUiRLCCSwKVE3mZFuBIAnVGYXnPqp+ZhnDenSsm0Z75YZp6vaJbu8p8Ve8
    9SJD5VyrVWPqfenJj4uEsFUMx9/Gr5iV7Jr98RkokrU1IBe1LLdAYuDx5063KSTH
    teRnciLLGQ==
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
X-CM-Envelope: MS4wfFdgn1LE19p/PPSzAiO7YJzva5eKcjJg4VDmA2lQ5lrZDXSsj36FeUWB+y1HBObVE1ww50XnCvmxD7ZObYF/DrRDHN/vKptPRUUzHsMGx1GS8H0QYRIX
    leqRhx2y6Vm8JY1UAD+ARynUTvR7X/J0sXHF/V8qc+HV8rmv2XAGe85c0BmqMKyGX4FRlE3Kz/TU1T+6Sh0D4VQY9nTFdCJuRYyfxnOejGC84ysK76jG89ps
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VJxAwUlu02UA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeERUrS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 16:47:18 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:45477 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeERUrQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 16:47:16 -0400
Subject: Re: [PATCH 4.9 00/33] 4.9.101-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180518081535.096308218@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <3f506b72-844e-e0d0-3689-e68071245e6e@kernel.org>
Date: Fri, 18 May 2018 14:47:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 02:15 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.101 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun May 20 08:15:20 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.101-rc1.gz
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
