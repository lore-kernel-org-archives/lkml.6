Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2345133-1519243984-2-6104002994024023274
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
    t=1519243984; b=NUmfXXOP3fe/mVQo3OjpyzE/V5qQug+8t23iJzn0ysi1uME
    StFTUXGH5Tx41P0diznUyVRchRKLkbQcnxN3WO0PBzd2HUpvOj5/beDMZNgyJQYH
    gfjg9tj5zsSuXVCveqkGCcmxcblNkuLIDL7vTeIbAaF2T1eSCetluGsdAFCD72pe
    WdcpLaCnoUd/qqYjQLVW/tmZRa4t+fWN1ODsRVgb6Ch2ZRUk0P5KkMAu8/2V5kli
    csKT14q9hwndWsQAgw300Budhj54MVu7cSaAfAKAyGRFm0k0UaF37YjkcQc9t8Zl
    pMY6NiG53zfEfK7y7X0xIhzJ4Z0c8hrSs0NhtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519243984; bh=7QA5rvV3504v4MaWioXWbFt/bN3vMFVP9+QhBGB44Mc=; b=n
    YCRusIH/x57RiUluV7KRFiPorifL6W816E2nS0ssxsVzlJ5snSWpAVLPRlk+PtH6
    /uj0uVqVA0cNPJnx6tH618F/EBallUcoMaGTZuBKcTM1MWqQDa872x0w1BS2Mz3T
    h/ogizkb+QZL/RI3lgaz4o66UuaMepufGdwd4Yi3vfE1KnbnT6JT+ww8f5aN58om
    XOCSqnpnO5+MhX7IipDC2zLNSwKDlj10VPHOyU9e/dHfOrOwJYqwYHv1nHYa6RBK
    M3bag/07wjIuOp+zOUY59Mt1e9/MOnWCMlf/lWfL4Lt69Y0yIQOw6TPorTh26aB/
    OiJqBvFd2qGbvk1VpXAUQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeBUUNB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 15:13:01 -0500
Received: from osg.samsung.com ([64.30.133.232]:63347 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbeBUUNB (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Feb 2018 15:13:01 -0500
Subject: Re: [PATCH 4.14 000/167] 4.14.21-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180221124524.639039577@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <c54f2c51-cc2e-fcde-9bed-24364186403a@osg.samsung.com>
Date: Wed, 21 Feb 2018 13:12:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.21 release.
> There are 167 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 23 12:44:42 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.21-rc1.gz
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
