Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA465C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCC42086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lDFnufhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCC42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeLKRrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:47:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56776 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeLKRrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:47:02 -0500
Received: from zn.tnic (p200300EC2BCD2B003506E5B42EFA948B.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:3506:e5b4:2efa:948b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63EB11EC0432;
        Tue, 11 Dec 2018 18:47:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544550421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MF2g+Mg7Od624J9u5c7AhX/bVay53cqBQDtbJamVV5M=;
        b=lDFnufhgCaboDonOKXzwR8RI6oAQdr5P6JGeT5jHelAao3CYE9eiVCIoT37QNLCKkRxr7e
        9SjJ5mELTl/98kRTZG1BMz/n7s2awwZNJLlMoa9kFqt24PI91pqHV5LoqqlyzAYaxeb6Vx
        o/S133Pk97LDq1ZNhl87mDq0OtY1fbA=
Date:   Tue, 11 Dec 2018 18:46:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, hpa@zytor.com, jdike@addtoit.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, bp@suse.de,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/build] x86/um/vdso: Drop implicit common-page-size
 linker flag
Message-ID: <20181211174658.GN27375@zn.tnic>
References: <20181206191231.192355-1-ndesaulniers@google.com>
 <tip-f4313ba52f9caccfda6a55f991c84aba6726b88f@git.kernel.org>
 <CAKwvOdmBNvpjiYDdP88c9TZHzqbf-GTcQqPdft+LgJXC+W26Dw@mail.gmail.com>
 <5480353.C3TqP6Wb6x@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5480353.C3TqP6Wb6x@blindfold>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 06:43:39PM +0100, Richard Weinberger wrote:
> https://lore.kernel.org/lkml/1633144.08IGjMOzBB@blindfold/
> 
> Maybe google started to hate my mailserver (again).

You probably need DKIM fun. It is most likely marked as spam in his
mbox.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
