Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935575AbeEISb5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 14:31:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:58747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935545AbeEISby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 14:31:54 -0400
Message-ID: <1525890708.11382.1.camel@gmx.de>
Subject: Re: bug in tag handling in blk-mq?
From: Mike Galbraith <efault@gmx.de>
To: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 09 May 2018 20:31:48 +0200
In-Reply-To: <1e51eb57-6d9b-a53c-9cd6-2adfc86b21b5@kernel.dk>
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
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FY3CyKR7HrlKiGoJ02IipwjBvaruK/6rrh3na0ctYlhvlhCqHYU
 HBuMF/5zMMJjeuhJfd5JTvdxfTth6xf/r8O2Emvs8uYPQEhF6FSRlKZ6vlAwYtk7mshdCnz
 wk4pT8Drt+NkR2MhTp5CXQEBJROmzF8iN1btAO/8ByU35m5xUWxUCkZs3kkzkpPQGX0/H33
 H+d64Q1HhLCRmEX905dHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5IPBhLXSNfs=:+RVdiYAh0AfVhLkG5AFZCK
 kFefRlHGNWfazyUVp0svvT5FyqETXVdWhC0t3xxBu8JBLzKGrE0S6KS+b5oI95hWaJQs943+W
 EbBZWPTFdyTTMn2IrkAMRMokj0cLdnfUUqdIgXsnlIM8icYgePSe3NzeTzkEIqzLb+cQugz8z
 bATbvTxPgaVJ2l4LzyMjaS2ev8sY8zTIkg9Lj9nqG5jYzuK6wBVbi5MqdSFYq5d84anMXj3wt
 KxkCMtYM6hwQaU97uaWhXwK8B8F91hhViA22Txe/EomASbZq9mAgPhjv38m1zYTpm2hbhKmFV
 aYzF87OiO2qR+Ecmog5TaEm6RMhFiiN/1Fm/BQtWlZCtJ3H3Hl0JpxTOQPzSGyXJLjS4tV8lc
 SjJpkirPum5dceuZUZLUbBBIjCZwmjXVH15R7pTw7d8fFCOYb6M91RXyZ+yB4tBDHvRUFHsoe
 liQbKQyc3qYZRMw2ISAIVRBV7OOPlkJWkCi56Y5VwjAAzPcvWGuFyF7DgtLVz5qo0VJvD17JL
 lX5PkyZPo2jgErCPxcxxUE3Vgu0c86lDqDJ+t2+B5/UTe/IDr3/WTkIsObiNuyQUERzvPt2k6
 dv0/sW483+jvEldGD6RgN2QhrIeBMj/ofrDcV5TbfKW2mvMpCuJPtNYON0J4BhDmh+Ymq+c2J
 zO0rjb7Ea+dTI4x85NEbVaoo4pAmIFC5UhhdXYM68eP9QP0XG/xz9B5dZxoLJ8F2fYou8btW6
 TvHg4vEoV0ZctZW1pI5DWK4PuPOIbagkbF8QDpZRX7TustNygd8WD7/dKg+1r/EZw1yBpthrm
 yP2+PcF
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-09 at 11:01 -0600, Jens Axboe wrote:
> On 5/9/18 10:57 AM, Mike Galbraith wrote:
> 
> >>> Confirmed.  Impressive high speed bug stomping.
> >>
> >> Well, that's good news. Can I get you to try this patch?
> > 
> > Sure thing.  The original hang (minus provocation patch) being
> > annoyingly non-deterministic, this will (hopefully) take a while.
> 
> You can verify with the provocation patch as well first, if you wish.

Done, box still seems fine.

	-Mike
