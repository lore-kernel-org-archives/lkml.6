Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3060808-1525177565-2-17045101167452740795
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525177564; b=GFs+tKWItjPYvlFKFauVILjB8hdVSX1ZmXdT2A1nGCh3Z2muBs
    JW0BtuTnPKR32cgnvZ1YJgny48hyVlIdEXIMuAKqwCzWHf8QX8oeiIc9oc9QgEcp
    3hbUcJPYsSm3QZUZc05VPHk5Ui4YJkujgynqfxa2lZFqjL1jAN/2czxo9T5jDkI7
    jL6LqJzsKx15k5WuFXcGmKsgB+QwN2IP35EP0zmtOK0dXnr4n0VDaPIGjqeLVK0v
    drwuUFHkD1yREAAZXBarI8aCzehC3zMbFMRvQhXLv7Yv5oCpDP7+yTTOoNzyPBlY
    ydPRgJ5DPZ+IAl3gm7OiBKYg7tuqMe41urRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525177564; bh=fstFr6f3dbX
    IDFXdgNDwicFw6AFysTG8uxgVtcXbLnc=; b=Vc6odM+AlVm2DWMxfnOJWlK/igy
    E7g1m4pvLh7uWjyAr47Y7ih5N1T7n9X8FiHxuEegpcbjt7Yt/EkUSMtB0aNedb/o
    oGO78zkOIqHfZAY65RrByAh6Hcu2pzDYCkE6A5jOd0gi8EfOzxmqPe7jbmuJnNIl
    8lE6ZxsJ1BL3VFcgG4TTKFn8wCHeAUxJ38HaXXS5AfZxAqEmU4+KF5fW8IkAFr/S
    N/G5J8E6M0sEYdED+kpxhgCF0Zifl03UrTVsWUZaJPrNxcq4Afqo4gVOQ52gzZE9
    sVz6kWNio+arAINOCbh34BFW2OIL2otwlbrfrkI3FNuFcQu/8Qcua2UKOcA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=ti.com header.i=@ti.com header.b=NMNujenx x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=ti.com header.i=@ti.com header.b=NMNujenx x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
      header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFQ/fJgru5X564r3Ln47pO3Xf0QmvqLawV8EmvuecUlSKztPUBI+AithDij++n8WH7bmNMEEgI+69GB03J2HM6thQ7otBfdik9WK61md2ZXqExs03+RU
    qy7hm2lUw3Nu2p9Zyphra3ST0N1+gs7qX8Rl/9Jy5bnm1pRVCy5Oeh/6f85NptLtRIl5WM6cyo2q+H4BNhksBeV8Ny8KHy8sq6Kx9UNVtXkO4QTqHZvvGacm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=H15RgtuIrPfxKeBy5lUA:9 a=JGlBsGInkvCyc3Qw:21
    a=0fxTz4ci5Wlq5rnn:21 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755044AbeEAMZu (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 08:25:50 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:40620 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754827AbeEAMZt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 1 May 2018 08:25:49 -0400
Date: Tue, 1 May 2018 07:25:33 -0500
From: Bin Liu <b-liu@ti.com>
To: Paul Kocialkowski <contact@paulk.fr>
CC: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Message-ID: <20180501122533.GD21238@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>
References: <20180328215213.29538-1-contact@paulk.fr>
 <20180329092326.dayuccomq5zrywqo@flea>
 <1522324644.1746.19.camel@bootlin.com>
 <20180420142524.GB29011@uda0271908>
 <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
 <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
 <b24cf58d2f48519893a5051a98bee6579c5e0d98.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b24cf58d2f48519893a5051a98bee6579c5e0d98.camel@paulk.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 11:08:42PM +0200, Paul Kocialkowski wrote:
> Hi,
> 
> Le samedi 21 avril 2018 à 09:34 -0500, Bin Liu a écrit :
> > Okay, this came down to an argument that whether we should require
> > loading a gadget driver on a dual-role port to work in host mode,
> > which is currently required on musb since a long long time ago.
> > 
> > I understand the requirement is kinda unnecessary, but since it
> > already
> > exists on musb stack for a long time, I don't plan to change it.
> > Because I
> > cannot think of a use case in real products that doesn't automatically
> > load a gadget function on the dual-role port.
> > 
> > If you can explain a use case in real world (not a engineering lab)
> > that the gadget driver will not be loaded at linux booting up, but
> > later based on user's input, I will reconsider my decision. To remove
> > this requirement from musb stack, the work is more than this patch.
> 
> My use case here is to support common GNU/Linux-based distributions, not
> use-case-specific varieties of GNU/Linux-based rootfs. So my point here
> would be that most distros will (and probably should) ship g_ether as a
> module but without any particular reason to autoload it, or any other
> gadget module in particular, since the system is general-purpose.

This is the case I called it "in a engineering lab", not a real product.

> Then, imagine a user wants to plug a USB device through OTG (say,
> because it's the only USB port available at all on the tablet they're
> using), it simply won't work. It won't be obvious to that user that this
> is because no gadget is loaded, since what they want to do does not
> involve using gadget mode at any point.

If a tablet has a dual-role usb port, it is designed to use a gadget
driver, which has to be loaded at some point. In the case you described
above, when the gadget driver will be loaded? and how?

If a gadget driver will never be used, a host-only port should be on
the board, not a dual-role port.

> Do you think this is a valid use case? It surely is a common one and
> perfectly depicts my situation.

As I explained above, I don't think so.

> Note that in addition to Allwinner devices, I also have omap3/4/5
> devices for testing things. I don't think I have other MUSB-enabled

Much more than what I have ;)

> devices in my collection though, but I would be willing to test fixes to
> this issue on the ones I have.

Appreciated it, but someone has to make the patches first. The one you
posted might be a good start, but it is not complete. The first problem
I see is that musb_start() will be called twice, one in the place you
patched, the other is when the gadget driver is bound to the UDC.

Regards,
-Bin.
