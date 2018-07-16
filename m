Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369E1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD349208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD349208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeGPTt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:49:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52540 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeGPTt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:49:58 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ff93K-0002l7-PP; Mon, 16 Jul 2018 21:20:58 +0200
Date:   Mon, 16 Jul 2018 21:20:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alan Cox <alan@linux.intel.com>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: cpu_no_speculation omissions?
In-Reply-To: <1531767303.4364.109.camel@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1807162120181.1693@nanos.tec.linutronix.de>
References: <20180716160513.GA6080@brightrain.aerifal.cx>  <alpine.DEB.2.21.1807161851290.1693@nanos.tec.linutronix.de>  <193fb2f5-8f6c-8fe6-298f-a6af4fae862a@linux.intel.com> <1531767303.4364.109.camel@linux.intel.com>
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

On Mon, 16 Jul 2018, Alan Cox wrote:
> On Mon, 2018-07-16 at 10:28 -0700, Dave Hansen wrote:
> > On 07/16/2018 09:56 AM, Thomas Gleixner wrote:
> > > On Mon, 16 Jul 2018, Rich Felker wrote:
> > > > At least the Centerton (late-generation Bonnell uarch) Atom
> > > > family is
> > > > omitted from the cpu_no_speculation table added by commit
> > > > fec9434a12f3
> > > > to arch/x86/kernel/cpu/common.c. Is this intentional? Would a
> > > > patch
> > > > adding it and possibly other omissions be welcome?
> > > 
> > > Probably. Dave?
> > 
> > IIRC, Alan Cox was compiling a list on what is affected vs. not.  He
> > would know way better than I.
> 
> The pre Silvermont atom cores are in order. When I did the original
> list I didn't bother with all the 32bit cores as we didn't have any
> 32bit mitigations then.

At least we should give the users that warm and fuzzy feeling that they are
not affected.

Thanks,

	tglx
