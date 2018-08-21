Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056ADC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F0120895
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F0120895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeHUQlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:41:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbeHUQlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:41:52 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EvaJ79_dH0Hg; Tue, 21 Aug 2018 15:21:27 +0200 (CEST)
Received: from nazgul.tnic (77-85-47-250.ip.btc-net.bg [77.85.47.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 13D531EC0330;
        Tue, 21 Aug 2018 15:21:25 +0200 (CEST)
Date:   Tue, 21 Aug 2018 15:21:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/MCE/AMD: Check for NULL banks in THR interrupt
 handler
Message-ID: <20180821132141.GF30528@nazgul.tnic>
References: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
 <20180809161548.GA20928@nazgul.tnic>
 <BN7PR12MB259365671F2A73D5FF33C134F8250@BN7PR12MB2593.namprd12.prod.outlook.com>
 <BN7PR12MB25930909EFF4F407A528A44FF83E0@BN7PR12MB2593.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN7PR12MB25930909EFF4F407A528A44FF83E0@BN7PR12MB2593.namprd12.prod.outlook.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 07:00:43PM +0000, Ghannam, Yazen wrote:
> So I think we should keep the NULL pointer checks for now to keep this fix
> small. I can make a new patch following your suggestion above.
> 
> We can change the code so that we create the data structures during the
> earlier init process, but I think this will be a much bigger change. This could
> fall under the idea of decoupling the handling code from sysfs.

Ok, then pls add the simpler fixes at the beginning of the series so
that they can go to stable and have the more involved changes follow
them.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
