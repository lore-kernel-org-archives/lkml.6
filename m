Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A252C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0457D20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="co0rRgJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfBFOB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:01:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47788 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfBFOB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:01:27 -0500
Received: from zn.tnic (p200300EC2BCEF10055133BB909886643.dip0.t-ipconnect.de [IPv6:2003:ec:2bce:f100:5513:3bb9:988:6643])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 998DF1EC0A0E;
        Wed,  6 Feb 2019 15:01:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549461686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9+uTYRbPC2m29hdAmlXgEfYGrLhG96cvcMlwLv+ALfc=;
        b=co0rRgJbnRFt00aS27wq/r4syMkQhFu98a+0lP0WXyB8EeT6qNe4QwgXfO8LNFsYBXrEr9
        9lSbS1sMpHuaSvsn1IZ98jORmhbyRHHhBlwgRhRBdr0uBkCWdQwb03byMKMUR3sEjzz6Xx
        4RO+6QDz8nYmMoSxDj4eZI8oSYaSigM=
Date:   Wed, 6 Feb 2019 15:01:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 07/22] x86/fpu: Remove fpu->initialized
Message-ID: <20190206140114.GD7314@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-8-bigeasy@linutronix.de>
 <20190124133449.GC11554@zn.tnic>
 <20190205180336.smegi6rz7waprfaf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190205180336.smegi6rz7waprfaf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 07:03:37PM +0100, Sebastian Andrzej Siewior wrote:
> Well, nothing changes in regard to the logic. Earlier we had a variable
> which helped us to distinguish between user & kernel thread. Now we have
> a different one. 
> I'm going to add a comment to switch_fpu_prepare() about ->mm since you
> insist but I would like to avoid it.

I don't understand what that aversion is towards commenting stuff,
especially important stuff like the meaning of the presence of ->mm for
the FPU code. What is the downside to documenting that?

Considering that in this very thread we ourselves encountered the fact
that stuff is not documented and we complained that it wasn't!

> We have a comment, it is just not helping.

Why is it not helping?

> Steven said on IRC that it can be removed.

Did he give an explanation why is it ok?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
