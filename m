Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB034C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A410B20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A410B20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeK2AJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:09:31 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59649 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeK2AJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:09:30 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gRzZE-0005cU-CN; Wed, 28 Nov 2018 14:07:48 +0100
Date:   Wed, 28 Nov 2018 14:07:42 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
cc:     Nadav Amit <nadav.amit@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
In-Reply-To: <87a7ltjxnz.fsf@vitty.brq.redhat.com>
Message-ID: <alpine.DEB.2.21.1811281404230.1532@nanos.tec.linutronix.de>
References: <20181126154732.23025-1-vkuznets@redhat.com> <20181126154732.23025-2-vkuznets@redhat.com> <20181126200413.GA7852@rkaganb.sw.ru> <87wooyk6na.fsf@vitty.brq.redhat.com> <20181127184835.GA5147@rkaganip.lan> <8A215F49-BB8F-4E93-AC62-EC33B4734F24@gmail.com>
 <87a7ltjxnz.fsf@vitty.brq.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1590561786-1543410468=:1532"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1590561786-1543410468=:1532
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 28 Nov 2018, Vitaly Kuznetsov wrote:

> Nadav Amit <nadav.amit@gmail.com> writes:
> 
> >
> > On a different note: how come all of the hyper-v structs are not marked
> > with the “packed" attribute?
> 
> "packed" should not be needed with proper padding; I vaguely remember
> someone (from x86@?) arguing _against_ "packed".

Packed needs to be used, when describing fixed format data structures in
hardware or other ABIs, so the compiler cannot put alignment holes into
them.

Using packed for generic data structures might result in suboptimal layouts
and prevents layout randomization.

Thanks,

	tglx
--8323329-1590561786-1543410468=:1532--
