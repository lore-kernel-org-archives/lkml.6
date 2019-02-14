Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B019C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2974222D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eHcuSnLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439202AbfBNOai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:30:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51766 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387633AbfBNOah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:30:37 -0500
Received: from zn.tnic (p200300EC2BCDFC008528D8D3AD4EA9C4.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:fc00:8528:d8d3:ad4e:a9c4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2F6A1EC0253;
        Thu, 14 Feb 2019 15:30:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550154635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kNe+8uIKEA6q5f1ImpwDUJ0iZQMlUnj7IC6+4ZB91xA=;
        b=eHcuSnLY2msjXpjiARiJ+Go+ZIMiUpdj32QOcShY8sznHKeYqpYCTPawqpUsrhhmNFz0dn
        EK1AqagMRTB0e5otx81Ex/Q2ZubKUXHskIDvuKpsCr3x6FqgY908MAJeHboVPTrt7XA9le
        V5zmAjk/n/8905BBUisE5DF4kN/KSSc=
Date:   Thu, 14 Feb 2019 15:30:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 7/9] x86/alternative: Batch of patch operations
Message-ID: <20190214143030.GB4423@zn.tnic>
References: <cover.1549308412.git.bristot@redhat.com>
 <84e6b00634085f0fca721e4e7e5aaf43cd062564.1549308412.git.bristot@redhat.com>
 <20190214125330.GB12467@zn.tnic>
 <20190214090620.1ee73a36@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214090620.1ee73a36@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 09:06:20AM -0500, Steven Rostedt wrote:
> Although you did say above that "patch" is an overloaded term. Also, I
> do find the current name rather descriptive.

When you look at "text_to_poke" as a struct name, you go, WTF is that?
The whole text? Some of it?

It should have the word "location" in it, to be clearer IMO.

> 	void *trampoline;

Well, it ain't a trampoline either. It is a "temporary location to go to while
patching is going on". Now make that a member name!

:-)))

> But they are named after you! "bp_" :-)

Uuh, you shouldn't have! :-)

Then they *must* be changed immediately!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
