Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeBGJYK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:24:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:50600 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753147AbeBGJYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:24:07 -0500
Message-ID: <1517995431.25619.5.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Jens Axboe <axboe@kernel.dk>,
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
Date: Wed, 07 Feb 2018 10:23:51 +0100
In-Reply-To: <E52CCDEA-279A-40D8-AD9B-F4D1AF351BF1@linaro.org>
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
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:fM0a06oiYz9M58ACLK+gKVfA4H7ObZiI01O7dt48FODuFnnIwRS
 ZAYSHoVNK03zHiBF4UPJiXCwMUEJZV4Hrurt2M3EbjN96CIEYF8UavxlQcb63lUejtQMpsQ
 fSQgD5ZiFYDVhSNhH2UNKsi/IDoYeVWp0olTCA9QYgAE+uTnkif/zckGAn9fn8/lGrT574H
 LUU3OgA8d9+0XWLfldXaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BqjVxHeI+xQ=:5eGD+Z5D+x24jqp8QGwk5h
 ni6/XubQ0U0jl4eA1RWQnB8YzqSbhinkKGqh0aqU3qIwojzd1THmDNCL3vpHkWwSuy5HKC80o
 J+6eaR3S8750hmhlbP0V5mEb/2cC0PJimGoDPIEyJcSxltmfULGqNt1PLAyEVMvV1Ny4rz6UD
 v8zGb9IxbpvrPR1SRzZPkweKbfAnf615NTdcORryDg++WjddIciWTXDZ5LjaEsaqeV89EITpM
 3QxzcCH13c5SEYZNJAhDGuTYdqH7/tBvUft2pxlsO9DzdRqA1/8JL4ikk04J9eHzbwIJBDvuN
 cWQVAKsLhdo/oOcFx76FQ8/2r7RMFURQoERzOgzAA4sJHbHs8dK21J1aGi4d44QTjzxT/aejA
 BIiRO+Pm/ZcgcEJzt1Qzi8rRVKvAWg88Vptib0AWjGfiglINMKb4fR5Qz7cbpNll8lNzIAdWg
 XC8L4fa+pWJEYNS93e6zaqkpdRWLlJtu49L/ZJpJnzBZZmAwUBB/j7dfdZcIc5mmW5ljlSDYv
 6dDrXikTYLTZ9D3nAk2pTJCUDEiFwo3bU68cnTnUVGbg10bRMDJ1NRXxnKQe4vi9EhBYJ7hjr
 ujbfizAqTIrTfDf9RZEjuVSCi3NKnClygTo1RxRDxUKQMCdgmBQsDFCAn1pxEA3Z78iMIXNu5
 Avjc/Hpz1YGWoOPSGm7cjm//QnfBPSoYUPE2D35Jn05M8cRnV2lQ5RoNd4Eu2JQk7LKhABer6
 19JqMZEcpPVwTsXQ2kkjPxYTc4t4aFibGNNXGPhXjKaF/m7ydxcL6itYFRo0pZzewIsNEICg9
 sQm9n4svyb2zTLRwOrjGt/TFIf0hhoKWBZViyxT/2S4uYD4dBA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-07 at 10:08 +0100, Paolo Valente wrote:
> 
> The first piece of information I need is whether this failure happens
> even without "BFQ hierarchical scheduling support".

I presume you mean BFQ_GROUP_IOSCHED, which I do not have enabled.

	-Mike 
