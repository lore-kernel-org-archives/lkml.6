Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761A3C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EE22146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EE22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeLFXNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:13:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53416 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbeLFXNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:13:01 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gV2pE-0003ok-KK; Fri, 07 Dec 2018 00:12:56 +0100
Date:   Fri, 7 Dec 2018 00:12:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
cc:     Linus Walleij <linus.walleij@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] genirq: Export irq_chip_set_wake_parent()
In-Reply-To: <cd55816a-68da-c7d3-5dc7-bfe0b27c2ad2@arm.com>
Message-ID: <alpine.DEB.2.21.1812070012350.3743@nanos.tec.linutronix.de>
References: <20181129170312.23625-1-thierry.reding@gmail.com> <20181129170312.23625-3-thierry.reding@gmail.com> <CACRpkdbRswRmMWFGuB6pMWeUVdB6=rxqC-o4ytv1VhK-2yjWDg@mail.gmail.com> <cd55816a-68da-c7d3-5dc7-bfe0b27c2ad2@arm.com>
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

On Thu, 6 Dec 2018, Marc Zyngier wrote:

> On 05/12/2018 21:31, Linus Walleij wrote:
> > On Thu, Nov 29, 2018 at 6:03 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > 
> >> From: Thierry Reding <treding@nvidia.com>
> >>
> >> Interrupt controllers in a hierarchy want to use this function to
> >> propogate ->irq_set_wake() operations to their parent domains.
> >>
> >> Signed-off-by: Thierry Reding <treding@nvidia.com>
> > 
> > Tglx/Marc: is this change OK? (ACK?)
> 
> It looks OK to me, as it is consistent with irq_chip_set_type_parent,
> among others.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

No objections either:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
