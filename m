Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662112083F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="m9PaC30k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662112083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbeLEOZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:25:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42190 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbeLEOY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:24:58 -0500
Received: from zn.tnic (p200300EC2BC09900B100099FAFCBAE1B.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:9900:b100:99f:afcb:ae1b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 729EA1EC02B8;
        Wed,  5 Dec 2018 15:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544019896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fM+A4e+a5vKO5c5JMc1th9P/BdqIEUDGy/Uv09YvjSw=;
        b=m9PaC30khcJscoSDvK54ejY4vLXkG55kfqG0K3JMjoga8oxL96BHJ32j5UdlJGvHH1GRBT
        RUZiV8dFAT3aHnLc7MpNVYQlicp7IzGaUY386PMpPJTok4XFnhZekjsQCuBELjZh80prdC
        W8pwHnAsXm1UfsdsojT+HzCvijLgSFQ=
Date:   Wed, 5 Dec 2018 15:24:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Message-ID: <20181205142448.GH29510@zn.tnic>
References: <20181205101131.28996-1-bp@alien8.de>
 <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:49:06PM +0900, Masami Hiramatsu wrote:
> I would like to put this prototype inside arch/x86/kernel/kprobes/core.c,
> since that is locally used.

Done.

> Should we declare prototypes for __weak functions? Anyway, we should remove
> __weak from the prototypes.

And done.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
