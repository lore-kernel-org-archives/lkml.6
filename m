Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-808778-1524068442-2-13189251058471103476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524068442; b=nF8bSk6MFlFz6Clu5sijUSatgzqJhZAwpqMddMp8uuGiFiDjqQ
    Ji+kJWnmVxt6Hla0oh7UfB2EACzXShWXhsvdGqMEFuHTo1x0QXQVrnmD2ck090A2
    3j+iXYIfE1eFgnhfpx0qrnsdkW6VqTn7peN0anvPJSy27f7jGy00ZB/0RTDtYysI
    Ws4+Lna/CuwGVnooQH2BFYIANTIXPDKlP1xJ7kB2GX9VmBYfN7fU05pdHiZEK9Wv
    xuz8qRzet1sow4DWzpNlDNqwRchJsiVk4ly16OLal0k4kGoNfauyu/bK/LyCSK1N
    Z23WxIjfvQwLkqyHUFRgQtb1cRzm6dvXRU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524068442; bh=QyeZUkgjSwCwnyf/1leVq2/pr9eu1q
    7Ut9JmtblzFhM=; b=U6kBR/yoPGO0kilWd5bsA1m4iRQGZ8A7VRx7UTaT4efwBA
    wiBAlHfrXTC0LByVnJx64Ivfa9vruxO7kx+WmAT3UnpJrODmazYwBAloEaQK3PPp
    jwgkvOAqlWMH5VM5hrXDxaF5ij6kFkBbBVRYFVZqJ4VqHAdCfdRVzUedC/fvfuFw
    vjtozzV5ORduuKHDhcA9oXbUQMOAkniBMPJUtE8Z+ADgunx0P2PVJQZANgJQBC0G
    55N+NxjoU65pgekwIOr7elZqaT9ZwxDQpX1Vk6+DId3S2K9E5DlFEXPidoKQDtEN
    xhjatAdHQqNf6iPHYCFkTwrYD/SxSqxMSAZudWRA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=IiyRKqn5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=IiyRKqn5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK+pPu/G7nktyxBfOO4dJ+pyTkHrTU0TjxYjm73tZMEdWMHHNCdrdpw6wJnrPE2oT7lU2w1cHWhqL+EPe/JR+daXGQKsTql3P/zcIqQvfSE4NCFGg6ny
    kQsuPxImYbkwEESaMTau5uYUzBMoEwTSGdzxSPGWauvblIe/Jh+I0Kges7XZM/YtXrD+wmGMpCra8uvnO6nDBCGVl9pZS6T1pRQP3GCPaGJ3w9D9z4ni5DWR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=mPnVraxuRPR7U-h1wg4A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeDRQU1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 12:20:27 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:37231 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeDRQU0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 18 Apr 2018 12:20:26 -0400
Date: Wed, 18 Apr 2018 11:20:15 -0500
From: Bin Liu <b-liu@ti.com>
To: Johan Hovold <johan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] USB: musb: dsps: phy fix and DT-topology support
Message-ID: <20180418162015.GG14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180413151505.32663-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180413151505.32663-1-johan@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Johan,

On Fri, Apr 13, 2018 at 05:15:02PM +0200, Johan Hovold wrote:
> I've been carrying a patch out-of-tree since my work on improving the
> USB device-tree support which is needed to be able to describe USB
> topologies for musb based controllers.
> 
> This patch, which associates the platform controller device with the
> glue device device-tree node, did not play well with the recent changes
> which added generic phy support to USB core however.
> 
> Like the recent dwc2 regression fixed by Arnd after the device-tree
> #phy-cell changes, the generic phy code in USB core can now also fail
> indefinitly with -EPROBE_DEFER when the controller uses a legacy USB
> phy.
> 
> The second patch addresses this for musb, which handles its own (legacy
> and generic) phys, but something more may possibly now be needed for
> other platforms with legacy phys.
> 
> In the process of debugging this, I stumbled over another issue which
> caused the dsps legacy phy init two be called twice on every probe and
> which is fixed by the first patch.
> 
> Johan
> 
> 
> Johan Hovold (3):
>   USB: musb: dsps: drop duplicate phy initialisation
>   USB: musb: host: prevent core phy initialisation

Are the two bugs only affecting you with your out-of-tree patch? It
seems don't have any functional impact for me. I need to make a decision
if these two patches need to go to the stable trees...

Regards,
-Bin.
