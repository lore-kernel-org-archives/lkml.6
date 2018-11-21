Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2EFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19CE2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UCEYlrHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19CE2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbeKVJnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:43:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40916 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387888AbeKVJno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:43:44 -0500
Received: from zn.tnic (p200300EC2BD0AB00883B4D3E2A7F8FA4.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:ab00:883b:4d3e:2a7f:8fa4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8D651EC09F7;
        Thu, 22 Nov 2018 00:07:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542841635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lpSHyg9wcY0crHruAVGPaqTBxhr+BObfZ3ek09hje+Y=;
        b=UCEYlrHj+ihszB+/0OlzmcOPTIjBZFxB1x/sybguWSKsT3rIdV0HiH7U+9R7EvFmFEs2FY
        oUl7Q6WvwMKJ17hbzASz7waggzAoj4PVb9u/st7jS7Mmfbb8dMq2P0kEAqRv/BpiBXwh5Z
        Ah2CxKl0PlmewLLwwBnJr/UnZ/fHP94=
Date:   Thu, 22 Nov 2018 00:07:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arjan van de Ven <arjan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [patch 01/24] x86/speculation: Update the TIF_SSBD comment
Message-ID: <20181121230706.GG27559@zn.tnic>
References: <20181121201430.559770965@linutronix.de>
 <20181121201722.337599561@linutronix.de>
 <CAHk-=wgLZkKDLeNN818VG0wC6B_kCUJqKPLdW+KDVocU6_DvtA@mail.gmail.com>
 <CAHk-=wj6fZpcad+1O5Ou0HZb0NEv1RM_BweyM0XBGtzE87YXXg@mail.gmail.com>
 <alpine.DEB.2.21.1811212345180.1665@nanos.tec.linutronix.de>
 <20181121225336.GE27559@zn.tnic>
 <9cbce8e5-bc0d-a817-04f5-57b9f8ec0f70@linux.intel.com>
 <20181121225646.GF27559@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181121225646.GF27559@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:56:46PM +0100, Borislav Petkov wrote:
> On Wed, Nov 21, 2018 at 02:55:20PM -0800, Arjan van de Ven wrote:
> > part of the problem is that "sharing" has multiple dimensions: time
> > and space (e.g. hyperthreading) which makes it hard to find a nice
> > term for it other than describing who attacks whom
> 
> Shared Hardware Isolation of Tasks ?

Ok, srsly:

spectre_v2_task_isol=

to mean, task isolation and it not being an abbreviation.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
