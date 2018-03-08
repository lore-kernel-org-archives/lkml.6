Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1700296-1520505347-2-1866385553216535755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520505347; b=Ghw+WZ3UYCkoMye2SyEam1hLLvrBBbMpy8jHknKTg/vC3Wd
    PAr0+tYEKPsBntnsaWCfnTRiFIKq+IuFqrQY5dxSjOZMsyel9l3vYiBSWA8UoHVI
    ItP6PdbF2DYrEu3IBvT16vPuJJi8M3HdjobD6o+QWovu8v0MP/jJ+qMzfTJeZ1n2
    k5S1/NlHF5sy0b01eACJoRtC6yY834KtJFh8vjo0BbmpO/Wge6n04KFut2n684JY
    eOPtXk7PmgDuwrdAIAT1uMYeJPf4UUEordIfc5NBGQrN8vtoeecG99UfNL+P3XL3
    E693IUB+4hYvrBcSObkc8zzBfMY7LjPt4FdTLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520505347; bh=VWQ21om3+ScWEA0p/EomzW59n9
    /Q/dHRnGJTl9/pfco=; b=MUervCA5Bvz9Vq/FE4XxCNGdxWS3YULlPuCzN1JXvK
    TDGQp2VpcRUdRT/h14XCUxFBUgvp4l2TxA0/8OFdKJQZ67Okw3Ftt+lZ+tjW29wm
    RViKC4E1q7ApWtk6gy2yt6UE5zecO+6CfFrW1Z0sCGzCRoXoOLueO51W59cIm1wW
    BCYyzl6bmzpuVh37rhn1KHEHklZNKNcbzKwbq8k0gixCM/u65v4LftclPwaaqWLC
    6AKNIQ+aeV5+DX1C/+ODSUxjHu0brbT/+1/nr+GnW11QoteYo1bmc27soRGb8cjO
    1Oqe7ROrU//sW4C7A3Zcs8rRDjwhhoRJheKNMfsPIQNg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935254AbeCHKfq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 05:35:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47649 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755152AbeCHKfp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 05:35:45 -0500
Date: Thu, 8 Mar 2018 07:35:41 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/122] 4.15.8-stable review
Message-ID: <20180308103539.GA3409@calabresa>
References: <20180307191729.190879024@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 11:36:52AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.8 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar  9 19:16:43 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------

Merged, built on amd64, arm64, armhf, i386, ppc64el, s390x.

Cascardo.
