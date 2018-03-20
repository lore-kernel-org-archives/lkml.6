Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-820325-1521532228-2-9537328055678363100
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521532228; b=UZie9seUxleJsl/yarrKDnTsU/6dXFVJbnkz2mVoKTBPc6h
    zV0TrQyKDwyPwETSvwIpgApLsd5exOgqqXg7Vjzk8oquD+BU0Mtv+LFzkGiXMxm2
    Ws5zG+UzbyIRPROKIbssGwSiq0zxDEMgjxSj5o4MqhAN+IV8I9VDM8JZKpooOioZ
    ZzLdmj1XG6HK4uzTrp23UOgmKrWu8BIpq/BQh2WSQFPkVS5YmvzIthRq+7HPcCSS
    6arlgwEXAi5BEFxMHDfVYOO6i/TsUIDEpMdzlXEdaDjHH/KebJQWOUbDNLuIVJUT
    kHUtBdrc0vC6GNLrFncgdM9Z/UXRtvt34ysvf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521532228; bh=+4cxfmALyYrWKFSrgHyloKY/5g
    C52lLr1YZlxcRdWKM=; b=SaIobvwJjJNCH88LFMx9cOpz/OPTHJd33BfctMbOTB
    rDfN9WgYSBUfdAJFTbNT1GtgDixl6xykn0tR9dSE+uQpeI2xyGPsciZTPiZcTpsD
    MiZLpj3b98OQ2Ca9GjoQEldKPTFbSuev8xN92+QE9Vg0KvYLk4nfLCSPzeRshZ0G
    qhtGKKGIBVnhiC222Fp372tp+5+/RlQTxHQCUhBRKyNjizONMO6q+tt8kU4ZpIct
    V74v5f/6EuXh6w2zjelSky0uhLrl7xdaCyoi99LJw9PNeZRB1Ib6a9A0AYRWUWV9
    nMT2QVEYZ/1qSOouCW2VTvhNQBnfAr4KyGRBsr9Q4A/g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeCTHts (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 03:49:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTHts (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 03:49:48 -0400
Date: Tue, 20 Mar 2018 08:49:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
Message-ID: <20180320074945.GA10034@kroah.com>
References: <20180319180751.172155436@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:04:25PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.89 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.

-rc2 is out to fix a bunch of arm32 build errors:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc2.gz
