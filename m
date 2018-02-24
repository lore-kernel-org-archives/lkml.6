Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-51572-1519432702-2-5302187674178349438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
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
    t=1519432701; b=svm3rjQspkNcbDL8343ZAsPbjU9shi9qSzXwrbw+IWJNbFE
    /wXBsyFbvwpxkbi9hvHk+maYBo3ZK9IVsL4h6cdscuzZVTM0ysfnlmJGKAJQtTU3
    l5ZTOy3qSZ69Sgue9LunydDyThE7+NPiUkXXUtEv36gaIe/d3Ob5zJtY5ZdQruaE
    tTayEjGJ/AxgoEXyIrRt2RyseWxc4wfB5ASlq25dC3OY9whafuRIM317Vldl2Rht
    dtW3VM6AJ/FR9Q0fY03MPwSc0zso1lbhqIYsHODHp4Fl02q+XTpmS1eruv1uoIuP
    p1p7tLb8C/a1ay+k0YyNBpchR2MpSWoBRJ21yPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519432701; bh=cutn4xcD+AHeu2rdj81dqb2OQazhtRuvzTM+oWLnTD8=; b=P
    nSE19AglwJ4h0qG5vIlR6vnqaAQCIp7xRUBOBu2ZBq+DQ8HPsUoO3Amj5HvfPvQa
    +8yKX2INtlI3saeGYKM5O9iGe/oYBLLVCZo9OC+wHyViJoKENwGzhQBPya1qPuY8
    6iQ7NZXpK/kePuFRn0aoC+vH0wENoWWAD3CcLXVxrATFEv9LFaf11MWw8QFVllB6
    E6qEZptgQRz/o94DAcqU3XkmLrMCo2v1EfK1MGNUyU24rSKLngCAnIU8FSgh5TRR
    okHbfy8UXlKCWwhtNEk6kjb4qRiRmp1b+e0bqQtOCFdbbtpuJqV8rAzN+d4KoMs4
    NVGUQ3njA70IpvEapIxeA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeBXAiT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 19:38:19 -0500
Received: from osg.samsung.com ([64.30.133.232]:39659 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbeBXAiS (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 19:38:18 -0500
Subject: Re: [PATCH 4.15 00/45] 4.15.6-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180223170715.197760019@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <705a557f-373d-d56f-162d-134c6314a2d8@osg.samsung.com>
Date: Fri, 23 Feb 2018 17:38:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018 11:28 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:06:43 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
