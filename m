Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4029C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992AA208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992AA208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeH1BbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:31:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43533 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1BbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:31:11 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fuPHW-0001vq-1i; Mon, 27 Aug 2018 23:42:42 +0200
Date:   Mon, 27 Aug 2018 23:42:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Miroslav Lichvar <mlichvar@redhat.com>
cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH ghak10 v5 2/2] timekeeping/ntp: Audit clock/NTP params
 adjustments
In-Reply-To: <20180827114557.GN27091@localhost>
Message-ID: <alpine.DEB.2.21.1808272341370.1359@nanos.tec.linutronix.de>
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-3-omosnace@redhat.com> <20180824194703.h3mbuhrxzixmna4e@madcap2.tricolour.ca> <CAFqZXNvD_7psR+wM-GTXQ4bwK3w8=t7UnBidojB5XbmbE_K2oA@mail.gmail.com>
 <20180827114557.GN27091@localhost>
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

On Mon, 27 Aug 2018, Miroslav Lichvar wrote:

> On Mon, Aug 27, 2018 at 01:35:09PM +0200, Ondrej Mosnacek wrote:
> > On Fri, Aug 24, 2018 at 9:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > It appears this time_tai use of "constant" is different than
> > > time_constant, the former not mentioned by Miroslav Lichvar.  What is it
> > > and is it important to log for security?  It sounds like it is
> > > important.
> 
> > The TAI offset is the offset of the clock from the International
> > Atomic Time, so basically the time zone offset. I suppose it can't
> > influence the audit timestamps, but changing timezones can still cause
> > all sorts of confusion throughout the system, so intuitively I would
> > say we should log it.
> 
> It's not related to timezones. ADJ_TAI sets the offset of the system
> TAI clock (CLOCK_TAI) relative to the standard UTC clock
> (CLOCK_REALTIME). CLOCK_TAI is rarely used by applications. Setting
> the TAI offset effectively injects a whole-second offset to the TAI
> time. 

Rarely used today, but with TSN it's going to get more usage in not so
distant future.

Thanks,

	tglx
