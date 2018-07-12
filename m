Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18301C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B931320BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OehpOE8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B931320BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbeGLJRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:17:23 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:36702 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeGLJRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:17:23 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180712090840epoutp02be47b2ff5361f01535071cd322db518c~Ak_096K3e0216702167epoutp02Q;
        Thu, 12 Jul 2018 09:08:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180712090840epoutp02be47b2ff5361f01535071cd322db518c~Ak_096K3e0216702167epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531386520;
        bh=Wkplri9XOHjDgS++xukPdKVen16VR2D7u3HsKoHjSjM=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=OehpOE8xeRXibxzJXa2fT3TV8wC8u05oxD7gBFa2NVeN9tTRl0Pkjy9m/IeICR2+n
         M2/PAbVTAjiheP1oQ4SeW04FLwp8k48Sk9loFYHh0SlC9oDSAToOemILRCyXWCm2z6
         7BIPT4iHsi2/ck0ceClmNum0Gh6Id9V+fEVPXYn8=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180712090837epcas1p4de8c52b9a3d8f71fbe199360b0561a9a~Ak_yML6_50987909879epcas1p49;
        Thu, 12 Jul 2018 09:08:37 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.5B.04068.59A174B5; Thu, 12 Jul 2018 18:08:37 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180712090837epcas1p27a4704b395e0765ab0dc4aaad05657e1~Ak_x5DqWY2357523575epcas1p2H;
        Thu, 12 Jul 2018 09:08:37 +0000 (GMT)
X-AuditID: b6c32a36-be9ff70000000fe4-5a-5b471a95c1ef
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.BE.03915.49A174B5; Thu, 12 Jul 2018 18:08:37 +0900 (KST)
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBQ00BW6XEC3W60@mmp1.samsung.com>; Thu, 12 Jul 2018 18:08:36 +0900 (KST)
Subject: Re: [PATCH v5 07/12] PM / devfreq: export devfreq_class
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-id: <41164a91-b271-5f3b-b461-21ff5997cc84@samsung.com>
Date:   Thu, 12 Jul 2018 18:08:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
In-reply-to: <20180706180923.GH129942@google.com>
Content-language: en-US
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmnu5UKfdog5XLJS3+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB2VapORmpiSWqSQmpecn5KZ
        l26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD9JqSQlliTilQKCCxuFhJ386mKL+0
        JFUhI7+4xFYp2tDQSM/QwFzPyAhIG8daGZkClSSkZszbNp+94J90xZZJJ1kbGLvEuxg5OSQE
        TCReflnEDGILCexglLh9R7qLkQvI/s4oceFtKxNM0anJq5kgErsZJebcnAOW4BUQlPgx+R4L
        iM0soCnx4sskFoiiu4wS5379BEsICzhI3Nh3nB3EFhHQkHjy+zwjSBGzwDRWie5p/9lAEmwC
        WhL7X9wAs/kFFCWu/njMCLHBTmJV8yqwQSwCqhL7L5wC2ywqECHR9Pwn2FBOAUOJ5T9uMkNc
        IS7R3HoT6iJ5iYNXnoNdJCFwi13i4smlUP+4SNyf95gFwhaWeHV8C9AgDiBbWuLSUVuI+nZG
        iS8vmlkhnAmMEh9ObYZqNpZ4trCLCWIDn8S7rz2sEM28Eh1tQhAlHhI39veyQYLiL6NE++Tj
        7BMY5WYhBdkspCCbheTwWUgOX8DIsopRLLWgODc9tdiwwEivODG3uDQvXS85P3cTIzhta5nt
        YFx0zucQowAHoxIP7wYOt2gh1sSy4srcQ4wSHMxKIryXpgCFeFMSK6tSi/Lji0pzUosPMZoC
        A3Mis5Rocj4wp+SVxBuaGhkbG1uYGJqZGhoqifP2nHaNFhJITyxJzU5NLUgtgulj4uCUamBc
        f+Fy0qydXBdtEuQEnk3rXLT0ZfC0zKYF1XNd5y+4uP4k850f03fl8d+PU5wZWfHrzO+lneLK
        L1x6ojlscttE7e8UnfSN17oUlfNNOLCl+afMTlPvOR1vDlz+/ufJ9ItzFMwS/p7PenDlTsCF
        xXJnonenVl1PseDjurTKSdh463OOHfd6tja9VWIpzkg01GIuKk4EALaorlXxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t9jAd2pUu7RBm3T2Cz+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlTFv
        23z2gn/SFVsmnWRtYOwS72Lk5JAQMJE4NXk1UxcjF4eQwE5Gif13TrOAJHgFBCV+TL4HZHNw
        MAuoS0yZkgtRc59RYvK8C+wgNcICDhI39h0Hs0UENCSe/D7PCGIzC8xgldh4IQai4S+jxJb7
        H1lBEmwCWhL7X9xgA7H5BRQlrv54zAixzE5iVfMqsMUsAqoS+y+cYgKxRQUiJO6d/wRWzylg
        KLH8x01miAXiEs2tN1kgbHmJg1ees0xgFJyF5O5ZCHfPQtIxC0nHAkaWVYySqQXFuem5xUYF
        hnmp5XrFibnFpXnpesn5uZsYgVG87bBW3w7G+0viDzEKcDAq8fBu4HCLFmJNLCuuzD3EKMHB
        rCTCe2kKUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6YklqdmpqQWpRTBZJg5OqQZG
        JYbzbML86c3n+L/Jdi+b/+WAm8W2TSe3F3b5TPgsG3jjFrfm97+r2kRvbmI93Rz8cMWkLLHO
        H8tr1XbnmTD0Wn8PCotYceAQT1/Ivqz13w8cZIlKvM29Rig3S1WtW1xEZiPz9DyutLXfd3zN
        kvjmn37ZYvah3TNff+j/UnLn4o3oP5k7KidGKrEUZyQaajEXFScCAB2SftzeAgAA
X-CMS-MailID: 20180712090837epcas1p27a4704b395e0765ab0dc4aaad05657e1
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20@epcas5p1.samsung.com>
        <20180703234705.227473-8-mka@chromium.org> <5B3C5B78.6020401@samsung.com>
        <20180706180923.GH129942@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 07월 07일 03:09, Matthias Kaehlcke wrote:
> Hi,
> 
> On Wed, Jul 04, 2018 at 02:30:32PM +0900, Chanwoo Choi wrote:
> 
>> I didn't see any framework which exporting the class instance.
>> It is very dangerous. Unknown device drivers is able to reset
>> the 'devfreq_class' instance. I can't agree this approach.
> 
> While I agree that it is potential dangerous it is actually a common
> practice to export the class:
> 

I tried to find the real usage of exported class instance
and I add the comment for each class instance. Almost exported class
instance are used in the their own director or some exported class
like rio_mport_class/switchtec_class are created from specific device driver
instead of subsystem.

Only following two cases are used on outside of subsystem directory.
devtmpfs.c and alarmtimer.c are core feature of linux kernel.

	drivers/base/devtmpfs.c uses 'block_class'.
	kernel/time/alarmtimer.c uses 'rtc_class'.

I cannot yet agree this approach due to only block_class and rtc_class.

You added the following comment why devfreq_class instance is necessary.
Actullay, I don't know the best solution right now. But, all device drivers
can be added or removed if driver uses the module type. It is not a problem
for only devfreq instance. 

/*
+	 * devfreq devices can be added and removed at runtime, hence they
+	 * must also be handled dynamically. The class_interface notifies us
+	 * whenever a device is added or removed. When the interface is
+	 * registered ci->add_dev() is called for all existing devfreq
+	 * devices.
*/


> grep "extern struct class " include/linux/ -R
> include/linux/rio.h:extern struct class rio_mport_class;
rio_mport_class is created on drivers/rapidio/rio-drivers.c.
It means that just device driver create the 'rio_mport_class' class
instead of any linux kernel subsystem.

> include/linux/tty.h:extern struct class *tty_class;
tty_class is not used on outside of drivers/tty

> include/linux/fb.h:extern struct class *fb_class;
fb_class is not used on outside of drivers/video/fbdev

> include/linux/ide.h:extern struct class *ide_port_class;
ide_port_class is not used on outside of drivers/ide.

> include/linux/device.h:extern struct class * __must_check __class_create(struct module *owner,

> include/linux/devfreq.h:extern struct class *devfreq_class;
not yet

> include/linux/switchtec.h:extern struct class *switchtec_class;
switchtec_class is created on drivers/pci/switch/switchtec.c
and then switchtec_class is only used on drivers/ntb/hw/mscc/ntb_hw_switchtec.c.
It is not subsystem. Just switchtec.c device driver makes the their own class.

> include/linux/input.h:extern struct class input_class;
	input_class is not used on outside of drivers/input.

> include/linux/power_supply.h:extern struct class *power_supply_class;
	power_supply_class is not used on outside of drivers/power/supply.


> include/linux/genhd.h:extern struct class block_class;
	drivers/base/devtmpfs.c uses 'block_class'.

> include/linux/rtc.h:extern struct class *rtc_class;
	kernel/time/alarmtimer.c uses 'rtc_class'.

> 
> struct class_interface and class_interface_register() would be
> pointless without exported classes.
> 
> My understanding is that the kernel is often lax on encapsulation and
> exposes private/delicate data pragmatically within the kernel when
> needed because "the kernel trusts itself".
> 
> Thanks
> 
> Matthias
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
