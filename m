Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2078400-1527172892-2-3845829283116497900
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
    1527172892; b=i95j7puq7uAr5tRz4HfcEjQfoNJl8Jl8RJzndXvIGk364dAe7k
    cigOChBem2umIIL3AwICVLaNVtY2crz2SrT9OCLlP+28JuQUW3/0pnKXKmiY/5u7
    JoyQj0oZoKw64YPCarByR5o9mC0XvGsCuOd9NVcicJO821WPr/TveZJAnWQsBIf2
    lzLQTMZBVCFiR06CaRcKtg7yLCW5y9spvOxiWfUVaedkyQazhkfy12MmURh+9/mY
    eZaFrCeyZCcRTw/r0VFBq/K2dZJY+ICoNDoREpPRmuMLUy7cShT6exlU0D7+4+ge
    Ivsc65ljj8T1JuzbbV+osrx/CMF2VcFhIopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527172892; bh=NoI/aX+892wfkCDaZHhKCZj46LuCGM
    I2QUjDxk8UdOA=; b=TN6awXbU3aDCFIkIwvo4kmOjocbY5LbPbKWUL7U5yEgC1a
    /hM+fL4UW8Qb0pSrM1H9VVaHBKgxyhJnkWQFHbTaum3M/6OrN9Qm4Ileu3CkaLVU
    oK3disOaVrryy4cXE9IfiGDdDlwn5Z2+WVrKjmQrnbgfxm6pkXSabuRRcER7Hd2p
    azuSknhQ/ntBmBw9v40giSRCI49DjEtuMa0BSTPU0UV1z0V3vXkLAgSotVYFlUmv
    tUlgSGKdOMGWkmn4nAXIK/uSqQ8pbHO2BMlhzjJBm+t4ytwvc/rjBb3ZAc/mKqeo
    Xl0njde6JGqAwFa0VvvhiZ2PZyHCNwbBRYtSRojw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=m4xjV6fO x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=duaibHOY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=m4xjV6fO x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=duaibHOY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOdrQP+PlSHkO2LEw4SXzyzh9ObmtRGudBb4MZ2Un7ZZyG295VrOJyUg1JoLaie7Z+dhSTKFwXzeZOD7ETZSwaiSVjTeXORL9H2xi8HSKSu8unmFXk1O
    HruvE3Bs23sKI6oYCX1DCEqSNkVO/dcXQQHs5G1bKIqiIZxTA8tqhTecyNLSGXNn6zy1Fffo3D28g3AVx34Wu+gb0gWQVaCZetUQH4lznbdydRRSr9Q2a8kw
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=MQJW2e49u_IA:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=Siu4zqdh0esk7Uw435MA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965805AbeEXOla (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 10:41:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37283 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965438AbeEXOl3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 10:41:29 -0400
X-Google-Smtp-Source: AB8JxZq+n/GPJ7Ll/SOMSp8YVUF4QuMmVdzw+rgIUM9eKCuR6zo8VZ+mY9wMYXGxyKsGn1kZyNlifg==
Date: Thu, 24 May 2018 07:42:05 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/45] 3.18.110-stable review
Message-ID: <20180524144205.GA9229@flashbox>
References: <20180524093120.599252450@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 11:38:08AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.110 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:30:59 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.110-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed on my Pixel XL.

No issues noticed in dmesg or general usage.

Thanks!
Nathan
