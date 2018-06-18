Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6937C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887EF2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887EF2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935997AbeFRS5G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:57:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935752AbeFRS5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:57:04 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tYIZSDuT3OEs; Mon, 18 Jun 2018 20:57:03 +0200 (CEST)
Received: from zn.tnic (p200300EC2BE29C00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:9c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 509D51EC00FD;
        Mon, 18 Jun 2018 20:57:03 +0200 (CEST)
Date:   Mon, 18 Jun 2018 20:57:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com
Subject: Re: [PATCH] x86/CPU/AMD: Fix LLC ID bit-shift calculation
Message-ID: <20180618185654.GG24921@zn.tnic>
References: <1528915390-30533-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20180618172048.GD24921@zn.tnic>
 <8552af6b-c6c6-82d7-9df9-8b928ff3f1d9@amd.com>
 <20180618182315.GE24921@zn.tnic>
 <55a20153-9416-404b-7442-ed851386e2e0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55a20153-9416-404b-7442-ed851386e2e0@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 01:46:11PM -0500, Suthikulpanit, Suravee wrote:
> Your understanding is correct. I was not sure about what you were referring
> to earlier. Basically, the number of threads sharing cache is used to
> calculate the amount of right-shifting of APIC ID, which results in removing
> the core and thread ID bits.

Yap, that's exactly what I was hinting at, thanks. I'll add it to the
commit message.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
