Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-599407-1524852886-2-17172564816943051882
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
    1524852886; b=HuPHteh7i0kPcOTm4ZvA/uRVMsYgK6kIbA+6PDKdE74IulO8SR
    oUIKX++ikuiVZJgX7nwyKwZGh6vaFEFx8jSlwbuYnGbOpV8e9EB8iRE4HNLLl1+Z
    V5KaJdhrXHMXjj/fCmOJ/R07OoMZ9d7CQhALcqimnCQV8qTv4qKhgGuNqCq0ICgT
    bs3f0xUm6onLothJZIhVdoHTrqEtslF5bOy6oY2llRjoSoqo4xsc2tua52OEgSMN
    /E0Jfv+sNHmnCl5YLk/dBnIDL03i6sM1RkJdedHVCl6fp2AqX6QISQDU6izviIdo
    4/Ai0xpWURrnJXnlksWbF5FVHKuNY7WuOyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524852886;
    bh=TzuCvTdW/Wi8z7ukhthweiTa2NwH2X8B/ZYmDe2E0m4=; b=giUYHwzvj5iO
    n80QjdIV3KW46UHuT//SzXbpLcqxqlFGmLmmPLyNi/bvCuHUjtQSMXVytNKlzSUo
    obc0xJzgbOX6g8PzreYvRuMYFJJqs87EKMGtNnnpW3DyUMQ3Qvy20vHMNRO6mgv0
    wwfvfuKLvpBa442TKIwt2rO9Tdp6cPOFuya9Y9IARHQE7VNhhVvhwpXfFnBVIcF5
    ssujmN2b5G9XZ/X8e4wDRpFeAKYZsDIEsBo1ry1oMljukZl/TCOwvyKKfODWx5tb
    08Ft8f2UGhUlqmJsGBOIKyQKS1uy1yDkGJM9EBFbXpTdb7VlFxz5ndhiunBFAHnm
    huC/dPZucQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfBfbjaf3A2VlrdSROVYRoZtLEE3qQ8JUNl2/DJpGdRYIJtqhKWmty9ODQFbkpAIb+aRTst2kKhkbF7JUH1dOW45Bke8L9YbxRDtS8l2R8fq3qpQMXi+a
    YFFfHV6JhTtEURyErnFeRBQHzYi1eCK5+L8p5yC+YdcyY4xNc2ACALmjY5+RvCyiGvoe1PwYzmMaPCiMQr9fyeyqtFl1Tyt7pYZosu0N4fvD99XjuoXrBVu6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=D2BsPUkyXeIA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757338AbeD0SOn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 14:14:43 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:48987 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757225AbeD0SOn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 14:14:43 -0400
Subject: Re: [PATCH 4.14 00/80] 4.14.38-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180427135732.928644313@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <c041bcff-8567-03bd-3553-f41ea03932dd@kernel.org>
Date: Fri, 27 Apr 2018 12:14:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 07:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.38 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:57:13 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.38-rc1.gz
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
