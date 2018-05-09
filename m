Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeEIFKD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 01:10:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:37265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbeEIFKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 01:10:01 -0400
Message-ID: <1525842595.15732.3.camel@gmx.de>
Subject: Re: bug in tag handling in blk-mq?
From: Mike Galbraith <efault@gmx.de>
To: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 09 May 2018 07:09:55 +0200
In-Reply-To: <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
References: <999DF2B3-4EE8-4BDF-89C5-EB0C2D8BF69E@linaro.org>
         <7760d23b-7a4c-a645-1c7a-da7569bb44dc@kernel.dk>
         <84145CD7-B917-4B32-8A5C-310C1910DB71@linaro.org>
         <1525755090.24338.1.camel@gmx.de> <1525768632.5208.4.camel@gmx.de>
         <ffd0c030-43f8-0dbe-42b3-03bb9c410bea@kernel.dk>
         <1525797766.5204.2.camel@gmx.de>
         <3692ce7d-a767-72e6-65ae-6178b6c2e7d8@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PNB7Cf4T+7t5fhZXqYMaSXfZ+aI9jeSMvMozq6J0VsDGvdxGRm8
 QyZWGWDSKvzUhWQECluTxt8UIE9WgC+6mpge6HquftdTTrEGo7UrrkyS0sO3VxScOoGIm2P
 tTfVMI13ecPpZ+LgdaNAD6GsFukahIx/NA7dJOWv8Ibe/uyT4fpyaJUkMsnOdVqCOGbuF2u
 0U+mf7TWjXSZIL3qeh6Gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:381Hrv5XBmw=:jgaj5rdiAdCsrV8MwdAEmn
 zJ4JgVI9cTp1u4tUkawDpKGtqT3vu9qnRpmMdN4nO9MQgK8VNufLx3n36NZzDO8VH3MJr7k79
 sK5Ye/GzMi+yfTc+Vc3b7UuANV2iQGU2YjOuE3ATrBMTs/VgAQPRYVuWsMVoTVWolPtw7zXKv
 CnAKhoLOkEOf+SGhVtKdiEcug9AbKM5mBp9Y5kPxsMl+NXsBXEOm3J6VGvlB3Vom98hPB6Ayq
 iPKnWCG3r0H+cMNodNR5wDh4OGQDwqj+wffCa/sLBv9LhbA2hy6MV8TO4hOIbHA03b9mUoi1P
 TqHisk4tKexBpOfdgbkFHaAaNubtaG+oBGApvwwj04KcFJguHcWX57KHtjYQPnCHrjoe7gTVO
 5I9vqYJ6ksiyVcN4Q8hR44cV/+qN6UH7+yrqsYJD2UzVwn+wNX1tnqN/8YBNWTTLl0qMm5sV0
 wN6VSRRRRpzdSKkjdYOSxbPHgjhEBcmUgvyMTw6sm4qngAYrI1mXTxiVwYe/ydrmvaEaVXkcE
 J78uw+y2LAk+XNVVo58wpDhjaS5RKTIfiNUdeNFIGuaVi/tT9tQf8Vh4dGjlReJO6WWC8/jSV
 rYOzAxWImlFmTXIqZQnx56UsO+d26eVl15p868VJ2rAaTjAJX/5Kl0kQBRTBxiv8MRiaN98/f
 ScjwCFgbEiyKRiUDQh+mw2Q+c5dyqS+V2cHc09l1ZI/eroXFFc9bVUR1Yg7nXV5oVOr56A8ro
 25bL5bKsoI6dIYNg7VIZpssvnYoHZAFuBmMBivFJP4qHO+hJfI2PVMxsyyCMJHTQobtOrDmRo
 426IZ7G
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-08 at 14:37 -0600, Jens Axboe wrote:
> 
> - sdd has nothing pending, yet has 6 active waitqueues.

sdd is where ccache storage lives, which that should have been the only
activity on that drive, as I built source in sdb, and was doing nothing
else that utilizes sdd.

	-Mike
