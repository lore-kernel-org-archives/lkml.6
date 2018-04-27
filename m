Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-599759-1524852926-2-17125162851749909010
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
    1524852925; b=kijQOggHn1I56Pnj0MAmmdNLSBTqWWu4S5IKzJdTS/KIOWAEeH
    4Y1j+v6Mbj4W/Lg8PpTPVxKeOEzGHQUHY2pbLao1pTR65ea97m4vXbZZSY+pgq/t
    RA2r25zEn5LRGaLzJ1Bluz0LGKKiNicUsop4DbS04vjAk2k2m6ALP0RmaYztKxVO
    aW58k6pQCv109EBze6CnEnnMUdqfy0gzFVCV4J86H0T0aci0uNROG6xpeNvAQP4C
    Qqk3mmSdAKSZlf2AUgZyJqBw3F+RrvrKWFSQnvwcO23zznDrNhU5EFuY4gWLtc39
    dI4yJ5oRj0MQ2Ic889yGCq9XXabEQ4SzBgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524852925;
    bh=4QhLh4VVz2HnajJO7fhcgMX/C1BGqKE+5wzw0zCMXMA=; b=lUFEmdc1gpYn
    OPMiikkvJGTcHLCLg7JhEAJcaPhQTTmUxYhO0FzL9Cx+VH1FZ8TKMYf/xsBFPIyF
    UjTINXk9O2fbpEuuo2TkGvFx0KhPix2zTnbLYx36foCHwdOzYciEMUrMZQJo2X+4
    4bcVPT/FLpjZqseOCAN5n7bxbtiMqZX82oV8NLLzWuLS72hcFa5u7bcv3D/4wDK2
    Uwe6YlcJZH9/nNaKnNK5pKE7YS9YiYjcAbRgdaaPDz2kq06cSSinhnH4XIYonmd7
    EAjW/c/sGnqDThwk4jHRB06Ow+rWpyUg9iaXIG7WUYENMQr9FrVf+1eXj98YU6jF
    DwCOAUJztg==
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
X-CM-Envelope: MS4wfM9RXZfsOHGoJezbNXVEdrN7heMM/VLoxN6btzQSff0/SdE4Losci2zWmxr5PIPr/JJleRUqNmqopzD0tjNFQRkQI2sKJ+7eFl4Se8ZknPTbJumvqyUF
    g+EU/ew4SbbSQgIoN02xXl33z2u8cU3zdblCWoVZCtZRuGVbwPvj7nfQ+5PkVx+gJ1+29B09jvZUN1le/VA/Vr0Q2WtuTPNzqwV6PQox8HEFdg8YHoWRu1FP
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=oZq4rTz8mb0A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757936AbeD0SPX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 14:15:23 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46434 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757920AbeD0SPW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 14:15:22 -0400
Subject: Re: [PATCH 4.4 00/50] 4.4.130-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180427135655.623669681@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <b97cbb0b-544b-cf8d-4616-db41b64bd11d@kernel.org>
Date: Fri, 27 Apr 2018 12:15:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 07:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.130 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:56:42 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.130-rc1.gz
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
