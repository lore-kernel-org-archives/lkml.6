Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 11B08C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58CD208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58CD208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756043AbeFOLnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:43:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51410 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755651AbeFOLnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:43:00 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mmmz4Uu-fi9j; Fri, 15 Jun 2018 13:42:59 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCDD600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:d600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F0F61EC0299;
        Fri, 15 Jun 2018 13:42:59 +0200 (CEST)
Date:   Fri, 15 Jun 2018 13:42:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] x86/microcode/AMD: Check microcode container data
 in the early loader
Message-ID: <20180615114253.GD25559@zn.tnic>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
 <0c53181bd5eb4e172407d9fde534cedb12e19b98.1526767245.git.mail@maciej.szmigiero.name>
 <20180605085427.GB1617@zn.tnic>
 <7c47bfe2-3293-2973-d9bb-daa218d5751b@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c47bfe2-3293-2973-d9bb-daa218d5751b@maciej.szmigiero.name>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 10:56:07PM +0200, Maciej S. Szmigiero wrote:
> At this point we don't know the CPU family the particular patch is for
> since the patch header contains only CPU rev_id, not an explicit family
> number.

	patch_fam = 0xf + (mc->processor_rev_id >> 12);

which means, you can do

        if (patch_fam != family)
                return 0;

like verify_and_add_patch() does before calling verify_patch() with the
correct family of the current CPU.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
