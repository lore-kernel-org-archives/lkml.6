Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016C8C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB6A20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB6A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJ0BN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:13:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60426 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeJ0BN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:13:29 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 20B6_MW6XUMc; Fri, 26 Oct 2018 18:35:45 +0200 (CEST)
Received: from nazgul.tnic (unknown [185.30.24.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53F3E1EC05B0;
        Fri, 26 Oct 2018 18:35:45 +0200 (CEST)
Date:   Fri, 26 Oct 2018 18:35:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        bhe@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181026163554.GA26331@nazgul.tnic>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 08:32:11PM +0800, lijiang wrote:
> If SME is enabled in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
> contains the memory encryption mask, so i have to remove the sme mask to obtain the
> true physical address when dump vmcore.

Sorry, I have no clue what makedumpfile does exactly so you'd have to
be more detailed (or wait until I look at it :)). Which kernel accesses
which kernel's pagetable?

/me goes and looks at the makedumpfile's manpage...

Ok, it uses vmcoreinfo to exclude pages which would mean, it accesses
the first kernel's pagetable and traverses it.

Am I close?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
