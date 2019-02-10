Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105DAC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C4F20863
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfBJVtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 16:49:07 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37422 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBJVtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 16:49:06 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gswy4-0001Uf-LY; Sun, 10 Feb 2019 22:48:52 +0100
Date:   Sun, 10 Feb 2019 22:48:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     lantianyu1986@gmail.com
cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        joro@8bytes.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, iommu@lists.linux-foundation.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com,
        alex.williamson@redhat.com, dan.carpenter@oracle.com
Subject: Re: [PATCH V3 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
In-Reply-To: <1549553629-8414-2-git-send-email-Tianyu.Lan@microsoft.com>
Message-ID: <alpine.DEB.2.21.1902102247100.8784@nanos.tec.linutronix.de>
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com> <1549553629-8414-2-git-send-email-Tianyu.Lan@microsoft.com>
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

On Thu, 7 Feb 2019, lantianyu1986@gmail.com wrote:

> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> set x2apic destination mode to physcial mode when x2apic is available
> and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> 8-bit APIC id.

This looks good now. Can that be applied independent of the IOMMU stuff or
should this go together. If the latter:

   Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

If not, I just queue if for 5.1. Let me know,

Thanks,

	tglx
