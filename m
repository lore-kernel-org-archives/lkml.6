Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeCZWgU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:36:20 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:38583 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeCZWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:36:19 -0400
X-Google-Smtp-Source: AG47ELtjUz0O36qSVjQM7P761dvX1E8L74K/k9UreaSOiY1EqCXKR9mcpQ2V8roOPuOMNjinFg4NRQ==
Date: Mon, 26 Mar 2018 15:36:16 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Joe Perches <joe@perches.com>
cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Use octal not symbolic permissions
In-Reply-To: <2e032ef111eebcd4c5952bae86763b541d373469.1522102887.git.joe@perches.com>
Message-ID: <alpine.DEB.2.20.1803261535460.93873@chino.kir.corp.google.com>
References: <2e032ef111eebcd4c5952bae86763b541d373469.1522102887.git.joe@perches.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018, Joe Perches wrote:

> mm/*.c files use symbolic and octal styles for permissions.
> 
> Using octal and not symbolic permissions is preferred by many as more
> readable.
> 
> https://lkml.org/lkml/2016/8/2/1945
> 
> Prefer the direct use of octal for permissions.
> 
> Done using
> $ scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace mm/*.c
> and some typing.
> 
> Before:	 $ git grep -P -w "0[0-7]{3,3}" mm | wc -l
> 44
> After:	 $ git grep -P -w "0[0-7]{3,3}" mm | wc -l
> 86
> 
> Miscellanea:
> 
> o Whitespace neatening around these conversions.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: David Rientjes <rientjes@google.com>

although extending some of these lines to be >80 characters also improves 
the readability imo.
