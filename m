Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD78C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F308320659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TfgQNI4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F308320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406516AbeKWEdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:33:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51460 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391864AbeKWEdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:33:02 -0500
Received: from zn.tnic (p200300EC2BDC9100898E5A1DF8FAB135.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:9100:898e:5a1d:f8fa:b135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD9801EC05C4;
        Thu, 22 Nov 2018 18:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542909156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CyHVfmn16kBFn8JlFe2Q/uztou1CSxx1shdX393Avx4=;
        b=TfgQNI4ytRZieMJ0BE1GGtvyG0eZTZhj6aPFqMYrrw/yzL1GkBwYOqpz1KrSCG6LpBz6H0
        HJgdJvZVREJ1sdu3QuAnWjby8+zs+yUQV5sRV6zgtFmFlR48whhFfkdrYXfnG5N5gpifHB
        K4NML8WgS26Ynwovdkyl2sLS0b6sF3E=
Date:   Thu, 22 Nov 2018 18:52:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [patch 01/24] x86/speculation: Update the TIF_SSBD comment
Message-ID: <20181122175229.GD10365@zn.tnic>
References: <20181121201430.559770965@linutronix.de>
 <20181121201722.337599561@linutronix.de>
 <CAHk-=wgLZkKDLeNN818VG0wC6B_kCUJqKPLdW+KDVocU6_DvtA@mail.gmail.com>
 <CAHk-=wj6fZpcad+1O5Ou0HZb0NEv1RM_BweyM0XBGtzE87YXXg@mail.gmail.com>
 <alpine.DEB.2.21.1811212345180.1665@nanos.tec.linutronix.de>
 <20181121230450.k75e4ipdag73dayz@treble>
 <20181121230854.GH27559@zn.tnic>
 <20181122173004.fn4tqoclhcyibxff@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181122173004.fn4tqoclhcyibxff@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 11:30:04AM -0600, Josh Poimboeuf wrote:
> But it does describe its purpose, especially in relation to the
> 'spectre_v2=' option.

Sure, but the thing I'm proposing

spectre_v2_task_isol=

describes it more precisely, IMHO. :)

I.e., "enable/disable spectre v2 task isolation".

> Previously 'spectre_v2=' might have been more appropriately named
> 'spectre_v2_kernel=' because it only protected the kernel from Spectre
> v2 attacks.  Now with these new patches, 'spectre_v2=on' will protect
> the entire system.

Hmmm, crazy idea: can we extend the options of spectre_v2= nstead?

spectre_v2=user_isolation,...
spectre_v2=kernel,...
spectre_v2=task_isolation,...

and so on?

This way we can do a couple of option switches in one go.

Hmmm?

> Now off to eat a giant turkey.

Try not to fall into a turkey coma. :-P

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
