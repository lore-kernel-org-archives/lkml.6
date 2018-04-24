Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1986038-1524530324-2-3631267011375860662
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
    1524530323; b=FJzewNsBufwRaOPrztcyJ6swpNwxMFv5fxqKhOVbsYI9ChPyR8
    lRlC8YeTFvBnyE7W6VfFvSJTKUTpaTiKsBS0z9tYnbrvJEku7cAyHCjMVXtjynuI
    KfrtIKrD0AiBlcBcArG0iqj5YtOoLEHUTi5YngPlc/uc1+EfeNeo057tPEQUGjf5
    o4xtQI6we3rp8uUneFK3x5A6W8EdgcuuPK3z2xGIxJFfg5FE6Wa9YU+yGIxsDPDk
    CEg8JwPwWJeEC9Ydypls2P0M5KvVKAguROQ8vCeWDGaeiz0or8e1M00ajlvc7ekY
    WUb07C4+v16LzhRIK5qzwSoaZCfvomNt32/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524530323;
    bh=Tq0ycyth3Giq9pJWeEfcNUiZ8NL2/k4gifYFSzPBdMY=; b=kzbGYj42f8nF
    GjdCMo6/WxbILSjIvKeJJ/9IFVDFpzeGTKfkDL6PA4pc4aPvl3B/0tkzAVrmLa7u
    3qxjuIYH5DyPSvQtVeT+vek4JDY2ery/VJgESaiStJhKgQ2379WNp3inkQfnkKG4
    fHEZqj782uQvEDlXxqpxXCgkSlADlI/7apDM22a7tJ30zt+/5eALJddcuFj7txrQ
    h+GSC2bK1JklzWa9XlRIc7PH1I8FyRr8nw7lTT6fucyvLzaNY8U6s5WxZy3rfI02
    l+gOd1eRTO4YbR06iOhzfjzTtzXXYa4bwVpuollmfRcIzI6qlUO5OT/yD7SOz/du
    SQZYyxB7cw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfPs44z8DRILLIbTwVdhJin7as99Pzd3xFyYcGB7/bPhvjbOvpZZmsWYoHyCBpKloRDoLg4vDa/qdri5mskcj54SHiznQ3UZJm/GFFD6xoIntXV8Tu7Ms
    dNc4aazgvZWXnRcgt5zLw+m0cDMkBMHZvgc24XrX/WGOJdofKltd0iqLnPs8uCjCGg7I/BWgmaQiVcJ6iv6iQwJqGJ8albVt53G3szp9j1wSBxzxQ+mFJlgf
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=mxXUtGV5dC8A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=wV1J1nbwTEn18NIYiJoA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932635AbeDXAik (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 20:38:40 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46943 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932611AbeDXAik (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 20:38:40 -0400
Subject: Re: [PATCH 4.14 000/164] 4.14.36-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180422135135.400265110@linuxfoundation.org>
 <20180423180346.GB27081@kroah.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f5a7a39e-cb0b-0fc0-b1eb-a2fb92c8c21d@kernel.org>
Date: Mon, 23 Apr 2018 18:38:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423180346.GB27081@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/23/2018 12:03 PM, Greg Kroah-Hartman wrote:
> On Sun, Apr 22, 2018 at 03:51:07PM +0200, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.14.36 release.
>> There are 164 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Tue Apr 24 13:51:05 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.36-rc1.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
>> and the diffstat can be found below.
> 
> There is a -rc3 out now:
>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.36-rc3.gz
> 
> 

rc3 looks good. Compiled and booted on my tests system with no dmesg regression.
Please ignore the WARN report on rc1.

thanks,
-- Shuah
