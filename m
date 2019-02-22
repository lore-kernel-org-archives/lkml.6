Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F59CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CDD2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="a9NwRp86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfBVQO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:14:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41096 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfBVQO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:14:28 -0500
Received: from zn.tnic (p200300EC2BCB3900F0C56855832FAB14.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:3900:f0c5:6855:832f:ab14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69EC41EC0324;
        Fri, 22 Feb 2019 17:14:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550852066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TtW/o2236hee295y0l38KlKQhr9G4t9UGeyqpVmzjfk=;
        b=a9NwRp86cR2AQFYae8KVR4Yy4+lZE3yv+GWVs72qb7oHaM6m4WF14MUq1S8WN/i+S/W1+t
        kFGXOo6Nsaa2ObF3jQSUmyu73h1eCiA/LTtjnDrZFdJwViQEin2xP1OQy+L88nRo/VTmiN
        N/L0FcMuJpPh+Cqm16wWUjYndvyN9bQ=
Date:   Fri, 22 Feb 2019 17:14:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com
Subject: Re: [PATCH v3 00/20] Merge text_poke fixes and executable lockdowns
Message-ID: <20190222161419.GB30766@zn.tnic>
References: <20190221234451.17632-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221234451.17632-1-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:44:31PM -0800, Rick Edgecombe wrote:
> Changes v2 to v3:
>  - Fix commit messages and comments [Boris]
>  - Rename VM_HAS_SPECIAL_PERMS [Boris]
>  - Remove unnecessary local variables [Boris]
>  - Rename set_alias_*() functions [Boris, Andy]
>  - Save/restore DR registers when using temporary mm
>  - Move line deletion from patch 10 to patch 17

In your previous submission there was a patch called

Subject: [PATCH v2 01/20] Fix "x86/alternatives: Lockdep-enforce text_mutex in text_poke*()"

What happened to it?

It did introduce a function text_poke_kgdb(), a.o., and I see this
function in the diff contexts in some of the patches in this submission
so it looks to me like you missed that first patch when submitting v3?

Or am *I* missing something?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
