Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C3F20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C3F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeIFSjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:39:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34123 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeIFSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:39:01 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxusO-0000Ur-Us; Thu, 06 Sep 2018 16:03:17 +0200
Date:   Thu, 6 Sep 2018 16:03:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     James Morse <james.morse@arm.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: Re: [RFC PATCH 00/20] x86/intel_rdt: Start abstraction for a second
 arch
In-Reply-To: <dfe94bdc-8fe8-55ff-9c6d-268ffd9dc4ed@arm.com>
Message-ID: <alpine.DEB.2.21.1809061559260.1570@nanos.tec.linutronix.de>
References: <20180824104519.11203-1-james.morse@arm.com> <20180827142204.GA223688@romley-ivt3.sc.intel.com> <dfe94bdc-8fe8-55ff-9c6d-268ffd9dc4ed@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018, James Morse wrote:
> You want to see it all at once (great!). I'm not quite ready with all this yet,
> so it will be a while. I assumed 'all at once' would be to much to ask from
> reviewers, hence this attempt to break it into small chunks and post it over a
> longer period of time.

And that's perfectly fine. We know where you are heading to and we also
don't want to have duplication of that stuff. So separating it in place
which also makes further modification follow that separate model is the
right thing to do.

That said, can the RDT people @Intel please look at that separation as a
work of its own? Moving the separated part over to fs/xxx is a nobrainer
after that.

I skimmed through the pile and couldn't spot something which made me
immediately barf, but my capacity is not allowing me to do a thorough
review.

Thanks,

	tglx
