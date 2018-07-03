Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947B8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D33F24736
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D33F24736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeGCVnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:43:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37566 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753076AbeGCVnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:43:08 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DitO_wuQEbpO; Tue,  3 Jul 2018 23:43:06 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCC6E00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:6e00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CFD91EC019F;
        Tue,  3 Jul 2018 23:43:06 +0200 (CEST)
Date:   Tue, 3 Jul 2018 23:43:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, Filippo Sironi <sironi@amazon.de>
Subject: Re: [PATCH] x86/MCE: Fix CPU microcode version output
Message-ID: <20180703214300.GA15087@zn.tnic>
References: <20180703164844.9742-1-prarit@redhat.com>
 <20180703165849.GA17773@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180703165849.GA17773@agluck-desk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 09:58:49AM -0700, Luck, Tony wrote:
> On Tue, Jul 03, 2018 at 12:48:44PM -0400, Prarit Bhargava wrote:
> > On systems where a runtime microcode update has occurred the
> > microcode version is wrong because boot_cpu_data.microcode is
> > not updated during runtime.
> > 
> > Use the per-CPU microcode version in the MCE message.
> 
> Other option would be to fix the microcode update code to make
> sure that boot_cpu_data.microcode is right.

Yes, I already requested that:

https://lkml.kernel.org/r/1527852626-7258-1-git-send-email-sironi@amazon.de

Looks like Filippo has a patch already. CCed.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
