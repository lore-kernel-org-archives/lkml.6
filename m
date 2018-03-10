Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1867236-1520644038-2-7150312202726770502
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520644037; b=OgWCsd0EwmrQNFJi2Fct4fBl8Jqsu+qYqo/XeeYHfaaBLK8
    C+ilpgEsPLgToQQnv79TbJkyP4W80t5dmtteHZyTf+p87zWqGK6x58hmDqjm1UgU
    9d32vk3WTTjmPUW7EvNBv1+wz9QqCEUq7wtfSLqW+CH1xQlj3bfMpjoHx3Ij+enq
    Zq2PddqTBauUbtV2bpiWJTNvXKM8rn30r6MRn/a0mpNzoEPpqV+tYB6l18nqjqEK
    Zy34iri8goO4j4eEGXVbjGGwf/GrqLX3hxvH772wo1ZNvDPG7RBKz1My7j3CpFUp
    dre3E6x5PH3Bwa+Eo8aN2Z0etCjuQIBFfbVgUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520644037; bh=R/vaVD0tNiwu7OL12HLZEJFqun
    lfAR02Sij6BNoiZAA=; b=nypaLe8CT7UFbpLjCUhrElJJzdOkPLrPBfWe3+AfbA
    52t/OSSZzrJIrqY0GG9rKc/fJC7lYlfOs3KUiQAIjbDAVAv/NN37GJzSgok9RvUM
    n4Fybd4nY7Vz2i7vrGZY5hFw2AvDPV4Q0HnDho+BSKdCYHkdaQ/zLF0guNI/gcJu
    YigUqMU2eaYvWSm4f53aJYK4jx9vVjvR929UDiCOrvtlSD0IB2LwNIJAF2rVgFtz
    2G1ANQPBWrQRM7OOK01nwgjX1vruO18351PWFqtE7BgFXaTxRdEgr5SssgV5+Qfb
    0iDDbBwsWIR6AHwEsRul0JR5c9VMEXjoJPYNT9FE05+Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BEVxUDl2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FXlTUYXv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BEVxUDl2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FXlTUYXv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932666AbeCJBHQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 20:07:16 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39468 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932223AbeCJBHQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 20:07:16 -0500
X-Google-Smtp-Source: AG47ELvJfWCtsZ1MffxyhYRWD0duMyCs/TGSHBgGKhrQOEGx3CdPwuEDw91yvDkbPISFO+bNyUpIhg==
Date: Fri, 9 Mar 2018 18:07:12 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/36] 4.4.121-stable review
Message-ID: <20180310010712.GA21961@flashbox>
References: <20180310001807.213987241@linuxfoundation.org>
 <20180310005035.GA21196@flashbox>
 <20180310010312.GA26120@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310010312.GA26120@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 05:03:12PM -0800, Greg Kroah-Hartman wrote:
> On Fri, Mar 09, 2018 at 05:50:35PM -0700, Nathan Chancellor wrote:
> > On Fri, Mar 09, 2018 at 04:18:16PM -0800, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.4.121 release.
> > > There are 36 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Mon Mar 12 00:17:54 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.121-rc1.gz
> > > or in the git tree and branch at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > >
> > 
> > Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.
> > 
> > No merge conflicts and no visible issues in dmesg or general usage.
> 
> That was fast, thanks!
> 
> greg k-h

I happened to run the stable queue since there was no RC when I decided
to build so the timing worked out!

Nathan
