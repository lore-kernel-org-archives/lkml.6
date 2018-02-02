Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114275-1517596899-2-2665202438337182336
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517596898; b=ZgAf4ks6xs2tHEJKYXIFNw7u88k+MRBNKWs5edgoNPpmM38
    Ba/IShCILkVHDmIZUbdLxqK+F2b0IR7y3iwO+Ks8zkPNKru/zFrd5CH76ET81EvC
    ypFiUcyvjG7R+fQGoeyRtDqmef4wkFtT5Xk1LJ3RRiUG08wsRIrdW8ys876KjGk0
    ifIJrqIgxYAcUFqVp2fMYpT962LvaItXn4f+pO9hFJfvoIHzwsE0t7nQY5n/LQJ1
    DC/84LuCh7OyL+ptv6MaxOIvlISgBoWNO7dpV2rd2CtaEH2WYwTwQ3K+Hx5eerua
    jIZaA3pgxWN1KENeEC91oePhpxROcQPOANrum/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517596898; bh=MzalfIHyWDiGV5RJtRR/PmCe73
    cknIIWGi+qIEatsro=; b=EOAd33Dy969eMPuIe4oPSUYyOMB6EVikBObHH8tWUk
    kQ7jBQx+gnJkb+YtLY/60yoHDFTgth7VnYKrgdUmv++qIVKaHxKOnhjYnv460O2K
    GDzkIhMn9gHEL36G9TdD6don4OCp/ajmNm+zyXqWTa4Qy8MfZwMzhCsS1NwjQVaN
    Yvm9K3fp38zM1HUpvznSy8ysr+Ge1cmI2fyXEuLn44z5EOhNoSwfbtAQt9FAjgnt
    vPVCe67Q2QUmnq/upX9tHp6N1wSZas9qrmq4YuAniOjvX+l7F8YABaLgpH/rD2+b
    /LROlEaqAD8rI+jiG1chQoWxP8z5Oj+n82wYdqrC4Pkw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NMLh7EOD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=INKRQ18q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NMLh7EOD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=INKRQ18q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbeBBSlZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 13:41:25 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36070 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755149AbeBBSkZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 13:40:25 -0500
X-Google-Smtp-Source: AH8x225it5KxuKk449NvCRq9EHA62D2BNS1voJNAIZM9fHljBv6RD3luuDXhyeXFLS8vG81V1NiA7g==
Date: Fri, 2 Feb 2018 11:40:21 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/67] 4.4.115-stable review
Message-ID: <20180202184021.GA22245@flashbox>
References: <20180202140815.091718203@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 05:57:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.115 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb  4 14:07:31 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.115-rc1.gz
> or in the git tree and branch at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>

Merged, compiled, and flashed onto my Pixel 2 XL.

One minor conflict in drivers/usb/gadget/function/f_fs.c since commit
d567071acc75 ("usb: f_fs: Prevent gadget unbind if it is already
unbound") is already present in a different form.

No initial issues noticed in general usage or dmesg.

Reference trees for other Android users:
https://github.com/android-linux-stable

Thanks!
Nathan
