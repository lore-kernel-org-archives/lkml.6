Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1111413-1524077798-2-10743108091335559788
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
    1524077798; b=KPMMzG7l/rYZObs6wl4SHfcSzp1l3NKMc5GrJCrfsdiij8EcIl
    wx0NPYGup+UeOctuhZEsfdjxI0CIFtRMp1dNZhCVJUtbS1DlY1QlIU1IiXlcgwro
    WJ26qnLoTAne41/oZAvkTlQbjLncKMIK9yXg8YN7xFbFD41yfOMgeQIe0IrGnf+7
    Dslz6vzcZqeLws7JVFUzxRDLtwFHxxBHm9TezWxagyUuKIRzZE78QsaMBbwOkxOm
    KixKjDLbufIBJXUY/zLwQPaId1gk+zMH7Txu6GaQqzUae+fjPJQ46k8vo8gVALNM
    gGZY6PNdCbUUCwVaZTAtVkwvH3dmSEJMj3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524077798; bh=GG4s6WzdU/fJN8dqlJVGAzpfHyIy9L
    m57ERI2xoQOUE=; b=Rao+WGZrttNjDMxiYWyE3SIER978kQk2u1I9Hb2WXttSgG
    lYm3dzA6mpal8jfgY7nk0A+qXSTkR109rkdXoWAiwvC2lISBI/HBaKxcKEXejxAn
    bHaqkv19XyHR4Hnh0qGCq+8lu6+MhsZ6eHJV8mN21AEpr75AKCdWz+L7pU+giny/
    flWvJWIxeuaX0TSqd1+eyK5MOqGyBRGrMoq0n4+it24J6+c1J1Bu6KmfNJRG/L4h
    LMNU8TtrJGyRRvnP9S4m5cKtccPN0Wpv1siP9p4iPqKECYA7YCg5xjSHZRGufWQ7
    m47VMMoAYRqg0iF1CsIwOecq1ylep5iBVYZLUVNg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=Nqj1K6ef x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=Nqj1K6ef x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfON1F7GzhXR0vl563/4D3paeyB+qkilC8NQLe9x1osUOjjQ6I3volsKVay9fZLODbVRgbomCNORQULONXAit3+yRG+6bQyiUG5PVp46wgvChgp2qDHLa
    Paqwq6gO1KnAnZsdmxdE4kL97ZIcbwXB9jkqD9/oLkg3oo3lG3/XqskNjDesoQLcI6L7LTLIzghVfgOd3mjXLH5rSLZHAf8Kax69vpETXW2lCPSuNB3jBLUX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=GwAWpPUdmLjKtX7SCcEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeDRS4X (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 14:56:23 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:65375 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeDRS4W (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 18 Apr 2018 14:56:22 -0400
Date: Wed, 18 Apr 2018 13:56:13 -0500
From: Bin Liu <b-liu@ti.com>
To: Johan Hovold <johan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] USB: musb: dsps: phy fix and DT-topology support
Message-ID: <20180418185613.GH14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180413151505.32663-1-johan@kernel.org>
 <20180418162015.GG14921@uda0271908>
 <20180418184640.GJ9198@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180418184640.GJ9198@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 08:46:40PM +0200, Johan Hovold wrote:
> On Wed, Apr 18, 2018 at 11:20:15AM -0500, Bin Liu wrote:
> > Johan,
> > 
> > On Fri, Apr 13, 2018 at 05:15:02PM +0200, Johan Hovold wrote:
> > > I've been carrying a patch out-of-tree since my work on improving the
> > > USB device-tree support which is needed to be able to describe USB
> > > topologies for musb based controllers.
> > > 
> > > This patch, which associates the platform controller device with the
> > > glue device device-tree node, did not play well with the recent changes
> > > which added generic phy support to USB core however.
> > > 
> > > Like the recent dwc2 regression fixed by Arnd after the device-tree
> > > #phy-cell changes, the generic phy code in USB core can now also fail
> > > indefinitly with -EPROBE_DEFER when the controller uses a legacy USB
> > > phy.
> > > 
> > > The second patch addresses this for musb, which handles its own (legacy
> > > and generic) phys, but something more may possibly now be needed for
> > > other platforms with legacy phys.
> > > 
> > > In the process of debugging this, I stumbled over another issue which
> > > caused the dsps legacy phy init two be called twice on every probe and
> > > which is fixed by the first patch.
> > > 
> > > Johan
> > > 
> > > 
> > > Johan Hovold (3):
> > >   USB: musb: dsps: drop duplicate phy initialisation
> > >   USB: musb: host: prevent core phy initialisation
> > 
> > Are the two bugs only affecting you with your out-of-tree patch? It
> > seems don't have any functional impact for me. I need to make a decision
> > if these two patches need to go to the stable trees...
> 
> The first bug is independent of the third patch (the "out-of-tree"
> patch), but as Uwe also noted it seems to be mostly benign since it took
> two years for it to be discovered. For that reason, and to minimise the
> risk of any stable regressions, I did not mark it for stable.
> 
> The second fix is really only needed with the third of_node patch since
> I don't think any of the glue drivers propagates the device-tree node in
> this way currently. Hence it could also wait for 3.18, and it is in any
> case not stable material as the generic-phy support in USB core is new
> in 3.17.

Great, thanks for confirming. I will not send them for stable trees.

> 
> Note that other host controllers may have a device-tree node with
> associated legacy-phys however and that this could now lead to similar
> problems starting with 3.17.

regards,
-Bin.

