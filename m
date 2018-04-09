Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbeDIRDG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:03:06 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:38208 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeDIRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:03:05 -0400
X-Google-Smtp-Source: AIpwx49f2f+Es8O1S+jMGiFfCVHJGFKxbMpNtz5qmUOgTHPs4nGbN3PrAna5ciZpxUABgkG8ODLMya4nVPVMc9OGhfE=
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1804091809310.1698@schleppi>
References: <alpine.LFD.2.21.1804061125390.1819@schleppi> <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com>
 <alpine.LFD.2.21.1804091809310.1698@schleppi>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Apr 2018 10:03:03 -0700
X-Google-Sender-Auth: sSVk19khLXCzw06ZnOzLLFiblyQ
Message-ID: <CA+55aFw1MoQ=7=U6QCGXAAiCniMKy8_igxgc8sMLykSRcDk-0g@mail.gmail.com>
Subject: Re: [bisected] 3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 oopses on s390
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: Kees Cook <keescook@chromium.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 9:18 AM, Sebastian Ott <sebott@linux.ibm.com> wrote:
>
> Both of the following return 0 on my machine:
> +       pr_warn("%u\n", min_not_zero(100, 1000));
> +       pr_warn("%u\n", min_not_zero(1000, 100));

Oooh.

[ Raises hand, and says "I know, I know, pick me, pick me" ]

min_not_zero() hasinternal variables "__x" and "__y".

And "__cmp_once()" has internal variables "__x" and "__y".

When min_not_zero does

    min(__x, __y));

that expands to crazy stuff.

Out old "min()" had the internal variables called "min1" and "min2",
which is crazy too.

             Linus
