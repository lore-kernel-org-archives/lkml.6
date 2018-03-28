Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1354722-1522216984-2-17275697637652962747
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
    t=1522216984; b=AdnqaGz7N1UYiMwUN2+sg563xG4CuaVao+z8w1DCdgJp6G/
    yOvqXByJiLW3SnTftSwWlLWNBqLJdf0eMSS6vRF3cM1Q9GAbXTlLJ43r59Qs3ZFl
    f8Az0t79JiSDxubIVYJkgH5LjAc47xG/nBDXJTPs0Yxy7yTeVwx0sAc+2+ctguuY
    oYFMW1/YMdg9SJ0W6HhyrHfdigkJREADUD9oTekeosYmh47Asjj8TQ+qttCPIBw+
    TS/KRRE/EfzREFMGJmZfcD3nyS7qjATzhmotTl8DVJ1ftkO7Hu0vg0xrp87NdbfY
    05I3LKT+ARZagj4aIhe/VSHGP6gLN+/VKgxseHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522216984; bh=Iw9SdrpIdmKwONhiGz9zBiaYBj
    10Iu2ZYXDC6tUiZbQ=; b=vUZKN/vij0dj4kELxLs1fmhfmlC0aKVzYwGEtDobLy
    IDcz19Z1RTA4d3mNdnUu/eXlwC2ttqTspiWMEGpH6WLIdL4spbrV7+wQq1ILIgbD
    nfFXIqHbHdOwEF5O/g+x+egRJADTJZNznaEwJIAn/vxZk3BxAnCt56fKeJUz7S3Y
    ZAiT0PsOORE9zbbinP38N6gnIMXKKcXQ/jEs9P7t4k4gqPtvmeFyVeZodDjA1LOW
    cslR2cRp+FV1lrvrWTb9nVLpNGKKMtswbAMrUn9DBK6n0t8VJ0Z6d88H1qWPQR68
    uDIF+0SmtsdvF05Sn6m4HC1SWFE2ESHcI5gjfobHSIaw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfOGo4c21QbyxFnYGkTiZ0hFapipYWrQ9+2qA0UI2walZQPegAn/WZ+avG0aCiajDWYRlNDAdQ21F8M04hVuppP5r18zAtEefLXLbvHujAqJ3ampWDp3z
    kr8z6BkrDm7RXQLUQN+y+wt2bdkWRn4lt+O4Drb70fXD19thFJngN6rxPgaZjMwSUDVGistPCPjTT2UloR7mi8b8OT7tuyAWDSJNZ+74cEIVYtmIadIrlyz1
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=HpFSncBSp1MA:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=QwK3zxdBwoPrVwGfhKIA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750733AbeC1GDC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 02:03:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeC1GDC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 02:03:02 -0400
Date: Wed, 28 Mar 2018 08:02:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/105] 4.15.14-stable review
Message-ID: <20180328060257.GA7226@kroah.com>
References: <20180327162757.813009222@linuxfoundation.org>
 <9c716ca2-daf9-40bb-0985-5eaf7f0a992a@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c716ca2-daf9-40bb-0985-5eaf7f0a992a@osg.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 04:57:44PM -0600, Shuah Khan wrote:
> On 03/27/2018 10:26 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.14 release.
> > There are 105 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 29 16:27:29 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.14-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system, No dmesg regressions.

Wonderful, thanks for testing and letting me know.

greg k-h
