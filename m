Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeCJQrN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 11:47:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33170 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeCJQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 11:47:12 -0500
Date: Sat, 10 Mar 2018 17:46:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/AMD: check microcode file sanity before
 loading it
Message-ID: <20180310164654.GD8261@pd.tnic>
References: <34e9d679-2eca-90cf-9a95-3864f0be060e@maciej.szmigiero.name>
 <f61522e6-fa15-0fc1-feef-6e0c84d6fc80@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f61522e6-fa15-0fc1-feef-6e0c84d6fc80@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 05:16:40PM +0100, Maciej S. Szmigiero wrote:
> To make sure that it is clear what this patch is about:

I know what you're trying to do but it seems you don't want to listen.
So let me try one last time to clear your confusion.

> It *isn't* about verifying the actual microcode update, that is, the
> blob that gets sent to the CPU as the new microcode.
> Such verification is (hopefully) done by the CPU itself.

Yes, it is done by the CPU. Microcode is encrypted.

> There is no container file at all for family 17h (Zen) so
> distributions like OpenSUSE that include this file must have gotten it
> from some other source

Or maybe they've gotten it from AMD directly. Don't you think that
getting microcode from the CPU vendor directly is the logical thing?

> That's why to get things like IBPB it is sometimes necessary to use
> a newer microcode version than included in linux-firmware, sourced for
> example from a BIOS update.

linux-firmware will get F17h microcode soon.

> Since BIOS updates contain only actual (raw) microcode updates one
> has to place it in a microcode container file so this driver can parse
> it.
> 
> As far I know there is no tool to automate this work so one has to
> manually tweak the container metadata.

Let me get this straight: am I reading this correctly that you've tried
to carve out the F17h microcode from a BIOS update blob and you're
trying to load that?!?

If so, you could've simply taken a distro microcode package and used
F17h microcode from there - they are all the same.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
