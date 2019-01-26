Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522B5C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194212082C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NOb52R9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfAZJsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:48:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52216 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfAZJsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:48:00 -0500
Received: from zn.tnic (p200300EC2BDB1B009D5831FC63CDB0C9.dip0.t-ipconnect.de [IPv6:2003:ec:2bdb:1b00:9d58:31fc:63cd:b0c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBDB91EC027A;
        Sat, 26 Jan 2019 10:47:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548496079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+60+WdaU4gzv15md8l2AvQZ4LSVGpy5E2NjcSi+0PLc=;
        b=NOb52R9AFkq2k0pTWF0bre+EWCU0VBxvsmxcAr7qJSi2plI9L1F5ukaAqrAv05yfarM1aY
        8NBqaDXx4sFa2eiAla0i+gVdHqonxOLocVNQB5ikuK3168NxQTymliMMSzy1rcqR50IH+K
        Mv0/jUdejzOI+Ju10zgl9h+LjX+mi9s=
Date:   Sat, 26 Jan 2019 10:47:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/insn-eval: Mark expected switch fall-through
Message-ID: <20190126094749.GA18555@zn.tnic>
References: <20190125205520.GA9602@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125205520.GA9602@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 02:55:20PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> arch/x86/lib/insn-eval.c: In function ‘resolve_default_seg’:
> arch/x86/lib/insn-eval.c:179:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (insn->addr_bytes == 2)
>       ^
> arch/x86/lib/insn-eval.c:182:2: note: here
>   case -EDOM:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling

For the future:

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
