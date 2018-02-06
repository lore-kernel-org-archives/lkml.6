Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeBFIrx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 03:47:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:51555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751835AbeBFIrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 03:47:46 -0500
Message-ID: <1517906853.9843.17.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, alban.browaeys@gmail.com,
        ming.lei@redhat.com, ivan@ludios.org, 169364@studenti.unimore.it,
        Serena Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 09:47:33 +0100
In-Reply-To: <34a0aa9dead3a082615899b2830f60f1@natalenko.name>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
         <20180205190510.5499-2-paolo.valente@linaro.org>
         <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
         <1517903761.9843.12.camel@gmx.de>
         <34a0aa9dead3a082615899b2830f60f1@natalenko.name>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:86YeTEQAq/DVYGz/StIiwD2puus3K1YUR9kWgEvSFibtHI5tbqB
 UzurjHaId/gX9RWAnlyF44io2qwScq36WiFgSm185FF7rR0UqINISzf9wbUv5YFvYhzpBFF
 D26v47qfFgphRVY6hd7kaPJvjanFcYI+I7xt6VFkhDVAscHWE5yQnyihf1CSC6AXoES1OZD
 XnWtVjnqpry62dutOYPig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cSUvQVqRL0Q=:l4WLUhbskrqg3rVOgcE1uq
 L7RFVuX084ANbjrm0kWSDa4sdx8h0N+k24YocuJ48Y0TA+C++7PLOeRvmgaahOSeuxWNCEUZY
 hoqZuRJ4xRDKaPMcatbE0Nt6c9HK2Oiwz4TRZ8LvV5C7wVMmFeVEmuCQjWFSJUuc9OQwQ0SxR
 rL5fuSZuM+J/XanagV3YOGZn3zyIvkeX81/PWBwqt+QTB5GqR5Z8cdgrehjk088e60pidpvix
 xWCWCwoj4SnUO8Xbp+HbG0KhpJmDod1hOt944C5oCRsmmDS4y7IGho6UkPVyzwh3xVVw0TOuT
 Yg0VVRTXNTJQUIosqIpmqC7BoVAOd/0V4JHwIq8kgtJ6magxqKBWXZIY5Nw0aiAryyBVMFJGH
 S6ZAkHopY+S+O2cVBFq2qgdJTRWOi2hikA7FvZZTCeCch+GVHRMb4sfye4Z0O2g4FXweaVMVt
 65isqlrYr1HlQFBMrcVyKvAsUs/zbEUYQN9TyysGNPxOG/+qJMJADZkKRCNqdIpGK4fVY4ZL4
 4O8TDHEdFf5Y8M2QDjvcX2HtDG8x6MeuGy72KCUoUnJ+SZT4tZG6xzzmxkunVW1cEgn1CyKEK
 wJUohG23QGUt+JQ8J4o3nwljDy7vsiBFiDtRq/LUPLZcPAMsG74RXi6Vx66ZI49Ea8c4PS6JZ
 kINBl9PWSouHBO/avAF+lNoJ892HA+0rZTXzTYWRrutMx/UtHZLABMIS3Ja43NCS4G+333tED
 rQcLpIIYC72j7lXGDqL+3Sb8lDl1DF3rrms62LwvxgVRMu0xsJrVCWewIWQYj/v4EgQ1h2cQ/
 1OfnkjDi4PHK1HETG9jtCEmx/qiUc3exT0GUm3PzLB08Tv+KpUzsr1XsttaO9r/N2E34xtx6u
 s9OzzF1kHTIYP/QZTTbCu4yC2qxxhZmGV8343oSyPr6bIHkMRTYteO9aB5qGSL
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-06 at 09:37 +0100, Oleksandr Natalenko wrote:
> Hi.
> 
> 06.02.2018 08:56, Mike Galbraith wrote:
> > I was doing kbuilds, and it blew up on me twice.  Switching back to cfq
> > seemed to confirm it was indeed the patch causing trouble, but that's
> > by no means a certainty.
> 
> Just to note, I was using v4.15.1, not the latest git HEAD. Are you able 
> to reproduce it on the stable kernel?

I didn't even try to wedge it into 4.15.1, tested it as posted.

>  Also, assuming this issue might be 
> unrelated to the BFQ itself, did you manage to reproduce the trouble 
> with another blk-mq scheduler (not CFQ, but mq-deadline/Kyber)?

I can give another scheduler a go this afternoon.

	-Mike
