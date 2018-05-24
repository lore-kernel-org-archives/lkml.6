Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2430669-1527190129-2-1428581438401761984
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
    1527190128; b=ILELjxbD9u5/xuG4iUc+PmLr6r4gXuxQHzX/MaIbd88qUlC402
    yMolPCkQSw+itLGa6Azy4aTgfBnP7X89nESgIUhyInkeeG6DXep6oKx78szteh8h
    jp6Sk2M1//BA9cnZW9MS2jnqGq78LDCFhWP1UCVxT6auK+uskY/6pgT/Q85Z7eln
    Iv80wcbZiISBq7uCr+BLiNtU6qyXPNaV1t1AdtcgBG/qqd8lm9Dms3X0ueO8Rrkw
    9ggVdQLT9FzB+gcw7QnzB7PVxVKPya3E6AfCedG9W8QggIY7KURadyqYZK4e5Ab8
    r7xdtlHBx1FrczSk054M8zwvdH6sZFs4BIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527190128;
    bh=dmR/BR1WpxM5VIgYj6KpnZvF6bXhDaj06G8ouyECbSM=; b=nMUJ5NY2/zof
    x7oW0qgbUn14mHXdo9oi8rpTu+1kM9qdoM6v1MqKDu/m2hyCAZyH88Wjfv+VLcaO
    BepE/fj0kzDOCYl09pOFEXtLRIsuq6ZiVUnSzKMGy1JRtEyUX25hYdoYjjhQHqs1
    7RHe4bkNYQlokyfwnNzm2cQm559ZU6XelGyXo1h1wH27rcIjFGEirWqHvBKVx67F
    lUsOvx/IRIaXpXSea0GgAmqFgGruh2evAmO+Z4rxcubtmaf19lwdAHEwVyyMN2Mx
    9tzst5LypXna4R+slWlqyKgeyhRfp4TsBlAl49DOU1nzI+xteVwjkgACsI1CwXoP
    a/BFr72YJA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfGTNIGF3os9gX6Sqwmc8iFYABfiqjUWtqZ6HHRrEyhDRT7Y/TgRP3J1qA+vcPEyuEg8tjeKcxcGiIhS/XtLZ9npjKKwECWliDfbulouL0u5CzD8qM5NC
    FvEhw7FDqU0x4NsP1JMcs9V7eIWQ+5326E8nVeNoIPL9pAMEd4eeD3wZ8yCdlujyzbojq22nEA4aUEqD9fW/Nak9zqVclVRPTaIVTNv8e74XSPkQSp0TLoAd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=zhKW8NK6TxkA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967744AbeEXT2q (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 15:28:46 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:41214 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967656AbeEXT2p (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 15:28:45 -0400
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180524093159.286472249@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <6d1dc0aa-87a9-7f6a-8da4-e35dbfaadc1a@kernel.org>
Date: Thu, 24 May 2018 13:28:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/24/2018 03:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.133 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:31:28 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.133-rc1.gz
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
