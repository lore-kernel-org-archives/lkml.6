Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1550609-1522351033-2-14775558632815920374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522351033; b=HexaxLtrqj1OmzAHsn+vO047XOKt9jXt9ddr51CWCxNLSeSkUV
    RDpyLTTJpZ+/RA58mpXmX2CA92eMZGy6KGId87WXVtoNV4o9dkeC50+tvC0LZruI
    AvXLfrSLh6wrIII0zQV0behaoEae04p0tKb2eOM9H4GYJPlpKM27AcfOt3pyiMeS
    IVAtqDDj3WhZn1EkXAn0ndYYN0Q2uClSBJftZ+fwZluXkw324FYri3XjwM9OVKlL
    rT4Th7QjVz9IUkdceCAMkcpns955pwghTg3AToBNfGSjBNF8u4P85Fiml9ZDNrLf
    FciiKPoOeGw5rYWVqy/LI9WqdY5oa1Di5cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522351033; bh=bJN6OcO27eC/CNJ+UPVRMF8cdbROtv
    VPmz1uOQqfmyQ=; b=wZQXTTfQjkBKHL02WF4sbA3PuirSW/T/pr1GxY3gfe2d9y
    7bPEEvUqftE2gVmfmSG0RDF8duSrHYCP9gYhSvr4QDoO0lXX4SnNdh2B2RQ9X2wC
    qho1+/f6J5LSWsg7xE9Y8culVNQwSWonkvhw6GRKeljYZ2R8oM16nYDIIHQVlXYn
    pSuREeKXYKOEJH4+8CDjRgt0CGNINTKP05y5bawXVzl+0rJ2SXp5tpUGsn5TWOsR
    /ua9DQvGvAZd9333M9g8kxshIJ10SRcmyCL5s2BLvzHX7TNFdcPHJOk111sKA/DC
    deLdxOcVPpo1Vh2w0AJH+HO6j4GPzTZhJaFL6Zvw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sx2i2YTD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eVydq3P0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sx2i2YTD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eVydq3P0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAGR5oZvzBQxlB4jljakCgoTDrdnKSITkaXXjxhlIuZlhp9HHg/S09YMY3peylhbTBDIolrYddQ0F7EY+Kcx/tMUXBvR1u4UY+9dBZB9n5kj5+5337x6
    qMPLFWR0AKVCdRZwM8Fn3FdMNZ8PuzvBT5dt8EDY4pXqcUC6vHKs9M07Ef0kk2uYCPNwOwJ/fpQXmF/bW43OPrC5X9LPjVAqNX03J23L0t2aRmUdO0aix4Za
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=vY_346TuTMEA:10 a=J1gerpJq6k4A:10 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=4vwb9Jxb5hvCEYhWV84A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeC2TRK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 15:17:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33745 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752492AbeC2TRI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 15:17:08 -0400
X-Google-Smtp-Source: AIpwx49tSKRLipTcvhwwHp2AjslEdiI+G06FbhosKy/YchC03dtU6vuV7G8fUUQWI9d4zLFgFMSthQ==
Date: Thu, 29 Mar 2018 12:17:03 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/20] 4.4.126-stable review
Message-ID: <20180329191703.GA7343@localhost>
References: <20180329175741.886181131@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 08:00:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.126 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Mar 31 17:57:30 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.126-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.

No issues noticed in general usage or dmesg. Feels like it's been a
while since there has been an update this small ha...

Thanks!
Nathan
