Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1111767-1524679692-2-12160146910184837143
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524679691; b=awemD9nzzPp73n6/io4PCyBqS1YpOfBlcKjzhsvhWRAhFplGPg
    2ArYltjVjOtSP2tcaIImuR8JDJsRQahB4Vt2vpIBk4uzFbshRFHKYMqxOvPEyJbf
    oYoWfaCHWNqQgB4cN49tz5IuHUMDJVZRRKCMgg95tZoiOk9LiuiGxRLD5KYfQuxf
    Jq9NFZkUs+jhEFzOqM5lNNOGDgBZ5NJzloIethJgzEe5DHJ7Ajd0xkXZ+fETheQN
    uPQXVv/iAX67vZyvdAakIQaTPes4LogMv1KO9z6taLN/ZVA1c6PJzCGUyXc0zkYK
    YVtMPPebRzzLOSGxgh0kuqWbi1LrWPQwkJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524679691; bh=DNyIjteB9pjLSm7j7XwuUeJdOr5DIZ
    St1ayk/BuqceQ=; b=fO+2VgOplbhKEuAEl5nk+mVSanqLfTETRksHOZW5H2bOpC
    01kNybyuJv/iqZFtAoT37Oi/ojU3plCktR8rDIPRN+Ir5WnqwI2j6aYh3SQuK+XI
    VPn2zQjI1C1VwknNqVR9/7Hu6g8opRizt+0HhCPif79zo/rtZ0dDOWZGjYDk3qYO
    r0IBBCX0jm4vYWjkCb7deqWUIuriGL+uhHGGXflwKXw03wTpOmSJAZdxZnrOLU/f
    HtBDl5eHyDMfI0ibtrVEVFINlLttFUw6uZVJn1XAqwm+/FtqHehcCSAfOX9ChDhL
    1ZDHFuvuQ9c3eVw74dw9/UCV1Nq37XyVTUPJBvdQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FhM69uRN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KoBWPa0D;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FhM69uRN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KoBWPa0D;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNYqr0UgzZluWMa/whGJuNbiV84p05225pIa4tjzzDrXnwYc+UPi7tFRGUiTz7772KgJ4JO0W/lWpXB7YOLKoIdo0oCrdt+susEMmV4awQ+QhGy1I8Mc
    HcnhInXuP7VPo4Il/bijekWfAwEEGbtDiWeyNxWfJsXQOQN8zitPkWX1QzSk16odjDLMJtXNKw6THBQ6hf087jJ1B687kfT4TO/z3USDMj3Cx6OobE7+Mr+P
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=viYhoEuuK30A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=5Wpbb-9rleufo6DuS-gA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeDYSII (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 14:08:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39412 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeDYSII (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 14:08:08 -0400
X-Google-Smtp-Source: AIpwx49ohJpbSgJcwA/QmXj+qes5pgIvb64QmgmHcpLMUCfH42FpNiKMwm2q18SjZXki+Jx+Yumycg==
Date: Wed, 25 Apr 2018 11:08:09 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/183] 4.14.37-stable review
Message-ID: <20180425180809.GA16835@flashbox>
References: <20180425103242.532713678@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 12:33:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.37 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Apr 27 10:32:04 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.37-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and installed onto my Raspberry Pi 3.

No initial issues noticed in dmesg or general usage.

Thanks!
Nathan
