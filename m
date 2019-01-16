Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33013C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B8320840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VtqPVdoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfAPTgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:36:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47290 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbfAPTgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:36:12 -0500
Received: from zn.tnic (p200300EC2BC98A00CC5DAB5F6CE50A3B.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:8a00:cc5d:ab5f:6ce5:a3b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1AD251EC0842;
        Wed, 16 Jan 2019 20:36:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547667370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=freker2xeydPEgartPfZuvsLaLqyXV0J4pURt/MXxYg=;
        b=VtqPVdoHFqAL18W5VIeFb0EtM9QblyqF0NIEESF04F2ItIXP9gWy2X+DlEFMf2vmUMzwOr
        HydtoMXE9L9bWC3nHdaP0wtyfpIwR63O3/egmcZKnHAnBE5bMpzg2BSOeYnXAu8IsfxQUv
        gTtRcWxB3Hw7A81pgMw+LotKzQRREBw=
Date:   Wed, 16 Jan 2019 20:36:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 05/22] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Message-ID: <20190116193603.GK15409@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-6-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:27PM +0100, Sebastian Andrzej Siewior wrote:
> Since ->initialized is always true for user tasks and kernel threads
> don't get this far,

Yeah, this is commit message is too laconic. Don'g get this far "where"?

> we always save the registers directly to userspace.

We don't save registers to userspace - please write stuff out.

So from looking at what you're removing I can barely rhyme up what
you're doing but this needs a lot more explanation why it is OK to
remove the else case. Hell, why was the thing added in the first place
if ->initialized is always true?

And why is it ok to save registers directly to the user task's buffers?

So please be more verbose even at the risk of explaning the obvious.
This is the FPU code, remember? :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
