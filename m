Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeEGQfr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:35:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37258 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752163AbeEGQfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:35:46 -0400
Date: Mon, 7 May 2018 18:35:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] x86/microcode/AMD: Check microcode container data
 in the late loader
Message-ID: <20180507163526.GC733@pd.tnic>
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <8f204a953dc4b46477e214ebd291021d7ab6fa6c.1524515406.git.mail@maciej.szmigiero.name>
 <20180430090527.GC6509@pd.tnic>
 <bce73502-0d18-e50c-b78b-8159dc9f8f66@maciej.szmigiero.name>
 <20180501084317.GC31863@pd.tnic>
 <e10212ef-c876-4965-6279-967005f53950@maciej.szmigiero.name>
 <20180501200308.GC13171@pd.tnic>
 <9cf234e8-4d96-46f0-70e0-7d60d49671d8@maciej.szmigiero.name>
 <20180503100133.GB20023@pd.tnic>
 <756e5bd8-6cd8-5f28-6cab-c60396dc5de4@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <756e5bd8-6cd8-5f28-6cab-c60396dc5de4@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:26:50AM +0200, Maciej S. Szmigiero wrote:
> Here we return this variable, implicitly converting it into a
> (signed) int.
> Any value above INT_MAX will wrap around to a negative pseudo-error
> code (which might not match any actual error number).

If you want to widen the return type and do proper checking then have
the function return int which denotes success (0) or negative on
error and then return crnt_size through an u32 * arg.

All this in a separate patch with properly explained situation in the
commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
