Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69461C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2F720835
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2F720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbeGKLdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:33:12 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54371 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeGKLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:33:12 -0400
Received: from null ([172.19.249.148]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MBFvV-1fkbpo2UBJ-00AAsz; Wed, 11
 Jul 2018 13:29:09 +0200
Date:   Wed, 11 Jul 2018 13:29:08 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Bruno Herrera <bruherrera@gmail.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, balbi@kernel.org,
        grigor.tovmasyan@synopsys.com
Message-ID: <1327750822.182401.1531308548893@email.1und1.de>
In-Reply-To: <CAD=FV=WL5-faArU=1MAbLHGCNUw5Fd_A_QZC6BTwEr=mO6EmMw@mail.gmail.com>
References: <9a64fc45-7722-8650-99cc-a939132e252b@i2se.com>
 <CAD=FV=WL5-faArU=1MAbLHGCNUw5Fd_A_QZC6BTwEr=mO6EmMw@mail.gmail.com>
Subject: Re: [RFT PATCH 0/4] usb: dwc2: Turn on uframe sched everywhere
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev34
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:dTLWg0H6jZnyieoXBDxeL2Wv/smXVmWSabhw/lf8L5OBs/wvPWJ
 q1GWP3n2FqIfJaiDzQQnzknswg3mECuD+twixnjiByB2+2A4OlsyJORwcBaRaRiw6v9heJy
 sLkOGr6GiQnY7dsoGHsEiqliDlw5UVZWk+iz+PGgwOHDcFWR1jhwCQPas6uewJrpxjj5+gu
 PaMtI1oHX4si1zZf/A9fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:04CObOx1lkg=:25XvrmDrJVPBT8qG2XyZYa
 ukX+Elc0N5QH6QACQ53peCEbYbSkIDNU5DYgVxPDCbQryOT+TwAwlBoYWIhqdr28YEuEJPTXU
 N7kloLROUVEicTWHKWjbPkMNcb64i1FtXaecwe/mlxdUNGCOWGvBWQ009uEq43f8Xtf3YhG3g
 SPfx8pOXOjM50D1A73xu4l+MJ9oWqnLXJax5pME0+QSEMrOvyyxCqWmj7BNA4nZ/9T8ls79PM
 IoJb8IMfjWHjj9Qh2HsZo/iHs08onUFqen2b/GPUhXBsuoNxTM9aKZXbFAv1v7QRQM7qOYj2d
 zGFK8hTbEoKRgAnRJNY3Vsyo3dSGCsek/w575dyuRV6AJQyty926xtui86DMK729EagpTivmq
 X+L43SWRPEUVuEybA9ezzPSMAR5mDPB4zmZhtUlJ3VVRfzNiwftcWzO9Tk7yzTmJrdXu2IFaB
 ehzjudkf9XNZ08AydBD51a50FZAW96u2IaYO5hdXIXj+vQ90ZTsbfDNr3Hv0lLjojLNQOcI6/
 yUmzzoqWIAch/B5UPzToWynrngOZfw271L+z5qrM+70xnzf9yWhSvOeExuMMSmE99qL6wlDBT
 GaP+zt1yLgB4URFAvG6eiin1gD2+PfNM2R63ucTfzCA81G0VQXiXT2O13kT3Q5XPDlwIf7zwT
 E6nXVjnxic4Mj0OwWp/87DzHviXuSrtUZUXw4sHlQKylyjnleGqHwh/d+JIx40Qhkz0AKAty3
 cjDPfGPKuH/zC0ff
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

[add Felipe and Grigor]

> Doug Anderson <dianders@chromium.org> hat am 10. Juli 2018 um 17:21 geschrieben:
> 
> 
> Hi,
> 
> On Tue, Jul 10, 2018 at 6:57 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > Hi Doug,
> >
> > since Stephen isn't BCM2835 maintainer anymore, please keep me in the loop.
> 
> Sorry for missing you.  :(  I wonder if you should add yourself to the
> MAINTAINERS file as a reviewer for dwc2 so you can get CCed always?

i don't think this is necessary and my USB knowledge is to little. I've setup a jenkins to catch regressions from linux-next. This is currently sufficient.

> 
> 
> > I'm not sure how to test this. Is there some kind of test scenario (don't
> > have a USB analyzer)?
> 
> I guess it'll depend on what USB devices you have sitting around.  The
> more USB devices you have plugged in then the more likely the dumb
> scheduler will get things wrong and a device won't like you.  You
> should also see significant compatibility improvements when you have
> low/full speed devices plugged into high speed USB hubs.
> 
> IIRC when testing I did things like:
> - In general, try to have lots of things plugged in.
> - Plug many different keyboards / mice in.  See if keys are dropped /
> mouse is jerky.
> - Try USB audio (ideally full speed, not high speed).  How is the audio?
> - If you're brave, try a USB webcam.  How is the video?

Thanks for the hints. The BCM2835 only have 8 EP, so my test setup isn't big:

1x Rasberry Pi 2 (with onboard ethernet SMSC95xx via USB)
1x keyboard connected to the Pi directly
1x external powered 7 port HUB (1x mice and 1x USB serial adapter)

/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/5p, 480M
        |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=smsc95xx, 480M
        |__ Port 2: Dev 4, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
        |__ Port 2: Dev 4, If 1, Class=Human Interface Device, Driver=usbhid, 1.5M
        |__ Port 4: Dev 5, If 0, Class=Hub, Driver=hub/4p, 480M
            |__ Port 1: Dev 6, If 0, Class=Hub, Driver=hub/4p, 480M
                |__ Port 1: Dev 7, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
                |__ Port 4: Dev 8, If 0, Class=Vendor Specific Class, Driver=, 12M

But even in this simple scenario, your patch #1 is an improvement.

Without the hub connected and without your patch
or with the hub (and the 2 devices) connected and with your patch the SMSC95xx works properly:

[   45.668254] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of remote wakeup
[   47.146506] smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xCDE1

But with the hub (and the 2 devices) connected and without your patch the SMSC95xx driver has timeouts and in the result the RPi won't get an IP from my router:

[   20.408622] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of remote wakeup
[   20.807821] Adding 102396k swap on /var/swap.  Priority:-2 extents:1 across:102396k SS
[   26.401346] smsc95xx 1-1.1:1.0 eth0: Failed to read reg index 0x00000114: -110
[   26.401360] smsc95xx 1-1.1:1.0 eth0: Error reading MII_ACCESS
[   26.401371] smsc95xx 1-1.1:1.0 eth0: MII is busy in smsc95xx_mdio_read
[   26.401387] smsc95xx 1-1.1:1.0 eth0: Failed to read MII_BMSR
[   31.441429] smsc95xx 1-1.1:1.0 eth0: Failed to read reg index 0x00000114: -110
[   31.441454] smsc95xx 1-1.1:1.0 eth0: Error reading MII_ACCESS
[   31.441465] smsc95xx 1-1.1:1.0 eth0: MII is busy in smsc95xx_mdio_read
[   31.441481] smsc95xx 1-1.1:1.0 eth0: link reset failed (-110) usbnet usb-3f980000.usb-1.1, smsc95xx USB 2.0 Ethernet
[   36.481359] smsc95xx 1-1.1:1.0 eth0: Failed to read reg index 0x00000114: -110
[   36.481372] smsc95xx 1-1.1:1.0 eth0: Error reading MII_ACCESS
[   36.481383] smsc95xx 1-1.1:1.0 eth0: MII is busy in smsc95xx_mdio_read
[   36.481402] smsc95xx 1-1.1:1.0 eth0: link reset failed (-110) usbnet usb-3f980000.usb-1.1, smsc95xx USB 2.0 Ethernet
[   41.521345] smsc95xx 1-1.1:1.0 eth0: Failed to read reg index 0x00000114: -110
[   41.521358] smsc95xx 1-1.1:1.0 eth0: Error reading MII_ACCESS
[   41.521369] smsc95xx 1-1.1:1.0 eth0: MII is busy in smsc95xx_mdio_read
[   41.521387] smsc95xx 1-1.1:1.0 eth0: link reset failed (-110) usbnet usb-3f980000.usb-1.1, smsc95xx USB 2.0 Ethernet
[   46.561349] smsc95xx 1-1.1:1.0 eth0: Failed to read reg index 0x00000114: -110
[   46.561363] smsc95xx 1-1.1:1.0 eth0: Error reading MII_ACCESS
[   46.561374] smsc95xx 1-1.1:1.0 eth0: MII is busy in smsc95xx_mdio_read
[   46.561393] smsc95xx 1-1.1:1.0 eth0: link reset failed (-110) usbnet usb-3f980000.usb-1.1, smsc95xx USB 2.0 Ethernet
[   59.441375] smsc95xx 1-1.1:1.0 eth0: Failed to read reg index 0x00000118: -110
[   59.441389] smsc95xx 1-1.1:1.0 eth0: Error reading MII_DATA
[   59.441405] smsc95xx 1-1.1:1.0 eth0: link reset failed (-110) usbnet usb-3f980000.usb-1.1, smsc95xx USB 2.0 Ethernet
[   64.545268] smsc95xx 1-1.1:1.0 eth0: Failed to read reg index 0x00000114: -110
[   64.545285] smsc95xx 1-1.1:1.0 eth0: Error reading MII_ACCESS
[   64.545297] smsc95xx 1-1.1:1.0 eth0: MII is busy in smsc95xx_mdio_read
[   64.545324] smsc95xx 1-1.1:1.0 eth0: link reset failed (-110) usbnet usb-3f980000.usb-1.1, smsc95xx USB 2.0 Ethernet

So you can have my

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

for the bcm patch.

> 
> 
> If you're trying a USB webcam w/ dwc2, maybe add in patches mentioned
> in <https://bugs.chromium.org/p/chromium/issues/detail?id=820961>

Interesting

Best regards
Stefan

> 
> 
> -Doug
