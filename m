Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1132802-1521014037-2-1980730862817354104
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
    t=1521014036; b=fkO4us7sid34D35i9vcPYEPv1cHa23JJ10eyGY9lRfnuV1N
    noGXCZag1pCZCG18PbqxOGW4EmL1129LlMloXh1+alVG8Gzdbap/Sg7Icqe4vzND
    pFdq4UbVbiQ+pRpFcSZt+TUoVy+BnH21W9Jig9A8hbbhfraV5bOCvvSVuUGfM47B
    BNK+o3F89zvObkHiz9v8x2MO6JDFdffnRfCNpEm9hLDX4Het+JxDLykFjZ1PSDrn
    Y/0COvR+cDjNthY9tW1LLillWtm/BwFW4OEgjkf+rfI2eQ39z5O//lp1QOjh8snc
    twteccD+zfD52B0w8TIfCsJGnpYRDt6b+TJpWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521014036; bh=GXcNuBn7zGuMMromgS/u1nzTXT
    kVmLOWl/6HLoJmBZk=; b=B4rQ3xmTcu2xZ7Z9MsyI2cJh9RjWEz78EV9lEKAAPX
    IrpJ+hfCxErQa5N/GhTGbGk2e9RsuODQwDIJjwOHvaqBoFfkNwXhsoOH336mjWVM
    uWRP3tGzxhaLzizR+EDnxsRrz4PY9Vdjke3iLPLAyGXokYfbQ6H8VRINnZYF6nr5
    6rLEO05ZBpONh4uJSr1Fz3t2la4meZjuxmVeippIScfHRt6bnBRIzMh+LvXy9npC
    3TinMiFeMLVV1S0GWhW2HQ5G7aSKk9+CjG+GYiyTdHczOXfrkNPOAMuWw9UWRUiV
    hjkeqEzycyIDjVlI/6z+C47Df1v58NVJ2ex1UsbKOiRQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeCNHxj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 03:53:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752347AbeCNHxg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 03:53:36 -0400
Date: Wed, 14 Mar 2018 08:50:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/146] 4.15.10-stable review
Message-ID: <20180314075016.GA27567@kroah.com>
References: <20180313152320.439085687@linuxfoundation.org>
 <20180313222800.GB4113@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313222800.GB4113@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 03:28:00PM -0700, Guenter Roeck wrote:
> On Tue, Mar 13, 2018 at 04:22:47PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.10 release.
> > There are 146 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 15 15:22:37 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
>         total: 147 pass: 147 fail: 0
> Qemu test results:
>         total: 141 pass: 141 fail: 0
> 		        
> Details are available at http://kerneltests.org/builders.

Great, thanks for testing both of these and letting me know.

greg k-h
