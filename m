Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1500788-1519993369-2-18148131456428607211
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519993369; b=HysH2unGOxxL98c2fEzBluaouYw7Qpc+qQtHuUPLcmfhGwC
    TBlQHN1Z3RZWHo2ytwQFTPIrc89Erzzak/M8hegbrfR170anpngyOAkaLUhNmmUq
    gVG64yr2XU3pquwywJAQiyvglRR2rrOS/uxv9jA8xkDrsHxD/e4uB+tO28Kuy3pl
    tNs4IluK8MSVc4ezozmcmfglKxgkfVw6Uwp0HZt8R0EhV58hWzO4lwjY07AQjPm0
    f2Tgnx7fp1HLDTAQ0uEZNe6oWx2hTzQbepXdIKdRuZP6yaqz0O33kO7bGHM7lTOz
    A5U5o8Xktso5cgAgJgKrghgO4qT04qPvSFND7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519993369; bh=2wiG+gihk1ujpcw15Z9iW2vKWW
    CWiIZ38uVd5xiVt3w=; b=wxWm8RNPX7SFaLJKl/2YSvhyFoaSo7mty/l4vNhkZH
    kV1tJFVHsyvdABdpfou9gzbwwJK+rweKOXGsjdA8wv5cb+VlLc2idcF5+/XExkUI
    1nLsdXACks0RCiVIFhCRw3TPNzuSQCu9D2APFaSqv6vxY289evFsNcTzadkavvXN
    Soe6zcbfi35RaOarFAGOQeRKP4Fg1olLfoMhhFbvh7MFWQYrzG6vpLheLshFRcHo
    aCQp2x+LPs9b6udHdP5VhpnPEgs1so7BLxxeXQK3mjClYObB/nPPFx7E9jkZ02S9
    eKwuThILHAFxIOjlJh/jWxW/iIzeT0GD2ZaXwkENSuAg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Q2pTnaZ6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hU6ibPPF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Q2pTnaZ6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hU6ibPPF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427549AbeCBMWq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 07:22:46 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35486 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423721AbeCBMWo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 07:22:44 -0500
X-Google-Smtp-Source: AG47ELvkqgM8FRzTMJuYHvdc8uhqAsMDZ/z0NUV4+UnwGP8owyTIYaCpfmBSnGpVWF4UaDnMulr/Lw==
Date: Fri, 2 Mar 2018 05:22:38 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/34] 4.4.120-stable review
Message-ID: <20180302122238.GA8345@flashbox>
References: <20180302084435.842679610@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 09:50:56AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.120 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar  4 08:44:20 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.120-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>

Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
