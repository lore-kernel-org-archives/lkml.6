Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754623AbeEAInk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:43:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46572 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754189AbeEAInh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:43:37 -0400
Date: Tue, 1 May 2018 10:43:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] x86/microcode/AMD: Check microcode container data
 in the late loader
Message-ID: <20180501084317.GC31863@pd.tnic>
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <8f204a953dc4b46477e214ebd291021d7ab6fa6c.1524515406.git.mail@maciej.szmigiero.name>
 <20180430090527.GC6509@pd.tnic>
 <bce73502-0d18-e50c-b78b-8159dc9f8f66@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bce73502-0d18-e50c-b78b-8159dc9f8f66@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 12:27:51AM +0200, Maciej S. Szmigiero wrote:
> 1) -EINVAL maps to a valid return value of 4294967274 bytes.
> We have a different behavior for invalid data in the container file
> (including too large lengths) than for grave errors like a failed memory
> allocation.

WTF?

> 2) This function single caller (__load_microcode_amd()) normalized any
> error that verify_and_add_patch() returned to UCODE_ERROR anyway,

So?

> 3) The existing code uses a convention that zero return value means
> 'terminate processing' for the parse_container() function in the early
> loader which normally returns a 'bytes consumed' value, as this function
> does.

parse_container() could very well change its convention to return
negative on error and positive value if the loop is supposed to skip
bytes.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
