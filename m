Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeCOJJA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:09:00 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:44994 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:08:57 -0400
X-AuditID: 0a3aad10-289ff7000001805c-02-5aaa3828390a
From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: Re: [PATCH] can: enable multi-queue for SocketCAN devices
Thread-Topic: [PATCH] can: enable multi-queue for SocketCAN devices
Thread-Index: AdO8OuhOVzxLUlpJTSaFvMZhLk/1Rw==
Date: Thu, 15 Mar 2018 09:08:49 +0000
Message-ID: <d2afad3064f6458390ad692bec0edff9@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tf0wbZRjHeblrezTcdlwpPKujjBrjnBmlwlyFhSiMDCfbiNEYq4kWuNFG
        2mKvENj4g42J8mPZYGWyCg0u0HSdG6w6rcAsIwsKJjpBDGRugKLZUBYmjOEaOq89WPuH/1y+
        9/0+n+d93udyBEa7CRmhN1oYs1FbohCKcXH6hYTtW9UuTcq9mTS159cpTO160IKpx3rbhOru
        s1ZcPdQRp+669bXgRWGu3fYdnntv9AbKPbGakrvolufjGvGuIqZEX86YlZnvinWN94tK75IV
        NUPjomo0QNajKAKoNLh+wY8HNE19HAm//KuqR2JOX0FQZ3WK+GABwdnru/ngMoL2ppsY/9KP
        oPXYdBAXUunwoeP7IBFLvQ7+k+2CQBFGHYmEmom7wSIJlQW+OyOIL8qGI96PhLxOht6fPVhA
        49RTMPvVsWA9SWVAu30y2BRRCdDT82OwBqPiwf3nAwF/Bwo6+3kfKCnc+d3P+QSnk6CtNSsg
        MeoZ6O5V8mQSWBtmRHz3GBg+M4ufRHG2sKa2EGELI2xhRAfCXUh6kEkpN+x8QaVONhcw7KEU
        VXKhyeBG/JejPMg2XDCIKAIposmobS4NLdCWs5WGQbSDiFRISa/VqaE3FJiKKnVaVveOuayE
        YRUyEkVERNCSxzZbVmDQs6zeZBxEQGCKWHLq/XMamizSVh5izCYeG0RPELginmwsqtLQVLHW
        wrzHMKWMeT3NIAgFkP7nuRlizEwxU3FQX2JZjxUJ/Jlx4Un4sZFE1CBKJaK5s+U7uRYkW6o1
        sPriNXwTj9PrbggdQQeI5SvTtRgxcfsv7vmF4+9ajMaNJiMjiyf3BsahApSuzPh4GtlmUiDk
        AmlYEOo4hyYQt08JKQgMEs39LKE5gPRI2t6kY9bMEPRcJ8dQN0VgP2oG7+QYgm7/PAZLI00i
        WBl4RMDKZ04x9NmPR4P3k+YN4Guu2QgPz7RshBM/XJbCpZVrcrD6f5PDP7aORFi6/+12eNR8
        XgmnmjxKGPf3p4Hn9IwaTq0uZMAfLdUvweToajb0TU/mgHe47WXwzI6+AquO6jxY8p3Og4u1
        7n0ccXUfXOrq3Q911z49AN7Fufw5bseR3I71XzoDO7ZoLf+z4zU3dDlZNUrvmsqbrK9a9u2u
        vDW20LC3YqFPqW3NFtqTe0s3p0bnpDZM5SfGZroXC51vHCfiFmTCXU9mV3dRb111nfO8XfGa
        GX96KGnZkZkoX9nxTbrETTTM3zAMVH0QMZ7jezVry+Hzqbf3bzq6WvesI2Ve0tj5+ZZCVWJj
        z0X6oeAn9+Gte1oUOKvTqrZhZlb7H7lq//LFBAAA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2F999eT008700

Hello Marc,

> > The driver consists of two layers because the HW is accessed via SPI.
> 
> Normal SPI?

Yes, normal SPI (CLK, MOSI, MISO, SEL) plus two GPIOs for flow control.
The CAN peripheral (SPI slave) asserts the additional signals to
request a transfer and to signal that it is busy.

> > I will have to check but I am pretty confident that we would be willing
> > to publish the driver on these mailing lists as well. We will anyhow
> > ship the source code (or a written offer) with every distribution.
> 
> Sure - can I find your devices used and low priced on ebay :) ?

That is rather unlikely. Though, you could buy a building containing
one.

> > If you are really serious about the review I will get the process
> > rolling for an early publication of our driver.
> 
> Yes, please go ahead!

Ok, I'll kick off the process and start to collect the required signatures.

Greetings,
Mark

Bosch Building Technologies, Panel Software Fire (ST-FIR/ENG1) 
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY | www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118 
Aufsichtsratsvorsitzender: Stefan Hartung; Geschäftsführung: Gert van Iperen, Andreas Bartz, Thomas Quante, Bernhard Schuster
