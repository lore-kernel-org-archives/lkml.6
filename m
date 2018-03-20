Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1923497-1521567252-2-10645764253015507994
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
    t=1521567252; b=RxuoglZj2cMaiC1BBS3Bxuti15zjhSYY4AidIT5hkGh/fkV
    oD9qIKQUnRUUKBnK/ZyfQvZnkjRKEEIBU5R/o63J4my6gsbNv/84cKu7B+EDJuec
    033i7tKhi9jCPO/Rus2PgXNAc4G0yqL1k60eNEorGoj16qFpkXDClY/F3pJiJSPo
    zsAxiw5zZehl0NCJp199HVJwgJj+kWF+YzNLlohwTtWuKXqJ+ooAHdUpeJzUFO7r
    GhOR6Zy6ZCv3w082n85+oIjnNs3QxizW6kdLgKr9II0FmP5+1ttIbcfpHdp5T/b/
    jss1Hif+MbSno37kl9F6dLq+f60B//svpJiQcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521567252; bh=wcSo9Pwu0Hlct0+DhOSxrwNhxMkIGYrKh0Lj6f//goE=; b=Q
    +K9YiKZgoCH9evSdPFthtEZJku+eA1WFEL61LsbtFK7ahm0mlF91+8SQsWXP0dnK
    teM/tj/P+C6IG09rOwP1SVC8i+Elf/K9pESyaMJHgsCC2FStduokKwSPv9EJVJQI
    ckfgWb88lsue+Yd4maENeifu6d8pyEK2sIRabyb0RLLHXDJfuby3HsOstVrbqqWv
    xjchxSBiA+c7OgxAeuuVZKo+xWo+3ifIVpLj60+mJl5T2/QRS43UL+OwgaNRQssa
    kO5rwXIZlQIIu1kxSrFAkDr9NW2GqQGSA1bfngWjCwQSWg7++wreFxX4cP3sgPyv
    c/e5hP1RzwaKAJEhod3FQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1751688AbeCTReL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 13:34:11 -0400
Received: from osg.samsung.com ([64.30.133.232]:32802 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbeCTReK (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 20 Mar 2018 13:34:10 -0400
Subject: Re: [PATCH 3.18 00/68] 3.18.101-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180319171827.899658615@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <d1cccc92-1cdf-414a-e3f5-b257a2eb843f@osg.samsung.com>
Date: Tue, 20 Mar 2018 11:34:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 12:05 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.101 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 17:17:59 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
