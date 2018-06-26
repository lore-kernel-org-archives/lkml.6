Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F5FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8CE266FF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8CE266FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeFZIpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:45:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49002 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeFZIpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:45:19 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXjb9-0004u7-7n; Tue, 26 Jun 2018 10:45:15 +0200
Date:   Tue, 26 Jun 2018 10:45:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michal Hocko <mhocko@kernel.org>
cc:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>
Subject: Re: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
In-Reply-To: <20180626063521.GT28965@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1806261043080.2204@nanos.tec.linutronix.de>
References: <20180516233207.1580-1-toshi.kani@hpe.com> <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de> <1529938470.14039.134.camel@hpe.com> <20180625175225.GQ28965@dhcp22.suse.cz> <1529961187.14039.206.camel@hpe.com>
 <20180626063521.GT28965@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018, Michal Hocko wrote:
> On Mon 25-06-18 21:15:03, Kani Toshimitsu wrote:
> > Lastly, for the code maintenance, I believe this memory allocation keeps
> > the code much simpler than it would otherwise need to manage a special
> > page list.
> 
> Yes, I can see a simplicity as a reasonable argument for a quick fix,
> which these pile is supposed to be AFAIU. So this might be good to go
> from that perspective, but I believe that this should be changed in
> future at least.

So the conclusion is, that we ship this set of patches now to cure the
existing wreckage, right?

Fine with that, but who will take care of reworking it proper? I'm
concerned that this will just go stale the moment the fixes hit the tree.

Thanks,

	tglx
