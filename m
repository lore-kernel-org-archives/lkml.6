Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-34232-1519432580-2-13058295897047831619
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
    t=1519432580; b=hYapwrJ5fUxreWuy9+23XAEMPw3dhKYcEuVIPQcwDGSV554
    FHKW07lxmJE6HIR05KQ8Vp7Rk4ZouNmtZS+fiLeUymMrH1ioJZcdD1S3BhmtFTnG
    SpCJGIPQuTsWZBCm+WQcRav5s3+9aONwvvwmGIZN3iZk2JAO/9N0/RsKDg0svQrk
    qnSoHjOmS5udptBB1S2/X43RFbhL7ODBErO47ch/5Fs8TUOkiR10TzeAfddGKkeL
    wY9SIwf+l47K3COViS13Vaelce1fybax8Lr3QvvC0Xik1vwYkKlJXdQTvsjwkcDu
    kkY6NjHMJ2bQttqR03KjpDYMzJCkWxnmEr3s4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519432580; bh=TCRdPiw4F053ClodYR4OhWGxPFAlI5UEWcEVCatM3fo=; b=U
    qb+rq/Sb+nuq9iS/GNAPHVbTFiTmaEVSNNUTN1efqSXXHbYuqPr2LnmqJF38FhU0
    IAtYtY4aUqfIPihG4Z5zb40Joy0xSNk+9fsjS7EqYYsmqJlImtPf/ZFXDhvmILMn
    RTLH8omPaGmiJeEm0zv4amEPuUm3pfKUjXp2AA56pif8xP4gQPaU9KcHp8WCrRAp
    3DKv3P4Jw0BJibI1mHvmpf3Xk8+EPa49B90VRerAuMEkPQKarkQy4he8WgafGEZc
    DN0iu/bc1TpccM2zF40xkhxGrUUM7+nQwleoduHqLWmX2CO9iGwOp/FoNJipqdgJ
    8rpFasH1rd2gilO149okQ==
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
        id S1751943AbeBXAgQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 19:36:16 -0500
Received: from osg.samsung.com ([64.30.133.232]:65383 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751629AbeBXAgP (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 19:36:15 -0500
Subject: Re: [PATCH 4.9 000/145] 4.9.84-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180223170724.669759283@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <b48a3287-11c5-3d41-9f32-5f042ab4c66e@osg.samsung.com>
Date: Fri, 23 Feb 2018 17:36:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018 11:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.84 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:06:27 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.84-rc1.gz
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
