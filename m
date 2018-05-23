Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935002AbeEWVHf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 17:07:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54092 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934299AbeEWVHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 17:07:33 -0400
Subject: Re: [PATCH] fixup! kconfig: refactor ncurses package checks for
 building mconf and nconf
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1527041491-12647-1-git-send-email-yamada.masahiro@socionext.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <55f33ace-61b0-51f8-647b-7238a5ab32b5@infradead.org>
Date: Wed, 23 May 2018 14:07:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527041491-12647-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 07:11 PM, Masahiro Yamada wrote:
> It is redundant to pass -DNCURSES_WIDECHAR=1 explicitly; when we use
> 'pkg-config --cflags', it takes care of appropriate flags.
> 
> Actually, 'pkg-config --cflags' will add -D_GNU_SOURCE, which will
> define _XOPEN_SOURCE_EXTENDED, and NCURSES_WIDECHAR=1, anyway.
> 
> I added -D_GNU_SOURCE to follow the suggestion of pkg-config
> for cases where pkg-config is not useful.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> The v3 (https://patchwork.kernel.org/patch/10417413/) was
> reviewed and tested.
> 
> I'd like to squash this into it.

Sure.  Works for me.  Thanks.

> 
> 
>  scripts/kconfig/mconf-cfg.sh | 8 ++++----
>  scripts/kconfig/nconf-cfg.sh | 7 ++++---
>  2 files changed, 8 insertions(+), 7 deletions(-)


-- 
~Randy
