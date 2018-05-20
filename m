Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeETWbY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 18:31:24 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35809 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbeETWbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 18:31:20 -0400
X-Google-Smtp-Source: AB8JxZqvAgLrmN1mtq2MSsWS8c/YG0Dx2DxEtHF5SjO0rDq46w+ul+mvvgP62YthSgRXDnCfnvqLMA==
Date: Sun, 20 May 2018 18:31:16 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Message-ID: <20180520223116.GB11495@kmo-pixel>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
 <a26feed52ec6ed371b3d3b0567e31d1ff4fc31cb.camel@wdc.com>
 <20180518090636.GA14738@kmo-pixel>
 <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
 <20180520221733.GA11495@kmo-pixel>
 <bb4fd32d0baa6554615a7ec3b45cc2b89424328e.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb4fd32d0baa6554615a7ec3b45cc2b89424328e.camel@wdc.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 10:19:13PM +0000, Bart Van Assche wrote:
> On Sun, 2018-05-20 at 18:17 -0400, Kent Overstreet wrote:
> > On Fri, May 18, 2018 at 03:12:27PM +0000, Bart Van Assche wrote:
> > > On Fri, 2018-05-18 at 05:06 -0400, Kent Overstreet wrote:
> > > > On Thu, May 17, 2018 at 08:54:57PM +0000, Bart Van Assche wrote:
> > > > > With Jens' latest for-next branch I hit the kernel warning shown below. Can
> > > > > you have a look?
> > > > 
> > > > Any hints on how to reproduce it?
> > > 
> > > Sure. This is how I triggered it:
> > > * Clone https://github.com/bvanassche/srp-test.
> > > * Follow the instructions in README.md.
> > > * Run srp-test/run_tests -c -r 10
> > 
> > Can you bisect it? I don't have infiniband hardware handy...
> 
> Hello Kent,
> 
> Have you noticed that the test I described uses the rdma_rxe driver and hence that
> no InfiniBand hardware is needed to run that test?

No, I'm not terribly familiar with infiniband stuff....

Do you have some sort of self contained test/qemu recipe? I would really rather
not have to figure out how to configure multipath, and infiniband, and I'm not
even sure what else is needed based on that readme...
