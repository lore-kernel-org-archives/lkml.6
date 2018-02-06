Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeBFH4Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:56:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:49303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751835AbeBFH4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:56:15 -0500
Message-ID: <1517903761.9843.12.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, alban.browaeys@gmail.com,
        ming.lei@redhat.com, ivan@ludios.org, 169364@studenti.unimore.it,
        Serena Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 08:56:01 +0100
In-Reply-To: <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
         <20180205190510.5499-2-paolo.valente@linaro.org>
         <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:95fVT3rM4aGBzHMwXKcpQVnwGkDW8jYMf2wHhO/HXslbT4CBZzp
 TiQeHAT9UWsf44jXW9CrBBR+UkdBe6+nx9epPU9tiz4V0V8D3VmAz+re+9vwVBhmJ6Lgz+1
 js+7Jyy1h+ff7IpXH/RdrHW1qbAwh5ixKW1YlTTkBQZ4Bad9+OJwpqCAK3qcBUOBhZ5c2uK
 Y+QbAxrnEAb/m9XLSN8SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nztlt0CGGeM=:cGzpTYCCnogZmCYnHrE73R
 ECLBfMuFM4IOczsJ9CciziMJlwFdbg9ebqQZBPIBIzE1LU1GRaOWiHLVs9oDW/Bk5uX2mtMe5
 KZwk1Ku44DvD6FoMhWMgNcTKeo47P841iheap8zxjDJjin3c3LoleFKvF918aFVszh4mCRcSq
 h4YcHF6Aw8ZhCBF771RYxtgEzsFD1tywWHzehDrcD1dy+5/a0V+Pq4FSdZM6CUandFxDWXYNy
 H8SQ5fs0m73B8rjS2oimw3t7mVj20whyNcX/CcqnEGjzcuaEN8tNX8hoSlCC+7TSyx0ZDx5GX
 Y7/xs4z+Ccvrl68faYAo6yKrkrNv6/8A3ZXTncNPEHnnYra8v4i15Jt0fLsF5CIw2dOv3EnPM
 KdBd+ugQA9utL+e0iji9lIwwApYyQ03qvxQW4ERsWYLW8XwElTwjknHgfLIuwzCPCiftvwSKC
 YPImAYnFudLgO9yGlt4re4fOdcS7f+puxKelzh5IJQAwbrCI0MZBQ+OH5D2+WLmDYx2iBUJ2U
 /aNvIx9bYTsGTTQZKXy3pueh15DJ3sWac0nHleHq8F/miysiNTVDMyRB6z0cZXYBTQTYlAayg
 fysgqxp8fg2H5Y1sbArHhZrfea2bvaJwL/ZrnHcomrFJBIqDOiX3H+9EdLTOLKOxf6Tj6OEsL
 ocSkpvvXCnQnld6P/5qaSZFrHd/C4kV1HGCAwLCn6b/xXkYDVltR1ZzhWihKQxQ1pOFszcnH4
 /FZPbRtLG+Duru7iunqmaQ9ZG6b+ZUn2O+zJOcYV4QoaN4NCeAsX6JEBur9DMsnsEU5XRxH5n
 unw48bQm1OZ+8XPl/ZYQqCzKL2PYyqZ1i6ywx9HBx1NkxhDYF8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-06 at 08:44 +0100, Oleksandr Natalenko wrote:
> Hi, Paolo.
> 
> I can confirm that this patch fixes cfdisk hang for me. I've also tried 
> to trigger the issue Mike has encountered, but with no luck (maybe, I 
> wasn't insistent enough, just was doing dd on usb-storage device in the 
> VM).

I was doing kbuilds, and it blew up on me twice.  Switching back to cfq
seemed to confirm it was indeed the patch causing trouble, but that's
by no means a certainty.

	-Mike
