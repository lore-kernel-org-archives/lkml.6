Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeCXKu2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 06:50:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42840 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbeCXKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 06:50:27 -0400
Date: Sat, 24 Mar 2018 11:50:23 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
cc: Eric Dumazet <edumazet@google.com>, x86 <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 1/2] x86, msr: allow rdmsr_safe_on_cpu() to schedule
In-Reply-To: <20180324080946.3db4xdkl5i6jx2rc@gmail.com>
Message-ID: <alpine.DEB.2.21.1803241149570.1481@nanos.tec.linutronix.de>
References: <20180323215818.127774-1-edumazet@google.com> <20180324080946.3db4xdkl5i6jx2rc@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2018, Ingo Molnar wrote:
> * Eric Dumazet <edumazet@google.com> wrote:
> 
> > I noticed high latencies caused by a daemon periodically reading
> > various MSR on all cpus. KASAN kernels would see ~10ms latencies
> > simply reading one MSR. Even without KASAN, sending IPI to CPU
> > in deep sleep state or blocking hard IRQ in a a long section,
> > then waiting for the answer can consume hundreds of usec.
> > 
> > Converts rdmsr_safe_on_cpu() to use a completion instead
> > of busy polling.
> > 
> > Overall daemon cpu usage was reduced by 35 %,
> > and latencies caused by msr_read() disappeared.
> 
> What "daemon" is this and why is it reading MSRs?

Why? Just because it can ....
