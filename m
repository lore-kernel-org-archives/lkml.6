Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8EFC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE71220652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE71220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeJESSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:18:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60908 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbeJESSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:18:36 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 62puEbml3eNp; Fri,  5 Oct 2018 13:20:14 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ABDEF1EC021C;
        Fri,  5 Oct 2018 13:20:14 +0200 (CEST)
Date:   Fri, 5 Oct 2018 13:20:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, "hpa@zytor.com" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Message-ID: <20181005112010.GC10285@zn.tnic>
References: <20181003213100.189959-5-namit@vmware.com>
 <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <20181004091222.GB21864@gmail.com>
 <D42AB116-BFA4-4CF0-BF45-41C579A9B4C7@vmware.com>
 <20181004094519.GA97692@gmail.com>
 <29591D3B-D49B-4D7A-B280-85A2C3F63F9C@vmware.com>
 <20181005093108.GA24723@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181005093108.GA24723@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 11:31:08AM +0200, Ingo Molnar wrote:
> 
> * Nadav Amit <namit@vmware.com> wrote:
> 
> > > Are you using defconfig or a reasonable distro-config for your tests?
> > 
> > I think it is best to take the kernel and run localyesconfig for testing.
> 
> Ok, agreed - and this makes the numbers you provided pretty representative.
> 
> Good - now that all of my concerns were addressed I'd like to merge the remaining 3 patches as 
> well - but they are conflicting with ongoing x86 work in tip:x86/core. The extable conflict is 
> trivial, the jump-label conflict a bit more involved.

FWIW, gcc guys are not too averse to the idea of enhancing gcc inline
asm syntax with a statement which specifies its size so that gcc can use
it to do better inlining cost estimation than counting lines.

Lemme work the process ...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
