Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeDFR1I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:27:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751344AbeDFR1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:27:07 -0400
Date: Fri, 6 Apr 2018 12:27:05 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] objtool: Support HOSTCFLAGS and HOSTLDFLAGS
Message-ID: <20180406172705.zvvmdf6d32jzj5v3@treble>
References: <20180329004805.7278-1-labbott@redhat.com>
 <20180329004805.7278-3-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180329004805.7278-3-labbott@redhat.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 05:48:04PM -0700, Laura Abbott wrote:
> It may be useful to compile host programs with different flags (e.g.
> hardening). Ensure that objtool picks up the appropriate flags.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  tools/objtool/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index e6acc281dd37..0ff3bcac1ca9 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -31,8 +31,9 @@ INCLUDES := -I$(srctree)/tools/include \
>  	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
>  	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
>  WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
> -CFLAGS   += -Wall -Werror $(WARNINGS) -fomit-frame-pointer -O2 -g $(INCLUDES)
> -LDFLAGS  += -lelf $(LIBSUBCMD)
> +CFLAGS   += -Wall -Werror $(WARNINGS) $(HOSTCFLAGS) -fomit-frame-pointer -O2 -g \
> +	    $(INCLUDES)

HOSTCFLAGS already has '-Wall', '-fomit-frame-pointer', and '-O2', so we
can remove the setting of those in CFLAGS here.

-- 
Josh
