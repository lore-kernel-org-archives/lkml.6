Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EA0C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7E32082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7E32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeK3XoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:44:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37347 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeK3XoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:44:11 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gSi0Z-0003LN-MB; Fri, 30 Nov 2018 13:34:59 +0100
Date:   Fri, 30 Nov 2018 13:34:59 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] x86/hyper-v: define structures from TLFS as packed
In-Reply-To: <20181130121511.12331-1-vkuznets@redhat.com>
Message-ID: <alpine.DEB.2.21.1811301320410.17702@nanos.tec.linutronix.de>
References: <20181130121511.12331-1-vkuznets@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Nov 2018, Vitaly Kuznetsov wrote:

> Subject: x86/hyper-v: define structures from TLFS as packed

Please start the first word after the prefix colon with an uppercase
letter. Also structures from TLFS doesn't make sense to me. Something like
this:

Subject: x86/hyper-v: Mark TLFS structures packed

> Without 'packed' compiler is free to add optimization paddings and re-order
> structure fields for randomization/optimization. And structures from

s/And/As/ ?

> hyperv-tlfs.h are used for hypervisor-guest communication, we need to
> ultimately forbid such practices.

That whole paragraph reads a bit strange. Something like:

  The TLFS structures are used for hypervisor-guest communication and must
  exactly meet the specification.

  Compilers can add alignment padding to structures or reorder struct
  members for randomization and optimization, which would break the
  hypervisor ABI.

  Mark the structures as packed to prevent this.

Hmm?

> Suggested-by: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Other than that: Acked-by: Thomas Gleixner <tglx@linutronix.de>
