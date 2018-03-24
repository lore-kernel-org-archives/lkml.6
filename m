Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3952077-1521899989-2-17748912058112299908
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
    t=1521899988; b=TSTsL53/YIKTZY5V9xFUkUhX1SJAjWu0aUoCMCKKOMFA1Dj
    kJqRSTE0i7n+yCUKMMayMzUICxR4q1LdCT69FxQd5vzc13PP0CCrYcBabh03HnhF
    jWo4Cpn4H81W0SDNh3k6rxQ9wtiMMM9Ya9HjO1PCb0jDAq/xAADySYqmd9Ug8WDF
    8uWLbq0XJzqm5/xRUDPznh8hpcJC7itkBUaPdAagJTDlwMY0but6kFMjAxjRa49l
    EpVvFLJNLSmMHOG/GetLlr95bdB2aEY5N75j2hKkPJToSc/OBmbJqXVbGObhOneV
    /5PRycVGXc18uLYISrrNZR8R0rDfdBzMeUbkWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521899988; bh=17hDn0SaCzGe8jxde+JuctWqikm8MH4nS1ZYO31DiJM=; b=w
    mMSwdwFrp2NWQ/4gIVd06w9igperCvBECbA5bjJSw9fz5nbmSPIVwJgOb624j4UD
    kQ0MWVexh25OV8OVR/3J+suCQ7D6QWKYRBqlCvrA+BpuyZSnHHx4+qZCAe4YK6ZF
    KP+04Ykhxf3diWgNP1cGjynjzZ3jXIGt8cc5h4Uq4dpaKyuo197KM+nA0JS7Ktjz
    SzfC4+nGsOD8thjqSUgcusaYc6nDeh79gmAFpbnthaGEKiYzFaUDvuNj9ckiuqgr
    pxzHvRyV6Dkj1lnhWh7odBgaqIBTT8j0x9J7eAvu72dxSnBFVNdEvrjrhVgTAsUJ
    DGCW02N3ckjU19ycoYz5w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1752161AbeCXN7e (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 09:59:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751999AbeCXN7c (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 24 Mar 2018 09:59:32 -0400
Message-ID: <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
From: Dan Williams <dcbw@redhat.com>
To: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Date: Sat, 24 Mar 2018 08:59:28 -0500
In-Reply-To: <20180323201343.GC23658@amd>
References: <20180309023750.108942-1-tony@atomide.com>
         <20180322135553.GA27648@amd> <20180322164633.GF5799@atomide.com>
         <20180322192843.GA17189@amd>
         <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
         <20180323105455.GB21644@amd>
         <20180323113521.45va72bhzis6ym6m@earth.universe>
         <20180323201343.GC23658@amd>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-23 at 21:13 +0100, Pavel Machek wrote:
> On Fri 2018-03-23 12:35:21, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Fri, Mar 23, 2018 at 11:54:55AM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > > Do you have the related dts patches picked from next?
> > > > > > 
> > > > > > fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port
> > > > > > naming")
> > > > > > e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600
> > > > > > USB PHY")
> > > > > > 
> > > > > > But yeah all you need to do is have phy-mapphone-mdm6600
> > > > > > and
> > > > > > ohci-platform loaded and then ifconfig should show four
> > > > > > wwan
> > > > > > interfaces being added.
> > > > > 
> > > > > ifconfig? I thought I should get /dev/ttyUSB0..3?
> > > > 
> > > > I believe they are QMI via qmi_wwan, not TTYs.
> > > 
> > > Well, qmicli expects device path... and I see nothing on
> > > ifconfig. Any
> > > idea how the device would be named?
> > > 
> > > But I believe it just does not work, see the qcserial experiment
> > > with
> > > new_id below.
> > 
> > Dan is right, you need qmi_wwan driver. qmicli expects
> > /dev/cdc-wdm<num> device. I use this on Droid 4:
> > 
> > qmicli -d /dev/cdc-wdm0 --some-other-option
> 
> Aha, there's ./drivers/usb/serial/usb_wwan.c and there's
> ./drivers/net/usb/qmi_wwan.o . That confused me.
> 
> qmicli now works for me, thanks!
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> 
> Does ofonod work for you? I could not get that one to work...

Because it's looking for a Gobi modem but the MDM6600 isn't one and
doesn't expose that layout (and doesn't really need to anyway).  I
don't think ofono has a generic QMI driver, so you'd either need to for
ce it to use the telitqmi or quectelqmi drivers, or write your own
generic QMI one.

Dan

> ofonod[4083]: plugins/udevng.c:create_modem()
> /sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/u
> sb2/2-1
> ofonod[4083]: plugins/udevng.c:create_modem() driver=gobi
> ofonod[4083]: src/modem.c:ofono_modem_create() name: (null), type:
> gobi
> ofonod[4083]: plugins/udevng.c:setup_gobi()
> /sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/u
> sb2/2-1
> ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm0 255/251/255
> 05 (null) (null) usbmisc
> ofonod[4083]: plugins/udevng.c:setup_gobi() wwan0 255/251/255 05
> (null) (null) net
> ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm1 255/251/255
> 06 (null) (null) usbmisc
> ofonod[4083]: plugins/udevng.c:setup_gobi() wwan1 255/251/255 06
> (null) (null) net
> ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm2 255/251/255
> 07 (null) (null) usbmisc
> ofonod[4083]: plugins/udevng.c:setup_gobi() wwan2 255/251/255 07
> (null) (null) net
> ofonod[4083]: plugins/udevng.c:setup_gobi() /dev/cdc-wdm3 255/251/255
> 08 (null) (null) usbmisc
> ofonod[4083]: plugins/udevng.c:setup_gobi() wwan3 255/251/255 08
> (null) (null) net
> ofonod[4083]: plugins/udevng.c:destroy_modem()
> /sys/devices/platform/44000000.ocp/4a064000.usbhshost/4a064800.ohci/u
> sb2/2-1
> ofonod[4083]: src/modem.c:ofono_modem_remove() 0x5eb380
> ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm0
> ofonod[4083]: plugins/udevng.c:destroy_modem() wwan0
> ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm1
> ofonod[4083]: plugins/udevng.c:destroy_modem() wwan1
> ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm2
> ofonod[4083]: plugins/udevng.c:destroy_modem() wwan2
> ofonod[4083]: plugins/udevng.c:destroy_modem() /dev/cdc-wdm3
> ofonod[4083]: plugins/udevng.c:destroy_modem() wwan3
> ofonod[4083]: plugins/upower.c:upower_connect() upower connect
> ofonod[4083]: plugins/hfp_hf_bluez5.c:connect_handler() Registering
> External Profile handler ...
> 
> 									
> Pavel
