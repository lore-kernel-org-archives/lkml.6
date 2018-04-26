Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2242495-1524730465-3-5016087348508950265
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='utf-8', cc='iso-8859-1', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524730464; b=LsEsBJjcoJ4XQAZvtn8hu0E0UFe+vapSlU3JlnSXVwERmKjVq/
    ez/JTQuoo7qnq4nYCiwJGc14kVEufPj6sHASQpq5zd+wuasS/bqDlQXs8MSBks7s
    veKlUDA/n4cS2Ca1GWz54vbPe7qhJGJAyZJYjlDj3hbCb1u24Fwpdxy5OYl9UG9z
    wSC2G/nQioPxDHx5fV/knesSDEuHrP7ONJK6Fy1m4pILpt94fuQB7UFSQTWgRmjg
    HarNhjavgrjBKPnkcydsdrYLrUtcN02dmgiy3qW5vXexDTqdGUPLF+Dy6U/90lkQ
    CDleX4Z+Cw/qGuvVRnJXXftLTmtLCgJSrcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524730464; bh=B779+Kub29W
    zN6Olkts2Hp02Nh6RSLzMScZe2J/1aZI=; b=R5XGlUiuQ2GBPVg0hS22Q89urvO
    t/Aq28QATnS1iPOikcuAd4K8WjDrTx+0yI2FuOT89fyGfR9vcJK9Mj9uNitw0FzM
    asJ6B0PiP8mZhIWXkiOO/j3th1GMIo+39Wb/6UJQa9bZ99KAxWufqe/JnLJybDTY
    ahEk2EOMqLeg1cwd3JtgDciail9IoNJwE8bU0hg3niStIIuwv42DUsIPXOZhQq07
    YXVHrfBODpV80uAOqSrwvECSI6u4gz2zsKBxPVfUdoms2uDnsfsMe+FtocbiODA5
    NGvZ608L7Cle/nnZJ+Txuei3RuIPqWlwi9VCZXStfMlU3yAbuFGWXHuecNQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=apZeql2L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PNlGpQkY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=apZeql2L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PNlGpQkY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE6p9mi059CtYsOGUv9LgwrRyrkT1DF2/1zTcJugBed529Sl2xHMzn50ykJhc5hxgBbA4efAV2mMPhRLpSbTGDe/n/2BpJSDYO9CFuDaHAuhCUXxjkAg
    psFBtS3phHTJPXD56Xzxszi90+/0bneoBM7dchlWaQ1A9WBD1hhJ57gF8jK2+SXd7Ofy/bNqpfNU9g/jm3pdbddNBJopL1/KNWsZgilR/KSvRCbSbQvyllA8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=dZ7Af3Q_AAAA:8 a=VwQbUJbxAAAA:8 a=zReSqDvqeSowRwQpIkEA:9 a=QEXdDO2ut3YA:10
    a=xnyMoErWsJe9py2mg6Iw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754456AbeDZIOW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:14:22 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:43229 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754479AbeDZION (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 04:14:13 -0400
X-Google-Smtp-Source: AIpwx49aaZIxXEUqm0NbD+eaBMc2Q/eIAbmHDCn0j09Kt6xwv5blW3zdjR+fj83qwpNf99HM+gq/5w==
Date: Thu, 26 Apr 2018 10:14:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Lars Melin <larsm17@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
        SZ Lin =?utf-8?B?KOael+S4iuaZuik=?= <sz.lin@moxa.com>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Dan Williams <dcbw@redhat.com>
Subject: Re: [PATCH] USB: serial: option: adding support for ublox R410M
Message-ID: <20180426081403.GA335@localhost>
References: <20180426062831.320-1-sz.lin@moxa.com>
 <20180426070927.GT4615@localhost>
 <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 02:48:54PM +0700, Lars Melin wrote:
> On 4/26/2018 14:09, Johan Hovold wrote:
> > On Thu, Apr 26, 2018 at 02:28:31PM +0800, SZ Lin (林上智) wrote:
> >> This patch adds support for ublox R410M PID 0x90b2 USB modem to option
> >> driver, this module supports LTE Cat M1 / NB1.
> >>
> >> Interface layout:
> >> 0: QCDM/DIAG
> >> 1: ADB
> >> 2: AT
> >> 3: RMNET
> >>
> >> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> >> Cc: stable <stable@vger.kernel.org>
> > 
> > Applied, thanks.
> > 
> > Johan
> 
> With a Qualcomm Device Management interface, shouldn't this modem be 
> driven by qcserial?

Hmm, we already have some QCDM interfaces handled by option and qcaux so
it's not that clear-cut.

Dan and Björn had a discussion about this a while back, so adding them
on CC. It seems to me that this device does not fit the intended use (or
Gobi 1000 layout) for qcserial, but I may be mistaken.

Thanks,
Johan
