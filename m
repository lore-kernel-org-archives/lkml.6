Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2431476-1523196452-2-4699674749056165260
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523196452; b=EfNtlHh1xMk7oVxiTkG2wRWywnRLbBo6bq4ErKnmx/TW6H7YVS
    qLdsEuULCQ6uQLkujlEcDAjsJ7C4MiFW1/KRppzxZs6S2Ctj2bHP5PCVQBnBuCiC
    V+81osPYOMT3+fUtrfTU5p7xHOnWRnBveoBznG6R9m/Le4tHf8s4jVfxT3g7ahea
    8C7ynzzxu3z0hnoOfeA99dVc75OP5w+FBNCn6qcCEgfQpvhM9e6YR08oyJDHCNWm
    BujNfa7ldtCsZWLhTNhBpl1l/Xsh1JU4i3Yzi+VgKHntYdKYPsJghUTF+/xLQeV5
    1K4oDxdLZYR9umpXOwf7vsYxA/Vcwq5lm10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523196452; bh=xFiu257Wenqb+DI6VYOMesaVJHCwpM
    U/NW+9n4+qSKE=; b=Zu7onJNJUcJYWboX6ctCIt5avM080rgrQWkmXAHkfsrb2A
    L7xcumNvuLXAlcamWDpWEN4WEy0GitLvyb64kZYKVWhSjOqsj1OiIlP4D8batB8V
    l6dTwAbGAKtmjIdU64P7dCnJRoK7wVHhr4foQw/8gSrnSHsuy3//MpD+5/ZFHuF/
    Fqs+z1X0TLQtElL0rVHj/B8RWWY7oU1tHzy38N520doSJmlc71kus/bz8l/JIGMV
    TyIT1e/a+Bn8lpNLysBsQKeAcLHHNStUiJylmFMjcnUlqPhNxQIcwAmPVzTRxedb
    lcDsxiz8NMR9vh+HIrn7wAc1xMOJVPcBaSrjLIGw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b8xdHcOW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iLrWNZSz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b8xdHcOW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iLrWNZSz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDKhZOZKod/hPurXNtp18lMLW7wH8pw6C4KTdWDIxbzJeEzjjt6ar+bHMeaYm0Ii18O2jrjgWoKJi3UxPEIAucHzj5ife9NqJw30HreljjJuy5RNTLe9
    vMXkBw9w32olttYeFMK9vlBwXUHTXLG/Oz3wTPXomTDRr5I75WopGF71yvaerHEIz4xfk0vY+EAojirqzQjisaIjdwBZUY3wKdx7cx2rkz2z1Z7W/g5rFTga
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=RRRRr2VPVCgA:10
    a=Kd1tUaAdevIA:10 a=yXIr3yKRTqOJSlTqdyMA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeDHOH3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 10:07:29 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:38041 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeDHOH2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Apr 2018 10:07:28 -0400
X-Google-Smtp-Source: AIpwx48ay1zlTXa9xt4VvGWkshO3U5RSiX+mi5Kl1b9VHXfrXxnHYlxc8fzmD2UCDvESdzD3SsQB3g==
Date: Sun, 8 Apr 2018 07:07:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/93] 3.18.103-stable review
Message-ID: <20180408140726.GB10391@roeck-us.net>
References: <20180406084224.918716300@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 03:22:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.103 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr  8 08:42:04 UTC 2018.
> Anything received after that time might be too late.
> 

Not full results this time, sorry (my build system is corrupted),
but there are various build failures in 3.18.y.

drivers/net/ethernet/freescale/fec_main.c: In function 'fec_drv_remove':
drivers/net/ethernet/freescale/fec_main.c:3342:2: error: implicit declaration of function 'pm_runtime_put'

and similar.

Guenter
