Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1320427-1522077426-2-1899479890831235610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
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
    t=1522077426; b=t2SGXxllJxP5da1dKTbSh2BIaccJ2JcbCv5X/ZfRwSOGZcQ
    pxg+QtLtCqRVNscb7u2Q0SJS8Bc1oNfT+dKOESySdx1fcf5LHV8WAIVQyjzJURiQ
    VP6zWbU87vsyyAnIukhDW1jL9pbxMg8leJOBloO+8wtkevPvLLHfssSd0E7ff5Bu
    C141VqQtIBDNlfyJPt7BLJVhA0o6nqEEZRIWNPImtshHfTlMtQx3bH/eJ4NO8Nf+
    F7pG8F2Nuz4jkRj4tMUR0vGVU6Wl7+JXRJTIuIXGNF/0zyQdcSItve08IBzmyQif
    9XbLxt9MEDHKQe0pdalFwvIp0uHOuAGS/8k7zoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522077426; bh=AAwaEk//mz9N8FtlnMCoyZgwEaDyVflW/mY5c7ZqKqg=; b=I
    +ad7+1jQV3GF7DMCYRz38U/kfjYH196gdgf3ttvSXmJ4HXqCo5jHcPP2shKgDTiy
    xyEneauchc8ANVHruoctzWtklaBCcuhAa0ggXuWASKR662uW2+tt1c5tn+//60SV
    Uohbc3utVivbJv+qWjgrF2YCbiQqpKH5XJ/HuHLIKAVWeWy7ttob/Lfgy2yOHhFE
    ODeU6usNFK4NS1Q4//S7YMVRXDD2OjTe9QX9dHZFPDoLTNzBzRQJ00gMquV9/cfM
    /X8pBQiVXoGx5uirNuzCUeYTJ1gvLLbVIZWI2ngCx5tVeeGVUtYnYojQ7IMlpKTj
    mTQ8hvkuPyNs/WC0C2u4w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGiP8TFNVR/WmviF9T2ciUKguvsA66q1bKEDpVmpjC876chA9Dz0lfb2smLywq9J9bCYx2JI1feL6iol5CetX32Buh8sOZrwTsZ+gjTR6cZrcdZa3jpX
    0PNH1jFQC1YKrKrjEEdJ25pfA/mOmxGCp2TtP8FOt9nemf640TTbpX/NtK6FyCSrbirQzDvgm9yVdIXptLLzw2AgaB8GGrBnfqbIHhIDSvnDULOe1VKk96Ac
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=NEAV23lmAAAA:8 a=bt8Zh30PAAAA:8 a=VwQbUJbxAAAA:8 a=pC2k5T7fpffKwYNUcOkA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeCZPQs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 11:16:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751127AbeCZPQq (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 26 Mar 2018 11:16:46 -0400
Message-ID: <e756d74aaff6b0a4546944393e1b98bf51ae4900.camel@redhat.com>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
From: Dan Williams <dcbw@redhat.com>
To: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Date: Mon, 26 Mar 2018 10:16:43 -0500
In-Reply-To: <20180325205232.GD5700@atomide.com>
References: <20180322192843.GA17189@amd>
         <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
         <20180323105455.GB21644@amd>
         <20180323113521.45va72bhzis6ym6m@earth.universe>
         <20180323201343.GC23658@amd>
         <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
         <20180324142517.GA94954@atomide.com> <20180324200224.GA17857@amd>
         <20180325154512.GC5700@atomide.com> <20180325185857.GA7582@amd>
         <20180325205232.GD5700@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-03-25 at 13:52 -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180325 19:00]:
> > Hi!
> > 
> > > > Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it
> > > > seems
> > > > to react to AT commands, and in particular reacts to ADT123; (;
> > > > is
> > > > important).
> > > 
> > > Is that to dial a voice call?
> > 
> > Yes. And it is ATD123; not ATD.
> 
> Strange, no semicolon is needed when using /dev/gsmtty to
> dial a voice call with my current pile of pending changes,
> just doing ATD123 dials..
> 
> Anyways, looks like qmi_wwan needs to be loaded before
> qcserial module, otherwise we get nine ttyUSB instances
> and ModemManager can't find any modems.

Use qcaux.c or option, unless the 6600 actually *does* have the same
layout as Gobi 1K/2K/etc devices.

If you're going to use qcaux or optoin, then you need to use some
variant of USB_DEVICE_AND_INTERFACE_INFO to lock the serial driver to
the specific USB interfaces that expose the TTYs and to ignore the QMI
interfaces and netdevs.

Dan

> With qcserial module loaded after qmi_wwan, it still takes
> a long time for ModemManager to find the modem.
> 
> Then unrelated to the qcserial module, also looks like I can
> no longer use the GPS with ModemManager:
> 
> $ mmcli -m 0 --enable
> $ mmcli -m 0 --location-enable-gps-raw
> 
> And then chmod a+r /dev/cdc-wdm0 and pointing gpsd to use
> /dev/cdc-wdm0 used to work, but now it seems that gpsd
> can no longer read it. Trying to start gpsd manually produces:
> 
> # gpsd -b -n -N /dev/cdc-wdm0
> gpsd:ERROR: SER: /dev/cdc-wdm0 already opened by another process
> gpsd:ERROR: initial GPS device /dev/cdc-wdm0 open failed
> gpsd:ERROR: can't run with neither control socket nor devices open
> 
> And lsof shows /usr/libexec/qmi-proxy having it open.
> 
> Anybody know what I might be doing wrong? Sounds like something
> now needs to be done with qmi-proxy to get access to GPS?
> 
> > > Anyway, "good" solution is to get ofonod running, then use ofone
> > > from
> > > here: https://github.com/pavelmachek/unicsy_demo
> 
> Thanks I'll take a look.
> 
> > > I think it's the cpcap based config to route voice call audio
> > > to SoC, Sebastian knows the details :)
> > > 
> > > The way to figure that one out is to dump the cpcap registers
> > > before and during voice call on android with cpcaprw, then
> > > diff the output for the audio registers. Probably some SoC
> > > registers need to be diffed too with rwmem or similar tool
> > > for the mcbsp instance(s) used.
> > 
> > That sounds like hard way to do it. There's source available, I'm
> > now
> > trying to understand it / fit it into Sebastian's driver.
> > 
> > https://raw.githubusercontent.com/NotKit/android_kernel_motorola_om
> > ap4-common/hybris-11.0/sound/soc/codecs/cpcap.c
> 
> Sure that hopefully helps too :)
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
