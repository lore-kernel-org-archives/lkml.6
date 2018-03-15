Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCOKn1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:43:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33536 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751757AbeCOKnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:43:25 -0400
Date: Thu, 15 Mar 2018 11:42:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] x86/microcode/AMD: check whether the equivalence
 table fits in the file
Message-ID: <20180315104246.GE27816@pd.tnic>
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <e2de27e0-6250-a10f-8d08-99c0c8d417ba@maciej.szmigiero.name>
 <20180314170457.GE16605@pd.tnic>
 <863eeb13-1c67-da37-6862-610a1204d648@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <863eeb13-1c67-da37-6862-610a1204d648@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 12:34:09AM +0100, Maciej S. Szmigiero wrote:
> 'size' here is the length of the whole CPIO blob containing all
> containers combined (well, the remaining part of it).
> 
> If we skip over 'size' bytes we'll have nothing left to parse.

Well, if

	size < eqiv_tbl_len + CONTAINER_HDR_SZ

then you really have nothing else to parse.

Come to think of it, if the whole blob is truncated like that, we
shouldn't trust it at all and stop looking at it. So yes, "return size"
is the right thing to do but for a different reason.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
