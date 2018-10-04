Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAEDC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12AF21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12AF21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJDSFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:05:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37910 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbeJDSFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:05:52 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EHGZR2f9PUKl; Thu,  4 Oct 2018 13:13:04 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A7EB1EC02D1;
        Thu,  4 Oct 2018 13:13:04 +0200 (CEST)
Date:   Thu, 4 Oct 2018 13:12:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: x86/mm: Found insecure W+X mapping at address (ptrval)/0xc00a0000
Message-ID: <20181004111258.GJ1864@zn.tnic>
References: <c8da5778-3957-2fab-69ea-42f872a5e396@molgen.mpg.de>
 <alpine.DEB.2.21.1809281653270.2004@nanos.tec.linutronix.de>
 <20181003212255.GB28361@zn.tnic>
 <20181004080321.GA3630@8bytes.org>
 <20181004081429.GB1864@zn.tnic>
 <6cbb9135-7e89-748f-1d55-ac105a9f8091@molgen.mpg.de>
 <20181004084946.GD1864@zn.tnic>
 <bdc5d224-91d6-eeee-c334-4b76efb56cac@molgen.mpg.de>
 <20181004105443.GH1864@zn.tnic>
 <fa6086e6-5f89-ec11-d14c-78f8f761b8b7@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa6086e6-5f89-ec11-d14c-78f8f761b8b7@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 01:00:42PM +0200, Paul Menzel wrote:
> While here you write, it did not.

Read again what I said:

> and I did try marking the ISA range RO in mark_rodata_ro() but the
> machine wouldn't boot after.

and the code I pasted has this:

	//      init_memory_mapping(0, ISA_END_ADDRESS);

which is disabling the direct mapping of the ISA range.

Two very different things.

And you don't absolutely need to try it because it would simply move the
warning to another address, just like it happened on my system. Because
looking at your dmesg, that E350M1 machine is very similar to the laptop
I have. But feel free if you have time on your hands... :)

> Sorry I do not understand the question. I carry the SSD drive with
> me, and connect it to the ASRock E350M1 (64-bit) or to the Lenovo
> X60 laptop and boot from it from both systems.

So it is an OS installation which you swap between two machines. I
admit, it is the first time I hear of such a use case. In that case,
yes, bitness does matter.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
