Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2680741-1525776716-2-14844817407213512875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525776716; b=Z9usDMtflICjVRrndgxRr0Q6nDb3+6fN5HpawAkSnDGaD27Dza
    l9RGtuHIE/Ad8RT1Qe4X9fZmyX/ASN73w8qtzqGTkpRZaj7VuZ1KHwJ1bRglJaDk
    I4b8SELCE9tLLpMbqabbp7E7ov+7Uw/5/faranXBqubpRWSnv/6uatfzR1P2KVDF
    GGlDzFbhtSc2v/db27BQ7oIEThdnXxOyUt5wclWN7j4vugq2omRkE2H8UeNLvnPF
    izEnklg3yFdMG9Fa8L26BkVgFOwBaPwLTzWdh0zep9vJqNtB8S7lD2eLXOmLbCbw
    8ukipCsIJoVSebv7d4ybHl590ScTWQmmvLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525776716; bh=HesvMrc0hL7
    IiMNHJFDkLU5L73/dziPn0f0SNMqZNkA=; b=HU/TcpYbQLmBb1iH3Ezg0kttBf8
    9mSF/QUBs/y9PIwdEGD0RxITPAYFd5edZVtkqRsPTmKKVbyssSAKXgp4++BTJFWL
    SYYf8b8PRRfS7jVXkR0W7QZ3Gh5H+rJAZRj/XeO+j2Pa/meRzekwrnThLAkiESeT
    oU2QoM9PQZkzi9RBt+Fm3fvvE/7medTe4YtBNBPQCtqpWc12/NIzyugPAd+Roqk3
    RAjnE+cXyWcHvZT1tvm4K9+bjuMCBLzGNMN1ItG//PlgbY4/XQpjm7YSM75pgE5s
    6pyh0N0DtNK9a4cyJ6GYKZr5k/NcANRNTdUTgP177qzgTV0Y0j6mXgPqSZg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=pengutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=pengutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGLq7OQEX+U2N564xcCGAeMdWY3Sknf+C7f7yKgfJLToAfYn2lefzhiLSWZAgD0h6uVPAmUneC2LB5KJofP+NM8WGmgYM6Z91XQ07OJdNWds4vi2N9mm
    K742GIojIwqdVds1jtVzrgtCvwDYNz/fFsdEiNAlI4VOEqG+yrny8H9b75LR4GDTGgtz1d8+my7P3rwsJDk/Hybyil0NmtIAv9A+gmuk9bmPk6j+M6olnNBx
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=bGNZPXyTAAAA:8 a=VwQbUJbxAAAA:8 a=c_kO7rGCJ9nJEBoy2RcA:9
    a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=yL4RfsBhuEsimFDS2qtJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeEHKvv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 06:51:51 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33941 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeEHKvt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 06:51:49 -0400
Date: Tue, 8 May 2018 12:51:31 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Robin Murphy <robin.murphy@arm.com>, kernel@pengutronix.de,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 3/3] tty: implement led triggers
Message-ID: <20180508105131.agz7u3q42gy7mrxy@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
 <20180508100851.GY2285@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180508100851.GY2285@localhost>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 12:08:51PM +0200, Johan Hovold wrote:
> On Tue, May 08, 2018 at 12:05:43PM +0200, Uwe Kleine-König wrote:
> > The rx trigger fires when data is pushed to the ldisc by the driver. This
> > is a bit later than the actual receiving of data but has the nice benefit
> > that it doesn't need adaption for each driver and isn't in the hot path.
> > 
> > Similarly the tx trigger fires when data was copied from userspace and is
> > given to the ldisc.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx25-logitech-baby.dts | 192 ++++++++++++++++++++++
> 
> Looks like you included more than intended in this patch.

Right, this doesn't belong here. Feel free to assume I didn't include it
in the patch and comment the rest :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
