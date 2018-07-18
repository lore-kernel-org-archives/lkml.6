Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8970ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A9B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A9B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbeGRTjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:39:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59254 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbeGRTjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:39:47 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ffrga-0003ba-RD; Wed, 18 Jul 2018 21:00:28 +0200
Date:   Wed, 18 Jul 2018 21:00:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: NULL pointer dereference in msi_set_mask_bit
In-Reply-To: <178bb701-56af-06cf-4836-1a26e74f2b07@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1807182058110.1689@nanos.tec.linutronix.de>
References: <b9bd8405-64b6-2bea-f5ce-d3ab4d82452a@molgen.mpg.de> <20180718140636.GD128988@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.21.1807181646280.1568@nanos.tec.linutronix.de> <6339fdef-a335-b833-4022-23725fd86d9e@molgen.mpg.de>
 <alpine.DEB.2.21.1807181722020.1568@nanos.tec.linutronix.de> <178bb701-56af-06cf-4836-1a26e74f2b07@molgen.mpg.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.21.1807182058431.1689@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Wed, 18 Jul 2018, Paul Menzel wrote:
> On 07/18/18 17:39, Thomas Gleixner wrote:
> > Bah. Could you please enable GENERIC_IRQ_DEBUGFS and after a successful
> > boot up provide me the content of all files in /sys/kernel/debug/irq/ and
> > its subfolders?
> 
> Sure, please find them attached. `7zr x sys-kernel-debug-irq.7z` should
> extract it.

It generates the files, but they are all size '1' and contain nothing.

Thanks,

	tglx
