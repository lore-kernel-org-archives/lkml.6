Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933137AbeBVP5B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:57:01 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:58738 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932952AbeBVP5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:57:00 -0500
Subject: Re: [PATCH v2] kconfig.h: Include compiler types to avoid missed
 struct attributes
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Patrick McLean <chutzpah@gentoo.org>, linux-kernel@vger.kernel.org
References: <20180222002854.GA29269@beast>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <36583adc-9c01-fd21-074a-e3df2cbb3dee@maciej.szmigiero.name>
Date: Thu, 22 Feb 2018 16:56:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180222002854.GA29269@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.2018 01:28, Kees Cook wrote:
> The header files for some structures could get included in such a way
> that struct attributes (specifically __randomize_layout from path.h) would
> be parsed as variable names instead of attributes. This could lead to
> some instances of a structure being unrandomized, causing nasty GPFs, etc.
> 
> This patch makes sure the compiler_types.h header is included in
> kconfig.h so that we've always got types and struct attributes defined,
> since kconfig.h is included from the compiler command line.
> 
> Reported-by: Patrick McLean <chutzpah@gentoo.org>
> Root-caused-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Fixes: 3859a271a003 ("randstruct: Mark various structs for randomization")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

I can confirm that this patch fixes the original nfsd GPF issue.
Also, struct path members offsets are consistent now between nfs4xdr.s
and other files.

> ---
> Updated Maciej's tag.

Thanks.

Maciej
