Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B1DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68B4208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68B4208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbeGaOkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:40:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50876 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732107AbeGaOkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:40:20 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bAWxVfGTqTbm; Tue, 31 Jul 2018 15:00:05 +0200 (CEST)
Received: from nazgul.tnic (95-42-131-245.ip.btc-net.bg [95.42.131.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80C451EC01A9;
        Tue, 31 Jul 2018 15:00:05 +0200 (CEST)
Date:   Tue, 31 Jul 2018 15:00:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Sironi, Filippo" <sironi@amazon.de>
Cc:     Prarit Bhargava <prarit@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
Message-ID: <20180731130003.GA22814@nazgul.tnic>
References: <20180601121939.GA23298@nazgul.tnic>
 <20180731112739.32338-1-prarit@redhat.com>
 <65549531-EA3A-49ED-BECA-D5F85B9F09E4@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65549531-EA3A-49ED-BECA-D5F85B9F09E4@amazon.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:46:09AM +0000, Sironi, Filippo wrote:
> There may be a chance of skipping this code, I think.
> 
> If the microcode is loaded on the hyperthread sibling of the boot cpu
> before being loaded on the boot cpu, the boot cpu will exit earlier
> from apply_microcode_intel() - in if (rev >= mc->hdr.rev) { ... }.
> 
> (This seems to be possible in apply_microcode_amd() as well.)
> 
> In my tree with the aforementioned change - Intel only - I also had
> the following patch:

Yap, good catch.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
