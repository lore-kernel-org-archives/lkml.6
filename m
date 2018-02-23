Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4092716-1519427612-2-8107639382331631961
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519427611; b=Yh8ArJpX6s01oWepWY7lIGukI/YcymU2IOs168QQ3Knyo8p
    ZRaST2PfRxu3BQ8NU1dlDALugKMW2aP0fb9DxJ8xO3wSV4sfFbJk+rDhKGFnrV/k
    CZSiLUK4DBEB0B+Oyrlg6hpSn9jeLlI/aSvDPioXd6V6pIAbrL1KRW+56Uvelj8Z
    LAH+KW0Y3REUosy2P718moe94CCVrIkFvfM2tke1BMr+V+JCHQB2GQJdAborZzHY
    p+gW1RSse2EZ0g9kQPVpOWsTgugsjKKgWzv1nOsXmvNivPh003DwhigRY3XTIVTG
    A454ZC9c1mCraWMvVB+3bij9netjyp1tnfzCy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519427611; bh=0oNPKtApJHiXGbavZmYCoamQxg
    ZGkx/hCBPJkVDjZ3o=; b=fDxzPT1R6D5Co/IkePYbaYLDq3aARgujMWmcLX5AMU
    c7Tx4hGjysgXncg4wJPzhkVb1T0vEMcinRGLPcDZCAMZOfGv2FAK4n2E3CqGiIYy
    5RcYPKRONKyp2amVRDQOaBbU0APng7PhOP451c3sbrYZfSbYRV1rtJ78ZJ0DojEC
    zRTAoW8JWQgd9Yt6BDUBGayS1ZRrn0TsU6oy4mmfcVzxEip+u6Etkk6vO/9bbxXv
    rG2RrNsf3Zh7KXrupYrQeS9BYosMJV7fWzBi48IBeZvFuZvZh09KsqwALl7UvUjC
    n9dPy6pSDeLoIgHjru90/eXYy2/fqyxmuoDW0McRP7qA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aS4GDzWM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eTbQ4EOO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aS4GDzWM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eTbQ4EOO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeBWXNa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 18:13:30 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51656 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbeBWXN3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 18:13:29 -0500
X-Google-Smtp-Source: AG47ELuu5KpfvEK/jZTBCjbnrX/9etjRB9ohfInADelC9lt8YLrZ0JrAlA635maJwGYG9cpiWGMMIA==
Date: Fri, 23 Feb 2018 16:13:26 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/193] 4.4.118-stable review
Message-ID: <20180223231326.GB30215@flashbox>
References: <20180223170325.997716448@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 07:23:53PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.118 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:02:20 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>

Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.

No immediate issues in either dmesg or general usage.

Thanks!
Nathan
