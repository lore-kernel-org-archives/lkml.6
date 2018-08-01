Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24033C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE90C20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE90C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbeHAR3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:29:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47210 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388988AbeHAR3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:29:38 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gVfDq5BzkABE; Wed,  1 Aug 2018 17:43:19 +0200 (CEST)
Received: from nazgul.tnic (95-42-131-245.ip.btc-net.bg [95.42.131.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 39F141EC0591;
        Wed,  1 Aug 2018 17:43:19 +0200 (CEST)
Date:   Wed, 1 Aug 2018 17:43:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        sironi@amazon.de, tony.luck@intel.com
Subject: Re: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
Message-ID: <20180801154255.GC13988@nazgul.tnic>
References: <20180601121939.GA23298@nazgul.tnic>
 <20180731112739.32338-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180731112739.32338-1-prarit@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(dropping stable@)

On Tue, Jul 31, 2018 at 07:27:39AM -0400, Prarit Bhargava wrote:
> I tested this on AMD Ryzen & Intel Broadwell system and dumped the
> boot_cpu_data before and after a microcode update.  On the Intel
> system I also did a fatal MCE using mce-inject to confirm the output
> from the mce handling code.

Ok, sending the two patches I've massaged into submission as a reply to
this message - please run them on your boxes. You can also inject MCEs
on the AMD box to verify - simply enable CONFIG_X86_MCE_INJECT, go to
debugfs and do, for example:

cd /sys/kernel/debug/mce-inject/
echo 10 > /sys/devices/system/machinecheck/machinecheck0/check_interval
echo 0x9c7d410092080813 > status; echo 0x000000006d3d483b > addr; echo 2 > cpu; echo 4 > bank; echo hw > flags
echo 0xbc00200000010015 > status; echo 0x00000000942e4d98 > addr; echo 6 > cpu; echo 2 > bank; echo hw > flags
echo 0xfe000010000b0c0f > status; echo 0xe1101add1e550012 > addr; echo 0xcafebeef > misc; echo 2 > cpu; echo hw > flags; echo 4 > bank

Thanks!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
