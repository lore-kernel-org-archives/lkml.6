Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeCILkA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 06:40:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41096 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeCILj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 06:39:59 -0500
Date: Fri, 9 Mar 2018 12:39:53 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
cc: Kees Cook <keescook@chromium.org>, re.emese@gmail.com,
        Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: irqdesc: Why the "__ref" is needed in __irq_alloc_descs() ?
In-Reply-To: <9246951e-9cf5-6a3f-5cf4-2d3aaff03026@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1803091237320.1364@nanos.tec.linutronix.de>
References: <9246951e-9cf5-6a3f-5cf4-2d3aaff03026@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018, Dou Liyang wrote:
> I have a question about "__ref" in Linux kernel.
> 
> When I looked into the __irq_alloc_descs(), I found it tagged a
> "__ref" mark, but I didn't find that it referenced code or data
> from init section.

See the various

#define irq_alloc_desc* 

variants. That will give you enough use cases from init.

> And after I tested, seems "__ref" just puts the code into a different
> section that is not checked by modpost. It does not affect the
> performance whether it is tagged or not. Is it right?

Well having code in a different section can cause performance issues, but
that only matters in a hotpath. irq_alloc_desc* is not performance critical
at all, so nothing to worry about.

Thanks,

	tglx
