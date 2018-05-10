Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756313AbeEJEig (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 00:38:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:58205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeEJEie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 00:38:34 -0400
Message-ID: <1525927108.7533.1.camel@gmx.de>
Subject: Re: bug in tag handling in blk-mq?
From: Mike Galbraith <efault@gmx.de>
To: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Thu, 10 May 2018 06:38:28 +0200
In-Reply-To: <2b65d736-aef8-5da1-96ad-c86a931d59eb@kernel.dk>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
         <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
         <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
         <1525755090.24338.1.camel@gmx.de> <1525768632.5208.4.camel@gmx.de>
         <ffd0c030-43f8-0dbe-42b3-03bb9c410bea@kernel.dk>
         <1525797766.5204.2.camel@gmx.de>
         <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
         <f04636df-3f97-6c16-f37b-d407e062b9e5@kernel.dk>
         <57952405-bdeb-f4e4-1aef-a7c0a8a68674@kernel.dk>
         <1525839089.15732.1.camel@gmx.de>
         <ce5ee556-9552-6ffd-7578-7b3b983c07bf@kernel.dk>
         <1525885030.15732.6.camel@gmx.de>
         <1e51eb57-6d9b-a53c-9cd6-2adfc86b21b5@kernel.dk>
         <1525890708.11382.1.camel@gmx.de>
         <2b65d736-aef8-5da1-96ad-c86a931d59eb@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:d5YgUoZJx1wp3Q1hm++fZ/3Vlx3ko4Akz21RLfWKLC+jBq8NfCc
 eJlch3ziHMGGAYG7mkd/6mTd8dvV3b8y4BCZRvhuHHT8QC019dD7APQgF/3/ElG+5txqjBO
 6/y1xnStg7CRfn1vdNkvLGrWKQSHpoRhu8vKbNgdVu+QRdSxfOQzLNcLxbU8mFWSgTuBsRK
 RDmhQVzWETUkNKPfGjNog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lkWZ5n0gWsM=:hlv3Eq6p6AaDOUTOWnnhtK
 z9wn/w97nAOrC0mXOkkysleycniU3yGf1asXzys+1EWJPIiB5Xd5XIuT3YOqon/R9AS8du1NX
 QxaulqfadiHeLi7KGL0B9iVeMO/7jWNFP67LyB3MCpgc7+EtWjIda1bqC6iltsfZZAiOyOC+j
 8KYuK6Wd2Z6dwfTldl3YFPiqLumUpWn1Y5HRXfME7DksNp5d8NY5cL5VrM1iVe/uXrUIZalvX
 4k6ikx5A+AZtdMnvZENCFaSzkutnZK2a/j4YmNK+VBDoHphWKW1w7XUSKWD9xVkJK5Bw+3u/W
 Wm1JJ/GsnZEac2BT8KQ5tcjBZm1sfozhS557ZaoHObZuuscEhn27EDo0HNxFUVugnIyzCJIjC
 +0xLwc7IOUlB0zF2ihUKRFj+elE2oNWhyC6HAdVfFV2l8PR2wB7UwwY1/ubaOUiWeQI7fvue5
 d//lRX8LoR19pnl1N0b4j3O+AVEZYvV2knPwFiVTX/WgM0n1w1BTSm9hkauCFzB13PnQ4uQL0
 YXxLIog2g6OgtgD+40zYClohV5rbmAx6Ey/tCS8Wr1dmvGbI40TsjkZWGdzObn6BYZQNPONle
 FaMmIf/xEUv4n1/fYWYyjEwojtZ1btd2iUwagqRk/+wQgVFBkcICr3+WCBUvlFcKR/0u8+bcO
 iBqHslUiQHR16Yx8yss/099tmysb4Z1aeHp5Z0qwzIqDlBbOFs3oORs1BuuykdVNpDVezxJXp
 V6Bl1a7GPv1/kZU3fFXXntMB9rY36ur0PKeksgzC7+Dwj7sL65H+GReD7b8BkQf7UCRTv/2cg
 Pbv5bDQ
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-09 at 13:50 -0600, Jens Axboe wrote:
> On 5/9/18 12:31 PM, Mike Galbraith wrote:
> > On Wed, 2018-05-09 at 11:01 -0600, Jens Axboe wrote:
> >> On 5/9/18 10:57 AM, Mike Galbraith wrote:
> >>
> >>>>> Confirmed.  Impressive high speed bug stomping.
> >>>>
> >>>> Well, that's good news. Can I get you to try this patch?
> >>>
> >>> Sure thing.  The original hang (minus provocation patch) being
> >>> annoyingly non-deterministic, this will (hopefully) take a while.
> >>
> >> You can verify with the provocation patch as well first, if you wish.
> > 
> > Done, box still seems fine.
> 
> Omar had some (valid) complaints, can you try this one as well? You
> can also find it as a series here:
> 
> http://git.kernel.dk/cgit/linux-block/log/?h=bfq-cleanups
> 
> I'll repost the series shortly, need to check if it actually builds and
> boots.

I applied the series (+ provocation), all is well.

	-Mike
