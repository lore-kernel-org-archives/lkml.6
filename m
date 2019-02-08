Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29824C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E760F2147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfBHDke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 22:40:34 -0500
Received: from ozlabs.org ([203.11.71.1]:58925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfBHDke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 22:40:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wgtl337Tz9sBZ;
        Fri,  8 Feb 2019 14:40:31 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Tobin C. Harding" <tobin@kernel.org>
Cc:     linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Start conversion of PowerPC docs
In-Reply-To: <20190207170131.1fd2bb03@lwn.net>
References: <20190207060316.3221-1-tobin@kernel.org> <20190207170131.1fd2bb03@lwn.net>
Date:   Fri, 08 Feb 2019 14:40:28 +1100
Message-ID: <87ef8jj6c3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:
> On Thu,  7 Feb 2019 17:03:15 +1100
> "Tobin C. Harding" <tobin@kernel.org> wrote:
>
>> As discussed at LCA here is the start to the docs conversion for PowerPC
>> to RST.
>> 
>> This applies cleanly on top of the mainline (5.20-rc5) and Jon's tree
>> (docs-next branch).
>> 
>> I'm guessing it should go in through the PowerPC tree because I doubt
>> you want to review this Jon, it's one big single patch (all blame for
>> that falls on mpe ;)
>
> Well, I went and took a look anyway, being a glutton for punishment.  So
> naturally I do have some comments...
>
> - I don't think this should be a top-level directory full of docs; the top
>   level is already rather overpopulated.  At worst, we should create an
>   arch/ directory for architecture-specific docs.

We currently have arch specific directories for arm, arm64, ia64, m68k,
nios2, openrisc, parisc, powerpc, s390, sh, sparc, x86, xtensa.

Do you mean they should all be moved to Documentation/arch ?

>   I kind of think that
>   this should be thought through a bit more, though, with an eye toward
>   who the audience is.  Some of it is clearly developer documentation, and
>   some of it is aimed at admins; ptrace.rst is user-space API stuff.
>   Nobody ever welcomes me saying this, but we should really split things
>   into the appropriate manuals according to audience.

I don't think any of it's aimed at admins, but I haven't read every
word. I see it as aimed at kernel devs or people writing directly to the
kernel API, eg. gdb developers reading ptrace.rst.

If Documentation/ wants to be more user focused and nicely curated
perhaps we need arch/foo/docs/ for these developer centric docs?

> - It would be good to know how much of this stuff is still relevant.
>   bootwrapper.txt hasn't been modified since it was added in 2008.

It hasn't been modified but AFAIK it's still pretty much accurate and
definitely something we want to have documented.

>   cpu_features.txt predates the git era

But so does the code it's documenting.

>   as does mpc52xx.txt; hvcs.txt is nearly as old. And so on. Can we
>   perhaps stop dragging some of those docs around?

We support some hardware that is ~25 years old, so we have some old
documentation too, and I'd rather we didn't drop things just because
they're old.

> - The use of flat-table in isa-versions.rst totally wrecks the readability
>   of those tables in the plain-text version.  Said tables are pretty close
>   to being RST in their original form; it would be far better to just fix
>   anything needing fixing but to keep that form.

Yes agree, I'd like the docs to be as readable as possible as plain text.

> - I'm glad you're adding SPDX lines, but do you know that the license is
>   correct in each case?  It's best to be careful with such things.

None of the files have licenses so I think we just fall back to COPYING
don't we? In which case GPL-2.0 is correct for all files.

cheers
