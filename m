Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1884642-1522361303-2-11148216390445258299
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522361302; b=iobmjV7g4jLdJq4psIymj5huDp/1aDm0k5O5e3L0sjKERnLXl5
    uspvA+6U4g4LZfdlKUDDBMpkq6AINHPjN0fjX8hj7ABdzhRCwOznTnsN962zxVhT
    TueLJy1vXe73+hb8JBXPZP6zgngb5kmyJj4qyEQlZrW4fFV7Iy0qwqwjZJ3UinPv
    DhUN18NRx/r4O8ADfC5bC4ki4PY+hw2KW83DLtVym/iOjp7+dGgSfb9whIRjgYGg
    iVOMkb+t+/TII51X/Xke79r/n/S7Cble05ZAR6FZn/kIDyhXgLnWZSL+x6Ksn0o8
    HUvS+p/sCZifDe8jxQEEhHs5ncy29kv5zoIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522361302; bh=R2mXx7lgcpzVRavGJSbE7i1+vKkYUS
    dZAqFXWTjC+7c=; b=dJDgYdl0PkYIbeu+mRmePlvH4uJaTz8/EYxzcQYjoYOSLe
    WK2XdcCrj8TaGmf+t1G7axucT2//B/qaclsXYm6AjrL5HCQQl8kJAZrsX/seczHz
    74Gk+tEPNWxbTZW/WNsFe5F1/chaBX7qVvrfBRLX5JD6M66PjMnEQLQR4HMEAeh4
    dJXwCXn/SqKPtxIo+zA0rfZeW8RVsP3BbzCuzqmWgIzZ5uZvI8UtNt/yJHWX4QJy
    58HlpJA3kXBtJsEMkqE6+dYKWXksCJNuDCzRImJ4ZUCRm7a0St/R/67w9g+lmBwp
    EamwZ6hi9x7QKub34pdZiS6AYMc4LeOF05NZsySg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lqjEBFeV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qaB6IvqQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=lqjEBFeV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qaB6IvqQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAgJ9kLesHfJT3VDe64D6JVALkFBt9VKydVBIGh7CUTgWGIIGOUSx+VM3emaenatDg6yu3lKXckoGJp2nYZgTebhPqLhg//cSaZEYSxTBCUDDahy0LlJ
    SceAUN/wykHEywKarBljkpYhQalPggrnyKAKEl9EYg4FtM5WOa/JrbIjUR1yE0jCMs11J7U8ut/fBmj146hQx9dF6KRq37hih/mxDvpMM47RFHDbVyeRLJyf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=toPVVLyrJj4A:10
    a=v2DPQv5-lfwA:10 a=U0zfkUukAAAA:8 a=VwQbUJbxAAAA:8 a=Pybxfbv0walMmDmpvIYA:9
    a=CjuIK1q_8ugA:10 a=rdti5zajfK0A:10 a=rXRU1dkEVDZ1dOovDhQH:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeC2WIV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 18:08:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40173 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeC2WIT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 18:08:19 -0400
X-Google-Smtp-Source: AIpwx4//lJiUaWoO8JWklOZaR5e5kJAJUKxVvIOnpDG+k0Tyfg+CLkLFLwOIsqB3H4RCmfjNOMlzMg==
Date: Thu, 29 Mar 2018 15:08:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "kernelci.org bot" <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/28] 4.9.92-stable review
Message-ID: <20180329220817.GC5526@roeck-us.net>
References: <20180329175733.447823703@linuxfoundation.org>
 <5abd622e.5b88df0a.be1c9.da43@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5abd622e.5b88df0a.be1c9.da43@mx.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 03:01:18PM -0700, kernelci.org bot wrote:
> stable-rc/linux-4.9.y boot: 122 boots: 1 failed, 104 passed with 14 offline, 3 untried/unknown (v4.9.91-29-gcdf42b7a5c27)
> 
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.9.y/kernel/v4.9.91-29-gcdf42b7a5c27/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y/kernel/v4.9.91-29-gcdf42b7a5c27/
> 
> Tree: stable-rc
> Branch: linux-4.9.y
> Git Describe: v4.9.91-29-gcdf42b7a5c27
> Git Commit: cdf42b7a5c277bc4a4dd0853f6e2155a3ead8b02
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 63 unique boards, 22 SoC families, 19 builds out of 183
> 
> Boot Regressions Detected:
> 
> arm:
> 
>     multi_v7_defconfig:
>         sun8i-a33-sinlinx-sina33:
>             lab-free-electrons: new failure (last pass: v4.9.91)
> 

This is an actual crash.

> Boot Failure Detected:
> 
> arm:
> 
>     multi_v7_defconfig
>         sun8i-a33-sinlinx-sina33: 1 failed lab
> 
> Offline Platforms:
> 
> arm:
> 
>     sunxi_defconfig:
>         sun5i-r8-chip: 1 offline lab
>         sun7i-a20-cubietruck: 1 offline lab
> 
>     multi_v7_defconfig:
>         exynos5410-odroidxu: 1 offline lab
>         exynos5800-peach-pi: 1 offline lab
>         sun5i-r8-chip: 1 offline lab
>         sun7i-a20-cubietruck: 1 offline lab
>         tegra20-iris-512: 1 offline lab
>         tegra30-beaver: 1 offline lab
> 
>     exynos_defconfig:
>         exynos5410-odroidxu: 1 offline lab
>         exynos5800-peach-pi: 1 offline lab
> 
>     davinci_all_defconfig:
>         dm365evm,legacy: 1 offline lab
> 
>     tegra_defconfig:
>         tegra20-iris-512: 1 offline lab
>         tegra30-beaver: 1 offline lab
> 
> arm64:
> 
>     defconfig:
>         meson-gxbb-odroidc2: 1 offline lab
> 
> ---
> For more info write to <info@kernelci.org>
