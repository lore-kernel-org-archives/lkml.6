Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbeBGKPh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:15:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:36421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753424AbeBGKPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:15:35 -0500
Message-ID: <1517998516.6606.1.camel@gmx.de>
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
Date: Wed, 07 Feb 2018 11:15:16 +0100
In-Reply-To: <FBF6DCBB-B0F5-446B-8FD1-106E2538A9C1@linaro.org>
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
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:pqEaPVA2aGhPA6KEQWF5IANlcR5hGwLpkt6Iz+zY5W59lLO4UyG
 0P9YUV9mpCzXgE8ca5+xwSPIsWXFsiiwi8raVAds5t/zXG2GxBGwCFPWRKDr90fKASm9UKL
 Vq+4k+bPfYYBUEkhDi5f7nnoRFFkOT9vMfNVxShJF7Nw5SS/8D65gPeNohMEocYHsFFzQ5a
 MDRKqCMK67IkQZSDsUGPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2VkMr5siPww=:XjE41Sk5RbUAHnobFhC0am
 AL5SfZRX0Rf/GibssSoG05jWZcWUEJQf8lvp7NqhGlLmbp77EVvinG8qR6Iet8pHzqSd4fupI
 HIeI/tr4/1B9gz1IvvyHCzRBn3PeB+ZzqlFDiqLi2Ha02YNqlgssnF0KYcxEWeSf/xFOenvQT
 0wWOEhZVnmPkueOnYCqf6dyEx+IaRcrLf16GM4ZMR1rkzHeXPVjoOBNQABn+XRRmVIayoDIIL
 5npIRL04gZw3F2CmyG4VQUQrnanv9vPl/Uw0uP0lxOwda/rpqe8PZ3Gejbxc8U2MNa9q7smBH
 DuPIqIsYqmsQ1pwn8SmUcsq3iGuIS5HXII/GN0E8vhHkl7l0d4/B6c5cDmsrH7YryLYQNyGQF
 fm/Ta0Vz5NoACDegOaUvqXFo1XKmASCzefbT2kDKR6as7pyqSktCs5TXCB27A1t9a+1bFZAeM
 eQX+8Cxs3pwXfYpEDbS2fvCZKYbIFLJVWiiBYCofPys4K7P7oTSEaeirvrNyhdBTwc+kGanLq
 rV/SWdve6Q2Gj8LD4YPGHZEuVemUbAAWegd91RrFET+u60q8pA/Xl/Tig7haQaLCSp/k7W9Nh
 JusRkEq50Iuh279ln8g+svSlj7N7ytbda4NjQn1nbMQ19NGoZCuT+D1P1Z6BbX7Hijh2wn6BO
 aprjY1MSR7s6vzdvs0G1a7ShJGSDM1cIdnOX4rroK43WlS9485P/bVVWAyEZ/Q/sU5kn/9Mc3
 TG289KbCC7SlnmKBp8PlGg6BYtJzQ93GKeiKV3YH6k7/Mv43v390Xm5K0aNNo5iBuv/XQgdM+
 EMe0/z1A68y4QNR4KimnXAzXSJquiMVRtnvZJ10K2NPtjcBuU4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-07 at 10:45 +0100, Paolo Valente wrote:
> 
> > Il giorno 07 feb 2018, alle ore 10:23, Mike Galbraith <efault@gmx.de> ha scritto:
> > 
> > On Wed, 2018-02-07 at 10:08 +0100, Paolo Valente wrote:
> >> 
> >> The first piece of information I need is whether this failure happens
> >> even without "BFQ hierarchical scheduling support".
> > 
> > I presume you mean BFQ_GROUP_IOSCHED, which I do not have enabled.
> > 
> 
> Great (so to speak), this saves us one step.
> 
> So, here's my next request for help: please apply the attached patch
> (compressed to preserve it from my email client) and retry. It adds
> several anomaly checks. I hope I have not added any false-positive
> check.

kernel BUG at block/bfq-iosched.c:4742!

4742         BUG_ON(!(rq->rq_flags & RQF_ELVPRIV));
