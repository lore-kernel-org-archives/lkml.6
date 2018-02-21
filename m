Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2360122-1519243946-2-1392418672156358018
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
    t=1519243946; b=VhF/UJNd6sHGFaJwNH3Gg3DZKJrBrmh0TghZC9aPTzxJGYP
    WjEDadJQZ8q2wzw3VucIamNVxBD3WLllPRdmlruTvARL2nFFuU19XKyUBkB6IgJv
    sDDSpLfQiVBNFfTSoqAWouHJgI2xeiOBmaHR2dIuQc0F7qZXK0Rw5/3HC9WmkgrN
    xUgJWAlGd1pzjkeeN1DW4cVLEOwKrziISIakVFs16Q5J2rMR70SZPGmnO7gMNRLy
    EXmfiK9m86nEsok9y/T3eMhl/mjW/ytGuN7Rfifo4w0VW/VceWZwif5lyw++smrf
    GM8FvRmZHsEK8rXFYYg41IQNMaiq4tUTXQYBV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519243946; bh=EGFPT2IHo0GkrF9JnCdAclwsMiNUHb63dRO//3yb4eE=; b=T
    s4ZkPYqCUyHF+yxn8JZiRn2kvnRSdnsr8EdG9mpICARNZPnz5Oj39z9X2IgkrpRA
    jPmiZXTmGIcifjWvDglkD+zcVqZ2c4YRtXyEBYvdyI3ob7SphQ2tyj7DhjDGotnd
    gCnamSnxrcVfzHYa/nfP1kymCTxRr5KGK6tPK2HjDpvtVf+k5DPnhbWk2IIPeIPC
    AGZZ4SAnm3jg31owifjVEVUZGyXc5dJD2xW3M2bg2IFF+n+WSzlH3qG24TyA9Ji8
    iEo5vctk2dxk4E6KUpimiYSWf0Sgw2hwjEDtTc9whtNX9nfVsV58xQ2xzgFa7bNL
    QGHVA0N3ZBEMGOk+8o1qw==
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
        id S1750738AbeBUUMX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 15:12:23 -0500
Received: from osg.samsung.com ([64.30.133.232]:35048 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeBUUMW (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Feb 2018 15:12:22 -0500
Subject: Re: [PATCH 4.4 00/33] 4.4.117-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
References: <20180221124409.564661689@linuxfoundation.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <3f4a6235-1a03-cf30-1b32-229aac5c0ce5@osg.samsung.com>
Date: Wed, 21 Feb 2018 13:12:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:44 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.117 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 23 12:43:54 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.117-rc1.gz
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
