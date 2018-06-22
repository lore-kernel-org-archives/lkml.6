Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE8C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CBE24992
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CBE24992
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbeFVW5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:57:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42971 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754184AbeFVW5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:57:30 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWUzX-00056V-N5; Sat, 23 Jun 2018 00:57:19 +0200
Date:   Sat, 23 Jun 2018 00:57:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 02/16] x86/split_lock: Handle #AC exception for split
 lock in kernel mode
In-Reply-To: <20180622224154.GD18979@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1806230051040.1589@nanos.tec.linutronix.de>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com> <1527435965-202085-3-git-send-email-fenghua.yu@intel.com> <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806221334150.2402@nanos.tec.linutronix.de>
 <20180622224154.GD18979@romley-ivt3.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Fenghua Yu wrote:
> On Fri, Jun 22, 2018 at 01:59:44PM +0200, Thomas Gleixner wrote:
> > Aside of that the spec says:
> > 
> >   31 Disable LOCK# assertion for split locked access.
> > 
> > Can you pretty please make sure that this bit enforces #AC enable? If 31 is
> > ever set and such an access happens then the resulting havoc will takes
> > ages to decode.
> > 
> > That bit is also mentioned in the SDM with ZERO explanation why it exists
> > in the first place and why anyone would ever enable it and without a big
> > fat warning about the possible consequences. Can this pretty please be
> > fixed?
> 
> The bit 31 already exits on all processors. Hardware always sets its value
> as zero after power on. It has been legacy for 20 years. It was added for
> one customer 20 years ago. Now Intel hardware design team doesn't expect
> anyone to set the bit.

Doesn't expect. ROTFL.

That's the most stupiest excuse for not adding a big fat warning into the
SDM why this abomination should never be used at all.

Aside of that does the Intel hardware design team expect that this one
customer is still depending on this nonsense and is therefore proliferating
it forever?

> Currently Linux kernel doesn't define this bit and doesn't set this bit.

Thanks for the education. I knew that already, but it still does not make
the existence of it in contemporary CPUs any better or more justified.

Thanks,

	tglx
