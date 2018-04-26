Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2046117-1524725993-2-9016533790718301763
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524725993; b=FnQ2Wf370TPl/2Lk3XanjqXzGgx4g61k46+NBnIbGf6YeKJRzJ
    ZNCGLH3dLNM0ETPSCk0B//InkD5pHlAwVOlJ55EPEKmcnhUdESGKn2KzsY2hVqZG
    +7sVHpJN5OmdUI23DCiCASdxXP2qm+tCxnNXOX5jcGGMDKJCYkYwgwPqEQ7Kz0fN
    xI0Xz94w0lsvqBuZ/IhfpQrQAh8FsraVg0TlRKfaoJY1UQAwbQ2zrmW1yDfhFDLf
    +EJQEbOjQSZllVuykJqoMCxQtFI3CNyVa0BblMbjc00Mlo3ebou0PGsLCGZc/vrO
    KAEPgIGynPkrXhJ1JoQ2xRdZ+xRlOGUUHeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524725993; bh=4UM9mmTb4BxDtgkgIXScpf67l30u/9
    JnWBj+7Gxbhik=; b=H/CZyIibk/lPHRX/7pTM0bh2ey3TC9JHqBb53QNgoPZ8qZ
    J/b6KrA8deAXo6C3v7/YoZXP3H6Eqkz1f2XWODEhekW1wOQghz/1Siq0CPj4hD3d
    caVk6YiQD9kQmNJqGAjVT/MTM3wQB5nOYM7foAdWuU0tvXUmLBWv+V00KozdfvSW
    JroV3HGWObBSMnJ6CjiiprZEW2GnynnHoIMqVoKkQVlmz+K4fBh3zSHkXPNkbC+a
    wR48Ncrey3RQeKUraWMhU2nhCeh3ym4VgmyrA8+pyzHeK9D9/vXNPkk8vblZCuCX
    hTMzUk6w9IvC+pH3cCNqzXXura6l7a75TkPDID+g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfFW1AGXYBEFo7LP2hPWjzw4XF4FQ8NhLS86MB3APHZKH8fxtfYBv5McIsCVZkoSO91t/Wk5s7mVhm3I5VoREgEjPAc9iEBvE2pk0e21s6UtsH3Be1AUN
    VD++p6JdTDvGbnu3FRUiunF9C89VElcE6CVH/t7/SFyLRpfRz703GcxDNdV/CImmA9qrxW2AUBjZHlRp0r0D8dKg5h2dT15m1O2wgj+htDojrU2JBShdNnWG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=viYhoEuuK30A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=p6uYKqZLiLQurPCpMg4A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbeDZG7w (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 02:59:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbeDZG7v (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 02:59:51 -0400
Date: Thu, 26 Apr 2018 08:59:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/183] 4.14.37-stable review
Message-ID: <20180426065943.GE14025@kroah.com>
References: <20180425103242.532713678@linuxfoundation.org>
 <20180425180809.GA16835@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425180809.GA16835@flashbox>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 11:08:09AM -0700, Nathan Chancellor wrote:
> On Wed, Apr 25, 2018 at 12:33:40PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.37 release.
> > There are 183 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Apr 27 10:32:04 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.37-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled, and installed onto my Raspberry Pi 3.
> 
> No initial issues noticed in dmesg or general usage.

Thanks for testing and letting me know.

greg k-h
