Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4073467-1521901589-2-11646993980159382200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521901589; b=qyKSpZkghaHuMWQncV+mJvSXlJxso/7kDY7ExjgadYrI1Ww
    SosCUZvw10ZTOB6FYkAAvYg0nF2xi4b5E9Gk3iceSIkYoQCUwgutgMz5F2Z02Cw5
    +aQvOIX/prGqFhrwlHbWCZ7vc4kOY3kcV6+pwrTkbctPdjaPKtid730Umm2zXvaf
    o4sK5ARG+LZK/sObAuPoZiruYiALpiW3/9QE1q8VNNqbpE6b5prGQhUDDZHiaVeK
    RGYevZVMCVxNgnmXAgVVXflHN3M1hx1+mqgV00udX7TcLp96KRl2FJdNo+p2dnC/
    otcQbWHZMXBW6paeqW30sgNjrofCI7wd820fWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521901589; bh=IBDzAtk06RNXPu62ED9fckSAcE
    tv2OoDfY3ck+Du0Hk=; b=DZ1aO+pirOFyMVNqJxdB44HSm0RPqd9nHwY2WGfiZr
    AE6cRzjLiSVTYkjiyd0ar2LASXHYvFmst0/uFmEM38gHB2MTr0x2Ue+nEtT1jsif
    716xXj1rG0a84D2CBkvrxBnLI0XDVaj3m2s8JOY61pwmfaJsX3msugXR1S2ZnkN5
    Mq2AhDqBJcI3DLy5jxgE/+6n0z8G5C1kcB45jmanXN/DxSdlpnKvMbGGsSbnjef4
    wbdrAWVKfmf+2nVuh8TZIxZQI61UPsjSx7bLcjN/qRDfP3Vyc50O5zWAFK+ayvth
    sR7gOs1tSqJ3WUluIdHtxh/4tzm1lS+NK+yDekzhlGrA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeCXOZ1 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 10:25:27 -0400
Received: from muru.com ([72.249.23.125]:33532 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbeCXOZ0 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 24 Mar 2018 10:25:26 -0400
Date: Sat, 24 Mar 2018 07:25:17 -0700
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
Message-ID: <20180324142517.GA94954@atomide.com>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Dan Williams <dcbw@redhat.com> [180324 14:00]:
> On Fri, 2018-03-23 at 21:13 +0100, Pavel Machek wrote:
> > Does ofonod work for you? I could not get that one to work...
> 
> Because it's looking for a Gobi modem but the MDM6600 isn't one and
> doesn't expose that layout (and doesn't really need to anyway).  I
> don't think ofono has a generic QMI driver, so you'd either need to for
> ce it to use the telitqmi or quectelqmi drivers, or write your own
> generic QMI one.

We also get five USB uarts if we add the device id with something
like the patch below. I don't quite get why we get five UARTS?

Also not sure if we should be using drivers/usb/serial/qcaux.c
instead of qcserial.c?

And from what I recall trying it out, adding the USB UARTs
somehow confused ModemManager I think, that needs to be retested
though :)

And the USB UARTs added do not offer the same set of AT commands
as the n_gsm serial mux.

Regards,

Tony

8< ------------------
diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -181,6 +181,9 @@ static const struct usb_device_id id_table[] = {
 	/* Huawei devices */
 	{DEVICE_HWI(0x03f0, 0x581d)},	/* HP lt4112 LTE/HSPA+ Gobi 4G Modem (Huawei me906e) */
 
+	/* Motorola devices */
+	{DEVICE_HWI(0x22b8, 0x2a70)},	/* Droid 4 mdm6600 */
+
 	{ }				/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.16.2
