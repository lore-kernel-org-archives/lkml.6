Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38311C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD4E260A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD4E260A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755684AbeFYUIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:08:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47516 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeFYUIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:08:18 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXXlI-0005bY-P1; Mon, 25 Jun 2018 22:06:56 +0200
Date:   Mon, 25 Jun 2018 22:06:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Stultz <john.stultz@linaro.org>
cc:     Baolin Wang <baolin.wang@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, pombredanne@nexb.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        douly.fnst@cn.fujitsu.com, Len Brown <len.brown@intel.com>,
        rajvi.jingar@intel.com, alexandre.belloni@bootlin.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/8] time: Add persistent clock support
In-Reply-To: <CALAqxLWgfy8X75GOK5WttzRfgbwBxW0ibnQaFxcLrUTFmHMSUw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806252142261.1587@nanos.tec.linutronix.de>
References: <cover.1528878545.git.baolin.wang@linaro.org> <d330f02c8ef2a348b179850e1745a52ab9c47e90.1528878545.git.baolin.wang@linaro.org> <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de>
 <CALAqxLWgfy8X75GOK5WttzRfgbwBxW0ibnQaFxcLrUTFmHMSUw@mail.gmail.com>
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

On Mon, 25 Jun 2018, John Stultz wrote:
> On Sat, Jun 23, 2018 at 5:14 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> Thomas, what is wrong with *you*?  This is completely unnecessary.

Nothing is wrong with me. I just hit a point where the amount of half baken
crap tripped me over the edge and I let of steam. Sorry for that, it surely
wasn't necessary. It was one of those days where grumpiness took
control. My steam pressure is back to normal and I'm more than happy to put
that back on the pure technical level.

To be clear, that rant was not a shot at Baolin. It was definitely
addressed to the people behind him who set him on this project and then
failed to do any sanity checking.

> Now, I've also been quite a poor maintainer of late, and haven't done
> much to help with pre-review of Baloin's code.  So that's on me, not
> him.

Fair enough.

> I was really lucky to have your guidance and support when I was
> starting in the community. Your helping bring me up as a co-maintainer
> (only a a relatively small set of responsibility compared to your much
> wider maintainership), does let me see that having the responsibility
> of billions of devices running your code is immense and comes with no
> small amount of stress. Juggling the infinite incoming stream of
> review requests on naieve or otherwise lacking code with other
> important development priorities is a major burden, so *I really get
> how frustrating it is*.

Yes, and I have to admit that I'm not a super human and despite trying to
control my emotions, there are points where I fail in doing so. It makes me
explode and that's it. I can assure Baolin, that this is nothing which
sticks. I'll look at the next patchset from a pure technical level. There
are surely precautions, but definitely no prejudice.

> And its super annoying to have lots of short-term development requests
> being thrown at you when you're the one who has to maintain it for the
> long term.  But long-long-term, no one is going to be a maintainer
> forever, and we are not going to develop more olympic swimmers if we
> keep peeing in the pool.

Right, that's why I early looked for co/sub-maintainers, but as you
admitted yourself, that's not always working out and I surely would
appreciate if there would be more help on all ends. I'm the last person who
rejects help, quite the contrary I'm very happy when I can mark mails as
'none of my business, somebody else takes care of that'.

Thanks,

	tglx
