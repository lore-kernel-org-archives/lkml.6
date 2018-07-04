Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B830AC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6E6244CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6E6244CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeGDKAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:00:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46866 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753600AbeGDKAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:00:22 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faea4-0003cF-D2; Wed, 04 Jul 2018 12:00:12 +0200
Date:   Wed, 4 Jul 2018 12:00:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH 0/2] Allwinner A64 timer workaround
In-Reply-To: <1d75c538-9166-5eec-a08c-b168f9770bd1@arm.com>
Message-ID: <alpine.DEB.2.21.1807041151530.1816@nanos.tec.linutronix.de>
References: <20180511022751.9096-1-samuel@sholland.org> <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com> <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org> <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com> <24b78819-5e3f-431f-3987-f7409742ef07@linaro.org>
 <1d75c538-9166-5eec-a08c-b168f9770bd1@arm.com>
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

On Wed, 4 Jul 2018, Marc Zyngier wrote:
> On 04/07/18 09:23, Daniel Lezcano wrote:
> > 
> > If the patches fix a bug which already exist, it makes sense to
> > propagated the fix back to the stable versions.
>
> That's your call, but I'm not supportive of that decision, specially as
> we have information from the person developing the workaround that this
> doesn't fully address the issue.

The patches should not be applied at all. Simply because they don't fix the
issue completely.

From a quick glance at various links and information about this, this very
much smells like the FSL_ERRATUM_A008585.

Has that been tried? It looks way more robust than the magic 11 bit
crystal ball logic.

Thanks,

	tglx


