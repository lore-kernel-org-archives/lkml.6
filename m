Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeCLNHN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:07:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52802 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbeCLNHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:07:12 -0400
Date: Mon, 12 Mar 2018 14:06:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/microcode/AMD: check microcode file sanity before
 loading it
Message-ID: <20180312130653.GC9431@pd.tnic>
References: <787b0ecc-8c1a-3b5a-82e0-9840c7b7c595@maciej.szmigiero.name>
 <20180312095336.GB9431@pd.tnic>
 <ddf0ddc2-bc46-d61c-7080-0eca26d6bfcf@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddf0ddc2-bc46-d61c-7080-0eca26d6bfcf@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 01:56:59PM +0100, Maciej S. Szmigiero wrote:
> The equivalent CPU table is allocated using vmalloc() so it is nice
> when the maximum size is an integer multiple of the page size.

Arbitrary.

> Since the maximum entry count in current microcode files is 18 the

Where did you dream up that 18?

> maximum size of 256 entries (or one page) gives us plenty of headroom.

Arbitrary.

> Also, looking in the past, there probably won't be more than 256 AMD CPU
> types in one CPU family.

Wrong.

The only limitation on the equivalence table size we have is the 32-bit
unsigned length field at offset 8 in the equivalence table header.

> This limit is an absolute upper cap of a patch size.

More dreamt up crap.

See verify_patch_size() for the actual patch sizes.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
