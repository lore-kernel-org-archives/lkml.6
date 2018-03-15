Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCOBBH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:01:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35156 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751302AbeCOBBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:01:05 -0400
Date: Thu, 15 Mar 2018 02:00:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] x86/microcode/AMD: automatically compute the
 PATCH_MAX_SIZE macro
Message-ID: <20180315010029.GD11061@pd.tnic>
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <de9e4416-0afa-ef07-2c0d-77aa7252a6ea@maciej.szmigiero.name>
 <20180314180209.GH16605@pd.tnic>
 <a4ea015b-1176-2db2-d339-677b1b5893f5@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4ea015b-1176-2db2-d339-677b1b5893f5@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 01:05:14AM +0100, Maciej S. Szmigiero wrote:
> Unfortunately, this does not work:
> > ./include/linux/kernel.h:806:41: error: braced-group within expression allowed only inside a function
> >  #define __max(t1, t2, max1, max2, x, y) ({  \

Ok, let's drop this line then. It is simply too much monkey business
just to end up with max size of 4K which is F15H_MPB_MAX_SIZE,
coincidentally.

Just put a comment in verify_patch_size() stating that PATCH_MAX_SIZE
needs to be adjusted when a bigger per-family patch size gets added.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
