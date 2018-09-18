Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88608C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA7D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA7D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbeISC3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:29:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58827 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729736AbeISC3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:29:31 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2N1Y-00032s-SC; Tue, 18 Sep 2018 22:55:08 +0200
Date:   Tue, 18 Sep 2018 22:55:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [REVIEW][PATCH 00/20] siginfo cleanups for x86
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182253220.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com>
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

On Tue, 18 Sep 2018, Eric W. Biederman wrote:
> I have been slowly going thought and reworking the arch specific
> functions that generate siginfo.  The problems I have been addressing
> is that using siginfo directly is error prone.  Using siginfo directly
> makes it easy to leave fields initialized, and get confused about
> which fields need to be filled in.
> 
> To address this I have added a series of helper functions to
> kernel/signal.c, that are specific to exactly one use of struct siginfo
> and take the parameters they need.
> 
> To use these functions the x86 signal handling needs some cleanups but
> the net result appears to be less code that is easier to follow.
> 
> If while looking over these patches you see anything please let me know.

Only nitpicks.

> I don't think I missed something but to err is human.

I went through the changes a couple of times, but failed to spot
something. Was pleasure to read that set!

> Likewise if you would like to merge these patches via the tip tree
> let me know.  Otherwise after the review is complete I plan on merging
> these into my siginfo tree.  At this point I believe all of the
> prerequisite patches are merged so it should not make a difference.

Works either way. Ingo?

Thanks,

	tglx
