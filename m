Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDBEC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58E920881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58E920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbeGIJ3O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:29:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41160 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754404AbeGIJ3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:29:11 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s89sPC2jAeDW; Mon,  9 Jul 2018 11:29:10 +0200 (CEST)
Received: from nazgul.tnic (unknown [78.130.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44A8C1EC0559;
        Mon,  9 Jul 2018 11:29:10 +0200 (CEST)
Date:   Mon, 9 Jul 2018 11:29:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, dyoung@redhat.com,
        kexec@lists.infradead.org, iommu@lists.linux-foundation.org,
        bhe@redhat.com
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Message-ID: <20180709092901.GA22182@nazgul.tnic>
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com>
 <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
 <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
 <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7357038-08bd-7ba8-5357-7c91d21d10fe@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 02:28:11PM +0800, lijiang wrote:
> Last week, I had tried many ways to do this work, but it looks
> like that the ways of deducing address is not suitable to another
> scenarios, such as mapping some devices mmio space, which are
> unencrypted, and the device mmio space is outside kdump kernel like
> the old memory, but the old memory is encrypted, we can't find the
> general rules to decide when to encrypt or not.

If we can't find the "general rules" how is the caller supposed to know
how to access the memory?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
