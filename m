Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeFDQGk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:06:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45954 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbeFDQGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:06:39 -0400
Subject: Re: linux-next: Tree for Jun 4 (md/dm-writecache.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <dm-devel@redhat.com>, dm-devel@redhat.com
References: <20180604215911.75399f6e@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0e3fa62d-727e-ccb8-53ae-a6aaa6c506e2@infradead.org>
Date: Mon, 4 Jun 2018 09:06:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604215911.75399f6e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 04:59 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180601:
> 

on x86_64:

In file included from ../drivers/md/dm-writecache.c:8:0:
../drivers/md/dm-writecache.c: In function ‘writecache_status’:
../include/linux/compiler.h:61:17: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘int’ [-Wformat=]
   static struct ftrace_branch_data   \
                 ^
../include/linux/device-mapper.h:550:46: note: in definition of macro ‘DMEMIT’
      0 : scnprintf(result + sz, maxlen - sz, x))
                                              ^
../include/linux/compiler.h:48:24: note: in expansion of macro ‘__branch_check__’
 #  define unlikely(x) (__branch_check__(x, 0, __builtin_constant_p(x)))
                        ^
../drivers/md/dm-writecache.c:414:35: note: in expansion of macro ‘unlikely’
 #define writecache_has_error(wc) (unlikely(READ_ONCE((wc)->error)))
                                   ^
../include/linux/compiler.h:56:23: note: in expansion of macro ‘__trace_if’
 #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                       ^
../include/linux/compiler.h:251:2: note: in expansion of macro ‘if’
  if (check)       \
  ^
../include/linux/compiler.h:258:22: note: in expansion of macro ‘__READ_ONCE’
 #define READ_ONCE(x) __READ_ONCE(x, 1)
                      ^
../drivers/md/dm-writecache.c:414:44: note: in expansion of macro ‘READ_ONCE’
 #define writecache_has_error(wc) (unlikely(READ_ONCE((wc)->error)))
                                            ^
../drivers/md/dm-writecache.c:2196:32: note: in expansion of macro ‘writecache_has_error’
   DMEMIT("%ld %llu %llu %llu", writecache_has_error(wc),
                                ^

s/%ld/%d/


-- 
~Randy
