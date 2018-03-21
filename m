Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeCUAg4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 20:36:56 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34029 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeCUAgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 20:36:52 -0400
X-Google-Smtp-Source: AG47ELt+U0fExKBbv0ymA0DGC4fxq0jb+n7YT/Ze1zKyD3u3GUoEL8UVyoFGCsEP1HzcOaoSr+qtA80CzkQwv6uNtpA=
MIME-Version: 1.0
In-Reply-To: <20180321001824.8395-1-daniel@iogearbox.net>
References: <20180321001824.8395-1-daniel@iogearbox.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Mar 2018 17:36:51 -0700
X-Google-Sender-Auth: wLK-gamGJ2-9JzthUKMU5_RS2O8
Message-ID: <CA+55aFw94wSeOvs1JO2iPHXgpwWQ-EF6v0XYwjFrQN1wr5tY-A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: disable clang's default use of -fmerge-all-constants
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, psodagud@codeaurora.org,
        Network Development <netdev@vger.kernel.org>,
        Chenbo Feng <fengc@google.com>,
        Richard Smith <richard-llvm@metafoo.co.uk>,
        Chandler Carruth <chandlerc@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 5:18 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> Prasad reported that he has seen crashes in BPF subsystem with netd
> on Android with arm64 in the form of (note, the taint is unrelated):

Ack. This looks good to me. And thanks for noticing the behavior wrt
the correct gcc merging.

>  [ Hi Linus, feel free to take this fix directly if you want.
>    Alternatively, we could route it via bpf tree. Thanks a
>    lot for your feedback! ]

So since it's your patch and the only known issue comes from the bpf
side, I think it should just go through the bpf tree, and I expect it
to get to me through all the usual channels.

Thanks,

                Linus
