Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B0EECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6154F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6154F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeGTITv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:19:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47806 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbeGTITv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:19:51 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kEOG6nptlX3S; Fri, 20 Jul 2018 09:32:54 +0200 (CEST)
Received: from nazgul.tnic (77-85-109-49.ip.btc-net.bg [77.85.109.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A7C51EC06DA;
        Fri, 20 Jul 2018 09:32:54 +0200 (CEST)
Date:   Fri, 20 Jul 2018 09:32:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>, lijiang <lijiang@redhat.com>
Cc:     bhe@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com,
        joro@8bytes.org, thomas.lendacky@amd.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Message-ID: <20180720073245.GA26926@nazgul.tnic>
References: <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
 <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
 <20180709092901.GA22182@nazgul.tnic>
 <fc6a47ca-1b16-eba5-d15e-ca294e01af93@redhat.com>
 <20180713170857.GB17896@nazgul.tnic>
 <33453712-9b0b-e8b9-08a6-de09e0806dd6@redhat.com>
 <20180720052304.GA9146@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720052304.GA9146@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 01:23:04PM +0800, Dave Young wrote:
> > Here, it doesn't need to dump MMIO space of the previous kernel, when the
> > kdump kernel boot, the MMIO address will be remapped in decryption manners,
> > but the MMIO address don't belong to the range of the crash reserved memory,
> > for the kdump kernel, the MMIO space(address) and IOMMU device table(address)
> > are outside address, whereas, the IOMMU device table is encrypted in the first
> > kernel, the kdump kernel will need to copy the content of IOMMU device table
> > from the first kernel when the kdump kernel boot, so the IOMMU device table will
> > be remapped in encryption manners.

-ENOFCKINGPARSE

I believe you're the only one who understands that humongous sentence.
How about using a fullstop from time to time. And WTF is "encryption
manners"?

> > So some of them require to be remapped in encryption manners, and some(address)
> > require to be remapped in decryption manners.

> There could be some misunderstanding here.

Hell yeah there's a misunderstanding!

Can you folks first relax, sit down and explain the whole problem in
*plain* English using *simple* sentences. *Not* like the unparseable
mess above. Use simple, declaratory sentences and don't even try to
sound fancy:

"The first kernel boots. It's memory is encrypted... Now, the second
kernel boots. It must do A because of B. In order to do A, it needs to
do C. Because D..."

And so on. Explain what the problem is first. Then explain the proposed
solution. Explain *why* it needs to be done this way.

When you've written your explanation, try to read it as someone who
doesn't know kdump and *think* hard whether your explanation makes
sense. If it doesn't, fix it and read it again. Rinse and repeat. Until
it is clear to unenlightened readers too.

It is about time this hurried throwing of half-baked patches at
maintainers and seeing what sticks, stops!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
