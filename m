Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC1EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C68821582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C68821582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeI0VX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:23:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52246 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI0VX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:23:29 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5XqQ-000620-Ix; Thu, 27 Sep 2018 17:04:46 +0200
Date:   Thu, 27 Sep 2018 17:04:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rob Prowel <rprowel@comcast.net>
cc:     linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon bogus performance value causing RCU stalls?
In-Reply-To: <38932eb1-921f-55f7-10c8-358f9aae32b2@comcast.net>
Message-ID: <alpine.DEB.2.21.1809271703530.8118@nanos.tec.linutronix.de>
References: <6243f7cc-1a80-db0b-4765-fa12bda9b06a@comcast.net> <alpine.DEB.2.21.1809232314460.1398@nanos.tec.linutronix.de> <38932eb1-921f-55f7-10c8-358f9aae32b2@comcast.net>
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

On Wed, 26 Sep 2018, Rob Prowel wrote:
> On 09/23/18 17:19, Thomas Gleixner wrote:
> > > 
> > > Other than RTFM, or please build a bunch of kernels from source on your
> > > slow
> > > machine, using differing config options to help track down the cause of
> > > this...any thoughts about a solution?
> > 
> > Yes. This was decoded recently as an issue on 32bit due to a calculation
> > which is based on 'unsigned long' but requires to be 64bit wide.
> > 
> > It's in the 4.18.8 stable kernel, which should be available from your
> > fedora repo anytime soon.
> 
> OK.  Followup on AMD performance counter problem in 4.18.7
> 
> The Dell machine I was experiencing the problem on had a lot of ACPI
> issues.  One of the invalid ACPI entries was for a system timer.
> dmesg suggests that the broken timer was used in calculating the
> Athlon performance value.  So no, 32/64 bit math was not the issue.

Uff.

> ACPI=off in the kernel boot line fixed the issue completely. Machine
> still functions well as a file/web/postgresql dev server so it's all
> good.

Thanks for letting me know. I was about to dust of that old X2 I have
somewhere.

Thanks,

	tglx
