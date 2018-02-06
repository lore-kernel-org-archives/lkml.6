Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeBFNqa convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:46:30 -0500
Received: from mout.gmx.net ([212.227.17.21]:58060 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbeBFNqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:46:23 -0500
Message-ID: <1517924768.25841.32.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Alban Browaeys <alban.browaeys@gmail.com>, ming.lei@redhat.com,
        ivan@ludios.org, 169364@studenti.unimore.it,
        Serena Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 14:46:08 +0100
In-Reply-To: <77124223e6116350a5184a5199850304@natalenko.name>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
         <20180205190510.5499-2-paolo.valente@linaro.org>
         <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
         <1517903761.9843.12.camel@gmx.de>
         <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
         <1517918234.25841.31.camel@gmx.de>
         <77124223e6116350a5184a5199850304@natalenko.name>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:NQKfyg7lpStcMh45QK9tsQJ+yWUwm6q1HseaXeDKlXTugPD+4ix
 rxk7aJEv0drzRNH3zEncfJ8HxQpLAtLjH8elrHodyLXeGVNd28Dw7ZBKeaw7xMItTWw/vBm
 78/50pCiCK+waj/dCkFflXSct6ZalRR9Sz/LTUeZeWWngTpP/vHmdqGPR4ShWVuZ0SJTrnl
 Ki54jqrXN0/5Mc47lz2FA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dv3v5wr1IJU=:4LQjFfGs881W/MVc6ZBIr8
 4/OnUEQRnrYvlteW2oj+GflcSTFpFMqfafuw0qlWArBXs5J8fAK2QkAPGV/qH5FcjYzO8NrU1
 2mJAqvZ75Doxp1rhYUr8G/LbmvUFbnfFjViCJmxDMtieJV/fvkOrtT0IvID0OnnYAlwk0hBY2
 pluLRxZTzXz4ZQ8cBNoeOcH8Mc+R8SV4ropOJpqmHK0Y1obF9A3p+i6L9kbliuqsWmpYAmh4a
 7eI1ge7PXW/OfrcLVyXnOlD92g0g818rPGnME+1g+JxVFoxb9jzLIKvc4YHvY8myL5AoW1tMh
 PlZIeuv03pIXf6JSVPChND+jQXFGLJP2X51h3OiWTR5+XAUCtUUG5AujCzUuMvE0mk/HLmpwy
 EC2H2U2fHhOomSPoZ0u9N9JmKHUkBLeIoAD+FOl2vuTzCVCYnJLas0oFzLFROu21nNGMkLP3k
 ld8YyolHGrJmSvmzgP9cK66bKMkjoUh7dJlWJMEs4TtX2R5ATeo9dI8JqDfLYGcXP+GKGpGyb
 WJzdclJ54Y16QeYOt/nllLnhoMW89i87YikOavWKN6zwfT9CumqTQk/HAIBCbyALQI764b+xC
 CpuyERMAqGv0XHJBUUygZ5bL1sZ6UyECqn42oGHkK6KKezAwKmWKKnq1sJgAgOkcDXAPd4e1W
 kQ7GlTY5vJwH0/5SMftXoysbShhjmDDkbmG8mzr/EO173niiAIM2sN66geGKdibv9bJ+/X5KM
 GwU4N/3BI4FqY/X3UwIaHoGI7HUB0jb6piejU6ZWNKUQJ8/owF4bQdmBx35X0BhgumSTJ3Hu8
 73CFqjn/6AS68+LmldsJANNVat3DZv4yQmz+o8yKy4OnWeVlncqwYS2c23sYq4UyJ7H96HuJ/
 2HqQiiZBpSDpJ/HCJf6xSuJfKzJ3J8DfMBy5u/WTszUD2qcdKSThHRH9grCeID9dhXvan+NlK
 3MFqbHVmfpA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-06 at 13:16 +0100, Oleksandr Natalenko wrote:
> Hi.
> 
> 06.02.2018 12:57, Mike Galbraith wrote:
> > Not me.  Box seems to be fairly sure that it is bfq.  Twice again box
> > went belly up on me in fairly short order with bfq, but seemed fine
> > with deadline.  I'm currently running deadline again, and box again
> > seems solid, thought I won't say _is_ solid until it's been happily
> > trundling along with deadline for a quite a bit longer.
> 
> Sorry for the noise, but just to make it clear, are we talking about 
> "deadline" or "mq-deadline" now?

mq-deadline.
