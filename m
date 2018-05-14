Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-837036-1526306281-2-13111332372826891607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526306280; b=ZE5RLixD8AZRaWbyU74tCrVql410gpgamdeZUOHQlxfnVyCwaB
    5JItZudJXDkvbH8mx4DeDWT7krD9f2mN64W0Z40tZD+7PHz+B9d2jcYva9fNTyAi
    0JRgKyGu7hxiRFYNBZQFsiFWNnucs/b5iGFZ0ETTtbzqloKx02/FPYjnW/F6hU2a
    xhaY6/iiwIHmvTnbmFqJdZuN3ppXSc/Qpqg+AAPCeIu+98I1JwczHbRXvKs1EAw6
    wVaCsR65BB6vECulTv4CvsheS/HsorLEWE42xtoYIFBK8NXhw192rA6+bK8mvqtq
    OEweSm63maU/NPyYpGH74oWTftRKsqHgSysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526306280; bh=/NF2jxMngg1kZE2jDcV9VL9KNnuWiH
    CTHcgWX3H4/AE=; b=BMiirEkPaTnPf49NQ1O+JlOBS08qB+uc0h8rHLu4HU/Bmd
    4Z515x1rzLBBSQ8OH41j4qFNgHftf6hztnaH3CgcMIKMKofHs4sf28hO7g9r36iQ
    ClM8MzocHFxfjKLIu3FmJ1+5IjbLdKP4WpPGF0FQl55jpWuxR7AjU2dQcDIoTtK+
    6/C8pGqFB0zfaAdIl202G6NedcgyoDBrHE1IpMv8Xf6wzF/GVXLgn8H0PGekHudy
    Z/fo5QrMLf68Rb7ZVzANIH8kQfKz7o6eOMdxfNxWm3QrT5jHLuD1Q4vI3E8tRqgm
    w1XPwr3dz9Ro/2j8+CLrHei0Lm/0vZtwZ/W0WFbw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=WGTMipiA x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=WGTMipiA x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEZBr2SP/JAmwOynOMzA0790PdXfUntHdHEGJ9bm0kIA5VW6Tv7QpNTTnjgdUdRMhixnBKV/w/pGPs0NGLjwLJEZd6C8snxTRYqjvg9xBurq2rKZjaub
    uf+28QZFg3hfkS9wRomtgh0QpKp6uzg1W4hYqMZlTewT9TGr7Vt/O2VCrxSgJa94LWORqW+xySXMSx8XjEdlyVxFAzziUChFDd0l68NVD0s4ldR1+p8iCXdr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=0U73VwB4dlIA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=uQ-lHTlDaOci50oTP6AA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeENN5b (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 09:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932125AbeENN53 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 09:57:29 -0400
Date: Mon, 14 May 2018 15:56:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/23] 3.18.109-stable review
Message-ID: <20180514135601.GA2220@kroah.com>
References: <20180514064704.046463679@linuxfoundation.org>
 <20180514080157.GA6589@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514080157.GA6589@localhost>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 01:01:57AM -0700, Nathan Chancellor wrote:
> On Mon, May 14, 2018 at 08:48:29AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.109 release.
> > There are 23 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed May 16 06:46:49 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.109-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled, and installed on to my Pixel XL.
> 
> No initial issues noticed in general usage or dmesg.

Thanks for testing all of these and letting me know.

greg k-h
