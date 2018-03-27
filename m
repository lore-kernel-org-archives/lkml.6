Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2407521-1522111553-3-2757483571202175237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522111553; b=sFrDRuEAVBmulQN4fnLrZfqoeCfZOAuP7ZHXpi/SoIA0Blz
    uQFvGwYsgyonBR6HKTf9xQ6jJ3QxGY1Ndkb7wwLqUzMMVbDUV24x7yQe84rTJD/x
    GbJpThSLBlwEYP8FBi1vOhC1vzt+sACRSQyx1Bguw+X9NSI1W4BqxSNRdicZnnit
    O0M6cNw3CAVzdo3KAXZ9lcaO7KiZqDaZlJxTJvbVu7NaT+QwpQxWFxunOZI8WEOM
    y2tpKY6QTEF2e4njG/GIWM9rxtNUrJPPYdMXs5usfzhQFRkU2ailUpybsIE9HIFt
    lb9s78e2vwfGLCHSSmUf4hLt2JBOSnN6N1d5gJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522111553; bh=TIqkEMTQgpYgxbXTmdHaXBbNnB
    XvoTdHUvdvXUBn/wE=; b=COldNNfKJXQh78XsbdCJ44VhZikxnv2SMWw/o82/ES
    LxwvGqra3g7PBcgzdO1ogeuaNh5ONsDc1CVeUwcpBo6cE4uu/ZQYWGyPTV6KaxPw
    /fGLOkShRLz0pmgKV4aDbC3izRllj6w/tm6r3MHS4LsNiUUVjINYDCKGr/qEz3xT
    KxLQnOh9OxEbtN2vCgknQQ37NjL03CjYLEzYnQRoi3ocGzfA2+qBoVqWDv1ZUY7C
    VP5xCbdak6kheQEDisnc/k2kRJAJ+92LFqBIDxwju5V/8Fbv7f7Hth894wvcHPnL
    S7FrfIjeBQoskfgXyRsuCawBtYuMQw+UppSUy5FiQsMQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP3YJC7rrfDHJl7MbRxIUld0NLwFVxItQIqPc3bzBytqafplKuEEvqy/O5aaPVY4VJeInVOM8lNK/5zkXQ3ur4GyoXTX7qSOlvZTloC9wgsFmiurreUk
    LL+4ltvnr3i69gytl186h1IF+vHfRBF5qze0BLPeEVd115AfmL3UxYdRScMkZZtXGOlNgD7v8Iotb42dCfurDqE3CBQxJCiyk1/Ssof61hfU5KuBBzpNcemb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=l97TSMD3IINMrqZxN-cA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeC0Aph (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 20:45:37 -0400
Received: from muru.com ([72.249.23.125]:34004 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbeC0Apg (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 26 Mar 2018 20:45:36 -0400
Date: Mon, 26 Mar 2018 17:45:31 -0700
From: Tony Lindgren <tony@atomide.com>
To: Dan Williams <dcbw@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180327004531.GH5700@atomide.com>
References: <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
 <20180325154512.GC5700@atomide.com>
 <20180325185857.GA7582@amd>
 <20180325205232.GD5700@atomide.com>
 <e756d74aaff6b0a4546944393e1b98bf51ae4900.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e756d74aaff6b0a4546944393e1b98bf51ae4900.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Dan Williams <dcbw@redhat.com> [180326 15:18]:
> On Sun, 2018-03-25 at 13:52 -0700, Tony Lindgren wrote:
> > Anyways, looks like qmi_wwan needs to be loaded before
> > qcserial module, otherwise we get nine ttyUSB instances
> > and ModemManager can't find any modems.
> 
> Use qcaux.c or option, unless the 6600 actually *does* have the same
> layout as Gobi 1K/2K/etc devices.

OK yeah I don't think it's Gobi.

> If you're going to use qcaux or optoin, then you need to use some
> variant of USB_DEVICE_AND_INTERFACE_INFO to lock the serial driver to
> the specific USB interfaces that expose the TTYs and to ignore the QMI
> interfaces and netdevs.

OK thanks I'll take a look and post a patch after some testing.

Regards,

Tony
