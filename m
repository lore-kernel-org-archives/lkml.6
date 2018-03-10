Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbeCJOJp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 09:09:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932096AbeCJOJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 09:09:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851D621799
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
X-Google-Smtp-Source: AG47ELvrfCl2sJ7yQaiILdq2Hp2gS5hudXcH2RGFqO79LxDifDDNc8qaRLgOh/hlp1tEWSf6gF7xz3e6s5uUdLAwy2w=
MIME-Version: 1.0
In-Reply-To: <20171130023605.29568-1-mcgrof@kernel.org>
References: <20171130023605.29568-1-mcgrof@kernel.org>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Sat, 10 Mar 2018 06:09:21 -0800
X-Gmail-Original-Message-ID: <CAB=NE6XDLBpXbBfjC1254xpEzsUvwZddz_5mfFaSR2RK3wqE5g@mail.gmail.com>
Message-ID: <CAB=NE6XDLBpXbBfjC1254xpEzsUvwZddz_5mfFaSR2RK3wqE5g@mail.gmail.com>
Subject: Re: [PATCH 0/3] module: process aliasing when debugging
To: Jessica Yu <jeyu@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>,
        Alexei Starovoitov <ast@fb.com>
Cc: Kees Cook <keescook@chromium.org>, Djalal Harouni <tixxdz@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>, Aaron Tomlin <atomlin@redhat.com>,
        Petr Mladek <pmladek@suse.com>, hare <hare@suse.com>,
        James Morris <james.l.morris@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*Poke*

  Luis

On Wed, Nov 29, 2017 at 6:36 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Debugging ineractions with userspace can often be a bit of pain, specially
> when trying to figure out who is at fault for an issue. Having the kernel
> process aliases when debugging can help us much faster find who is the
> culprit to an issue.
>
> I've been carrying this around privately in my tree since 2016 but it seems
> others can benefit from similar debugging functionality so pushing this out
> for integration and wider review.
>
> Further testing, thoughts, reviews, flames are all equally appreciated.
>
> Luis R. Rodriguez (3):
>   module: use goto errors on check_modinfo() and layout_and_allocate()
>   module: add helper get_modinfo_idx()
>   module: add debugging alias parsing support
>
>  include/linux/module.h |   4 ++
>  init/Kconfig           |   7 +++
>  kernel/module.c        | 129 +++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 135 insertions(+), 5 deletions(-)
>
> --
> 2.15.0
>
