Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCWTqF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:46:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42226 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbeCWTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:46:04 -0400
Date: Fri, 23 Mar 2018 20:45:59 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dave Hansen <dave.hansen@intel.com>
cc: Shakeel Butt <shakeelb@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linuxram@us.ibm.com, mpe@ellerman.id.au,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org
Subject: Re: [PATCH 4/9] x86, pkeys: override pkey when moving away from
 PROT_EXEC
In-Reply-To: <alpine.DEB.2.21.1803232036140.1481@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1803232044350.1481@nanos.tec.linutronix.de>
References: <20180323180903.33B17168@viggo.jf.intel.com> <20180323180911.E43ACAB8@viggo.jf.intel.com> <CALvZod6F8x-smAE7sEGfJ3Ds5p6M5Qj6gd-P-VLejuBxfU6niQ@mail.gmail.com> <f7897068-18a3-d88b-0458-5dcf05d7ffc2@intel.com>
 <alpine.DEB.2.21.1803232036140.1481@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018, Thomas Gleixner wrote:

> On Fri, 23 Mar 2018, Dave Hansen wrote:
> 
> > On 03/23/2018 12:15 PM, Shakeel Butt wrote:
> > >> We had a check for PROT_READ/WRITE, but it did not work
> > >> for PROT_NONE.  This entirely removes the PROT_* checks,
> > >> which ensures that PROT_NONE now works.
> > >>
> > >> Reported-by: Shakeel Butt <shakeelb@google.com>
> > >> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Should there be a 'Fixes' tag? Also should this patch go to stable?
> > 
> > There could be, but I'm to lazy to dig up the original commit.  Does it
> > matter?
> > 
> > And, yes, I think it probably makes sense for -stable.  I'll add that if
> > I resend this series.
> 
> The fixes tag makes sense in general even if the patch is not tagged for
> stable. It gives you immediate context and I use it a lot to look why this
> went unnoticed or what the context of that change was.

That said, I'm even lazier than you and prefer you to dig up the original
commit :)

Thanks,

	tglx
