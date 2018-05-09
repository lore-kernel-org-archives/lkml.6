Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965662AbeEIQ5f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:57:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:47971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965487AbeEIQ5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:57:33 -0400
Message-ID: <1525885030.15732.6.camel@gmx.de>
Subject: Re: bug in tag handling in blk-mq?
From: Mike Galbraith <efault@gmx.de>
To: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Wed, 09 May 2018 18:57:10 +0200
In-Reply-To: <ce5ee556-9552-6ffd-7578-7b3b983c07bf@kernel.dk>
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
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sT8nsHgEyeO/dGkX49BLH4m4hsJO/DXWYk4eNZP8Adzb9ECtRLs
 HLvT4g6lathU51qV5BiWAdIvrimDrRXqevZpkL1u6TBt/k6DkWGCeJUF4dEwREoyMdPZiDL
 sjOvOv9/K1pMZinhMXB/06BPzhxDY+C9h/atI5Rf3vLSGjNJHkM8hCM/wwIftR1wFrKboU7
 mXlzkK3ZXEIRzByOU0LSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xfQBhaoMcLE=:CCFzSFcxakk1J55QtVYvhI
 Vx6PNBypRWVrg/fOUt+udvRnjRKF8s990os+UnxA4d7Uww7Uyl42aoldIeOi2ZS8+mIqmxyv4
 4Z/4jhzJMiOGig2U4S22rvKMkuYGCakHpau4OWMODPo8EeRQwwAcbuea7uoLW7eRPsUyPVruk
 3mYqn/oRo7lxaPpQM6bTZXDIIKRCEWuxsU5Ia1TcfWDpXShd9FMAGK/vnG4C3B14ajxSWo1Cr
 FMYDrLG6W2yMoQzRcO6MblmxZqjGf8zAS3Lebew5sYZU0Eh06yq0dQAOcmImvAJZ9Hpd7wryx
 6YJ3S3amWV2RWtyGMtAw5aB9FU1nYfMWA+c9dFHI3bdU1ILQxsbJSjT06ZAdDi/5RTeBSnT4Z
 JP2xJpyK24Y/PzQBtQs9FajdY8OJO1/mmXo6Q2qmW9Mv5tcySeoMd6eMQYQYR1Wkq6vACOZGI
 ckNcxhIeLpR/TXG63ck3VoJIRaf8B+t7IHlfF7rEoQqC06YzjqekyzqcCveTqmIXcbXbIRl3d
 9K02AWIjZl9LzDV4UskoetyjD3yDDkrr+9YcoJ04JxIkA0/Ny24D47dYSvsmdxx+9OHtR+Pfv
 CgOcQgVl6qcFG98RICH1L3atEgOSzRs2RqW3+0RcKbJ7+tlm2mf6v19CYGvvmoEFRg3NZdEvn
 /Kw1kdZv5M0UhTb7tmXAAgOPZkd/GK4o/N+60W5smjnjzoysDxXqa3kJOmvErZPe2fHxkcZ9b
 jjMtwRyyX+tkwO30TqgVh6mKIa49PI+i5W4qYsFE+UNg3AlfLiVW8ZNGcCuVRbHv44tz16csI
 4nhR0Qi
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-09 at 09:18 -0600, Jens Axboe wrote:
> On 5/8/18 10:11 PM, Mike Galbraith wrote:
> > On Tue, 2018-05-08 at 19:09 -0600, Jens Axboe wrote:
> >>
> >> Alright, I managed to reproduce it. What I think is happening is that
> >> BFQ is limiting the inflight case to something less than the wake
> >> batch for sbitmap, which can lead to stalls. I don't have time to test
> >> this tonight, but perhaps you can give it a go when you are back at it.
> >> If not, I'll try tomorrow morning.
> >>
> >> If this is the issue, I can turn it into a real patch. This is just to
> >> confirm that the issue goes away with the below.
> > 
> > Confirmed.  Impressive high speed bug stomping.
> 
> Well, that's good news. Can I get you to try this patch?

Sure thing.  The original hang (minus provocation patch) being
annoyingly non-deterministic, this will (hopefully) take a while.

	-Mike
