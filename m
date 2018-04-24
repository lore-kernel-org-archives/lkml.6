Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756042AbeDXFyW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 01:54:22 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:38278 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbeDXFyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 01:54:20 -0400
X-Google-Smtp-Source: AIpwx49oNQpx6xFCvaEF6yvtEzUN/QyNSPvRt9sncTKJ/EtGQ/FiMpsENDgi4usaPkofUVxie0TTQQ==
Date: Mon, 23 Apr 2018 22:54:18 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rdunlap@infradead.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
In-Reply-To: <20180421203604.GB14396@avx2>
Message-ID: <alpine.DEB.2.21.1804232249380.82340@chino.kir.corp.google.com>
References: <20180419190846.GE2066@avx2> <1c3b9cf3-3a36-568f-3da2-e560a721f4aa@redhat.com> <20180419195504.GA4343@avx2> <eb7c1569-e445-5cbb-6d10-2694b625232a@redhat.com> <20180419203949.GA4555@avx2> <c0530769-50c3-87ad-1558-164873482130@redhat.com>
 <CAEi0qNn9KbTtUxLvFKvq958BhG9KrpY=S-89T5HJBebO9Da4zw@mail.gmail.com> <20180421203422.GA14396@avx2> <20180421203604.GB14396@avx2>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2018, Alexey Dobriyan wrote:

> > On Thu, Apr 19, 2018 at 04:23:02PM -0700, Joel Fernandes (Google) wrote:
> > > Can we not just remove per-IRQ stats from /proc/stat (since I gather
> > > from this discussion it isn't scalable), and just have applications
> > > that need per-IRQ stats use /proc/interrupts ?
> > 
> > If you can prove noone is using them in /proc/stat...
> 
> And you can't even stick WARN into /proc/stat to find out.
> 

FWIW, removing per irq counts from /proc/stat would break some of our 
scripts.  We could adapt to that, but everybody else would have to as 
well, so I'm afraid it's not going to be possible.

It would probably be better to extract out the stats that you're actually 
interested in to a new file.
