Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2177121-1518207632-2-2851788536313545207
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518207629; b=JrKqP4ldJEG+Ocoq26iNGz7hWS2kXuTe9kkEb2t90utO2MZ
    +oArSfa8x5Lnk3qfGZe3WErmmnWTE/1FOtuy7BCq+XSLKYRFPcPI8WhXjSGi4Cdn
    hFbOy88VR52z32LbIYC2+fLHc+tgE9zljW6MrqSYD60hu/pdssl4Ke7ft5XkfEia
    QrWOa4BtbyhyrJ5M+39FrDAL/UaLn/PIIjhoNgfDmu+2ySXKRn6ynHMScnaau8Sn
    6ybCJ4Itq6JMtaPC3n7ysPz7wq1H92rxGbWScoNnVENsE+rQM2jFwEVSBDMvBiau
    NRpSOnpaL5oACK8BlD8vuBh2sabm9zdp82uQd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518207629; bh=gfi1KqR9pdypsU6+O1MTF2HDb9WQvvLpIiyTLPrDyN8=; b=B
    xlV/+sMb6sT9Ngq3bRwIm0guEqcHsEThfu8M6KWcxK6LONCVFkoUk1pMo6R7TrLD
    4EShj1QaiYPWCpZhhp2szYludk+Wnmy5fhjSETBXpnMsEaotrxYvUlf5x3SNIgUg
    gQncsI96pfrwIEVInmT/RbUxqAvFKXu5q7R44tde+JRBIbBjimpF/j068wxO3hft
    6DrIVjS/uW6xN4aS3jgtpA8KrsBfZ+yx6Wl3/oDdtvviqta+sV41M1ku5XQuC9mY
    8f/2eaJq0/Cqdvea/UtZNZKIwZoqPRp0VAgBWfGk5QyU9RMj6yibeSRuK8dWW6Mm
    iNB+oNS42irw+L2FR73lQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeBIUU2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 15:20:28 -0500
Received: from osg.samsung.com ([64.30.133.232]:41960 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbeBIUU2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 9 Feb 2018 15:20:28 -0500
Subject: Re: [PATCH 4.15 00/23] 4.15.3-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180209133938.366024920@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <f53caa75-a957-6553-7869-66d89b2de7c4@osg.samsung.com>
Date: Fri, 9 Feb 2018 13:20:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 06:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.3 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 11 13:39:20 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.3-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
