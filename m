Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeCVQMD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:12:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39786 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbeCVQMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:12:02 -0400
Date: Thu, 22 Mar 2018 17:11:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/10] x86/microcode/AMD: Check patch size in
 verify_and_add_patch()
Message-ID: <20180322161130.GA11575@cz.tnic>
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
 <30562911-7fde-782b-d1b2-03e30b6987c5@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30562911-7fde-782b-d1b2-03e30b6987c5@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:08:17AM +0100, Maciej S. Szmigiero wrote:
> @@ -505,7 +505,7 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size,
>  		break;
>  	}
>  
> -	if (patch_size > min_t(u32, size, max_size)) {
> +	if (patch_size > min_t(size_t, size, max_size)) {

So I don't like this conversion to 8-byte-width size_t's. It is not
necessary. I'm pretty sure we can do fine with signed and unsigned ints.

For example, you can convert the size to signed int (if it hasn't been
converted yet) and check for < 0 and stop further processing. And so on...

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
