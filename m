Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3741325-1521368210-2-7665059097178401299
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
    t=1521368210; b=mYjShgbvgQWCAMftPwwmZtC4Ly8INljLmbvy7dxJnpsSqQN
    Vtp/jfJ/PC3g+oFZ+26bbbkUekkJKWWY+0kbAWDh24Il41bocD+RbMG5LhUeQCws
    ZHRRr4JKW3aGWjhkyHaegddGos7ncSkrsovEyomJXOyXxH8TZlnfNM+EF0cLLr/F
    TuAGK4rOUddDCbqaZ6NbGAJ+pe1PcK0YW7aHfgc60IIk1mhNyuNic5dsrqPjPPK0
    Kf1iX8Z+KPTpKomBVKx/e11zAnxoPvGjrSeAzEJQ64lv/XyVQdGKUe2LI/vc8bib
    mcvAsxNG0SGchaRU1Hpo9S9/rIPEq0ltCtlQU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521368210; bh=6YgjKTcYxp6/yFNa3ouU+H5T03
    ybi0G1k4NY1HXEcb8=; b=Okf12vCW15RrR75baMtw9HRQRm7HFUeGFFikgd4+ve
    FSDHJ+bVBpjkDva1VZn2awcFI/mXonD8DYUuWQBVhOCgjnvIRFLsnkP+VJ8tr2b0
    NmKkAWtBYaVfuVbY9Fh82PxPfUbUYz2fFJZorZjSVYNVtIPzAZPg66cXyMWyz/5l
    l5bjJQXrnuw31hiTurARkf77ehyhd9kDAKjCvwr9f6y/XoAbs6WQz4sJKZovYr5q
    kIJr9kkVUcYXzEQPyLHsrKDDgnPyvjVVznQGZ7OGL129kaeelc16Et25PLC7r5MW
    IsqzaAwaiYQ3lUOFxzLNJCDDLfvwVaIe5hyKVhao02OA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeCRKQs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 06:16:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbeCRKQs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 06:16:48 -0400
Date: Sun, 18 Mar 2018 11:16:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/63] 4.4.122-stable review
Message-ID: <20180318101647.GF13276@kroah.com>
References: <20180316152259.964532775@linuxfoundation.org>
 <20180316180531.GA18177@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316180531.GA18177@flashbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 11:05:31AM -0700, Nathan Chancellor wrote:
> On Fri, Mar 16, 2018 at 04:22:32PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.122 release.
> > There are 63 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 18 15:22:41 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.122-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> >
> 
> Merged, compiled, and flashed onto my OnePlus 5 (unfortunately, my Pixel
> 2 XL is going in for an RMA).
> 
> No initial issues noticed in general usage or dmesg.

Great, thanks for testing and letting me know, and sorry about your
Pixel 2 :(

greg k-h
