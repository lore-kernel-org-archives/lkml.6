Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeBAS2X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:28:23 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:52395 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeBAS2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:28:22 -0500
X-Google-Smtp-Source: AH8x224HobHj5XALauBy9ErqHN6+bcH0BnJSSAPMlbnZftAP0d/zYKh+QEbQQSnsf4BLpeNG1kVZ05BwlKDzND64Yu0=
MIME-Version: 1.0
In-Reply-To: <20180201180052.32643-1-aryabinin@virtuozzo.com>
References: <20180201180052.32643-1-aryabinin@virtuozzo.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2018 10:28:20 -0800
X-Google-Sender-Auth: F9kSVwlpVaQt5LjlrgkmFcnzjgw
Message-ID: <CA+55aFyLb6utrR_bCRj1JXteuvVchiWrsNNkjM3HetLHNxHx9A@mail.gmail.com>
Subject: Re: [PATCH 1/5] compiler.h, kasan: Avoid duplicating __read_once_size_nocheck()
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, Kees Cook <keescook@chromium.org>,
        Eryu Guan <eguan@redhat.com>, Alexander Potapenko <glider@google.com>,
        Chris Metcalf <metcalf@alum.mit.edu>,
        David Laight <David.Laight@aculab.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ack for the whole series.

Will this go through Andrew's mm tree or what? I can pick it up directly too.

               Linus

On Thu, Feb 1, 2018 at 10:00 AM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
> Instead of having two identical __read_once_size_nocheck() functions
> with different attributes, consolidate all the difference in new macro
> __no_kasan_or_inline and use it. No functional changes.
>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
