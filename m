Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C42C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BD02087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="T+ea7hdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfAGLYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:24:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41126 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfAGLYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:24:37 -0500
Received: from nazgul.tnic (unknown [78.130.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CDE21EC035B;
        Mon,  7 Jan 2019 12:24:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1546860275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IcM5TA0IuUQwbspzD3n7TdBp6UmZoVHuF6MwK3QYyDg=;
        b=T+ea7hdgmhZ2UCBPTtv+hGsfcAeq7eUR5AS3cdg9xvX45BaJC6Jpx84ZUhhhdfKb8MSvAO
        Gq0Vu+Uji/65BWERQnBZMUPmb6adQAtr1NRGxNxo0b5qIU5N3Xnj6zg1E22tTPKX2YzYEm
        G6kAFEW2FQg6mBQjZbGcQjI2XkQiDd4=
Date:   Mon, 7 Jan 2019 12:24:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "S, Shirish" <Shirish.S@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] x86/mce/amd: apply missing quirks for family 15
 models
Message-ID: <20190107112430.GA28223@nazgul.tnic>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:37:07AM +0000, S, Shirish wrote:
> This patch series applies to family 15 CPU's of AMD platforms,
> so as to address a consistent warning of
>  "[Firmware Bug]: cpu 0, invalid threshold interrupt offset"
> at every boot and upon completiong of successful S3 cycle,
> due to a missing quirk, which was not extended to newer models
> and also not applied in resume path.
> 
> Shirish S (2):
>   x86/mce/amd: Extend "Disable error thresholding bank 4" to more models
>   x86/mce/amd: Ensure quirks are applied in resume path as well
> 
>  arch/x86/kernel/cpu/mce/amd.c  | 34 ++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/mce/core.c |  2 +-
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> -- 

You sent those once three days ago. Why are you sending them again?
There's no changelog to explain what the difference is from the last
submission so what's up?

Also, I'd suggest you have more patience. And while you wait, you can
take a look at

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

to read up on all the modalities when sending patches.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
