Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AE5ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513DB204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513DB204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJQSqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:46:25 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeJQSqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:46:25 -0400
Received: from [192.168.178.69] ([109.104.44.135]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LcbEF-1fka0d1ItL-00k7BT; Wed, 17 Oct 2018 12:50:56 +0200
Received: from [192.168.178.69] ([109.104.44.135]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LcbEF-1fka0d1ItL-00k7BT; Wed, 17 Oct 2018 12:50:56 +0200
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
To:     Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Eric Anholt <eric@anholt.net>
Cc:     tuomas.tynkkynen@iki.fi, Phil Elwell <phil@raspberrypi.org>,
        devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
 <1715113043.52878.1538821118324@email.1und1.de> <87a7nf5gr9.fsf@anholt.net>
 <CAAoAYcN_xVvi2-dUcGobVcMEtjFTV=Hi7OFr2vuEF08aQkVWHA@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <530d012b-50c3-ca03-a37e-fe62ac309e02@i2se.com>
Date:   Wed, 17 Oct 2018 12:50:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAoAYcN_xVvi2-dUcGobVcMEtjFTV=Hi7OFr2vuEF08aQkVWHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:hjvPuCvfNVRTTb1RCmWr5FlttXPKu9tKmoqkUWpn2QZ6FwpspiK
 +061o2yoWERWFC8f4qaqLkEybP9gyItzPaeFhIUk67LYVoHwz2Vd+vPGDiaiGJPQLdmxdNl
 ZeUTiWyUpa3C+RMHXRgytCygDyrzHmuy/CKikHks/z0N2EPAbqRTWcrPRCMv9jQn2o01lrP
 /MR8tniUjMWyD+V054DZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SaUGiqW4Fk0=:zDZV24LqlJwZTAart60GLG
 Yq5dxY90hBShiXbP8g0qXV+B2HH3/YPplO2IGFwc0GNIRe1cD0kV9HCktBomH/Z/tw3pJtKMP
 zPoZwKTy9nr2Kj3EaZHw8u1jW3lxVI4CqjZbdejhZF3jx1qM1uE0H7IvUdnvTxiQPlLXW0G+n
 kaFZHbMNUOR1pxRK4tmz1VKx+4XdYk5n3PJ+jQtDhhR4vww/rs1Mnt4e01d/31K0dXWawUEPB
 TOdWKJmPVAwrNq60Pr3ix/0iyQtpNAAsn55g3T+zWPLR3OgBJUT8O/U1pox+Ee1v4punjTA/s
 D7WGfJyeFD+SJzTw4ldF5mX880g4GEAarZeC3XyVj3bTy1rAFVSuwOJ8wTjSwZEHcGa5cOH2N
 y5Ks/SZwiZNdkj3k5DO5I0/53OQZfHYYWife+MaKm1nA+4t4teTopMBbe2hgcJvCOOM85hBTg
 Sk/YvztS+j+deIsA9i8PGu7pICPT1IMmwewjUND9xjF8s4f54Wi2/7IZXJDORlFVRJJflasBo
 Odepn/Xz1ZyAUOOC2Yo/jyWb6OmetzlUmm2g3uKvIhNPX5OF55R7hxjvR1jRNJQ/IosCicPkV
 U6jea1Eyrqbt4WYBi1uuc62GsRMUJv1B7ywBm0zYNnvvuB06F4ii++2pgzlxHXdtlSPsHZtl5
 o6fsvHjRR7x5LhZhDewlAhAjNWs2rn3f2w6GF+KgeoL/LI9LgWIyuFP0Clh65jyw1ztEJ+QSU
 Dyw6M721CFjkK+Bl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 17.10.2018 um 11:55 schrieb Dave Stevenson:
> On Mon, 15 Oct 2018 at 17:27, Eric Anholt <eric@anholt.net> wrote:
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>
>>> Hi Tuomas,
>>>
>>>> Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi> hat am 4. Oktober 2018 um 11:37 geschrieben:
>>>>
>>>>
>>>> Drop various pieces of dead code from here and there to get rid of
>>>> the remaining users of VCHI_CONNECTION_T. After that we get to drop
>>>> entire header files worth of unused code.
>>>>
>>>> I've tested on a Raspberry Pi Model B (bcm2835_defconfig) that
>>>> snd-bcm2835 can still play analog audio just fine.
>>>>
>>> thanks and i'm fine with your patch series:
>>>
>>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>
>>> Unfortunately this would break compilation of the downstream vchi
>>> drivers like vcsm [1]. Personally i don't want to maintain another
>>> one, because i cannot see the gain of the resulting effort.
>>>
>>> [1] - https://github.com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/broadcom/vc_sm
> I'm happy enough to work around these changes. Once the change is in a
> released kernel we can merge a modified version of vc_sm into the
> downstream kernel branch. It's not as if it requires big changes.
>
>> I think the main concern would be if we removed things necessary for
>> 6by9's new vcsm (the one that will let us do dma-buf sharing between
>> media decode and DRM).
> The new vcsm uses the same VCHI service as the existing downstream vc_sm driver.
> The video codec driver don't use any VCHI functionality over and above
> the camera. It goes via a slightly extended version of the
> mmal-vchiq.c, which I have split out into a shared module.

my statement about the old vc_sm based on assumption there wont be a
user of this driver.

In case the camera driver would use the new vc_sm driver, i would be
happier to see this merged in staging than in downstream.

Stefan

>
>> On the other hand, git revert is a thing, so it's not like we actually
>> lose anything.
> :-)
>
>   Dave

