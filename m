Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34148C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D4C21EB6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D4C21EB6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbeHISnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:43:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37080 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbeHISnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:43:51 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ALuRgVcBss28; Thu,  9 Aug 2018 18:17:57 +0200 (CEST)
Received: from nazgul.tnic (77-85-50-230.ip.btc-net.bg [77.85.50.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 523791EC01A9;
        Thu,  9 Aug 2018 18:17:57 +0200 (CEST)
Date:   Thu, 9 Aug 2018 18:18:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 2/2] x86/MCE/AMD: Skip creating kobjects with NULL names
Message-ID: <20180809161806.GB20928@nazgul.tnic>
References: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
 <20180809140834.59264-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180809140834.59264-2-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 09:08:34AM -0500, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> During mce_threshold_create_device() data structures are allocated for
> each CPUs MCA banks and thresholding blocks. These data structures are
> used to save information related to AMD's MCA Error Thresholding
> feature. The structures are used in the thresholding interrupt handler,
> and they are exposed to the user through sysfs. The sysfs interface has
> user-friendly names for each bank.
> 
> However, errors in mce_threshold_create_device() will cause all the data
> structures to be deallocated. This will break the thresholding interrupt
> handler since it depends on these structures.

Same argument as before: if our init fails in some fashion, we should
not be running the interrupt handler.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
