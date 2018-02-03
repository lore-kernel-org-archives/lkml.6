Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-523705-1517646013-2-3963010303148286346
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_03_06 1.592,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517646013; b=g7/5oZ7ppjoLag3jpFxYB4fLgTukmk1n3My8QKJjCpZTkGa
    wbjayNqWNDLsV+P+uG1sVOw09YL+3vcyNRHgsalnXN4gNvJsSCOJpGYw++m4nQIk
    Zeoqgi/3GxJnX8tvktDxUzBMgOne6F6tlXvyuEPuCVJpNHJDZdJLvpga9GYgWKVg
    OhB6uHy63Cv2ig9iqJY1v5k84jhx96yq1idooPKkTHAhRN4wFX4v7lTPJSQ0Nlqi
    I8b86qy1gZuVmwL0DljxjQXBCBDqQCHf9dOGCbNAol4OyEtEVmIt92Oy9i2fLayB
    eZfpyphMx869/ckx2GEC8tgq8vN97xJhjiRjmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517646013; bh=sGg/zPrgMT+rn+qGQVGJ36TUAy
    M2fLsZ7P3J2PP7fTI=; b=OjDLWEVtSDUHGvz58Q1PsshZ1uNeOhkIsiVFxc+DLE
    iPj774tBDJYUJpVJ+TyknlLd0jaL33FE8G5N6KnqkvuS4tgt6F0txz9UrtHDr4d5
    GNFlHormaw5YF+F0uKUrN5NTsM55RjUOwNyMSJRGUSI0Q97HYKZEOod20m5y1q5T
    ZVgZgs8wVfB/jC+WJqOKlP8+KVbyDclqL4kC83O/rF22E+oee9HRjICWvOYh4WOh
    o6QS+BQVBl3FhQbytmWZ9+Nc3Cu/dhDnF5nLvRKaCiSiOAjJxNc6pVjEqMzkbo9r
    3AZwvaKs6e2r1uAcqBXEDXPjszAXUArrA7/TgAn1ZO1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeBCIUK (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 03:20:10 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbeBCIUE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 03:20:04 -0500
Date: Sat, 3 Feb 2018 06:18:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/67] 4.4.115-stable review
Message-ID: <20180203051846.GD1329@kroah.com>
References: <20180202140815.091718203@linuxfoundation.org>
 <20180202184021.GA22245@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202184021.GA22245@flashbox>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 11:40:21AM -0700, Nathan Chancellor wrote:
> On Fri, Feb 02, 2018 at 05:57:29PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.115 release.
> > There are 67 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb  4 14:07:31 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.115-rc1.gz
> > or in the git tree and branch at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> >
> 
> Merged, compiled, and flashed onto my Pixel 2 XL.
> 
> One minor conflict in drivers/usb/gadget/function/f_fs.c since commit
> d567071acc75 ("usb: f_fs: Prevent gadget unbind if it is already
> unbound") is already present in a different form.
> 
> No initial issues noticed in general usage or dmesg.
> 
> Reference trees for other Android users:
> https://github.com/android-linux-stable

Great, thanks for testing and letting me know.

greg k-h
