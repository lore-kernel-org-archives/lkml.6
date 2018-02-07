Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeBGLDf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:03:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:60506 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753476AbeBGLDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:03:33 -0500
Message-ID: <1518001397.29698.6.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Ivan Kozik <ivan@ludios.org>,
        SERENA ZIVIANI <169364@studenti.unimore.it>,
        Serena Ziviani <ziviani.serena@gmail.com>,
        Holger =?ISO-8859-1?Q?Hoffst=E4tte?=
        <holger@applied-asynchrony.com>
Date: Wed, 07 Feb 2018 12:03:17 +0100
In-Reply-To: <5584030F-8F4E-4C98-84A5-79873A1BF775@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
         <20180205190510.5499-2-paolo.valente@linaro.org>
         <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
         <1517903761.9843.12.camel@gmx.de>
         <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
         <1517918234.25841.31.camel@gmx.de>
         <77124223e6116350a5184a5199850304@natalenko.name>
         <1517924768.25841.32.camel@gmx.de>
         <8842084cc8a26b7f46ae600bda8a7bd0@natalenko.name>
         <CC8CDDA5-A232-41A6-BE1E-CDB0B361C3DB@linaro.org>
         <82ffc96aacc3945861cbb708df346338@natalenko.name>
         <E52CCDEA-279A-40D8-AD9B-F4D1AF351BF1@linaro.org>
         <1517995431.25619.5.camel@gmx.de>
         <FBF6DCBB-B0F5-446B-8FD1-106E2538A9C1@linaro.org>
         <1517998516.6606.1.camel@gmx.de>
         <5584030F-8F4E-4C98-84A5-79873A1BF775@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:XQzQx+7iEiGwZkuoEo3hnypBuiGqH9RV/ZTdRlUYeyT9YmYXMQ3
 ypMawGVRV4pf1G/kvYm88c2Y1T2rZCweuxTZkEQkubrLAQNBbhe8bVKrmM75m/tuNuzi0MC
 jlYUoal2vCnpR5Gr6XyvsZ6VWOlfN6PXKLnltep3ZMiQJCrka26kxTdOiHkgzAfmR5WhLHe
 a4T2v70lrHDURcqjMzM0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1UjZHybs+0U=:/25OraoP8ccHGlhysE9miJ
 EfRDcbT162/+CkDGeAuJdwyqRj/E81BXzIBqjts/ShtQW2gg50qdKhbdbSdKUddYp2ztI5Qzz
 6RQhZ6ca2Uwp2FETgRiqacsfKoVEGWZS/GpujfRjCoSBjBP/ZbULHp84qzGqAkML47lrBSKLW
 wYPbEgJi4FY1mQBRhwlsK62y8160HjugZM4HZSA6k03WUri0ETVp97hmO72xmNUHYorL5/gSD
 cdM2U9O1fZ0RN9MIgB8/kS73ujmV9BySQsA1rGDRRVlMpFUnkw/UFAfZSc16lREGpU3t0ffuQ
 FEM2ukdxBP4M5YyfZdxviNCAeoj/EEbKxxboXE2qpCAkya2fmh25tYuzyaby5+J7bUBuc2Kby
 qp0/QSaCVllb0Y3yN8T2ElXOvdoxkM8omLTMxQiMRbSUHmkVhokd1MoBVUmBmAs90oAOs5iOA
 L6stlVpE6fnXDI+flAdoOfoD6G61mlqA8E9CYvHRBWgvAB0Be8AWV2yByIxb/Epg6h559R4bH
 zSfoFFxVS0n79PIAM8OE52bkKA9GiKFxohcsGuAm8YI8DJ/gG0Yrs2fTUSKtmpTV+B2vf8Sy1
 KoybGxgOGGX8ZVy8xYFgsF+c/UbW9SOsT2r+MiyO/uSL/PbUcCXG3Z8TNqLYc7GBNgY9AWwt+
 jmgSg/5UmPdoeOJlDlaapjA1ankmzBLYbVtkF2/tLjZ02Or/EUTyVx/gYSBxfaCwd9TEFQFHn
 UUj+3I9B4bt33+nKRdhS+QkQbGU173Mpa+/YetGhl1uedO49XjGJADtNG1KjPZ8hbHuCdZcfz
 op/JXgtD6IJdUIFvHl/tNaPUf1C59T6IZSzudBXQvxZWXK9Ihk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-07 at 11:27 +0100, Paolo Valente wrote:
> 
> 2. Could you please turn that BUG_ON into:
> if (!(rq->rq_flags & RQF_ELVPRIV))
> 	return;
> and see what happens?

That seems to make it forgets how to make boom.

	-Mike
