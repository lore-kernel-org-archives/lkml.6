Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754549AbeEWIt4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:49:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43255 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754266AbeEWItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:49:55 -0400
Date: Wed, 23 May 2018 10:49:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Tariq Toukan <tariqt@mellanox.com>
cc: Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
In-Reply-To: <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com>
Message-ID: <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com> <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de> <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com> <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2018, Tariq Toukan wrote:
> On 19/05/2018 2:20 PM, Thomas Gleixner wrote:
> > On Fri, 18 May 2018, Dmitry Safonov wrote:
> > > I'm not entirely sure that it's the same fault, but at least backtrace
> > > looks resembling.
> > 
> > Yes, it's similar, but not the same issue. I'll stare are the code ...
> > 
> > Thanks,
> > 
> > 	tglx
> > 
> 
> We still see the issue in our daily regression runs.
> I have your patch merged into my internal branch, it prints the following:
> 
> [ 4898.226258] Trying to clear prev_vector: 0
> [ 4898.226439] Trying to clear prev_vector: 0
> 
> i.e. vector(0) is lower than FIRST_EXTERNAL_VECTOR.

Could you please enable the vector and irq matrix trace points and capture
the trace when this happens?

Thanks,

	tglx
