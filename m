Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeDJORM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:17:12 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39661 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752812AbeDJORL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:17:11 -0400
X-Google-Smtp-Source: AIpwx49GSC+aT3OModXBdkEs0ri1CUMaPLeOXFvA6sGCOrx21KROwSBqu4eI+wv05yibLy2N/UCJUA==
Date: Tue, 10 Apr 2018 07:17:07 -0700
From: Tejun Heo <tj@kernel.org>
To: Christopher Lameter <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC] mm, slab: reschedule cache_reap() on the same CPU
Message-ID: <20180410141707.GL3126663@devbig577.frc2.facebook.com>
References: <20180410081531.18053-1-vbabka@suse.cz>
 <alpine.DEB.2.20.1804100907160.27333@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1804100907160.27333@nuc-kabylake>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 09:12:08AM -0500, Christopher Lameter wrote:
> > @@ -4074,7 +4086,8 @@ static void cache_reap(struct work_struct *w)
> >  	next_reap_node();
> >  out:
> >  	/* Set up the next iteration */
> > -	schedule_delayed_work(work, round_jiffies_relative(REAPTIMEOUT_AC));
> > +	schedule_delayed_work_on(reap_work->cpu, work,
> > +					round_jiffies_relative(REAPTIMEOUT_AC));
> 
> schedule_delayed_work_on(smp_processor_id(), work, round_jiffies_relative(REAPTIMEOUT_AC));
> 
> instead all of the other changes?

Yeah, that'd make more sense.

Thanks.

-- 
tejun
