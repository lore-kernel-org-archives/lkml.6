Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3450C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BDC20878
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BDC20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeGDTkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:40:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48469 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeGDTkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:40:07 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fand3-00054R-69; Wed, 04 Jul 2018 21:39:53 +0200
Date:   Wed, 4 Jul 2018 21:39:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Will Deacon <will.deacon@arm.com>
cc:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <MHocko@suse.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with
 addr
In-Reply-To: <20180704173605.GB9668@arm.com>
Message-ID: <alpine.DEB.2.21.1807042137330.28271@nanos.tec.linutronix.de>
References: <20180627141348.21777-1-toshi.kani@hpe.com> <20180627141348.21777-3-toshi.kani@hpe.com> <20180627155632.GH30631@arm.com> <1530115885.14039.295.camel@hpe.com> <20180629122358.GC17859@arm.com> <1530287995.14039.361.camel@hpe.com>
 <alpine.DEB.2.21.1807032301140.1816@nanos.tec.linutronix.de> <20180704173605.GB9668@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Will Deacon wrote:
> On Tue, Jul 03, 2018 at 11:02:15PM +0200, Thomas Gleixner wrote:
> 
> > I just pick it up and provide Will a branch to pull that lot from.
> 
> Thanks, Thomas. Please let me know once you've pushed something out.

Just pushed it out into tip x86/mm branch. It's based on -rc3 and you can
consume it up to

  5e0fb5df2ee8 ("x86/mm: Add TLB purge to free pmd/pte page interfaces")

Please wait until tomorrow morning so the 0day robot can chew on it. If
nothing breaks, then it should be good to pull from.

Thanks,

	tglx


