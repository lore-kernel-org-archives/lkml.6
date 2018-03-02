Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2297825-1520016785-2-14887964000894940131
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
    t=1520016785; b=mkyyo6QFibf7UPSWhqviFe6bSfVQz0SKnkj0nv22tofLUan
    PxpqgSw8QBOwaZm79izHBZT/J3/zmEE8GI0gz3WWA/3gyMcWNpCQljTqDpf1RqGO
    dnr4WGzmdwu57tZm8bj9MN8SJG9yprmjejv34ZiBcLcHKofhaf2VOVs4JRSrEhd/
    RPot0Uew6tV8oevItyvnnNSRjAID+9Ta2t3RyivT8BuNrbgQ/Wv3VjMbLD5eS+DI
    UldEO3fdR5joBqd/e9G/g481NEy/CGj7Kbuo20x3ctlV4s0/rhqvPVzkbbRJJzXa
    iMeYDy2paICDyDCohalefC8tQx0GINlx7GYxR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520016785; bh=IZkcgYG8s7vNlkoiXlAdM3HdrV
    qH2QLtnE4ScFgp6xI=; b=KqhHUufGn6zBJZ5Oty4dqMwqFiIcfvoxYQD7yWrxKW
    QuUIDZPv7Muh58xYeGmrwC/4E8QrY3NrTE191jsaw93BOKrqpdi4Zes2qI1scFdt
    9vDUyvgLc9xFFj3iPAL/A+agJWBeM8ebvdxYjZQyu7CC7YF0eKNiyoqVErZklnHf
    po16jew4bUQzpEzb5R0OylDEUBh2vuGU1mvgYv/TMQ4opneKGeZcKiLxSeUZXyan
    sY3ayyN94bUa5IFIvwuQGMSNlNEos2v11dq3rj39vAbrGu2IKqHUdfRIZ97XnXFT
    Nxp7E8n+DJD2Q/MpiJvJ8lI3cVYqL8COCXLnVvZOi6NA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947529AbeCBSxD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 13:53:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947528AbeCBSxD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 13:53:03 -0500
Date: Fri, 2 Mar 2018 19:53:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/34] 4.4.120-stable review
Message-ID: <20180302185303.GB16331@kroah.com>
References: <20180302084435.842679610@linuxfoundation.org>
 <20180302122238.GA8345@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302122238.GA8345@flashbox>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 05:22:38AM -0700, Nathan Chancellor wrote:
> On Fri, Mar 02, 2018 at 09:50:56AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.120 release.
> > There are 34 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar  4 08:44:20 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.120-rc1.gz
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

Wonderful, thanks for testing and letting me know.

greg k-h
