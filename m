Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164686AbeBOXVV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:21:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163785AbeBOXVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:21:18 -0500
Subject: Re: [PATCH] disable sparse warnings about unknown attributes
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org
References: <20180215210750.28813-1-luc.vanoostenryck@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c215cf31-ba19-49ff-3da9-268e64ea1ba0@infradead.org>
Date: Thu, 15 Feb 2018 15:21:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215210750.28813-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2018 01:07 PM, Luc Van Oostenryck wrote:
> Currently, sparse issues warnings on code using an attribute
> it doesn't know about.
> 
> One of the problem with this is that these warnings have no
> value for the developer, it's just noise for him. At best these
> warnings tell something about some deficiencies of sparse itself
> but not about a potential problem with code analyzed.
> 
> A second problem with this is that sparse release are, alas,
> less frequent than new attributes are added to GCC.
> 
> So, avoid the noise by asking sparse to not warn about
> attributes it doesn't know about.
> 
> Reference: https://marc.info/?l=linux-sparse&m=151871600016790
> Reference: https://marc.info/?l=linux-sparse&m=151871725417322
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 79ad2bfa2..8d9a7374c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -388,7 +388,7 @@ PYTHON		= python
>  CHECK		= sparse
>  
>  CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
> -		  -Wbitwise -Wno-return-void $(CF)
> +		  -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
>  NOSTDINC_FLAGS  =
>  CFLAGS_MODULE   =
>  AFLAGS_MODULE   =
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

thanks,
-- 
~Randy
