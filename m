Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BD2C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3837120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HOkPE/DS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3837120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeLKUyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:54:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60606 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbeLKUyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:54:02 -0500
Received: from zn.tnic (p200300EC2BCD2B0010F6E1EC68D6BA6C.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:10f6:e1ec:68d6:ba6c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 560871EC028C;
        Tue, 11 Dec 2018 21:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544561640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PTqW057CK7jH/7xbE22CAUyFrfg7Ae/8HzZNLpNPcCA=;
        b=HOkPE/DSK8KPQdJYQ/T5hGpJPamX+ZS75JPGNpcuKWaPJAEClNw+hHtt8z01thr9bCAS89
        h+E7xcpw/nMqc7uikDBtZCTMMEs0x6fNtR1Bi0H5T23gdRlhesIm3LHez9dPqMjlhiW6dp
        ZnRSgnAcBCZrciR6hyRsgUtWae19AvY=
Date:   Tue, 11 Dec 2018 21:53:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bp@suse.de, richard@nod.at,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, hpa@zytor.com, jdike@addtoit.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/build] x86/um/vdso: Drop implicit common-page-size
 linker flag
Message-ID: <20181211205353.GR27375@zn.tnic>
References: <20181206191231.192355-1-ndesaulniers@google.com>
 <tip-f4313ba52f9caccfda6a55f991c84aba6726b88f@git.kernel.org>
 <CAKwvOdmBNvpjiYDdP88c9TZHzqbf-GTcQqPdft+LgJXC+W26Dw@mail.gmail.com>
 <5480353.C3TqP6Wb6x@blindfold>
 <20181211174658.GN27375@zn.tnic>
 <CAKwvOdnkqbxTYudCWH+Q_nuGbpKp8w3_3zHpxe29nirKKPrpsQ@mail.gmail.com>
 <20181211180547.GG25994@zn.tnic>
 <CAKwvOd=OY-qWqxK9gcacKChAEAPqFWyyBbgsQK6-h0zTYTcOgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=OY-qWqxK9gcacKChAEAPqFWyyBbgsQK6-h0zTYTcOgg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:08:30AM -0800, Nick Desaulniers wrote:
> Personal gmail account, yes. Corporate gmail, no, IIUC.  There was a
> pretty big internal thread where all of our kernel contributors got
> cut off one day and were scrambling to figure out how to send/review
> patches as their workflows were interrupted.

Gotta love all those stories of kernel people and corporate mail
systems... And every company has its own strange idiosyncrasies...

> Something is still not configured right when I send patches
> (maintainers have merged patches with my email address but no name, I
> assume from working with mbox files).

Yeah, had to fix that up today too. For some reason your git setup

 X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog

doesn't do names in From:

https://lkml.kernel.org/r/20181210222718.19926-1-ndesaulniers@google.com

> We have some internal tool that's smtp based but does the two factor
> authentication.

So some people send from !corporate mail servers but put their company's
name in brackets to keep attribution:

Signed-off-by: <First name> <Last name> (<Company>) <email@address.com>

For example. Dunno if that's something that would make sense for your
case though.

> Internal Gmail developers were able to help me verify that SPF was
> setup correctly, but indeed there's no DKIM.  This article has more
> info: https://support.google.com/mail/answer/81126?hl=en.

I know that one from my very recent past. :)

> Richard, I don't know if that's a lot of work on your end, but other
> folks using gmail might have the same issue repeatedly with receiving
> emails from your domain otherwise.

We had to do that too for our domain.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
