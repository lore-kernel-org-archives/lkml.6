Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EB9C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CCE216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CCE216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeHUQft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:35:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49646 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbeHUQft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:35:49 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2SVsYDHxrXxb; Tue, 21 Aug 2018 15:15:25 +0200 (CEST)
Received: from nazgul.tnic (77-85-47-250.ip.btc-net.bg [77.85.47.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF0491EC028D;
        Tue, 21 Aug 2018 15:15:24 +0200 (CEST)
Date:   Tue, 21 Aug 2018 15:15:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] x86/MCE/AMD: Skip creating kobjects with NULL names
Message-ID: <20180821131541.GE30528@nazgul.tnic>
References: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
 <20180809140834.59264-2-Yazen.Ghannam@amd.com>
 <20180809161806.GB20928@nazgul.tnic>
 <BN7PR12MB259395675EBD74400D9FEBE5F8250@BN7PR12MB2593.namprd12.prod.outlook.com>
 <20180815155452.GB28669@nazgul.tnic>
 <BN7PR12MB2593C9819A949A2F7571FAB7F83E0@BN7PR12MB2593.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN7PR12MB2593C9819A949A2F7571FAB7F83E0@BN7PR12MB2593.namprd12.prod.outlook.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 06:46:33PM +0000, Ghannam, Yazen wrote:
> Future SMCA systems may have banks whose MCA_IPID is not known so we

You lost me here. How would the IPID not be known? Are you talking about
an old kernel running on new HW and thus the HardwareID in its MCA_IPID
to be unknown to the old kernel?

> In the past, the sysfs entries were named something like "th_bank#" before
> each bank was given a more descriptive name. We can go back to this format
> as a fallback for unrecognized bank types. This will fix the issue with sysfs
> failing and also the interface will still work on new hardware.

You could do: th_bank#<HardwareID> so that we can find what it is by
grepping the PPR.

> I agree. I just wanted to make a small change and fix this issue. I
> think there's a lot we can do to clean up the thresholding code going
> forward.

ACK.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
