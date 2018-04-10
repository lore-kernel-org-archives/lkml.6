Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeDJUX6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:23:58 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:43700 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbeDJUX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:23:56 -0400
X-Google-Smtp-Source: AIpwx4+PiA5IsX8Xk3icEAREXc/b2MXj5oRFcGtKCF1pHJ3dNSV6t496JXJprbzeOuGZ5tTfe60jmA==
Date: Tue, 10 Apr 2018 13:23:53 -0700
From: Tejun Heo <tj@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christopher Lameter <cl@linux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC] mm, slab: reschedule cache_reap() on the same CPU
Message-ID: <20180410202353.GB793541@devbig577.frc2.facebook.com>
References: <20180410081531.18053-1-vbabka@suse.cz>
 <alpine.DEB.2.20.1804100907160.27333@nuc-kabylake>
 <983c61d1-1444-db1f-65c1-3b519ac4d57b@suse.cz>
 <20180410195247.GQ3126663@devbig577.frc2.facebook.com>
 <d4983f13-2c02-6082-f980-a6623ab363e6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4983f13-2c02-6082-f980-a6623ab363e6@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 10, 2018 at 10:13:33PM +0200, Vlastimil Babka wrote:
> > For percpu work items, they'll keep executing on the same cpu it
> > started on unless the cpu goes down while executing.
> 
> Right, but before this patch, with just schedule_delayed_work() i.e.
> non-percpu? If such work can migrate in the middle, the slab bug is
> potentially much more serious.

That's still per-cpu.  The only time the local binding breaks is when
the kernel is explicitly told to do so through explicit unbound_mask
or force_rr debug option.

Thanks.

-- 
tejun
