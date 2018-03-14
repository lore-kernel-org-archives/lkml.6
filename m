Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeCNQvq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:51:46 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:41180 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeCNQvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:51:41 -0400
X-AuditID: 0a3aad15-083ff700000062e5-47-5aa9531cbe77
From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH] can: enable multi-queue for SocketCAN devices
Thread-Topic: [PATCH] can: enable multi-queue for SocketCAN devices
Thread-Index: AdO7tG8amYWoZjUaGkqac9wy28Ktbw==
Date: Wed, 14 Mar 2018 16:51:38 +0000
Message-ID: <1e51047cd14048e99989ffcf9e10ffa8@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tf0wbZRjHeXvXciu97WhpeVYGupr9IXNAEbNKjejMEkZMnJiZrIm6Qw7a
        CAV7hYypE1hAQVR+bxRsimjTNTqgQywdk63qdCO6SEkYYzLm0ACDDYLbGseYdx6s/cN/3jzP
        93k/3+e55/ISmNxJqAmT2cpYzHSBRiLFpelfx+/Y8spxQ8rls9t03itXMZ37bgumC/g6JLru
        z5tx3TmHSvfl5ID4OUmm3fYznrk0MoEyP72fkrnsSdiLG6TP5DIFplLGkvzsAamx3N2PFbti
        DnbaL0rK0bSiFm0ggEoD57ejeC2SEnLqqAhOOB2RQnIawWzXuEhIFhB89ckDJCSDCEb7T+A8
        L6HS4QPncCQfx1D7YLX+MzF/CaMGRNC54pLwBQW1C+7NXkDCpRegYuhDiRAnwbmuKs6IIHBq
        G8zXJfIySemhzmP/zxNR8dDTcxHjY4yKBc9fd8XC3BR8MSjoQClh9vqqmLcBait0HNvFhxj1
        OHT7kgVyKzR/dC1ScI+G823TeD1S2sJMbSHCFkbYwggHwt1ImceklBZqd6Zpkyw5DHsoRZv0
        ZlGhBwm/S+lFnZ2v+hFFII2MLMs6bpCL6VK2rNCPniJEGiU51OwyyDfmFOWWGWnW+IalpIBh
        NWoSRUREyBUPZbYkp9DEsqYisx8BgWliyEE9Z0Xm0mWHGEuRgPlRHIFrYsm63HcNciqftjJv
        MUwxY1mv6glCA+Stlzkw2sLkMwfzTAXW9bImXuipCq+EtxURG/zoSULG9dZm873ZYrqQNeWv
        4ZsFXL6uhtAL6CXizumpaoy4NHODO/uc89WYHDcXmRl1LOney3lRPGUsMT+cRr2FfE3mNMiV
        YYWQ4xwaQ9w+FeRmfhAZ90JCcwDpVXTsl0eviSEotYtjKIcUbi8yYK+0wNB4AMFkZbUIrlyt
        waB7dQGDy8EeMRzz9UnAf2eCgOCZBwRM3jwSBaOVl6LAszQfBafsH8tgqL1xI9xrPLIJ/mlr
        2QRBT4MKah2tKugN/pAAp/6oegwqPX2J0FvTtB1m6ieegL9v/7QDmhq8yRAY/CUVvK3XdNB7
        3q2HpvuLehjxVWWArc2XMcetWMSt2NTv4ldspa3/s+I1NfRt6nLUlxczFtztztoTlZFtb0x6
        8ZvfB2+efNtYcXjU9eNy3I2l1Pf2Z30XmLOlN7i6Hz05s1yRqZ06MJz2yG8JadCO1dxaGY8e
        CJxd+n5Fpcf+PDpVzexbmZse1raPJVccHgn+ultkfP7p12fZxfTrOx1065ll3WJ2S8c7E3Xb
        R7QL7zeXx2lw1khrEzELS/8La0ocr7kEAAA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2EGpnth020690

Hello Marc,

> >> Do you have a driver or a patch to make a driver mq aware?
> >
> > Yes, we have CAN hardware with multiple queues and we also have a
> > SocketCAN driver for it.
> >
> > IMHO the driver will be of very little use for the Linux community
> > because the HW is proprietary.
> 
> That doesn't matter. It would be the first driver that makes use of the
> feature, so we can learn from it. And you might get a free review of
> your driver.

Of course we would be happy if somebody was volunteering to review
our driver for free.

The driver consists of two layers because the HW is accessed via SPI.
So there is a SPI driver of 1000 lines. On top of that is the CAN
driver and it has 600 lines. Because the HW does more than just
CAN there is another driver which implements a char device with
additional 300 lines.

Are there still volunteers?

> > Our motivation to separate this patch from the proprietary SocketCAN
> > driver
> 
> Looking at your email address I assume your employer sells devices with
> this hardware and the driver. So someone has to provide the sources for
> it anyways to fulfil the GPL license requirements. :)

I will have to check but I am pretty confident that we would be willing
to publish the driver on these mailing lists as well. We will anyhow
ship the source code (or a written offer) with every distribution.

If you are really serious about the review I will get the process
rolling for an early publication of our driver.

Greetings,
Mark

Bosch Building Technologies, Panel Software Fire (ST-FIR/ENG1) 
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY | www.boschsecurity.com 

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118
Aufsichtsratsvorsitzender: Stefan Hartung; Geschäftsführung: Gert van Iperen, Andreas Bartz, Thomas Quante, Bernhard Schuster
