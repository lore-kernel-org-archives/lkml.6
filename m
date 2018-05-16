Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-526264-1526488777-2-5318632030085446743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526488777; b=CPDMrNqQvO7jCTGut2Q2QcIbfkDZcCMF3aMsuRHPrsH+K5PnH2
    c40VQtNDZnQWOqKgiMVdmvW8V6g/n5zkX9vg7sHaBpIc/0No+SF8qa1ev2sANJrm
    G7mLbM3iXXL5eVMuU1YVRRLzlAQJDYeLT8HHMyRZuQFKEC/G0wx0898o4zcs971K
    ybJobD7r8hUrANG4Al7eY+PWQNiJQskrUSAOu/rT8iW8juOY1tybXdrlFPHUPjcM
    2Ol5SU53x9z743qmWn0pqlHw2sVXL4QdISIWNnIfe0J8M+MDqTuwMLYEmVXLy9A9
    WUfRyCAaQZ2LTWMDqRSd/8FyItV4Me+ckRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526488777; bh=Jj3JAKv8pAWCdC9vk49jamMqRiysxk
    SFml97MOqmjus=; b=BxrbeHx4xE+BJbPSdfsAfB81o40VQ8kqafp4o/5jn9Kl2y
    nTs60Bvm2jbNaltQhwBMJ1gM7isRtgHCj2O3LHDnYiSpZRFCkZo9NYR9zqxKmAu/
    5ZZ0eN+dOL19QMwPkqkmdgMn/aif4pKMrRvhHfZRWyPSLMVnEy8Xp4vCiWUp+YkO
    mFHHkc70p0UYL7yI7p/nJXGaQDJENt1BTcjVABCDNypeCmE+uhNC4Mc9SfMBFvy7
    LRZJXfBzMZRfEERnwTRB806ZKgZMemdbl6OgGAwrisYV0pl9foDrpWqSN0Mz92Tz
    S6aGLAHPQfgLLhRFWcnQfu8SwV1UOPm3C4tgV23Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=messagingengine.com header.i=@messagingengine.com
    header.b=T63/ubBI x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=messagingengine.com header.i=@messagingengine.com
      header.b=T63/ubBI x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDtEKMDQzd/y8BT3xkRA3P/Lm4FKiKPYA5+M4jwyk1rm/e0neZLjtstW52edowQAT6mVDS+kqBE4Usj8RjsXzY6R/4B04Q0iIZplOUftpUiSNPQ4HK2M
    AgyW8aD3HoVs2csXPqclQjPajH072V2fYULUtRD4UUkW4dc8P0EgYcGRzwCcmlcClrsVEIm2pBaRzl4efxvhHuREF4pgMwizx1vX2V2ExfNlehcTYmCDAO/H
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=iLNU1ar6AAAA:8 a=VwQbUJbxAAAA:8 a=zLoA9V-_IBI5EWoYkqoA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbeEPQjX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 12:39:23 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39429 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750778AbeEPQjW (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 16 May 2018 12:39:22 -0400
X-ME-Proxy: <xmx:uV78WsQYJQC5uW197PTXN76EDO15DhG_c4CEuikdbH0okGwUvneWYw>
X-ME-Proxy: <xmx:uV78Wtticsy8wzzwk8C_5a51AgiSWDinmrOK4DaDxxneR8rMEx1dsw>
X-ME-Proxy: <xmx:uV78WuaPX-FkVeK1mhluTB-BWiQ_H5Zz3Sm72HcZysyg5OAOSAPd1A>
X-ME-Proxy: <xmx:uV78Wn_ypgIKivAd8crVyGtJ6m1oDR3x4rDogCsw0tuvTB7B-Ieh1g>
X-ME-Proxy: <xmx:uV78Wqq36uKqPflGCysGV8OJp3VjAVVte2mv14KrHzXqG8BI0LJh3Q>
X-ME-Proxy: <xmx:ul78WqnPxgSE5oEymeXBzeuHMv25XcuRxFSMO0fU6CQxtsdMOulM_Q>
X-ME-Sender: <xms:uV78WpaVpmyEx1y_I2njAgNCYBvJndYLipBhffRbcFTXzbrric4-6g>
Date: Wed, 16 May 2018 18:39:05 +0200
From: Greg KH <greg@kroah.com>
To: Mario.Limonciello@dell.com
Cc: heikki.krogerus@linux.intel.com, pmenzel+linux-usb@molgen.mpg.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Message-ID: <20180516163905.GE20425@kroah.com>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
 <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com>
 <20180516115814.GB11469@kuha.fi.intel.com>
 <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 04:13:31PM +0000, Mario.Limonciello@dell.com wrote:
> > > [1] When the power supply for the docking station is bigger than the
> > >     laptop's power supply, you begin to wonder what is in that thing and
> > >     stop using it after a while...
> 
> Mostly to satisfy letting the docking station work with beefier machines and
> still deliver power up to what USB PD will negotiate.
> I think they can actually run with smaller power supplies but you will need
> something "a little" bigger than regular system power supply to power the
> dock and system both.

Given the date of my docking station (2+ years old), I would be _amazed_
if it could do USB PD.  But I should go try it, my existing Dell laptop
doesn't support that, but I have an Acer here, along with some
chromebooks that do.

I guess I need to go get the latest Dell laptop, "just to test" with :)

thanks,

greg k-h
