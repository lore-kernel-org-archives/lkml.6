Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933057AbeCEIJ5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:09:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:35075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752144AbeCEIJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:09:55 -0500
From: Sven Joachim <svenjoac@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 4.16-rc4
References: <CA+55aFxXg8hi+T_DNCG_OrAotqSheyREw-Njf9XgUD1vXqAyHQ@mail.gmail.com>
Date: Mon, 05 Mar 2018 09:09:31 +0100
In-Reply-To: <CA+55aFxXg8hi+T_DNCG_OrAotqSheyREw-Njf9XgUD1vXqAyHQ@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 4 Mar 2018 15:15:38 -0800")
Message-ID: <878tb7eyf8.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K0:rDhb5cpEGw3ZE8X1P/cwLJ2kHMi+fxZA6MXFRxn1ws9pRn11qih
 edKzpIzIMl6wW0biuJtIEETlYpS4exGb62iZsQP+I3BcnLA380mPA1Vyv5gf5to+kxAbm+2
 9HDEIPj0hp0jKMPOQkzCDXSMqrCZDWoFa0VKwNmYK+EUDxEmilKbBQMT0gsqhOwx/u6bAip
 ml7dtEW4FJRXVhJu6PlSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mmyOckcsb7Q=:IDl+ScJyKL/x6Pnwncec46
 +PYwREtAn0lkNvr5dXTxbekNbEZAIZBj2cqe1GK6pIMFTIp10p9PrKRTqmKjzDQ66YmKI3HUd
 CfWy0eh7EwG863j6yQg+fNv9284z8l+PPX9ukLGhSSfoSCMvWJngVkSBp92EyyYXuZb8oEj/N
 6skuFzd2fJ4CjI5NHjQKdyujdxsK3vSPfbIS1pwkunN6OsujMWQ4K0DJ2xX99zxX/Y0hQEi5/
 ZH8QnsT67zbWwAQBKMoeVT9F5ehmzNwHmRIKG5y/olPUHUPN9lmUuifDU82XwQLj/ZUDvwG1E
 VYfeLEDt/oL8La9zX9RLqv1Uiwl26OpNhYAllXNxOiDhVZcTXJbKW/KWvGcE1osL3k5n84d1u
 UROTIvM2U7ZlTjk6lzgmSeayoeXqnJhGrIsZQR0gWZIRKN2NZRhhwmvQh020EKsvBZfQOcBSo
 ffEiwsQQs0Bl7zsk+5XHCIf1EthyjW4oKTlHdU3dN1an0VyB5vkwL2bk0ALC5GFcGBIEbXxHg
 v9uHnEXMvvowzEF6NfRy6uYq953PdiSqsKeWrck3N3seFugVKF39cH+6mueye8MtHqcZrVxAN
 MIj1Pdt4Qgzzi5JSCDBhtXaXHV4FU1zM7MtbHcw+6UuUioVK/WwXToA4Md1xpULH9z9tSBYYE
 ULVihSA234i1XzhDAzm+TasTa57FsACEXw6fnlGVtNv4qzaQ7Zx36ymvw2FHMulH6WNE6I7/p
 wtHswQaWwZiEQspZxfMTNQDA/F4KUPxdIj1jpmvUIaUDkfNET3DwogzeHgeyGXzIvJzDe3xMg
 9PSu+wUYcplNMMy/1Q1vy5wT7Rf1ppi+mIiXbSPDqp5CGcO6IM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-04 15:15 -0800, Linus Torvalds wrote:

> Hmm. A reasonably calm week - the biggest change is to the 'kvm-stat'
> tool, not any actual kernel files.
>
> But there's small changes all over, with architecture updates (x86,
> s390, arm, parisc) and drivers (media, md, gpu, sound) being the bulk
> of it.  But there's some filesystem fixes (mostly btrfs),
> documentation updates etc too.
>
> Go test,

Huh, this version does not build for me:

,----
|   CALL    scripts/checksyscalls.sh
|   DESCEND  objtool
|   CC       /usr/local/src/linux/tools/objtool/check.o
| In file included from check.c:26:0:
| check.c: In function 'read_retpoline_hints':
| warn.h:57:3: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Werror=format=]
|    "%s: warning: objtool: " format "\n", \
|    ^
| check.c:1135:3: note: in expansion of macro 'WARN'
|    WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
|    ^~~~
| check.c:1135:44: note: format string is defined here
|    WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
|                                           ~~^
|                                           %d
| cc1: all warnings being treated as errors
| mv: cannot stat '/usr/local/src/linux/tools/objtool/.check.o.tmp': No such file or directory
| /usr/local/src/linux/tools/build/Makefile.build:96: recipe for target '/usr/local/src/linux/tools/objtool/check.o' failed
| make[3]: *** [/usr/local/src/linux/tools/objtool/check.o] Error 1
`----

This might be because I still use a 32-bit userland with a 64-bit
kernel.

Cheers,
       Sven
