Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E167C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E701420855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ii8GZ55i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfA1SaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:30:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45100 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfA1SaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:30:07 -0500
Received: from zn.tnic (p200300EC2BC5DE008821062B415D2F41.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:de00:8821:62b:415d:2f41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57FB51EC0229;
        Mon, 28 Jan 2019 19:30:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548700206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6SEky2RgSR6uf7Veux5Hjwby9f/IiMPdt9mt9hGx9Hg=;
        b=Ii8GZ55iHUcKPxkS/4bPezcl7aIUu2N6xwIgO3jJ/sJXBT9zok/c0fTNP83Cqoi7Zpkx8m
        uBvQdOW+UwN5KCFhWzOXMlg+nvRF1v7KgawZBHmgk3tgi1G6+A3eMhh83f7lrq38cziYN1
        hgprGFuYM/OKkhzk47Icv6sLWWQ9vtA=
Date:   Mon, 28 Jan 2019 19:30:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 10/22] x86/fpu: Make __raw_xsave_addr() use feature
 number instead of mask
Message-ID: <20190128183004.GH20487@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-11-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-11-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:32PM +0100, Sebastian Andrzej Siewior wrote:
> Most users of __raw_xsave_addr() use a feature number, shift it to a
> mask and then __raw_xsave_addr() shifts it back to the feature number.
> 
> Make __raw_xsave_addr() use the feature number as an argument.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kernel/fpu/xstate.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
