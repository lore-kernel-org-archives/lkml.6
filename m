Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCNR7D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:59:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37040 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbeCNR7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:59:02 -0400
Date: Wed, 14 Mar 2018 18:58:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] x86/microcode/AMD: install_equiv_cpu_table()
 should not return (signed) int
Message-ID: <20180314175824.GG16605@pd.tnic>
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <cf57ed15-df47-087e-c98f-527e4ce1e0f8@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf57ed15-df47-087e-c98f-527e4ce1e0f8@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 10:06:34PM +0100, Maciej S. Szmigiero wrote:
> The maximum possible value returned by install_equiv_cpu_table() is
> UINT_MAX + CONTAINER_HDR_SZ (on a 64-bit kernel).
> This is more than (signed) int type currently returned by this function can
> hold so this function will need to return a size_t instead.

I'm trying to parse this but I'm not really sure.

All I know is:

	unsigned int size = ibuf[2];

and that is really a 4-byte unsigned quantity so anything less is an
arbitrary limitation.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
