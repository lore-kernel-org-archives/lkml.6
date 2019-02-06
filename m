Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CE7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE00217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ruhgDjEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfBFRyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:54:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53290 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfBFRyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:54:09 -0500
Received: from zn.tnic (p200300EC2BCEF100C1C850073B25A4AC.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:f100:c1c8:5007:3b25:a4ac])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F00E61EC03D8;
        Wed,  6 Feb 2019 18:54:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549475648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IPCia0Z97GpfiVP2x9t4M7hbu3YYYO85N5VWc6T8Dec=;
        b=ruhgDjEQOFdztiTMC79z+L7d94lEjsTQYv6BKnA+5mIDEnGxtcum9J0A+3ExXoJ+YlIqXS
        zU5B6AtkpGWJ+5CZ30Rs9u8ObTAQ1qbBlHHejb9/8/++xKLIwog/pdvrrQWJwTqI3wRtbJ
        cbeYqusqwz6BbjxmFfZS23kJUFm/NAg=
Date:   Wed, 6 Feb 2019 18:53:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Julian Stecklina <js@alien8.de>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, jschoenh@amazon.de,
        Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] x86/boot: increase maximum number of avoided KASLR
 regions
Message-ID: <20190206175357.GG7314@zn.tnic>
References: <1548866403-13390-1-git-send-email-js@alien8.de>
 <1548866403-13390-2-git-send-email-js@alien8.de>
 <20190205144441.GS21801@zn.tnic>
 <ciirm8womdaxn2.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <20190206141753.GE7314@zn.tnic>
 <CAGXu5jLdm5O9U5N+LR15EnAYcPGB83qK_soaKb7HJ_Pa+G5+Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXu5jLdm5O9U5N+LR15EnAYcPGB83qK_soaKb7HJ_Pa+G5+Fg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 03:29:06PM +0000, Kees Cook wrote:
> I'm fine adjusting all this to do things better. Ultimately, we're
> still walking two lists to process their intersection.

I'm wondering if we could start with a single range including all memory
and then keep exluding until we're done and then feed those remaining
ranges to slots_fetch_random(). So that mem_avoid[] is not needed
anymore.

Probably need to look for the devil in the detail first.

> Eh, it's just in the boot stub. ;)

They always say something like that. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
