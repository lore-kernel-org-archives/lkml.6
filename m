Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841162-1521757415-2-12122699484740474949
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521757414; b=aw3JayEPv+mDzwd7L/Oh0AnqL+pClhFV+NzsWA2tSMkFdhw
    6SP9FqKqrFlcDNjYo+a3gqu2PQ5qGhZ5mBDXAjKz9/VnAt1v1V/Q5Krz9x+nKSQT
    SRzEwNDfjfVZ/aYM0uokwyiABB3HRXYKvCcZcKZiqu3WUao2qvmo41f/wspoOHoq
    Bz2uC6KekiJSLGS0WqmVAc0+Oytc8/Fi2H6SQqkbWgTxo7/vbouo0wAu9PCbmo8C
    nCwJZCqZxnB+rF3biMDHyyYEw+NlpT+goXJC6PUWzGbrA/N1Vpc9Rdc2i7Yae/qu
    ofwN3QxS/IA4Z60qkqKfmEg97EgXpFNce65LFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521757414; bh=TcyWoNYetf8TeLjLUhnD9RNtftuOKaru+rz69+bv+Xs=; b=B
    2sD6X9txze0vmQb6flFNLkTVNAAujN7CL9v8YSCS6Nus+T3WIshmUps9g7tT2JDD
    xGDoQvcEz06obnMJlrDNdltuNJh9O2xMZD+aTjq1cG+rbGLB59/t0DthLK3qqqbq
    4Btb52ukafQwC3woQSUfoQTxc+aeqBTjIfIX4OrmcoehPoRiFHFGPNbmQWFBmQBm
    pMEE1OjokGk4lW8xTvSs8DzB7SnL0pcRQzLBZXQy0dvvlHqBKZCrELY85HZKWX1A
    ckWj0pHOB+gEBHXKusPP57+sgfoM8vJBdWm/NW8dAtTaOnLZM5kNMNX9kwadr8TK
    o+/6SJNmoNCZXsdN0/ROg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeCVWXU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 18:23:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751303AbeCVWXT (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 22 Mar 2018 18:23:19 -0400
Message-ID: <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
From: Dan Williams <dcbw@redhat.com>
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Date: Thu, 22 Mar 2018 17:23:16 -0500
In-Reply-To: <20180322192843.GA17189@amd>
References: <20180309023750.108942-1-tony@atomide.com>
         <20180322135553.GA27648@amd> <20180322164633.GF5799@atomide.com>
         <20180322192843.GA17189@amd>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-22 at 20:28 +0100, Pavel Machek wrote:
> Hi!
> 
> > > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost
> > > $
> > > sudo lsusb
> > > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost
> > > $
> > > zcat /proc/config.gz | grep MAPPH
> > > CONFIG_PHY_MAPPHONE_MDM6600=y
> > > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost
> > > $
> > > zcat /proc/config.gz | grep OHCI_
> > > CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> > > CONFIG_USB_OHCI_HCD=y
> > > CONFIG_USB_OHCI_HCD_OMAP3=y
> > > CONFIG_USB_OHCI_HCD_PLATFORM=y
> > > user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost
> > > $
> > > 
> > > As far as I can tell,
> > > 
> > > +CONFIG_USB_WDM=y
> > > +CONFIG_USB_SERIAL=y
> > > +CONFIG_USB_SERIAL_QUALCOMM=y
> > > +CONFIG_USB_SERIAL_WWAN=y
> > > 
> > > should be enabled to enable the drivers (and I did that), but
> > > without
> > > device showing on the bus...
> > > 
> > > Any ideas?
> > 
> > Do you have the related dts patches picked from next?
> > 
> > fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
> > e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
> > 
> > But yeah all you need to do is have phy-mapphone-mdm6600 and
> > ohci-platform loaded and then ifconfig should show four wwan
> > interfaces being added.
> 
> ifconfig? I thought I should get /dev/ttyUSB0..3?

I believe they are QMI via qmi_wwan, not TTYs.

Dan

> Anyway, that does not seem to work. Something is detected now:
> 
> [   10.819549] ALSA device list:
> [   10.831787]   #0: HDMI 58006000.encoder
> [   10.841186] Waiting 10 sec before mounting root device...
> [   10.887573] usb 2-1: New USB device found, idVendor=22b8,
> idProduct=2a70
> [   10.897521] usb 2-1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=0
> [   10.907684] usb 2-1: Product: Flash MZ600
> [   10.914611] usb 2-1: Manufacturer: Motorola, Incorporated
> [   20.967193] EXT4-fs (mmcblk0p2): couldn't mount as ext3 due to
> feature incompatibilities
> 
> But qcserial driver does not bind to that. If I attempt to force it:
> 
> root@devuan:/sys/bus/usb-serial/drivers/qcserial# lsusb
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 002: ID 22b8:2a70 Motorola PCS
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> root@devuan:/sys/bus/usb-serial/drivers/qcserial# echo "22b8 2a70" >
> new_id
> [ 2059.267730] usb 2-1: unknown number of interfaces: 9
> [ 2059.272949] usb 2-1: unknown number of interfaces: 9
> [ 2059.278045] usb 2-1: unknown number of interfaces: 9
> [ 2059.283233] usb 2-1: unknown number of interfaces: 9
> [ 2059.288330] usb 2-1: unknown number of interfaces: 9
> [ 2059.293457] usb 2-1: unknown number of interfaces: 9
> [ 2059.298553] usb 2-1: unknown number of interfaces: 9
> [ 2059.303680] usb 2-1: unknown number of interfaces: 9
> [ 2059.308776] usb 2-1: unknown number of interfaces: 9
> 
> I don't get anything useful. Do I need to boot android before booting
> Linux or something? How does your lsusb look like?
> 
> Thanks,
> 								Pavel
