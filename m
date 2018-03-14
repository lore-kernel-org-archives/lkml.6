Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeCNM1D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:27:03 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:36696 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbeCNM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:27:00 -0400
X-AuditID: 0a3aad17-cb1ff700000073e9-6e-5aa91513004d
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
Thread-Index: AdO7j74LmYWoZjUaGkqac9wy28Ktbw==
Date: Wed, 14 Mar 2018 12:26:58 +0000
Message-ID: <9ce65a3a1535456dbad7120c5775a8f9@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22TfUwbdRjH+7u7lgN787jS8awKbrdg7F5YAecaRsxk0dW4bBrjH9QYV+RG
        q9BiDxDI4joMZWy+dIFls4EGzVa76cZLyIQNHOkSAmW+DhXFsG4g4W1/IBQQpXjHwdo//Ofy
        PN/n9/k+z+/55Uic8ZEa0mIt5uxWUwGriCPiMq8k7VSpLxl112oe1bf/cRfXX144i+vvXK9X
        6Js+ryP0PY0b9ReHO+T7FAaPu5cwzPw0hAyfLOsMs63JLxPGuKw8rsBSytl3PXskztx8/1dU
        9B1TdmfkNOZALuYUiiWBfho8ni/lp1AcydDnMHhQ5UVS0oWgrb4Gk5IHCALOq7iUdCKYG3Yo
        RF5BZ0K1tz9GjBPo1yDsalj1wukODD7717d6SEVnwz8TASQd2g8nbp5USHEqLPYHV3WCToEf
        r/yMizFF74WPKmsIMUZ0EjQ3f7+q43QitI4tyKXBabjQKelAq2FiJCzopBBvgfrz2WKI01po
        ur5LIrdA3el7MZJ7PPR9Okq4kNodZeqOEO4owh1FNCLiMlLzFl1pYbpOn5Fqz+X4Cl1a6lu2
        wlYkvVdiO5prMfkRTSJWSWlll4yM3FTKlxf60W4SY9XUzTqfkdmQa8srN5t485v2kgKOZzUU
        kslkjOqhzJfkFlp43mKz+hGQOJtAZW8QrKg8U3kFZ7dJmB89RhJsIvVh3jEjQ+ebirl3OK6I
        s69X95IkC9SmBAGMt3P5XNlRS0HxeplNknpujK5Et8XIWD/KIJVC72mV2JsvMhXylvw1fJOE
        M+tqBA2gw+R8V9CJk4PjU8K3zTvtxBnCarNymkRqQPSiRcpcYn04jeZx6g2l18ioowoRx0k0
        iIR9qqgD4l2Uwi8SmQOodlV9DhO/Jkag9AsCQ3eT4Km0w3ClE4Px7iAOve3VBCw6agn4+8wY
        Ab0LX8vBPz9EQs20MxZC7pVHYGDkohIGvh1Pgl/aAskwesLxBISCoc1w437VVuibaNTCuKNN
        C311S1poqandDiuhP3fAwAcuHQxWdemgY3khDXyBqXSYdTkzIOT07IHBrn49hDubsiC0+M0+
        uBH87XkY/eLuC5PCjjFhx5ZrPnHHxabi/9nxmhq5nMaBPj77ysED1uqTB2Nftb30w+/JLdXL
        5xoSUpe+es+bggVrG7ZpjoSWxu71PJlS9tyUGb0YO1tuaN596FBP3+Rf88mvb28N5+ycuaVY
        yZuhMtVz9OZ3Aztuu25XdL8vy6m4xWJ7fEBohow56Nh+WbftfNbRmGfCTx0/vPX4wmzZ1Y63
        2WSW4M2mtG24nTf9ByDcv2y7BAAA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2ECRBHb001611

Hello Marc,

> > The existing SocketCAN implementation provides alloc_candev() to
> > allocate a CAN device using a single Tx and Rx queue. This can lead to
> > priority inversion in case the single Tx queue is already full with low
> > priority messages and a high priority message needs to be sent while the
> > bus is fully loaded with medium priority messages.
> >
> > This problem can be solved by using the existing multi-queue support of
> > the network subsystem. The commit makes it possible to use multi-queue in
> > the CAN subsystem in the same way it is used in the Ethernet subsystem
> > by adding an alloc_candev_mqs() call and accompanying macros. With this
> > support a CAN device can use multi-queue qdisc (e.g. mqprio) to avoid
> > the aforementioned priority inversion.
> >
> > The existing functionality of alloc_candev() is the same as before.
> >
> > CAN devices need to have prioritized multiple hardware queues or are
> > able to abort waiting for arbitration to make sensible use of
> > multi-queues.
> >
> > Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> > Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> > Reviewed-by: Heiko Schocher <hs@denx.de>
> 
> Do you have a driver or a patch to make a driver mq aware?

Yes, we have CAN hardware with multiple queues and we also have a SocketCAN driver for it.

IMHO the driver will be of very little use for the Linux community because the HW is proprietary.

Our motivation to separate this patch from the proprietary SocketCAN driver is that we felt it was odd that the multi-queue infrastructure is in place and only very few lines of code are missing to offer it to the CAN networking subsystem as well.

Greetings,
Mark
