Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1982828-1522231448-2-18396310499379945685
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522231447; b=K4I9I7H/ByjnNwactZu/v5XNQLvnKeMgm0lruqYJsGUfEvd
    eFtf6JJcd4pAheMbCbPCuhahzM38E68x5d4ocrAN2gUcrGRZV63ZpEWlBx2Ij7hi
    2nk+HRqn4NGKv7aso2PMscNno+Hoys1X+0u19rFZc5eHWk7gtmYeE2LMzvoyhYH3
    rgRMobATCkmqeyXcVxR8/uoJgEfdoi7e5tq1LQOK8PH0oUxE81jgpPrd7TCce06F
    A+OpYSac50QBMvyIChLLbb7FB7wowjtJt5QxpQ5cn2/X+FSMESf5sgIneQw57Mnk
    71yzlb3m8jf1j4opJlHDaVwH/TPtwQtNKuBgUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522231447; bh=P+S23nqaZtx/WnK4fsGOXtby06
    zG31VfGMiAxk2n7cc=; b=bo4XeW1jXLJ4ggraXhuYOVzY+6qV0iXiB7KXVqZAym
    Tak6wi0IbbowHNoFCm4N5D4kW61+0wTmMvklYwczcFc1Qe/M7EblKJqN9TmItoSE
    FyZTtOjYFTw3R9DyZOsixXnambFu8sRaYOkAmfebsGgDWMnXvvwXOZDw3EabRnbz
    PplECCdT2QBNl1yl3OjFe/GyDIVwh8G83+oLvVpT7DMMd0CKjmF2KBQIGAv4QEHo
    hPPMa7DX8LVjeiOFb0+4BMIto/DGVUN0yapRPka5y2Ntl5ESlTrCIAgenOk3rRxU
    PyeKCBV6fTpQJ1IzIkyZZILAufYs0KbY3sinNiUosgaQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPg820LRIp0I36X1Au6dXseTtbAH6LaeHLBHNk4QCITURQ85YisuWPSPtQCcKNcf9Bx3eglU855YQANY75FXnFpZn2DDtZsYvNXkGccRaSPumWkHpTXT
    HWaTIxtzWIAwaMc23rDW9pPG/MybTcyioGxbKQ8NumMDj1JLufDzKi2SuGOmwkAAVyBD9yhNFQqcAJb4N1YeUCIvCworHSfXPbw32nA2pr0tutN8fnA6nobW
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=y98JahJlUwsA:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=PNilL9W0sFTrA6VEemwA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeC1KEG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 06:04:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbeC1KEG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 06:04:06 -0400
Date: Wed, 28 Mar 2018 12:04:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/43] 4.4.125-stable review
Message-ID: <20180328100403.GB29527@kroah.com>
References: <20180327162716.407986916@linuxfoundation.org>
 <20180327182444.GA11972@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327182444.GA11972@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 11:24:44AM -0700, Nathan Chancellor wrote:
> On Tue, Mar 27, 2018 at 06:27:04PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.125 release.
> > There are 43 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 29 16:27:00 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.125-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.
> 
> No initial issues noticed in dmesg or general usage.

Oops, responded to the wrong email...

thanks for testing this and letting me know, and glad you got your pixel
2 xl back :)

greg k-h
