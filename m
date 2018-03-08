Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2594629-1520533372-2-11915761179847847277
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520533370; b=GONirNLUY1V8ugNVIHs/1n8RkZURC2wtaZ5tEJpDS4AopEI
    Ufa4POztQ9Qk4X3inI30aayoh4QuApetm2RzRsT+z4tfPmb8VNLGhx3iE/3dNUrJ
    aCqdpgIotEfw2AA0wuZMC4twGAJPPtJwvYpTADXteRhOUuynPHfcf6K48eplGMsn
    KAlxoGvlKoTn/XAa2mMBolFlSNLCj4akFXaPibbYYBXw/LqT/3S0xFshhGoiE8AJ
    JhVfVwRgUIaU6L+sBwJWox9L2GBEBhPu6tG2A5T+BgfoanvyYcMaj85U5xG4sRL7
    fFoE0Ng0Q1YZaHi+mntnSqYhppbImJsERLGARNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520533370; bh=+ByQNG9cK2eG/NfEPdQ2O+otGi
    yuk5xMW9HTLcaXbJ4=; b=bRR/Enh+rTHlPWkth7/MUN6lTsU3aNtxP6gBOpTd1H
    INQlZqNYk89Q04OOBDhV/rf9Kk71SHXv2gmsGWaOZhK3L5OUYhffSJZ6O1qjdc04
    sCEyWIOSO666kdrlYAtghoMFoC/tBb77zXDYB0ugoI8+t6dhkZR6q9ZKTEvav8bj
    5JZTBiNHQtXGCAtpepT/nVUtO1bgBicSCd7bxanG6J4xBIVlZyWxMjtRRnMxJME7
    8BTTL8lm5OpxorpBG+9Va5VZ17BDmjDnmdZb80dqaZrvqHx3GKs/ecnvQalQArjD
    dtYLPsW+lv0uFD10DHmqZghxl4Sdutq/seylYxhFBRqg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=R4tCNak2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=R4tCNak2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756144AbeCHSWm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 13:22:42 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:50438 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeCHSWj (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 13:22:39 -0500
Date: Thu, 8 Mar 2018 12:22:38 -0600
From: Bin Liu <b-liu@ti.com>
To: Merlijn Wajer <merlijn@wizzup.org>
CC: <ivo.g.dimitrov.75@gmail.com>, <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: musb: Fix external abort in musb_remove
Message-ID: <20180308182238.GI14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Merlijn Wajer <merlijn@wizzup.org>, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308093121.11943-1-merlijn@wizzup.org>
 <20180308164613.GH14921@uda0271908>
 <1b280405-5af6-ef64-f8a2-cc8865487e0a@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1b280405-5af6-ef64-f8a2-cc8865487e0a@wizzup.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 07:00:16PM +0100, Merlijn Wajer wrote:
> Hi,
> 
> On 08/03/18 17:46, Bin Liu wrote:
> 
> 
> > No need to flush, the work is already cancelled at this point.
> > 
> >> +
> >>  	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> >> +	musb_platform_exit(musb);
> > 
> > This can be move down to out side of holding the spinlock,
> > 
> >>  	spin_unlock_irqrestore(&musb->lock, flags);
> > 
> > to here.
> 
> Thank you - with I've verified that it works with these changes. I'm
> surprised, because I believe that I had tried this already. I must have
> missed a step in my testing-routine.
> 
> I will send a patch shortly.

Thank you for fixing this up.

Regards,
-Bin.
