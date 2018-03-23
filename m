Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2180492-1521838027-2-7955103814130187976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521838027; b=D13yPns+6YaAD3zFxemssUVX3rVn75a8WMD74ptIk3Miivh
    WAec2M8czJ5qpFqrR6spLh5qRJyvRMOist77+Xi4oxyXb4Wn7psA71rhV5JXS5DI
    Qc1BvMfEkVI8iqUSLaJbkC+NkjYOZDZh/510JOFLJuWuLqGAjU4/4VwGHOxUhpnZ
    /qRdC1OHV8hiG6Xxv5xzoYj4R/mK3p2rinpDbIB8n872vnCUFx0FmMuxNG+Lfm6p
    jkEFD1xyhXXkwJm5buAdVyktnTT+TFl5MwfhGfW0bKjyIokF2TdhWK/OBCvfoKXi
    4WjujxygBYkkHEIh3UgLv3ci2zSIjse2zPwKh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521838027; bh=YNljHixwxT33EdUX3L8oUkg6fQ8cvDW5rtVDeRY25Rg=; b=h
    XbZVZ2zKjnYASO9ynjw64gAGi6xZD7rJYihV0kKbveYckKMSSXnymfa0X1ad5lud
    ynEIlsZyuMy3cXXb8uP+cd1bDxHQQEtoGY5yRzsCv6LCQzOWLE8UyEWPYk8htP9Z
    iWaKBeCwzg0+giBPu+YXaluB0DerCfoqJ/jUVYPwJjcNd2wFUyTxbo4vCi2ZhBR9
    lE9dXwbEh9ypvPWoQZfuvWZDrBIOeO4Iv1AJPtYfnslLnZZ+LgG4/J8OAmE7FGCh
    1OCsQyiPyzwUs0qE8QbUiICfMEQFr0mAdfrFJv/3+iXpR07UhwjOJjHgWnVuUA2u
    iL/IuMU8vuEgG6iOPLLlw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeCWUrE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 16:47:04 -0400
Received: from osg.samsung.com ([64.30.133.232]:43622 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeCWUrE (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Mar 2018 16:47:04 -0400
Subject: Re: [PATCH 4.14 00/77] 4.14.30-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180323094142.260022880@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <24614127-d372-2985-37b9-14ecab90e27d@osg.samsung.com>
Date: Fri, 23 Mar 2018 14:47:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 03:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.30 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 25 09:41:18 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.30-rc1.gz
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
