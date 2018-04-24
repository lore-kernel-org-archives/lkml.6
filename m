Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756294AbeDXGTE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:19:04 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:37187 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755724AbeDXGTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:19:03 -0400
X-Google-Smtp-Source: AIpwx49QBBKT5liQPWXx/df/o3T2aQY3mVSJD/430N6ZrnnFM/Qd/RKNPE6/gJT6drGrMF6/sB4fGw==
Date: Tue, 24 Apr 2018 09:18:59 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: David Rientjes <rientjes@google.com>
Cc: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rdunlap@infradead.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
Message-ID: <20180424061859.GA16181@avx2>
References: <20180419190846.GE2066@avx2>
 <1c3b9cf3-3a36-568f-3da2-e560a721f4aa@redhat.com>
 <20180419195504.GA4343@avx2>
 <eb7c1569-e445-5cbb-6d10-2694b625232a@redhat.com>
 <20180419203949.GA4555@avx2>
 <c0530769-50c3-87ad-1558-164873482130@redhat.com>
 <CAEi0qNn9KbTtUxLvFKvq958BhG9KrpY=S-89T5HJBebO9Da4zw@mail.gmail.com>
 <20180421203422.GA14396@avx2>
 <20180421203604.GB14396@avx2>
 <alpine.DEB.2.21.1804232249380.82340@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804232249380.82340@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:54:18PM -0700, David Rientjes wrote:
> On Sat, 21 Apr 2018, Alexey Dobriyan wrote:
> 
> > > On Thu, Apr 19, 2018 at 04:23:02PM -0700, Joel Fernandes (Google) wrote:
> > > > Can we not just remove per-IRQ stats from /proc/stat (since I gather
> > > > from this discussion it isn't scalable), and just have applications
> > > > that need per-IRQ stats use /proc/interrupts ?
> > > 
> > > If you can prove noone is using them in /proc/stat...
> > 
> > And you can't even stick WARN into /proc/stat to find out.
> > 
> 
> FWIW, removing per irq counts from /proc/stat would break some of our
> scripts.  We could adapt to that, but everybody else would have to as
> well, so I'm afraid it's not going to be possible.

Excellent!

> It would probably be better to extract out the stats that you're actually
> interested in to a new file.

This is the worst scenario. Individual IRQ stats are going to live in 2 places.
And /proc/stat still would be slow.
