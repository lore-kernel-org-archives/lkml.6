Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763410-1523031934-5-17544954573328895629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523031934; b=Ee1NQYbJLksUGfM3kCu7dixGJTlG1lTijNPCyhV0hVFxIX80+o
    uibigdZfcwRCpCK0V3HIAaulY10KzYSZThkpYN7WmyiYDDlOPxDyIGG7b9+L6iEE
    /ePw2cqlinR4MU7G+OghYtIavyWHzGXRlJ6Mey7LiSrSgu2a3MGJE1bkiOCPMaxR
    1YAQgWergEpr3ABicfFxECcj96Ww4y7PZpTUpEGdNFT6Xi+soabGItebHU2wpi6K
    rbFx2U1Hni4XWc8Hs3g74r3yX5ZWTQSJjPdTsPr1AQEWsYAFFF3bxo+k1DQYURHh
    EQ212tW5sN9BcrdxcpkxIPD8lxqDLV9khWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523031934; bh=OO+DDvQNKUYQI2eUIpIKzxxE6dSydC
    XWlPSmay2LB/U=; b=u2JhfVaWNHa8988PdBdt+ymREhwQBuCD4jac8nRgmg47RF
    zSthiEivsJgD9/0HTx4EjzRsP2IzzFbyUd+aLJL2stOdHExl6m0oeM7W2eaKwd14
    XjG1Zih+XOklcZUoCStb37zg8AVtiyDkcevrCimP/Ufs/ZwP/9Wr6W2pym3AdWAi
    00WJjT24gcUAMKy4RhPPEExZwaAY1WXHyyzUota9lO1RNt3lz7m5wUNPcj77XWhD
    BUZQ8RAuAXzOyaojlnmpoYEpR+uzLXSl74et0WvikvTjUABYMbO/U2QQxoQrWANl
    kpOiIh1lQWNzl9Yq9Gf+Q+1BjZ8ivdi+2+EKIzrQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qK+/+CQw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q8aF33rY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qK+/+CQw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q8aF33rY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHO9rRIYDUFl5QTrXIwDJEVrZTjM/o3UPz/xSoYpbwe8B1zPCYuuN5QnltBUO/sniJkRQBMZHX/gPFK2VvvNKYLxRR2F15LaaT6kzGCHMfP/fLg9z7mV
    r4lNPgHZ/BG8uZ+gX/HIImqEbQYPq+PDl9vq69O3e07xMk5AA7vfZaLKbor3iPiq4wDG8bNf6hItDPwo7DAZKyuX5+2nxbh8KeLExVFvPPtqgLQqNBUaMwee
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=vY_346TuTMEA:10 a=cDkPDwh1C9UA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=HoHkmTO8MvEsbZn3U1EA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeDFQZd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 12:25:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46364 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeDFQZc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 12:25:32 -0400
X-Google-Smtp-Source: AIpwx4/GT1WgzzIlDCE/THegQx7uKRCbXYJMEoih6jS3wWzYfCDuc9DkPhCvIEv1kzyJTmCjFqEopg==
Date: Fri, 6 Apr 2018 09:25:27 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/72] 4.4.127-stable review
Message-ID: <20180406162527.GA11358@localhost>
References: <20180406084305.210085169@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 03:23:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.127 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr  8 08:42:48 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.127-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and flashed on my Pixel 2 XL and OnePlus 5.

No issues noticed in general usage or dmesg (I've been running the queue
over the past few days to stay on top of any issues).

Thanks!
Nathan
