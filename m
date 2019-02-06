Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E30DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240EE2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dZtgTolq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBFTHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:07:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35308 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfBFTHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:07:38 -0500
Received: from zn.tnic (p200300EC2BCEF100C05112067955C97B.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:f100:c051:1206:7955:c97b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD8251EC0A98;
        Wed,  6 Feb 2019 20:07:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549480056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WWfiCOY5QJ10wbuwitVtx/2Y7BRU6je1aaJqdUPB3S0=;
        b=dZtgTolqMWDHcPKycdUxld1sUYCiKpq5K5G/oJd0Omer7LyD/EXWrd9yVsWJwIY6bEH2OR
        CPusjEyw8ppP6shJVFWj87aruWOKwqByw2dhpgLwVhDXZxnYGp9LOg6Q/BQ0GHqhzEGgM/
        XDqg9E+lzdjGsSxqrFEmJ6ycstv43H0=
Date:   Wed, 6 Feb 2019 20:07:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 5/9] x86/alternative: Split text_poke_bp() into tree
 steps
Message-ID: <20190206190726.GI7314@zn.tnic>
References: <cover.1549308412.git.bristot@redhat.com>
 <cf7096ad15708be48f3ea62b4e903f6ef29e2838.1549308412.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf7096ad15708be48f3ea62b4e903f6ef29e2838.1549308412.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 08:58:58PM +0100, Daniel Bristot de Oliveira wrote:
> text_poke_bp() updates instructions on live kernel on SMP in three steps:
>  1) add a int3 trap to the address that will be patched
>  2) update all but the first byte of the patched range
>  3) replace the first byte (int3) by the first byte of
> 
> This patch creates one function for each of these steps.

s/This patch creates/Create/

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
