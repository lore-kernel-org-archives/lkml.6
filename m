Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C42C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E8820827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E8820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbeJ2TRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:17:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38380 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbeJ2TRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:17:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 906F6165C;
        Mon, 29 Oct 2018 03:29:08 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 603E93F6A8;
        Mon, 29 Oct 2018 03:29:08 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5978E1AE0757; Mon, 29 Oct 2018 10:29:15 +0000 (GMT)
Date:   Mon, 29 Oct 2018 10:29:15 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Maksym Kokhan <maksym.kokhan@globallogic.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/8] add generic builtin command line
Message-ID: <20181029102914.GA14127@arm.com>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <20180929181725.GB27441@fifo99.com>
 <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
 <CAMT6-xj1rjVAy1AWFiMHc5wH36eu=TUSMtdKU=-qRtUbwr9bkg@mail.gmail.com>
 <20181023144815.GP30658@n2100.armlinux.org.uk>
 <CAMT6-xhvqy5PeQmkQ8tsLRiML_pNJTxyq7dizRRvZTEqc7uzgg@mail.gmail.com>
 <20181024090732.GS30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024090732.GS30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 10:07:32AM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 24, 2018 at 11:57:44AM +0300, Maksym Kokhan wrote:
> > Do you mean, that you haven't seen patch for ARM, which I sent on
> > September 27 along with cover and patch 1? It is strange, because
> > you was the one from recipients. If so, you can see this patch here:
> > https://lore.kernel.org/patchwork/patch/992779/
> 
> It seems that I have received patch 5, _but_ it's not threaded with
> the cover message and patch 1.  With 50k messages in my inbox, and 3k
> messages since you sent the series, it's virtually impossible to find
> it (I only found it by looking at my mail server logs from September
> to find the subject, and then searching my mailbox for that subject.)
> 
> This is unnecessarily difficult.

This comes up surprisingly often, and I think part of the issue is that
different maintainers have different preferences. I also prefer to receive
the entire series and cover-letter, but I've seen people object to being
CC'd on the whole series as well (how they manage to review things in
isolation is another question...!)

I wonder if we could have an entry in MAINTAINERS for this sort of
preference?

Maksym: in the short term, please just stick me and Russell on CC for the
entire thing.

Will
