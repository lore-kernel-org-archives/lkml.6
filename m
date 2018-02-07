Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbeBGLWQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:22:16 -0500
Received: from mout.gmx.net ([212.227.17.22]:52741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753785AbeBGLWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:22:14 -0500
Message-ID: <1518002521.29698.14.camel@gmx.de>
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
Date: Wed, 07 Feb 2018 12:22:01 +0100
In-Reply-To: <ADDEE2C2-9AC0-469D-BD28-05748C6EDCDA@linaro.org>
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
         <1518001397.29698.6.camel@gmx.de>
         <ADDEE2C2-9AC0-469D-BD28-05748C6EDCDA@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ZK/4X6VykiYty7bM3bRExopZrQsDejyBSvx+cb9cWGsmj3V1txG
 +MHj64WOhaa6XKKDPn9esITZhaMW2gUPzrNSllHrpTykMH7GMp+rY2WD/k9v9y2G05gtEXW
 Tx8EG7zTo130MZvwFJAQozTwOe9Ri5Vgc3eloOckjy0K/LIck+GFsWQokSDv+7S6MXBvP2C
 LQ/bi5CWDI0F+bjiknWiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mV8Qaxpka3o=:zLmswbO26vu7BsDBcBj74N
 n3R+yll2TVYj9khAf5hzSpjHgM/LSXOOao1O/nt2bzOdqqCptG8FZVqX8md4sEG8BcStMel9w
 vPSodFcw4gTyTcaGOf9We9i+cR+So/Odv5n1YLOj4h1W/jGQYBLtrdZ5E9fvWJ19mgSizYf04
 CO5fRpvyEnreyZ9kFcEf+8ZFTHYGq0dwAZn0VmDMbHwd3C/qd8j6ZSUH1bUEpUvHMMTgjA+vW
 OvoIqQPpoayL7CyJ4TDAv/HtOPAQZlvNWAVl15Hb3rCQFKS/v/UrTPLbDuuRBIDhnIheBJ4Kj
 yE6B25YBQeEK817iLtb4UeHSWmCTRx0CZG7fMEtcA6c29eMxGA/5tNz7vUdXgY38Hjqv7TERH
 MOUmvlvlXVTeD4JMCZhkPedL8mJdgMf365GXf9YbmCR6yIbnq+QeHuIAuR+4VaIcOY6qhOI+L
 pnOz2Wrb+4wimKcBXYAthudBjFC6TsBEXQtsxHIqRNiGR5fGnxYPieh+yzSsfb0RxUxsazfu6
 bso9W5SgmU3rEBi8T++vFmMsOx+ZOjcn6miUdBZf4Wtrv9YBmRGZQbYPTkeYz9q4EIq346qEG
 Dqcv44tN5gMtOm2Dc08SdxkMCkbNNLXOaQYpD60vZPH3cNg8V2X80qmpyQA/1NdT7HObFr2yb
 YrNdphHgTa4jIHmB9QAiix1UYCE6wQq8GC/38n/ZOcSmxbArv1BcjLa0/XOQ/hqoshGKh6GxA
 9h32KebzXT9Z6dG6+NDmFyEQWL4djGrRxigsO7E0YwcYs8VHWfTtNYPcnlpisNR0zLWhUyvne
 KC5+S44i0CyUMAbXmCJmMavWRjYJqcSTxCBJYts8lIk5YiNWfo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-07 at 12:12 +0100, Paolo Valente wrote:

> Just to be certain, before submitting a new patch: you changed *only*
> the BUG_ON at line 4742, on top of my instrumentation patch.

Nah, I completely rewrite it with only a little help from an ouija
board to compensate for missing (all) knowledge wrt BFQ internals.

(iow yeah, I did exactly and only what I was asked to do:)
