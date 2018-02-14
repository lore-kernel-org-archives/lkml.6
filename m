Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967479AbeBNLjT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:39:19 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52423 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967342AbeBNLjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:39:17 -0500
Date: Wed, 14 Feb 2018 12:39:09 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/intel: Use 64-bit arithmetic instead of
 32-bit
In-Reply-To: <20180213231847.36f87c0b@alans-desktop>
Message-ID: <alpine.DEB.2.21.1802141235570.1292@nanos.tec.linutronix.de>
References: <20180213164404.GA11664@embeddedor.com> <alpine.DEB.2.21.1802131747290.1130@nanos.tec.linutronix.de> <20180213231847.36f87c0b@alans-desktop>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018, Alan Cox wrote:
> > 	if (c->x86_cache_size >= 0)
> > 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
> > 
> > which is silly, because that really can be done with:
> > 
> > 	if (c->x86_cache_size)
> > 
> > as there is no point in printing 'cache size 0KB', which means
> > x86_cache_size can be made unsigned int, which makes sense because cache
> > size < 0 does not at all.
> 
> Currently 0MB means "I know you have no cache" (early slot 1 celeron),
> while not printing it means 'I have no clue'

Cute. I hope the 3 slot1 celeron users will not go wild if their
/proc/cpuinfo now claims to have no clue about caches.

Thanks,

	tglx
