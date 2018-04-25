Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-889516-1524668914-2-1746990018907078109
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
    1524668914; b=Bvvdcw2I6IYrgWsAVGt/P1bm9Kx66zzvSh+jZV0aDEouifNYMz
    nzxFrRaSGndXvo6Vl5qrzLj/UWnr8maS4Pgvn8+Sb+ibcX9dzVtUin27W32Rjd8R
    hKlbd5L+Rx4Csqt9TQZ2NiuQ+wAFueE+Zfx7epHnyXprzjR6Xa+8c7S88xBcvim+
    CPhtwgRT+OkFG14P11EqIPxjS/ZV1YyjdLtfeiGcSLYAjdT5VTpZplmAnOZXIioe
    0m4v5IcAI0dBPu6Qp1qnirijWyIPc7VbGXW5Y5S+FEzAqJC1wkQMSR9dHB1moAuU
    941iGxZ4WGFDSjM4n09MGg8OEgaj5agPTx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524668914; bh=PtTvVyXuTwHiHEg0iMcY41n2jWI5Re
    MY5GxuN4k4vUc=; b=dZmwQpSF3W7uyeFFfNVCdbVp7VYvarXdiMtgTPEl0IiyFN
    D/BxgZ+ZyldYex4sb16VXVpBmvUl53senqvkRwRtzeJ7KyUyqxqceSulmCyWy8YV
    AbYIgCbhXK4H2/f/qqSTubb5rrC91aWpfEGMDS58Jj1WLCSKtjOkJ8kpEuhw43kK
    aFF16mi4pcwbeu3vhBUYsqNwP1KShnD/UvdkXY56a0F88VYDIDiIZC//4WpAyGIK
    dQZkFK2Q42YykcXHXyy0nDvJwh8TncBNS5hzhE5uo93eTEZDZmEX2Vp7VxGTfiHl
    se1OsYndSVasmCoVTW+0QGsG8e6PnbQCiYJfH+Pw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHK9kBA+rCK6vD1JlQDVwfqzmtT92bFDgz2tefjf7EtJgJ46IgSuMn/YWEGoyp/PChBzMs7PAQ4N1uHkeBXdroRylfOAsqWM2wGvFbeW7IV8xBU9t+pQ
    xs/7wg6k3ctUXbnP9JldEVusmQjHIruhUarvNyrHtocpHaRocCahH32a7x5CPgPifUrweKiI5LU/wcfEJE+UMagsqwx/BEwsiaNRIVM/BH4fQ6edajVLvkRT
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=viYhoEuuK30A:10
    a=Kd1tUaAdevIA:10 a=X0RHW4gXn4F30lVEMlIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755021AbeDYPID (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:08:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47026 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754695AbeDYPIC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 11:08:02 -0400
Date: Wed, 25 Apr 2018 17:07:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/183] 4.14.37-stable review
Message-ID: <20180425150754.GA29414@kroah.com>
References: <20180425103242.532713678@linuxfoundation.org>
 <20180425144110.GA12890@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425144110.GA12890@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 07:41:10AM -0700, Guenter Roeck wrote:
> On Wed, Apr 25, 2018 at 12:33:40PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.37 release.
> > There are 183 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Apr 27 10:32:04 UTC 2018.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 146 pass: 145 fail: 1
> Failed builds: 
> 	powerpc:allmodconfig
> Qemu test results:
> 	total: 141 pass: 141 fail: 0
> 
> arch/powerpc/kernel/eeh_driver.c: In function 'eeh_report_resume':
> arch/powerpc/kernel/eeh_driver.c:395:13: error: 'struct eeh_ops' has no member named 'notify_resume'

Thanks for the report, I've now dropped the offending patch.

greg k-h
