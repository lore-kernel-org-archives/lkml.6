Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932402AbeE2Ifk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:35:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41175 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932270AbeE2Ife (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:35:34 -0400
Date: Tue, 29 May 2018 10:35:30 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Song Liu <songliubraving@fb.com>
cc: Song Liu <liu.song.a23@gmail.com>, Tariq Toukan <tariqt@mellanox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
In-Reply-To: <3F47F523-64C5-422B-B9B0-73B8D105CF71@fb.com>
Message-ID: <alpine.DEB.2.21.1805291031480.1685@nanos.tec.linutronix.de>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com> <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de> <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com> <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com> <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de> <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com> <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
 <09A22A95-6BBD-48EB-A2FE-42BF6244F751@fb.com> <alpine.DEB.2.21.1805282206440.1584@nanos.tec.linutronix.de> <3F47F523-64C5-422B-B9B0-73B8D105CF71@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018, Song Liu wrote:
> > On May 28, 2018, at 1:09 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, 28 May 2018, Song Liu wrote:
> >> This doesn't fix the issue with bnxt. Here is a trace with this patch:
> >
> > That's just the backtrace which is not really helpful. The real question is
> > what leads to this scenaria.
> >
> > What I was asking for is to enable the irq_vector and irq_matrix trace
> > points along with ftrace_dump_on_oops. The latter dumps the trace buffer
> > when the problem happens and that should give us a hint what actually
> > causes that.
> 
> Attached is the dump I got. It seems pretty noisy, with many message lost.
> 
> Maybe we cannot enable all trace points under irq_vectors/ and irq_matrix.

Right. Sorry, I forgot to say that we only need the irq_vectors ones which
are related to vector allocation, i.e.: irq_vectors/vector_* 

Thanks,

	tglx
