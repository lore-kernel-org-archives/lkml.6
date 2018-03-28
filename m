Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2729766-1522254718-2-3414509838553492754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
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
    t=1522254717; b=fFu70lToJIezFIrC6kfYYKy6qN7sqeVEepT5hfvzaZahI52
    YHWUALRUmoBDkYTy96kpAn3gR/56nmCvn39R1c1cbQ7u+ffy7FaSvFyRUm49n9VN
    yhU7xJMH4WVpbCgQdTdhXDlfoPKhx2Gx6IXHn4d0xSPN47cisIPX0TouSrTESTTc
    Bv0SlnFH+1rRXrl4CJKHKYqoQQ6CjOjdNaJ/FFPQDnmFOaEsA/UbgqzpIqAQq+1D
    /AkMsh6P2MGbOF2mV5wHwGa3nfbhkM88vfsZKlHEA7fQm9Xtvw+6LCR71D+nmHUQ
    X+TeLudTelR01lBWiO7SLJN4jLl1CD2QjJopc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522254717; bh=t7V6+kG1HXTJk4w5oBwtIKON9J
    lQqqVsP9FqswdoST8=; b=BOQZG7RQcOLFKQlSpyDmjdAaIhvb7B9hwLUBLtyAo3
    iNu53Gc6OyVaCuCPSU2lXLlzf+qVOEpQ3BPOeD7C8cfcLJjy3xjVyVcx5636Ovr3
    HeWwk1oWJk27B2Uhhqq+61e0WuSGSFAaUdIEeuOuft0nQE9J6pusUinWEOa4jUQj
    EAWIhCdDjzD1tZ8l3P9MAfYYaO0mBLbeJGY7H1Fb/Hm+n92QuMvAueTdA1l5Z+sR
    qIACwn6PJANi9vM/ITtReEZL01QHAiiANMUqET/bAnobDgoDK4uNay2jaYqVtD7R
    xKRTcBDOxyepsLCw05zmHQx7J3pz1TxM41oCkIu6FCEQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIrDuEu8+FmXlYd8CSr5XiqMb40maoiT42ZXGE3xe0rEO9nUnpvVy9SX2ZNHoXSkGWJqwQHek7LhtxmLL6o/EwMHwtzvw9H+vjS5QdL7A9l1173cn+Kx
    gsiZKlD+zpD65EaImT5AS+jdinyn189K0HI9iFvjHUIHHNHZxmK6KKwwSWf4zPwMBxzwxkiW88dE2ptkn21ManrD2c8Kow6xdtQHUojaGpNoWP+ic9caG0w+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=HpFSncBSp1MA:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeC1Qbz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 12:31:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48584 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeC1Qby (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 12:31:54 -0400
Date: Wed, 28 Mar 2018 13:31:34 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/105] 4.15.14-stable review
Message-ID: <20180328163131.GA3261@calabresa>
References: <20180327162757.813009222@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 06:26:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.14 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 29 16:27:29 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Merged with bionic kernel, built successfully on amd64, arm64, armhf, i386,
ppc64el, s390x.

Survived a kernel build on ppc64el (KVM VM) and amd64 (Thinkpad X200).

Cascardo.
